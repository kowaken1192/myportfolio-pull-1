require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'validations' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:post) { FactoryBot.create(:post) }
    let!(:favorite) { FactoryBot.create(:favorite, user_id: user.id, post_id: post.id) }

    it 'user_idのスコープ内でpost_idの一意性を検証する' do
      expect(favorite).to validate_uniqueness_of(:post_id).scoped_to(:user_id)
    end
  end
end
