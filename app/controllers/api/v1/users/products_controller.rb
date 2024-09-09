module Api
  module V1
    module Users
      class ProductsController < Api::V1::ApiController
        before_action :authenticate_user
        def index
          render json: { data: current_user.products }
        end

        def show
          render json: { data: current_user.products.find(params[:product_id]) }
        end

        def create
          process_interaction_result(::V1::Users::Products::Create.new.call(params)) do |_result|
            render json: { data: current_user.products }
          end
        end

        def update
          process_interaction_result(::V1::Users::Products::Update.new.call(params)) do |_result|
            render json: { data: current_user.products }
          end
        end

        def destroy
          current_user.products.find(params[:product_id]).destroy
          head :no_content
        end
      end
    end
  end
end
