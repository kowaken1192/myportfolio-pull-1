require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post) }

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

  describe 'Post scopes' do
    let!(:post_with_more_reviews) { create(:post) }
    let!(:post_with_fewer_reviews) { create(:post) }
    let!(:post_with_high_score) { create(:post) }
    let!(:post_with_low_score) { create(:post) }
  
    before do
      create(:review, post: post, user: user, score: 5)
      create(:favorite, post: post)
      create_list(:review, 5, post: post_with_more_reviews, user: user)
      create_list(:review, 1, post: post_with_fewer_reviews, user: user)
      create_list(:review, 5, post: post_with_high_score, user: user, score: 5)
      create_list(:review, 2, post: post_with_low_score, user: user, score: 3)
    end
  
    it '正しいカウント数と平均スコアを持つ投稿を返すこと' do
      result = Post.with_counts_and_avg_score.find(post.id)
      expect(result.reviews_count).to eq(1)
      expect(result.favorites_count).to eq(1)
      expect(result.average_score).to eq(5.0)
    end
  
    it 'レビュー数の一番多い投稿を返すこと' do
      expect(Post.reviews_count.first).to eq(post_with_more_reviews)
    end
  
    it '平均スコアが一番高くレビュー数の一番多い投稿を返すこと' do
      expect(Post.avg_score_and_review_count.first).to eq(post_with_high_score)
    end
  end
  
  describe '.ransackable_attributes' do
    it 'ransack検索で使用できる属性に「name」と「address」が含まれていること' do
      expect(Post.ransackable_attributes).to include('name', 'address')
    end
  end

  describe '#avg_score' do
    context 'レビューが存在する場合' do
      before do
        create(:review, post: post, score: 3)
        create(:review, post: post, score: 5)
      end
    
      it 'レビューの平均スコアを返す' do
        expect(post.avg_score).to eq(4.0)
      end
    end

    context 'レビューが存在しない場合' do
      it '0.0を返す' do
        expect(post.avg_score).to eq(0.0)
      end
    end
  end
end
