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
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end
  
  def detail
    @post = Post.find(params[:id])
    @review = Review.new
  end

  def show
    @post = Post.find(params[:id])
    @review = Review.new
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to :users
    end
  end

  private
  def post_params
    params.require(:post).permit(:name, :address, :detail, :country, :avatar)
  end
end
