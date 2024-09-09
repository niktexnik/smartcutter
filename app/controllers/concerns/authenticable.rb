module Authenticable
  extend ActiveSupport::Concern

  included do
    helper_method :current_user

    def access_token
      request.headers['X-Auth-Token']
    end

    def current_session
      @current_session ||= access_token.present? ? Session.includes(device: :user).access_token_active.find_by(access_token:) : nil
    end

    def current_user
      @current_user ||= current_session&.user
    end

    def current_device
      @current_device ||= current_session&.device
    end

    def current_company
      @current_company ||= current_user&.company
    end

    def render_current_session
      render json: current_session ? ::V1::SessionSerializer.render(current_session) : nil
    end

    def render_current_user
      render json: current_session ? ::V1::UserSerializer.render(current_user) : nil
    end

    def authenticate_user
      render_interaction_error(InteractionErrors.authentication_error) unless current_user
    end
  end
end
