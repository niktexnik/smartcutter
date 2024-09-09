module Api
  module V1
    module Companies
      class MediasetsController < Api::V1::ApiController
        before_action :authenticate_user
        def index
          render json: { data: current_user.company.mediasets }
        end

        def show
          render json: { data: mediaset }
        end

        def create
          process_interaction_result(::V1::Companies::Mediasets::Create.new.call(params)) do |result|
            render json: { data: result }
          end
        end

        def regenerate
          process_interaction_result(::V1::Companies::Mediasets::Regenerate.new.call(params)) do |result|
            render json: { data: result }
          end
        end

        def destroy
          mediaset.destroy
          head :no_content
        end

        private

        def mediaset
          @mediaset ||= current_user.company.mediasets.find(params[:mediaset_id])
        end
      end
    end
  end
end
