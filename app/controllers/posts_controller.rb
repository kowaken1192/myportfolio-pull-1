class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end
  
  def create
    @review = Review.new
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @review = Review.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:name, :address, :detail, :country, :post_image)
  end
end

