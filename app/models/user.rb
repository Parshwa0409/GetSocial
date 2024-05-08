class User < ApplicationRecord

  has_one_attached :profile_picture
  has_one_attached :cover_photo
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"
  has_many :notification_preferences, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :story_views, dependent: :destroy
  
  validates :name, presence: { message: "cannot be empty." }
  validates :password, format: {with: /.{8,}/, message: " must be minimum 8 characters"}
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "must be of valid format"}, uniqueness: true

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github, :google_oauth2]

  followability

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
