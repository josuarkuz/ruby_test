class ApplicationController < ActionController::API
  before_action :require_authentication

  def current_user
    return @current_user if defined?(@current_user)

    header = request.headers["Authorization"]
    return nil unless header&.start_with?("Bearer ")

    token = header.split(" ").last
    payload = Auth::JWTService.decode(token)
    @current_user = User.find_by(id: payload[:user_id])
  end

  def require_authentication
    return if current_user.present?

    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
