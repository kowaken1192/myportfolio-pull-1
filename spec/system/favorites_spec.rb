require 'rails_helper'

RSpec.describe "Favorites", type: :system do
  let(:user) { create(:user) }
  let!(:post) { create(:post) }
  let!(:favorite_posts) { create_list(:post, 2, user: user, postimage: Rack::Test::UploadedFile.new('spec/fixtures/test.jpeg', 'image/jpeg')) }
   
  describe "Favorites", type: :system do
    before do
      sign_in user
      favorite_posts.each { |post| user.favorites.create(post: post) }
      @favorite_posts = favorite_posts
      @favorited_post_ids = favorite_posts.map(&:id)
      visit favorites_user_path(user)
    end
  
    it '必要な投稿内容の情報が表示されていること' do
      @favorite_posts.each do |post|
        expect(page).to have_content(post.name)
        expect(page).to have_content(post.address)
        expect(page).to have_content(post.created_at.strftime('%Y年 %m月%d日'))
        expect(page).to have_selector("img[src='#{post.postimage.url}']")
        expect(page).to have_css('.star-rating-front', style: "width: #{post.review_score_percentage}%")
      end
    end
  
    it 'お気に入りアイコンが正しく表示されていること' do
      @favorite_posts.each do |post|
        if @favorited_post_ids.include?(post.id)
          expect(page).to have_css("i.fas.fa-heart")
        else
          expect(page).to have_css("i.far.fa-heart")
        end
      end
    end
  end
end
