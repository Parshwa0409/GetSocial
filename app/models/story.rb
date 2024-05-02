class Story < ApplicationRecord
  belongs_to :user
  has_many :story_views, dependent: :destroy
  has_one_attached :pic
  before_create :valid_image
  private

  def valid_image
      unless pic.attached?
          errors.add(:base,:invalid,message:"Story must have an iamge attachment.")
          throw(:abort)
      end
  end
end
