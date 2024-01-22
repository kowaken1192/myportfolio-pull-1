require 'rails_helper'

RSpec.describe "Address Search", type: :system, js: true do
  let!(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'ログイン'
    visit map_index_path
  end
  
  it 'Google Mapが表示されていること' do
    expect(page).to have_selector('#map') 
  end
  
  it "更新ボタンを押した後、google mapマップが表示される" do
    click_on "更新"
    expect(page).to have_selector('#map')
  end
  
  it "住所をエンコードしたときに正しい住所を表示する" do
    fill_in "address", with: "東京ドーム"
    click_on "Encode"

    expect(page).to have_content "国名：日本 住所：東京都文京区後楽１丁目３−６１" 
  end
  
  it "「NEXT STEP」ボタンをクリックすると次のページに遷移する" do
    click_on "NEXT STEP"
    expect(current_path).to eq new_post_path 
  end
end
