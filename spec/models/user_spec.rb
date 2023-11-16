require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  
  # first_nameがなければ無効な状態であること
  it "is invalid without a first name" do
    user.first_name = nil
    user.valid?
    expect(user.errors[:first_name]).to include("を入力してください")
  end

  # last_nameがなければ無効な状態であること
  it "is invalid without a last name" do
    user.last_name = nil
    user.valid?
    expect(user.errors[:last_name]).to include("を入力してください")
  end
  
  # emailがなければ無効な状態であること
  it "is invalid without an email address" do
    user.email = nil
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  
  # 重複したemailなら無効な状態であること
  it "is invalid with a duplicate email address" do
    another_user = build(:user, email: user.email)
    another_user.valid?
    expect(another_user.errors[:email]).to include("はすでに存在します")
  end
  
  # passwordがなければ無効な状態であること
  it "is invalid without a password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end
  
  # passwordが存在してもpassword_confirmationがなければ無効な状態であること
  it "is invalid without a password_confirmation although with a password" do
    user = FactoryBot.build(:user, password_confirmation: "")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end
  
  # Userモデルが複数のreviewsとの関連を持っていることをテストし、Userが削除された場合に関連するreviewsも削除されることを確認
  it { should have_many(:reviews).dependent(:destroy) }
  # Userモデルが複数のfavoritesとの関連を持っていることをテストし、Userが削除された場合に関連するfavoritesも削除されることを確認
  it { should have_many(:favorites).dependent(:destroy) }
  # Userモデルがfavoritesを通じてfavorite_postsと関連していることをテストし、この関連がpostモデルに源を発していることを確認
  it { should have_many(:favorite_posts).through(:favorites).source(:post) }
  # Userモデルが複数のpostsとの関連を持っていることをテストし、Userが削除された場合に関連するpostsも削除されることを確認
  it { should have_many(:posts).dependent(:destroy) }
end
