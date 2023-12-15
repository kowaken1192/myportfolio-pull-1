require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user_with_duplicate_email) { FactoryBot.build(:user, email: user.email) }
  let!(:user_without_password) { FactoryBot.build(:user, password: nil) }
  let!(:user_without_password_confirmation) { FactoryBot.build(:user, password_confirmation: "") }
  let!(:under_six_password) { FactoryBot.build(:user, password: '12345', password_confirmation: '12345') }
  let!(:valid_user) { FactoryBot.create(:user, is_valid: true) }
  let!(:invalid_user) { FactoryBot.create(:user, is_valid: false) }

  describe 'validation' do
    it "first_nameがなければ無効な状態であること" do
      user.first_name = nil
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    it "last_nameがなければ無効な状態であること" do
      user.last_name = nil
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください")
    end

    it "emailがなければ無効な状態であること" do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "重複したemailなら無効な状態であること" do
      user_with_duplicate_email.valid?
      expect(user_with_duplicate_email.errors[:email]).to include("はすでに存在します")
    end

    it "passwordがなければ無効な状態であること" do
      user_without_password.valid?
      expect(user_without_password.errors[:password]).to include("を入力してください")
    end

    it "passwordが存在してもpassword_confirmationがなければ無効な状態であること" do
      user_without_password_confirmation.valid?
      expect(user_without_password_confirmation.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
  
    it "パスワードが6文字未満だと無効な状態であること" do
      under_six_password.valid?
      expect(under_six_password.errors[:password]).to include("は6文字以上で入力してください")
    end
  end
  
  describe '#already_favorited?' do
    let(:post) { create(:post) }

    context '投稿をいいねしている場合' do
      before do
        user.favorites.create(post: post)
      end

      it 'trueを返す' do
        expect(user.already_favorited?(post)).to be true
      end
    end

    context '投稿をいいねしていない場合' do
      it 'falseを返す' do
        expect(user.already_favorited?(post)).to be false
      end
    end
  end

  describe 'Guest' do
    context 'ゲストユーザーが存在しない場合' do
      it '新しいゲストユーザーに正しい属性を設定する' do
        guest_user = User.guest
        expect(guest_user.email).to eq('guest@example.com')
        expect(guest_user.first_name).to eq('Guest')
        expect(guest_user.last_name).to eq('User')
        expect(guest_user.is_valid).to be true
      end
    end
  end

  describe '#active_for_authentication?' do
    context 'ユーザーが有効な場合' do
      it 'trueを返すこと' do
        expect(valid_user.active_for_authentication?).to be true
      end
    end

    context 'ユーザーが無効な場合' do
      it 'falseを返すこと' do
        expect(invalid_user.active_for_authentication?).to be false
      end
    end
  end

  describe '#inactive_message' do
    context 'ユーザーが有効な場合' do
      it 'デフォルトのメッセージを返すこと' do
        expect(valid_user.inactive_message).to eq :inactive
      end
    end

    context 'ユーザーが無効な場合' do
      it 'カスタムメッセージを返すこと' do
        expect(invalid_user.inactive_message).to eq :account_not_valid
      end
    end
  end
end
