module Api
  module V1
    class ApiController < ActionController::API
      include ActionController::Helpers
      include Authenticable
      include Renderable
    end
  end
end
