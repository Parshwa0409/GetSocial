class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: { message: "Cannot post an empty comment 😒" }
end
