require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { create(:post, user: user) }

  describe 'validation' do
    it '名前がない場合は無効であること' do
      post.name = nil
      post.valid?
      expect(post.errors[:name]).to include("を入力してください")
    end

    it '住所がない場合は無効であること' do
      post.address = nil
      post.valid?
      expect(post.errors[:address]).to include("を入力してください")
    end

    it '国名がない場合は無効であること' do
      post.country = nil
      post.valid?
      expect(post.errors[:country]).to include("を入力してください")
    end
  end
end
