module DryInteractions
  module ParamsValidations
    include Dry::Monads[:result]
    include InteractionErrors

    def validate_presence(params, keys)
      errors = keys.each_with_object({}) do |key, result|
        result[key] = [{ error: 'missing' }] if params[key].blank?
      end

      errors.any? ? Failure(validation_error(details: errors)) : Success(true)
    end

    def validate_inclusion(key, value, keys)
      errors = { key => [{ error: 'wrong value' }] } unless keys.include? value

      errors && errors.any? ? Failure(validation_error(details: errors)) : Success(true)
    end

    def validate_record_exists(params, query:, param_name:, search_by: :id)
      result = query.find_by(search_by => params[param_name])

      if result
        Success(result)
      else
        model = query.is_a?(ActiveRecord::Relation) ? query.model : query
        error_details = { param_name => [{ error: "#{model} not found" }] }
        Failure(validation_error(details: error_details))
      end
    end
  end
end
