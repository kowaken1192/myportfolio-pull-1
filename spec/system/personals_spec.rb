require 'rails_helper'

RSpec.describe 'パスワード変更', type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  
  describe "show" do
    before do
      visit personal_path(user)
    end

    it 'ユーザーのemailが表示される' do
      expect(page).to have_selector("input[value='#{user.email}']")
    end
    
    it '変更するボタンを押すと、編集画面に遷移する' do
      click_on '個人情報を変更する'
      expect(current_path).to eq(edit_personal_path(user))
    end
  end

  describe "edit" do
    before do
      visit edit_personal_path(user)
    end
    
    context 'パスワードとパスワード確認用が一致している場合' do
      it 'パスワードを更新できる' do
        fill_in 'user[password]', with: 'newpassword'
        fill_in 'user[password_confirmation]', with: 'newpassword'
        click_on 'update-password'
        expect(page).to have_content 'パスワード更新しました'
        expect(current_path).to eq(new_user_session_path)
      end
    end
    
    context 'パスワードとパスワード確認用が一致していない場合' do
      it '確認用とあっていなければパスワードを更新できない' do
        fill_in 'user[password]', with: 'newpassword'
        fill_in 'user[password_confirmation]', with: 'wrongpassword'
        click_on 'update-password'
        expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
        expect(current_path).to eq(personal_path(user))
      end
    end
    
    context 'メールアドレスを変更した場合' do
      it 'メールアドレスを更新できる' do
        fill_in 'user[email]', with: 'test@example.com'
        click_on 'update-email'
        expect(page).to have_content 'メールアドレスを更新しました'
        expect(current_path).to eq(personal_path(user))
      end
    end
    
    context 'ゲストユーザーとしてログインした場合' do
      let!(:guest_user) { create(:user, email: 'guest@example.com') }

      before do
        sign_in guest_user
        visit personal_path(guest_user)
      end

      it 'パスワードの更新ができない' do
        click_on '個人情報を変更する'
        expect(page).to have_content 'ゲストユーザーのパスワードは変更できません。'
        expect(current_path).to eq(personal_path(guest_user))
      end
    end
  end
end
