class UsersController < ApplicationController
  skip_before_action :require_authentication, only: [:create]

  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      token = Auth::JWTService.encode({ user_id: user.id })
      render json: { token:, user: }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
