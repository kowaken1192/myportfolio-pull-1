require 'rails_helper'

RSpec.describe 'User Unsubscribe', type: :system do
  context '通常のユーザー' do
    let!(:user) { create(:user) }

    before do
      sign_in user
      visit confirm_unsubscribe_user_path(user)
    end

    it '退会確認ページが正しく表示される' do
      expect(page).to have_link '退会する', href: withdraw_user_path(user)
      expect(page).to have_link '退会しない', href: users_path(user)
    end

    it '退会処理が行われるとフラッシュメッセージが表示される' do
      click_link '退会する'
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content '退会処理が完了しました。'
      expect(page).to have_selector('.notification.is-success')
    end

    it '退会しないをクリックするとマイページ画面に戻る' do
      click_link '退会しない'
      expect(current_path).to eq users_path(user)
    end
  end

  context 'ゲストユーザー' do
    let!(:guest_user) { create(:user, email: 'guest@example.com') }

    before do
      sign_in guest_user
      visit confirm_unsubscribe_user_path(guest_user)
    end

    it 'ゲストユーザーは退会できず、フラッシュメッセージが表示される' do
      click_link '退会する'
      expect(current_path).to eq confirm_unsubscribe_user_path(guest_user)
      expect(page).to have_content 'ゲストユーザーは削除できません。'
      expect(page).to have_selector('.notification.is-danger')
    end
  end
end
