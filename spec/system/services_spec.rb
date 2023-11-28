require 'rails_helper'

RSpec.describe "Services", type: :system do
  let!(:user) { create(:user) }

  before do
    visit service_index_path
  end

  it 'アプリ画面へを押すと検索画面に遷移する' do
    click_on 'アプリ画面へ'
    expect(current_path).to eq(search_post_index_path)
  end

  it '翻訳サービスが存在する' do
    expect(page).to have_selector('#google_translate_element')
  end
end
