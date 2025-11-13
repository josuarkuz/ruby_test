module Api
  module V1
    class AuthController < ApplicationController
      def register
        user = User.new(user_params)
        if user.save
          render json: { token: encode_token({ user_id: user.id }) }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          render json: { token: encode_token({ user_id: user.id }) }
        else
          render json: { error: "Invalid credentials" }, status: :unauthorized
        end
      end

      def me
        require_auth!
        render json: UserSerializer.new(current_user).as_json
      end

      private

      def user_params
        params.permit(:email, :name, :password, :password_confirmation)
      end
    end
  end
end
