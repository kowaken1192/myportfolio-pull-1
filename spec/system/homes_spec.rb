require 'rails_helper'

RSpec.describe "Homes", type: :system do
  describe "Homes System Tests" do
    before do
      visit homes_path
    end

    it 'ホーム画面に必要な情報が表示されているか' do
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
      expect(page).to have_content('ゲストログイン')
      expect(page).to have_content('Explore & Share - Japan')
      expect(page).to have_selector("img[src*='Untitled design']")
    end

    it '新規登録画面に遷移できること' do
      click_on '新規登録'
      expect(current_path).to eq(new_user_registration_path)
    end

    it 'ログイン画面に遷移できること' do
      click_on 'ログイン'
      expect(current_path).to eq(new_user_session_path)
    end

    it 'ゲストログインできること' do
      click_on 'ゲストログイン'
      expect(page).to have_content('ゲストユーザーとしてログインしました。')
      expect(current_path).to eq(service_index_path)
    end

    it 'タイトルをクリックするとホーム画面に遷移すること' do
      click_on 'Explore & Share - Japan'
      expect(current_path).to eq(homes_path)
    end

    it '画像をクリックするとホーム画面に遷移すること' do
      click_on 'ホームロゴ'
      expect(current_path).to eq(homes_path)
    end
  end
end
