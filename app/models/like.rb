class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"
end
