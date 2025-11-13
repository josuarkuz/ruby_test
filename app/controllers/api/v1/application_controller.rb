module Api
  module V1
    class ApplicationController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      private

      def jwt_secret = ENV.fetch("JWT_SECRET")

      def encode_token(payload)
        JWT.encode(payload, jwt_secret, "HS256")
      end

      def auth_header
        request.headers["Authorization"]
      end

      def decoded_token
        return unless auth_header&.starts_with?("Bearer ")
        token = auth_header.split(" ").last
        JWT.decode(token, jwt_secret, true, { algorithm: "HS256" })
      rescue JWT::DecodeError
        nil
      end

      def current_user
        return @current_user if defined?(@current_user)
        user_id = decoded_token&.first&.dig("user_id")
        @current_user = User.find_by(id: user_id)
      end

      def require_auth!
        render json: { error: "Unauthorized" }, status: :unauthorized unless current_user
      end

      def not_found
        render json: { error: "Not Found" }, status: :not_found
      end
    end
  end
end
