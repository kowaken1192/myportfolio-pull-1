class SearchPostController < ApplicationController
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:reviews).order(created_at: :desc)
  end
  
  def result
    @q = Post.ransack(params[:q])
    @results = @q.result(distinct: true).with_counts_and_avg_score
    if params[:sort_by] == 'avg_score_and_review_count'
      @results = @results.avg_score_and_review_count
    elsif params[:latest]
      @results = @results.latest
    elsif params[:reviews_count]
      @results = @results.reviews_count
    end
    @favorited_post_ids = current_user.favorites.pluck(:post_id)
    @prefecture_name = params[:q][:address_cont] if params[:q] && params[:q][:address_cont]
  end
  
  def count_by_prefecture
    counts = Post.group(:prefecture).count
    render json: counts
  end
end
