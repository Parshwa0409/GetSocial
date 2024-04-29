class LikesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        post = Post.find(params[:id])
        
        like = Like.create(user:current_user, post: post)

        if like.save()
            recipient = post.user
            notification = PostActivityNotifier.with(record: post, message: " liked your post.", user_email: current_user.email).deliver(recipient) unless recipient==current_user
            ActionCable.server.broadcast("pan_channel",notification)
            likes = post.total_likes + 1
            post.update(total_likes: likes)
        end
    end
    
    def destroy
        post = Post.find(params[:id])
        like = Like.find_by(user_id: current_user.id, post_id: post.id)

        if like.present?
            like.destroy
            likes = post.total_likes - 1
            post.update(total_likes: likes)
        end
    end
end
