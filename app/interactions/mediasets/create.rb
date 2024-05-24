module Mediasets
  class Create
    include Dry::Monads[:result, :do]
    include DryInteractions::InteractionErrors
    class Contract < ::Validations::ApplicationContract
      params do
        required(:name).filled(:string)
        required(:product_id).filled(:integer)
        optional(:user_id).filled(:integer)
        optional(:company_id).filled(:integer)
      end

      rule :product_id do
        key.failure(:record_exists?) unless Product.find_by(id: value)
      end
    end

    def call(params)
      params = yield Contract.new.validate_params(params)
      @product ||= Product.find(params[:product_id])
      ::Entities::Create.new.call(mediaset: create_mediaset(params))
    end

    private

    def create_mediaset(params)
      @product.mediasets.create(params[:name])
    end
  end
end
