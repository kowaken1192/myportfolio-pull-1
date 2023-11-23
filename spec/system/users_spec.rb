require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { FactoryBot.build(:user) }

  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができ,トップページに移動する' do
      visit homes_path
      expect(page).to have_content('新規登録')
      click_on '新規登録'
      expect(current_path).to eq new_user_registration_path
      fill_in 'user[first_name]', with: user.first_name
      fill_in 'user[last_name]', with: user.last_name
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password_confirmation

      click_button 'アカウント登録' 
      expect(page).to have_content 'アカウント登録が完了しました。'
      expect(current_path).to eq(service_index_path)
    end
  end

  describe 'ユーザーログイン' do
    let!(:user) { FactoryBot.create(:user) }

    before do
      visit new_user_session_path
    end

    context 'ログイン画面に遷移' do
      it 'ログインに成功する' do
        fill_in "user[email]", with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
        expect(current_path).to eq(service_index_path)
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end

RSpec.describe "UserProfile", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user 
    visit users_path 
  end

  it "ユーザーの情報が正しく表示されていること" do
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content(user.profile)
  end

  it "プロフィール編集ボタンをクリックすると、ユーザー編集ページにリダイレクトされる" do
    click_on 'プロフィール編集'
    expect(current_path).to eq(edit_user_path(user))
  end
end
