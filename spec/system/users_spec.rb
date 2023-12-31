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
    let!(:post) { FactoryBot.create(:post) }

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
        expect(page).to have_content "#{user.first_name} #{user.last_name}様"
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
        expect(current_path).to eq new_user_session_path
      end
    end
  
    describe 'ユーザーログアウト' do
      before do
        sign_in user
        visit posts_path
      end

      context 'ログアウトした場合' do
        it 'ホーム画面に遷移し、正しい情報が表示される' do
          user_name = "#{user.first_name} #{user.last_name}様"
          find('a', text: user_name).click
          click_on 'ログアウト'
          expect(current_path).to eq homes_path
          expect(page).to have_content('新規登録')
          expect(page).to have_content('ログイン')
          expect(page).to have_content('ゲストログイン')
          expect(page).to have_content('Explore & Share - Japan')
        end
      end
    end

    describe 'ゲストログイン' do
      before do
        visit homes_path
      end
    
      context 'ゲストログインした場合' do
        it 'ホーム画面に遷移し、正しい情報が表示される' do
          click_on 'ゲストログイン'
          expect(page).to have_content('ゲストユーザーとしてログインしました。')
          expect(current_path).to eq(service_index_path)
          expect(page).to have_content("Guest User様") 
        end
      end
    end
  end
end

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user, profile: "よろしくお願いします") }
  let(:post) { create(:post, created_at: Time.current) }

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

    it "編集ボタンをクリックすると、編集ページに遷移される" do
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
  
    it "更新後,一覧ページに遷移し、更新された情報を表示する" do
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

  describe "header and footer" do    
    before do
      visit service_index_path
      sign_in user
    end
    
    context 'ログインした場合' do
      it 'ユーザー名とナビゲーションバーが表示される' do
        within 'header' do
          expect(page).to have_content "#{user.first_name} #{user.last_name}様"
          expect(page).to have_css('div.navbar-dropdown.is-right')
        end
      end
        
      it 'フッターのアイコンとリンクが正しく機能する' do
        within 'footer' do
          expect(page).to have_css 'i.fa-home'
          expect(page).to have_css 'i.fa-solid.fa-comment'
          expect(page).to have_css 'i.fa-solid.fa-magnifying-glass'
          expect(page).to have_css 'i.fa-solid.fa-heart'
          expect(page).to have_css 'i.fa-solid.fa-user'
  
          expect(page).to have_content 'ホーム'
          expect(page).to have_content '投稿する'
          expect(page).to have_content '検索画面'
          expect(page).to have_content 'お気に入り'
          expect(page).to have_content 'マイページ'
        end
      end

      it 'ホーム画面を押すと投稿一覧ページに遷移する' do 
        click_on 'ホーム'
        expect(current_path).to eq posts_path
        expect(page).to have_content '投稿一覧'
      end

      it '投稿するを押すと住所検索ページに遷移する' do 
        click_on '投稿する'
        expect(current_path).to eq map_index_path
        expect(page).to have_content '住所検索画面'
      end

      it '検索画面を押すと投稿検索ページに遷移する' do
        click_on '検索画面'
        expect(current_path).to eq search_post_index_path
        expect(page).to have_content '地図から都道府県を検索する'
      end

      it 'お気に入りを押すとお気に入りページに遷移する' do
        click_on 'お気に入り'
        expect(current_path).to eq favorites_user_path(user)
        expect(page).to have_content 'あなたがいいねした投稿'
      end

      it 'マイページを押すとユーザーの投稿一覧画面に遷移する' do
        click_on 'マイページ'
        expect(current_path).to eq users_path(user)
        expect(page).to have_content 'あなたのプロフィール'
      end
    end
  end
end
