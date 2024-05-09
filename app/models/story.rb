class Story < ApplicationRecord
  has_one_attached :pic
  
  before_create :valid_image
  
  belongs_to :user
  has_many :story_views, dependent: :destroy
  private

  def valid_image
      unless pic.attached?
          errors.add(:base,:invalid,message:"Story must have an iamge attachment.")
          throw(:abort)
      end
  end
end
