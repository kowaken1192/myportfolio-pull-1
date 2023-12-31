require 'rails_helper'

RSpec.describe "Posts", type: :system do
  describe "Posts System Tests" do
    let(:user) { create(:user) }
    let!(:post) { create(:post, user: user, created_at: Time.current, detail: "楽しかった") }
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
  
      context 'レビューした場合', js: true do     
        it '投稿が成功し、おすすめの投稿が表示されるページにリダイレクトされる' do
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

      context 'レビューしない場合', js: true do
        it '投稿に失敗する' do
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

    describe '#destroy' do
      it 'マイページに表示されるユーザーの投稿のみ削除する' do
        visit users_path
        expect {
        click_on '削除する'
        }.to change { user.posts.count }.by(-1)
        expect(page).to have_content '投稿を削除しました'
        expect(current_path).to eq(users_path)
      end
    end

    describe "Related Posts" do
      let!(:post) { create(:post, prefecture: '東京都') }
      let!(:related_posts) { create_list(:post, 5, prefecture: '東京都') }
  
      before do
        visit related_post_path(post)
      end
      
      context '関連する投稿がある場合' do
        it '必要な投稿の情報が表示されること' do
          related_posts.each do |related_post|
            expect(page).to have_content(related_post.name)
            expect(page).to have_content(related_post.address)
            expect(page).to have_content("#{related_post.avg_score}点（#{related_post.reviews.count}件のレビュー）")
            expect(page).to have_content(related_post.created_at.strftime('%Y年 %m月%d日'))
            expect(page).to have_link('この投稿の詳細へ', href: post_path(related_post))

            if related_post.postimage?
              expect(page).to have_selector("img[src$='#{related_post.postimage.url}']")
            else
              expect(page).to have_selector("img[src$='https://sesupport.edumall.jp/hc/article_attachments/900009570963/noImage.jpg']")
            end
          end
        end
      end
  
      context '関連する投稿がない場合' do
        let!(:related_posts) { [] }
  
        it '関連する投稿がないことのメッセージが表示される' do
          expect(page).to have_content('関連している投稿はありません')
        end
      end
    end

    describe "All Reviews" do 
      let!(:reviews) { create_list(:review, 5, post: post, user: user) }
      let!(:user) { create(:user, image: Rack::Test::UploadedFile.new('spec/fixtures/test.jpeg', 'image/jpeg')) }

      before do
        visit all_reviews_post_path(post)
      end
      
      context 'レビューがある場合' do
        it 'ユーザーの登録画像が表示されること' do
          reviews.each do |review|
            expect(page).to have_selector("img[src$='#{review.user.image.url}']")
          end
        end

        it '必要なレビューの情報が表示されること' do
          reviews.each do |review|
            expect(page).to have_content(review.user.first_name)
            expect(page).to have_content(review.user.last_name)
            expect(page).to have_content("#{review.score}/5点")
            expect(page).to have_content(review.content)
          end
        end
      end
    end
  end
end
