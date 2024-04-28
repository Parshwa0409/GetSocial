class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  
  validates :content, presence: { message: "Cannot post an empty comment 😒" }
end
