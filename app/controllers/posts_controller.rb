class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :initialize_post, only: [:new]

  def show
    @user = @post.user
    @comments = @post.comments.includes(:user).order("created_at DESC")
  end

  def new
  end

  def create
    @post = current_user.posts.create(post_params)

    if @post.save()
      redirect_to post_path(@post)
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      redirect_to request.referrer # redirect to same page, see how to just show the flash message
    end
  end

  def destroy
    user = @post.user()
    @post.destroy()
    redirect_to profile_path(user)
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

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def initialize_post
    @post = current_user.posts.new()
  end
end
