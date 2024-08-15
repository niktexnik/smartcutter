module Api
  module V1
    module Users
      class ProfileController < ::Api::V1::ApiController
        before_action :authenticate_user
        def show
          render_current_user
        end

        def update
          process_interaction_result(::V1::Users::Profile::Update.new.call(current_user, params)) do |_result|
            render_current_user
          end
        end

        def change_password
          process_interaction_result(::V1::Users::Profile::ChangePassword.new.call(params,
                                                                                   user: current_user)) do |_result|
            render_current_user
          end
        end

        def change_email
          process_interaction_result(::V1::Users::Profile::ChangeEmail.new.call(current_user, params)) do |_result|
            render_current_user
          end
        end

        def destroy
          current_user.destroy
          head :no_content
        end
      end
    end
  end
end
