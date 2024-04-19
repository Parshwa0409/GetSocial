class User < ApplicationRecord

  # Associations
  has_many :posts


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: [:github, :google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
        user = User.create(
          name: data['name'],
          email: data['email'],
          profile_picture: data['image'],
          password: Devise.friendly_token[0,20]
        )
    end

    user
  end
end
