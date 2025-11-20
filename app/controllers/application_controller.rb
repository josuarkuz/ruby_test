class ApplicationController < ActionController::API
  before_action :require_authentication
  
  private

  def current_user
    return @current_user if defined?(@current_user)

    header = request.headers["Authorization"]
    return @current_user = nil unless header&.start_with?("Bearer ")

    token = header.split(" ").last
    begin
      payload = Auth::JWTService.decode(token)
    rescue StandardError
      payload = nil
    end

    user_id = payload&.[](:user_id) || payload&.[]("user_id")
    @current_user = user_id ? User.find_by(id: user_id) : nil
  end

  def require_authentication
    return if current_user.present?

    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
