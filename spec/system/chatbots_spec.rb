require 'rails_helper'

RSpec.describe "Chatbots", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit new_chatbot_path
  end

  describe "Chatbots" do
    describe "#new" do
      it "必要なボタンが表示されること" do
        expect(page).to have_button '送信'
        expect(page).to have_link '更新'
        expect(page).to have_link '戻る'
      end
    end

    describe "Chatbots System Tests, js: true" do
      it "送信ボタンを押したときに結果が表示される" do
        fill_in "input", with: "日本の首都は？"
        click_on "送信"
        expect(page).to have_content "東京"
      end
    end
  end
end
