module V1
  class SessionSerializer < ApplicationSerializer
    def render(session)
      session.slice(:access_token_expires_at, :access_token, :refresh_token, :refresh_token_expires_at)
    end
  end
end
