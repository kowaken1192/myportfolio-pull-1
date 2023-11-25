require 'rails_helper'

RSpec.describe "Posts", type: :system do
  describe "Posts System Tests" do
    let(:user) { create(:user) }
    let!(:post) { create(:post, created_at: Time.current, detail: "楽しかった") }
    let!(:review) { create(:review, post: post, user: user) }

    before do
      sign_in user
    end

    describe "#index" do
      before do
        visit posts_path
      end

      it 'ホーム画面に必要な情報が表示されているか' do
        expect(page).to have_content(post.name)
        expect(page).to have_content(post.address)
        expect(page).to have_content(post.created_at.strftime('%Y年 %m月%d日'))
      end

      it 'レビュースコアが正しく表示されていること' do
        expect(page).to have_css('.star-rating-front', style: "width: #{post.review_score_percentage}%")
      end
      
      it '投稿の詳細ページに遷移できること' do
        expect(page).to have_link 'この投稿の詳細へ', href: "/posts/#{post.id}"
      end

      it '各ボタンのリンクが表示される' do
        expect(page).to have_link '投稿一覧', href: "/posts"
        expect(page).to have_link '人気投稿', href: "/posts?sort_by=avg_score_and_review_count"
        expect(page).to have_link '最新の投稿', href: "/posts?latest=true"
        expect(page).to have_link '口コミの多い投稿', href: "/posts?reviews_count=true"
      end
    end

    describe "#show" do
      before do
        visit post_path(post)
      end

      it '投稿の詳細が表示されていること' do
        expect(page).to have_content(post.name)
        expect(page).to have_content(post.address)
        expect(page).to have_content(post.detail)
        expect(page).to have_content(post.country)
        expect(page).to have_content(post.created_at.strftime('%Y年 %m月%d日'))
      end

      it 'レビュースコアが正しく表示されていること' do
        expect(page).to have_css('.star-rating-front', style: "width: #{post.review_score_percentage}%")
      end

      it '投稿の一覧ページに遷移できること' do
        click_on '投稿一覧に戻る'
        expect(current_path).to eq(posts_path)
      end
      
      it '口コミの一覧ページに遷移できること' do
        click_on '全ての口コミを見る'
        expect(current_path).to eq(all_reviews_post_path(post.id))
      end
      
      it '口コミを書くページに遷移できること' do
        click_on 'このスポットの口コミを書く'
        expect(current_path).to eq(new_post_review_path(post.id))
      end

      it 'Googleマップへのリンクが正しく機能していること' do
        expect(page).to have_link('地図を見る', href: /maps.search/)
      end
    
      it 'Google検索へのリンクが正しく機能していること' do
        expect(page).to have_link('google検索', href: /www.google.com\/search/)
      end

      it 'ユーザ名をクリックするとユーザ詳細ページに遷移すること' do
        user_name = "#{review.user.first_name} #{review.user.last_name}"
        find('a', text: user_name, exact_text: true).click
        expect(current_path).to eq(user_path(review.user))
      end 
      
      it '関連するレビューが３つ表示されていること' do
        post.reviews.limit(3).each do |review|
          expect(page).to have_content(review.title)
          expect(page).to have_content(review.content)
          expect(page).to have_content("#{review.score}/5点")
        end
      end    
    end
  end
end
