module Api
  module V1
    module Users
      class MediasetsController < ApplicationController
        def index
          render json: { data: current_user.mediasets }
        end

        def show
          render json: { data: mediaset }
        end

        def create
          process_interaction_result(::Mediasets::Create.new.call(params)) do |result|
            render json: { data: result }
          end
        end

        def regenerate
          process_interaction_result(::Mediasets::Regenerate.new.call(params)) do |result|
            render json: { data: result }
          end
        end

        def destroy
          mediaset.destroy
          head 204
        end

        private

        def mediaset
          @mediaset ||= current_user.mediasets.find(params[:mediaset_id])
        end
      end
    end
  end
end
