class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :destroy]
  before_action :initialize_post, only: [:new]

  def show
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

  # TODO: CHALLENGES
  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def initialize_post
    @post = current_user.posts.new()
  end
end
