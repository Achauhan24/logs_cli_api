class UsersController < ApplicationController

  def index
    @users = User.page(params[:page]).order('id ASC')
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { message: I18n.t('user.create.success'), user_id: user.id }, status: :created
    else
      render json: { errors: user.errors.messages }, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
