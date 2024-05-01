class CommentsController < ApplicationController
    # skip_before_action :verify_authenticity_token
    before_action :set_post

    def index
        comments = @post.comments.includes(:user).order("created_at DESC")
        render partial:"comments/comments", locals: {comments: comments}
    end

    def create
        comment = @post.comments.create(comment_params)
        if comment.save()
            recipient = @post.user
            @post.update(total_comments: (@post.total_comments + 1))
            unless recipient==current_user
                notification = PostActivityNotifier.with(record: @post, message: " commented on your post: '#{comment.content}'", sender_email: current_user.email, recipient_id: recipient.id).deliver(recipient) 
                ActionCable.server.broadcast("pan_channel",notification)
            end
            render partial:"comments/comment", locals:{comment: comment}
        else
            render partial:"comments/create_comment_error", locals:{comment: comment}
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
