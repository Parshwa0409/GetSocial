class Post < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    
    # TODO: VALIDATE CAPTION & IMAGE
    validates :caption, presence: true
    before_create :valid_image

    private
    def valid_image
        unless image.attached?
            errors.add(:base,:invalid,message:"Post must have an iamge attachment.")
            throw(:abort)
        end
    end
end
