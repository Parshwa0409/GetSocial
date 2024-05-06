module Profiles
  class Details
    def self.call(user)
        user.posts.includes(:image_attachment).order("created_at DESC ")
    end
  end
end
