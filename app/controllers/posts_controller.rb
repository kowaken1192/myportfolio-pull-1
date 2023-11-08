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
  
  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      @review = current_user.reviews.new(review_params)
      @review.post = @post
      if @review.save
        related_posts
      else
        @post.destroy 
        render :new
      end
    else
      render :new
    end
  end
    
  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      flash[:notice] = t('flash.notice.post_deleted')
      redirect_to :users
    end
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

  def related_posts
    related_posts = Post.where(prefecture: @post.prefecture)
                        .where.not(id: @post.id).limit(5)
    if related_posts.exists?
      flash[:notice] = t('flash.notice.posts.post_recommendation')
    else
      flash[:notice] = t('flash.notice.posts.post_thank_you')
    end
    redirect_to related_post_path(@post)
  end
end
