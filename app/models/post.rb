class Post < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    
    has_many :likes, dependent: :destroy

    validates :caption, presence: true
    before_create :valid_image


    # TODO: ADD COMMENT ASSOCIATIONS & LIKES ASSOCIATION
    # TODO: ADD LIKES ASSOCIATION
    private
    def valid_image
        unless image.attached?
            errors.add(:base,:invalid,message:"Post must have an iamge attachment.")
            throw(:abort)
        end
    end
end
