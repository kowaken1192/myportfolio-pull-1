require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:review) { FactoryBot.create(:review) }
  let!(:pic_path) { Rails.root.join('spec/fixtures/test.jpg') }
  
  describe 'validation' do
    it 'スコアがない場合は無効であること' do
      review.score = nil
      review.valid?
      expect(review.errors[:score]).to include("を入力してください")
    end
  end
  
  describe 'review_images' do
    context "画像が指定されれば" do
      it "画像がアップロードされる" do
        review = create(:review, review_images: File.open(pic_path))
        expect(review).to be_valid
      end
    end
  end
end  
