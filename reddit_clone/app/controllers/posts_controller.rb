class PostsController < ApplicationController
  before_action :require_author, only: [:edit, :update]

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def new
    @post = Post.new
    render :new
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.where(parent_id: nil)

    render :show
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids => [])
  end

  def require_author
    @post = Post.find(params[:id])

    unless current_user.id == @post.author_id
      flash[:errors] = ["Not the author"]
      redirect_to post_url(@post)
    end
  end
end
