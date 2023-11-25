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
        click_on 'この投稿の詳細へ'
        expect(current_path).to eq(post_path(post))
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
      
      it 'レビューが３つ表示されていること' do
        post.reviews.limit(3).each do |review|
          expect(page).to have_content(review.title)
          expect(page).to have_content(review.content)
          expect(page).to have_content("#{review.score}/5点")
        end
      end
      
      it 'レビューしたユーザーの画像が表示されること' do
        review.review_images.each do |review_image|
          expect(page).to have_selector("img[src$='#{review_image.image.url}']")
        end
      end
    end

    describe "create", type: :system do
  
      before do
        visit new_post_path
      end
  
      context 'when valid data is submitted', js: true do
        it 'creates a new post and review' do
          fill_in 'post[name]', with: 'Test Place'
          fill_in 'post[country]', with: 'Test Country'
          fill_in 'post[prefecture]', with: 'Test Prefecture'
          fill_in 'post[address]', with: 'Test Address'
          fill_in 'post[detail]', with: 'It was great!'
          find_all('.fa-star-o')[4].click
      
          click_on '登録する'
          expect(page).to have_content '投稿ありがとうございます！'
          expect(current_path).to eq(related_post_path(Post.last))
        end
      end

      context 'when invalid data is submitted', js: true do
        it 'shows errors' do
          fill_in 'post[name]', with: 'test name'
          fill_in 'post[country]', with: 'test country'
          fill_in 'post[prefecture]', with: 'test prefecture'
          fill_in 'post[address]', with: 'test address'
          fill_in 'post[detail]', with: 'test detail'
      
          click_on '登録する'
          expect(page).to have_content '保存に失敗しました'
          expect(current_path).to eq(posts_path)
        end
      end
    end
  end
end
