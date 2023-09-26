class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @post = Post.find(params[:post_id])
    @reviews = @post.reviews
  end

  def new 
    @post = Post.find(params[:post_id])
    @review = Review.new
  end
  
  def create
    @post = Post.find(params[:post_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to post_reviews_path
    else
      render :new
    end
  end

  private
  def review_params
    params.require(:review).permit(:post_id, :score, :content)
  end
end
