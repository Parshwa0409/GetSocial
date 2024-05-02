class LikesController < ApplicationController
    # skip_before_action :verify_authenticity_token

    def create
        post = Post.find(params[:id])
        
        like = Like.create(user:active_user, post: post)

        if like.save()
            recipient = post.user
            unless recipient==active_user
                notification = PostActivityNotifier.with(record: post, message: " liked your post.", sender_email: active_user.email, recipient_id: recipient.id, post_create: false).deliver(recipient) 
                ActionCable.server.broadcast("pan_channel",notification)
            end
            likes = post.total_likes + 1
            post.update(total_likes: likes)
        end
    end
    
    def destroy
        post = Post.find(params[:id])
        like = Like.find_by(user_id: active_user.id, post_id: post.id)

        if like.present?
            like.destroy
            likes = post.total_likes - 1
            post.update(total_likes: likes)
        end
    end
end
