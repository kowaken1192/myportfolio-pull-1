class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
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
        @related_posts = Post.where(address: @post.address).where.not(id: @post.id).limit(5)
    
        if @related_posts.empty?
          flash[:notice] = '投稿ありがとうございます！関連する投稿は見つかりませんでした。'
          redirect_to related_post_path(@post)
        else
          flash[:notice] = '投稿ありがとうございます!あなたの投稿に関連する投稿が表示されます'
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
    if @post.user == current_user
      @post.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to :users
    end
  end
  
  def all_reviews
    @post = Post.find(params[:id])
    @reviews = @post.reviews
  end
  
  def related
    @post = Post.find(params[:id])
    @related_posts = Post.where(address: @post.address).where.not(id: @post.id).limit(5)
  end

  private

  def post_params
    params.require(:post).permit(:name, :address, :detail, :country, :postimage ,:user_id)
  end
  
  def review_params
    params.require(:post).require(:review).permit(:score, :content)
  end   
end
