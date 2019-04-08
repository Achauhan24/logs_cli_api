class Users::SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:create]
  before_action :find_user, only: :create

  # POST /resource/sign_in
  def create
    if @user.valid_password?(params[:password])
      response.headers['X-ACCESS-TOKEN'] = @user.generate_token
      render 'users/show', status: :ok
    else
      render json: { errors: I18n.t('user.invalid') }, status: :unprocessable_entity
    end
  end

  private

  def find_user
    return render json: { errors: I18n.t('user.empty_email') }, status: :not_found if params[:email].blank?
    
    @user = User.find_by('email = ?', params[:email])
    render json: { errors: I18n.t('user.invalid_email') }, status: :not_found unless @user
  end
end
