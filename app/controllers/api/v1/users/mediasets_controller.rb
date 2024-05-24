module Api
  module V1
    class MediasetsController < ApplicationController
      before_action :mediaset
      def index
        render json: { data: current_user.mediasets }
      end

      def show
        render json: { data: mediaset }
      end

      def create
        ::Mediasets::Create.new.call(params)
      end

      def regenerate
        ::Mediasets::Regenerate.new.call(params)
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
