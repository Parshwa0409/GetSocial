class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"

  validates_uniqueness_of :user_id, scope: :post_id
end
