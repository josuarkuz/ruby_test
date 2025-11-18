class SessionsController < ApplicationController
  skip_before_action :require_authentication

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = Auth::JWTService.encode({ user_id: user.id })
      render json: { token:, user: }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end
end
