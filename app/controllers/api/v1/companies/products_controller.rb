module Api
  module V1
    module Companies
      class ProductsController < Api::V1::ApiController
        before_action :authenticate_user
        def index
          render json: { data: current_company.products }
        end

        def show
          render json: { data: current_company.products.find(params[:product_id]) }
        end

        def create
          process_interaction_result(::V1::Companies::Products::Create.new.call(params)) do |_result|
            render json: { data: current_company.products }
          end
        end

        def update
          process_interaction_result(::V1::Companies::Products::Update.new.call(params)) do |_result|
            render json: { data: current_company.products }
          end
        end

        def destroy
          current_company.products.find(params[:product_id]).destroy
          head :no_content
        end
      end
    end
  end
end
