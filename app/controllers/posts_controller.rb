class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_post, only: [:destroy, :related, :all_reviews]

  def index
    @posts = Post.with_counts.with_avg_score
    if params[:sort_by] == 'avg_score_and_review_count'
      @posts = @posts.avg_score_and_review_count
    elsif params[:latest]
      @posts = @posts.latest
    elsif params[:reviews_count]
      @posts = @posts.reviews_count
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
    @post = current_user.posts.new(post_params)
    @review = @post.reviews.new(review_params)
    @review.user = current_user
    ActiveRecord::Base.transaction do
      @post.save!
      @review.save!
      recommend_related_posts
    rescue ActiveRecord::RecordInvalid
      render :new 
    end
  end
      
  def destroy
    if @post.user == current_user
      @post.destroy
      flash[:notice] = t('flash.notice.post_deleted')
      redirect_to :users
    end
  end
  
  def all_reviews
    @reviews = @post.reviews.eager_load(:user)
  end
    
  def related
    @related_posts = Post.with_counts.with_avg_score.where(prefecture: @post.prefecture).where.not(id: @post.id).limit(5)
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:name, :address, :detail, :country,:prefecture,:postimage)
  end
  
  def review_params
    params.require(:post).require(:review).permit(:score, :content)
  end

  def recommend_related_posts
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
