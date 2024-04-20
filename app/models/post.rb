class Post < ApplicationRecord

    belongs_to :user

    has_one_attached :image

    before_create :valid_image

    private
    def valid_image
        unless image.attached?
            errors.add(:base,:invalid,message:"YOU NEED TO ADD AN IMAGE TO THE POST !!!")
            throw(:abort)
        end
    end
end
