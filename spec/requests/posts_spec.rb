require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user, created_at: Time.current) }
  
  before do
    sign_in user
  end

  describe "GET /posts" do
    it "正常にレスポンスを返す" do
      get posts_path
      expect(response).to have_http_status(200)
    end

    it "投稿情報が表示されていること" do
      get posts_path
      expect(response.body).to include post.name
      expect(response.body).to include post.address
      expect(response.body).to include post.created_at.strftime('%Y年 %m月%d日')
    end
  end

  describe "GET /posts?avg_score_and_review_count" do
    it "正常なレスポンスを返す" do
      get posts_path, params: { sort_by: 'avg_score_and_review_count' }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /posts?latest=true" do
    it "正常なレスポンスを返す" do
      get posts_path, params: { latest: true }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /posts?reviews_count=true" do
    it "正常なレスポンスを返す" do
      get posts_path, params: { reviews_count: true }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /posts/:id" do
    it "正常にレスポンスを返す" do
      get post_path(post)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /posts/new" do
    it "正常にレスポンスを返す" do
      get new_post_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE /posts/id' do
    it '投稿が正常に削除される' do
      expect {
        delete post_path(post)
      }.to change(Post, :count).by(-1)
      expect(flash[:notice]).to eq I18n.t('flash.notice.posts.post_deleted')
    end

    it '正常にレスポンスを返す' do
      delete post_path(post)
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /posts/:id/all_reviews" do
    it "正常にレスポンスを返す" do
      get all_reviews_post_path(post)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /posts/:id/related" do
    it "正常にレスポンスを返す" do
      get related_post_path(post)
      expect(response).to have_http_status(200)
    end
  end
end
