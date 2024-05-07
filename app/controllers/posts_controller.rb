class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def show
    @user = @post.user
    @comments = @post.comments.includes(:user).order("created_at DESC")
  end

  def new
    @post = current_user.posts.new()
  end

  def create
    @post = active_user.posts.create(post_params)

    if @post.save()
      recipients = get_preferred_notifiers()

      Notifier::PostActivity.notify_all(
        " has posted something new.",
        true,
        @post,
        active_user.email,
        recipients
      )

      redirect_to post_path(@post)
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      redirect_to request.referrer
    end
  end

  def edit
  end

  def update
    @post.update(post_params)
    
    if @post.save()
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy()

    redirect_to profile_path(active_user)
  end

  def share
    post = Post.find(params[:post_id])

    Notifier::PostActivity.notify(
      " shared a post by #{post.user.email}.",
      false,
      @post,
      active_user.email,
      User.find(params[:user_id])
    )
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def get_preferred_notifiers()
    User.where(
      id: NotificationPreference
      .where(preferred_user: active_user)
      .pluck(:preferred_notifier_id)
    )
  end

end
