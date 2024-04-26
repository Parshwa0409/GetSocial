class Post < ApplicationRecord
    has_one_attached :image
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy

    belongs_to :user

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
