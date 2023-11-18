require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:under_six_password) { FactoryBot.build(:user, password: '12345', password_confirmation: '12345') }

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
    another_user = build(:user, email: user.email)
    another_user.valid?
    expect(another_user.errors[:email]).to include("はすでに存在します")
  end
  
  it "passwordがなければ無効な状態であること" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end
  
  it "passwordが存在してもpassword_confirmationがなければ無効な状態であること" do
    user = FactoryBot.build(:user, password_confirmation: "")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end
  
  it "パスワードが6文字未満だと無効な状態であること" do
    under_six_password.valid?
    expect(under_six_password.errors[:password]).to include("は6文字以上で入力してください")
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
end
