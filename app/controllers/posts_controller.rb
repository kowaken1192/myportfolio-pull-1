class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @review = Review.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user = current_user
  
    @review = Review.new(review_params)
    @review.user = current_user
  
    if @post.save
      @review.post_id = @post.id
      if @review.save
        redirect_to posts_path, notice: '投稿が成功しました。'
      else
        @post.destroy  
        render :new
      end
    else
      render :new
    end
  end
  
  def detail
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
    params.require(:post).permit(:name, :address, :detail, :country, :avatar ,:user_id)
  end
  
  def review_params
    params.require(:post).require(:review).permit(:score, :content)
  end   
end
