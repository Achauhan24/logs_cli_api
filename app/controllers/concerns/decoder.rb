module Decoder
  
  attr_accessor :current_user

  def authenticate
    
    status = decode_token(request.headers['X-ACCESS-TOKEN']) 

    if @payload.nil?
      render json: { error: I18n.t("jwt.#{status}") }, status: status
      return 
    end
    set_current_user
  end

  def set_current_user
    @current_user ||= User.find_by(id: @payload['id'])
  end

  def decode_token(token)
    @payload = JWT.decode(token, 
                          ENV_SECRETS[:secret_key_base],
                          true,
                          algorithm: User::ALGORITHM).first
    :success 
  rescue JWT::ExpiredSignature
    :unauthorized
  rescue JWT::ImmatureSignature, JWT::DecodeError
    :unauthorized  
  end
end
