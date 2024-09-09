module Api
  module V1
    module Companies
      class UsersController < Api::V1::ApiController
        def invite
          process_interaction_result(::V1::Companies::Users::Invite.new.call(params)) do |_result|
            render json: { data: current_company.users }
          end
        end

        def kick
          process_interaction_result(::V1::Companies::Users::Kick.new.call(params)) do |_result|
            render json: { data: current_company.users }
          end
        end
      end
    end
  end
end
