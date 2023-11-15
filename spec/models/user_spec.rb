require 'rails_helper'

RSpec.describe User, type: :model do
  # first_nameがなければ無効な状態であること
  it "is invalid without a first name" do
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("を入力してください")
  end

  # last_nameがなければ無効な状態であること
  it "is invalid without a last name" do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("を入力してください")
  end

  # emailがなければ無効な状態であること
  it "is invalid without an email address" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  # パスワードがなければ無効な状態であること
  it "is invalid without an password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it { should have_many(:reviews).dependent(:destroy) }
  it { should have_many(:favorites).dependent(:destroy) }
  it { should have_many(:favorite_posts).through(:favorites).source(:post) }
  it { should have_many(:posts).dependent(:destroy) }
end
