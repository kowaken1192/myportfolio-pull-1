require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ユーザー新規登録' do
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

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user, profile: "よろしくお願いします") }

  before do
    sign_in user
  end

  describe "#index" do
    before do
      visit users_path 
    end

    it "ユーザー情報が正しく表示されていること" do
      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name)
      expect(page).to have_content(user.profile)
    end

    it "編集ボタンをクリックすると、編集ページにリダイレクトされる" do
      click_on 'プロフィール編集'
      expect(current_path).to eq(edit_user_path(user))
    end

    it 'プロフィール編集のためのリンクを表示する' do
      expect(page).to have_link 'プロフィール編集', href: "/users/#{user.id}/edit"
    end
  end

  describe "#show" do
    before do
      visit user_path(user) 
    end

    it "ユーザーの情報が正しく表示されていること" do
      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name)
      expect(page).to have_content(user.profile)
    end
  end
  
  describe "#edit" do
    before do
      visit edit_user_path(user)
    end
  
    it "名字と名前が既に表示されている" do
      expect(page).to have_field 'user[first_name]', with: user.first_name
      expect(page).to have_field 'user[last_name]', with: user.last_name
    end

    it '編集を完了するボタンが表示されている' do
      expect(page).to have_button '編集を完了する'
    end
  end    

  describe "#updates", type: :system do
    before do
      visit edit_user_path(user)
    end
  
    it "更新後,一覧ページにリダイレクトし、更新された情報を表示する" do
      fill_in 'user[first_name]', with: 'NewFirstName'
      fill_in 'user[last_name]', with: 'NewLastName'
      fill_in 'user[profile]', with: 'New Profile'
      attach_file('user[image]', 'spec/fixtures/test.jpeg')
      attach_file('user[background_image]', 'spec/fixtures/test.jpg')
      click_button '編集を完了する'
    
      expect(current_path).to eq users_path
      expect(page).to have_content 'NewFirstName'
      expect(page).to have_content 'NewLastName'
      expect(page).to have_content 'New Profile'
      expect(page).to have_selector("img[src$='test.jpeg']")
      expect(page).to have_selector("img[src$='test.jpg']")
    end

    it "名字が空欄の場合更新できない" do
      fill_in 'user[first_name]', with: ''
      fill_in 'user[last_name]', with: 'NewLastName'
      click_button '編集を完了する'
      expect(page).to have_content "名字を入力してください"
    end

    it "名前が空欄の場合更新できない" do
      fill_in 'user[first_name]', with: 'NewFirstName'
      fill_in 'user[last_name]', with: ''
      click_button '編集を完了する'
      expect(page).to have_content "名前を入力してください"
    end
  end
end
