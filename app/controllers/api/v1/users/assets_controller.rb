module Api
  module V1
    module Users
      class AssetsController < Api::V1::ApiController
        before_action :authenticate_user
        def index
          render json: { data: current_user.assets }
        end

        def show
          render json: { data: current_user.assets.find(params[:asset_id]) }
        end

        def create
          process_interaction_result(::V1::Users::Assets::Create.new.call(params)) do |_result|
            render json: { data: current_user.assets }
          end
        end

        def update
          process_interaction_result(::V1::Users::Assets::Update.new.call(params)) do |_result|
            render json: { data: current_user.assets }
          end
        end

        def destroy
          current_user.assets.find(params[:asset_id]).destroy
          head :no_content
        end
      end
    end
  end
end
