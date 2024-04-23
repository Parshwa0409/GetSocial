class LikesController < ApplicationController
    skip_before_action :verify_authenticity_token

    
    def create
        post = Post.find(params[:id])
        
        like = Like.create(user:current_user, post: post)

        if like.save()
            likes = post.total_likes + 1
            post.update(total_likes: likes)
        end

        # render :json => post.to_json()
    end
    
    def destroy
        # debugger
        post = Post.find(params[:id])
        like = Like.find_by(user_id: current_user.id, post_id: post.id)

        if like.present?
            like.destroy
            likes = post.total_likes - 1
            post.update(total_likes: likes)
        end

        # render :json => post.to_json()
    end
end
