module Api
  module V1
    class UsersController < ApplicationController
      def create
        process_interaction_result(::Users::Create.new.call(params)) do |_|
          head 201
        end
      end

      def confirmation
        process_interaction_result(::Users::Sessions::Confirmation.new.call(params)) do |result|
          render json: { data: result }
        end
      end

      def accept; end
    end
  end
end
