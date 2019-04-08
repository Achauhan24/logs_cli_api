class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ALGORITHM = 'HS512'.freeze
  paginates_per 50

  def name
    [first_name, last_name].join(' ').titleize
  end

  def password_complexity
    return if password.blank? || password.match?(PASSWORD_REGEX)
    errors.add :password, 'should include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

  def generate_token(exp = true)
    payload = { id: id }
    (payload[:exp] = Time.current.to_i + 1.week) if exp
    JWT.encode(payload, 
               ENV_SECRETS[:secret_key_base].to_s,
               ALGORITHM)
  end
end
