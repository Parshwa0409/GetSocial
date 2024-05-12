class CommentsController < ApplicationController
    before_action :set_post

    def index
        @comments = @post.comments.includes(:user).order("created_at DESC")
        render partial:"comments/comments", locals: {comments: @comments}
    end

    def create
        @comment = @post.comments.create(comment_params)
        if @comment.save()
            @post.update(total_comments: (@post.total_comments + 1))
            Notifier::PostActivity.notify(
                " commented on your post: '#{@comment.content}'",
                false,
                @post,
                active_user.email,
                @post.user
            )
            render partial:"comments/comment", locals:{comment: @comment}
        else
            render partial:"comments/create_comment_error", locals:{comment: @comment}
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
