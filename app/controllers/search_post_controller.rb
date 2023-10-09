class SearchPostController < ApplicationController
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:reviews).order(created_at: :desc)
  end
  
  def show
    @q = Post.ransack(params[:q])
    @results = @q.result(distinct: true).includes(:reviews).order(created_at: :desc)
  end
end
