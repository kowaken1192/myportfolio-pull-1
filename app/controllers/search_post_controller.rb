class SearchPostController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:reviews).order(created_at: :desc)
  end
  
  def show
    @q = Post.ransack(params[:q])
    @results = @q.result(distinct: true).includes(:reviews).order(created_at: :desc)
    @prefecture_name = params[:q][:address_cont] if params[:q] && params[:q][:address_cont]
  end

  def count_by_prefecture
    counts = Post.group(:prefecture).count
    render json: counts
  end
end
