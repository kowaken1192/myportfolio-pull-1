class ReviewsController < ApplicationController  
  def new 
    @post = Post.find(params[:post_id])
    @review = Review.new
  end
  
  def create
    @post = Post.find(params[:post_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to post_path(@post)
    else
      flash[:alert] = t('flash.alert.reviews.failed to save.')
      render 'reviews/new'
    end
  end
  
  private

  def review_params
    params.require(:review).permit(:title, :content, :score, :post_id, review_images: [])
  end
end
