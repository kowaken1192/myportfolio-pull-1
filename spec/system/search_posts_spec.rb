require 'rails_helper'

RSpec.describe '投稿検索', type: :system do
  let(:user) { create(:user) }
  let!(:posts) { create_list(:post, 2, address: '東京都') }

  before do
    sign_in user
    visit search_post_index_path
  end

  describe 'index' do
    it 'チャットボタンのリンクをクリックしたらチャットボット画面に遷移する' do
      click_on 'チャットボットを使用する'
      expect(current_path).to eq(new_chatbot_path)
    end

    it '住所を検索すると検索結果ページに遷移する' do
      within '#address-search-form' do
        fill_in 'q[address_cont]', with: '東京都'
        click_on '検索'
      end
        expect(current_path).to eq(search_post_result_path)
        expect(page).to have_content '東京都'
    end
    
    it '行き先を検索すると検索結果ページに遷移する' do
      within '#destination-search-form' do
        fill_in 'q[name_cont]', with: '東京ドーム'
        click_on '検索'
      end
        expect(current_path).to eq(search_post_result_path)
        expect(page).to have_content '東京ドーム'
    end
  
    it 'SVG地図が表示される' do
      expect(page).to have_selector '#search_map' 
    end

    it '都道府県名をクリックすると検索結果画面に遷移する' do
      click_on '東京都'
      expect(current_path).to eq(search_post_result_path)
      expect(page).to have_content '東京都'
    end

    it '画像をクリックすると検索結果画面に遷移する' do
      click_on '東京画像'
      expect(current_path).to eq(search_post_result_path)
      expect(page).to have_content '東京都'
    end
  end

  describe 'result' do
    context '関連する投稿がある場合' do
      before do
        visit search_post_result_path
      end
  
      it '必要な投稿の情報が表示されること' do
        posts.each do |post|
          expect(page).to have_content(post.name)
          expect(page).to have_content(post.address)
        end
      end
    end
  
    describe '都道府県名によって違う検索結果が表示される' do
      context '東京都の場合' do
        before do
          within '#address-search-form' do
            fill_in 'q[address_cont]', with: '東京都'
            click_on '検索'
          end
          expect(current_path).to eq(search_post_result_path)
        end
  
        it '検索結果が表示される' do
          expect(page).to have_content("東京都")
          expect(page).to have_content("検索結果:2 件")
        end
      end
  
      context '北海道の場合' do
        before do
          within '#address-search-form' do
            fill_in 'q[address_cont]', with: '北海道'
            click_on '検索'
          end
          expect(current_path).to eq(search_post_result_path)
        end
  
        it '検索結果が正しく表示される' do
          expect(page).to have_content("北海道")
          expect(page).to have_content("検索結果:0 件")
        end
      end
    end
  end
end  
