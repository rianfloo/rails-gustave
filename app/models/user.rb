class User < ApplicationRecord
  has_many :meals, dependent: :destroy
  has_many :steps
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, omniauth_providers: [:facebook]

  def self.find_for_facebook_oauth(auth)
    user_params = auth.to_h.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)

    token = user_params[:token]
    url_picture = TokenPicture.run(token)
    uniq_facebook = UniqFacebook.run(url_picture)
    user_params[:uniq_facebook] = uniq_facebook

    user = User.where(uniq_facebook: uniq_facebook).take
    user ||= User.where(provider: auth.provider, uid: auth.uid).take
    user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

  def self.find_or_create_by_messenger_id(messenger_id)
    messenger_hash = GetMessengerId.run(messenger_id)
    uniq_facebook = UniqFacebook.run(messenger_hash["profile_pic"])
    user = User.where(uniq_facebook: uniq_facebook).take

    user_params = GetMessengerId.run(messenger_id)
    user_params[:email] = "#{user_params['first_name'].parameterize}.#{user_params['last_name'].parameterize}#{rand(999)}@gustave.wine"
    if user
      user.update(user_params)
    else
      User.create(user_params)
    end
    user
  end
end
