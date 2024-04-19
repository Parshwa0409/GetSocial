class User < ApplicationRecord

  has_many :posts
  
  has_one_attached :profile_picture
  has_one_attached :cover_photo


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
