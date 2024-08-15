module Validations
  class ApplicationContract < Dry::Validation::Contract
    include Dry::Monads[:result]

    config.messages.backend = :i18n

    def self.use_schemas(*schemas, &)
      params(*schemas.map(&:params), &)

      schemas.each do |schema|
        class_eval(&schema.rules)
      end
    end

    def validate_params(params)
      params = params.to_unsafe_hash if params.is_a?(ActionController::Parameters)
      result = call(params)

      if result.success?
        Success(result.to_h)
      else
        error = ::DryInteractions::InteractionErrors.validation_error(details: result.errors.to_h)
        Failure(error)
      end
    end

    private

    def validate_record_exists(evaluator, query, field_name = :id)
      evaluator.key.failure(:record_exists?) unless query.where(field_name => evaluator.value).any?
    end

    def validate_exclusion(evaluator, array)
      evaluator.key.failure(:included_in?, array) if array.exclude? evaluator.value
    end

    def email_validation(evaluator)
      evaluator.key.failure(:format?) if evaluator.value.present? && evaluator.value.match(User::VALID_EMAIL_REGEX).nil?
    end

    def password_validation(evaluator)
      return unless evaluator.value.present? && evaluator.value.match(User::VALID_PASSWORD_REGEX).nil?

      evaluator.key.failure(:format?)
    end

    def match_regexp(evaluator, regexp)
      evaluator.key.failure(:format?) if evaluator.value.present? && evaluator.value.match(regexp).nil?
    end
  end
end
