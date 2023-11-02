class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  
  def index
    @posts = Post.with_counts.with_avg_score
    if params[:sort_by] == 'avg_score_and_review_count'
      @posts = @posts.avg_score_and_review_count
    elsif params[:latest]
      @posts = @posts.latest
    elsif params[:reviews_count]
      @posts = @posts.reviews_count
    else
      @posts = @posts.all
    end
    @favorited_post_ids = current_user.favorites.pluck(:post_id)
  end
  
  def show
    @post = Post.with_counts.with_avg_score.find(params[:id])
    @reviews = @post.reviews.eager_load(:user)
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
        @related_posts = Post.where(prefecture: @post.prefecture).where.not(id: @post.id).limit(5)
    
        if @related_posts.empty?
          flash[:notice] = '投稿ありがとうございます！あなたの投稿はありがとうございます！'
          redirect_to related_post_path(@post)
        else
          flash[:notice] = '投稿ありがとうございます!あなたにおすすめの投稿が表示されます！'
          redirect_to related_post_path(@post)
        end
      else
        @post.destroy
        render :new
      end
    else
      render :new
    end
  end
    
  def edit
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "ユーザーを削除しました"
    redirect_to posts_path
  end
  
  
  def all_reviews
    @post = Post.find(params[:id])
    @reviews = @post.reviews.eager_load(:user)
  end
    
  def related
    @post = Post.find(params[:id])
    @related_posts = Post.with_counts.with_avg_score.where(prefecture: @post.prefecture).where.not(id: @post.id).limit(5)
  end
  
  private

  def post_params
    params.require(:post).permit(:name, :address, :detail, :country,:prefecture,:postimage ,:user_id)
  end
  
  def review_params
    params.require(:post).require(:review).permit(:score, :content)
  end   
end
