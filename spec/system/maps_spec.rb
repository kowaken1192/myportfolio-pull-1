require 'rails_helper'

RSpec.describe "Address Search", type: :system, js: true do
  let(:user) { create(:user) }

  before do
    visit map_index_path 
    sign_in user
  end
  
  it 'Google Mapが表示されていること' do
    expect(page).to have_selector('#map') 
  end
  
  it "更新ボタンを押した後、google mapマップが表示される" do
    click_on "更新"
    expect(page).to have_selector('#map')
  end
  
  it "「NEXT STEP」ボタンをクリックすると次のページに遷移する" do
    click_on "NEXT STEP"
    expect(current_path).to eq new_post_path 
  end
end
