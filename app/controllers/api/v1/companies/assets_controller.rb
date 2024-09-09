module Api
  module V1
    module Companies
      class AssetsController < Api::V1::ApiController
        before_action :authenticate_user
        def index
          render json: { data: current_company.assets }
        end

        def show
          render json: { data: current_company.assets.find(params[:asset_id]) }
        end

        def create
          process_interaction_result(::V1::Companies::Assets::Create.new.call(params)) do |_result|
            render json: { data: current_company.assets }
          end
        end

        def update
          process_interaction_result(::V1::Companies::Assets::Update.new.call(params)) do |_result|
            render json: { data: current_company.assets }
          end
        end

        def destroy
          current_company.assets.find(params[:asset_id]).destroy
          head :no_content
        end
      end
    end
  end
end
