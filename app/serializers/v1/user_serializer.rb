module V1
  class UserSerializer < ApplicationSerializer
    def render(user)
      user.slice(:id, :email, :phone, :email_confirmed, :agreement).merge(full_name: user.full_name)
    end
  end
end
