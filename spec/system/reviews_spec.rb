require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  describe "create" do
    let(:user) { create(:user) }
    let!(:post) { create(:post, user: user)}

    before do
      sign_in user
      visit new_post_review_path(post.id)
    end

    context 'レビューした場合', js: true do     
      it '投稿の詳細ページに遷移すること' do
        fill_in 'review[title]', with: '最高でした'
        fill_in 'review[content]', with: 'テスト'
        find_all('.fa-star-o')[4].click 

        click_on '保存'
        expect(current_path).to eq(post_path(post))
      end
    end

    context 'レビューしない場合', js: true do
      it '投稿に失敗する' do
        fill_in 'review[title]', with: '最高でした'
        fill_in 'review[content]', with: 'テスト'

        click_on '保存'
        expect(current_path).to eq(post_reviews_path(post.id))
      end
    end
  end
end
