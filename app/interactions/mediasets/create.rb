module Mediasets
  class Create
    include Dry::Monads[:result, :do]
    include DryInteractions::InteractionErrors
    class Contract < ::Validations::ApplicationContract
      params do
        required(:name).filled(:string)
        required(:product_id).filled(:integer)

        # rule product
      end
    end

    def call(params)
      params = yield Contract.new.validate_params(params)
      product(params)
      ::Entities::Create.new.call(mediaset: create_mediaset(params))
    end

    private

    def create_mediaset(params)
      @product.mediasets.create(params[:name])
    end

    def product(params)
      @product ||= Product.find(params[:product_id])
    end
  end
end
