module Authenticatable
  extend ActiveSupport::Concern

  included do
    # before_action :validate_session_expiration
    before_action :check_device_documents_confirmation

    private

    def session_token
      request.headers['X-Auth-Token']
    end

    def current_session
      @current_session ||= session_token.present? ? SessionRecord.includes(device: :user).access_token_active.find_by(access_token: session_token) : nil
    end

    def current_device
      @current_device ||= current_session&.device
    end

    def current_user
      current_device&.user
    end

    def validate_session_expiration
      if session_token.present? && (current_session&.access_token_expires_at.blank? || current_session&.expired?)
        raise Errors::SessionExpired
      end
    end

    def check_device_documents_confirmation
      raise Errors::DeviceDocumentsConfirmationFailed if current_device&.document_confirmation&.blocked?
      return unless current_device&.document_confirmation && Rails.env.production?

      raise Errors::DeviceDocumentsConfirmationRequired
    end

    def authenticate_device
      return if current_device.present? && update_device_app_version

      raise Errors::Unauthenticated, message: I18n.t(:device_unauthenticated,
                                                     scope: 'errors.active_interaction',
                                                     locale: I18n.locale)
    end

    def authenticate_user
      raise Errors::Unauthenticated if current_user.blank?
    end

    def merge_current_session_into_params
      params.merge!(session: current_session)
    end

    def merge_current_device_into_params_as_device
      authenticate_device
      params.merge!(device: current_device)
    end

    def merge_current_user_to_params_as_current_user
      authenticate_user
      params.merge!(current_user:)
    end

    def merge_ip_to_params
      params.merge!(ip: request.remote_ip)
    end

    def update_device_app_version
      app_version = request.headers['X-App-Version']
      current_device.update(app_version:) if app_version.present?
      true
    end
  end
end
