class LikesController < ApplicationController
    # skip_before_action :verify_authenticity_token
    before_action :set_post

    def create
        like = Like.create(user:active_user, post: @post)

        if like.save()
            Notifier::PostActivity.notify(
                " liked your post.",
                false,
                @post,
                active_user.email,
                @post.user
            )

            update_post_likes(@post, true)
        end
    end
    
    def destroy
        like = Like.find_by(user_id: active_user.id, post_id: @post.id)

        if like.present?
            like.destroy
            update_post_likes(@post, false)
        end
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def update_post_likes(post, liked_flag)
        likes = liked_flag ? (post.total_likes + 1) : (post.total_likes - 1)
        post.update(total_likes: likes)
    end
end
