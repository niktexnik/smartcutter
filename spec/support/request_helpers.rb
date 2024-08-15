module RequestHelpers
  def json_body
    JSON.parse(response.body)
  end

  def sign_in(user)
    post login_api_v1_sessions_path, params: {
      email: user.email,
      password: user.password
    }
    allow_any_instance_of(ActionDispatch::Request).to receive(:headers) { { 'X-Auth-Token' => user.devices.first.sessions.first.access_token } }
  end
end
