class CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_post

    def index
        comments = @post.comments.includes(:user).order("created_at DESC")
        render partial:"comments/all_comments", locals: {comments: comments}
    end

    def create
        comment = @post.comments.create(comment_params)
        if comment.save()
            @post.update(total_comments: (@post.total_comments + 1))
            render partial:"comments/comment", locals:{comment: comment}
        else
            render partial:"comments/error", locals:{comment: comment}
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content).merge(user_id: current_user.id)
    end

    def set_post
        @post = Post.find(params[:post_id])
    end
end
