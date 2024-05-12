class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  has_one_attached :attachment
  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"

  validates :msg, presence: { message: "cannot be empty 😒" }
end