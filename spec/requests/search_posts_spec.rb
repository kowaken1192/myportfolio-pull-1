require 'rails_helper'

RSpec.describe SearchPostController, type: :request do
  let(:user) { create(:user) }
  let!(:post) { create(:post) }

  before do
    sign_in user
    create_list(:post, 1, prefecture: '東京都')
    create_list(:post, 2, prefecture: '北海道')
  end
  
  describe "GET /search_post" do
    it "検索ページが正常に表示されること" do
      get search_post_index_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /search_post/result" do
    it "検索結果が正常に表示されること" do
      get search_post_result_path, params: { q: { address_cont: '東京' } }
      expect(response).to have_http_status(200)
      expect(response.body).to include "東京"
    end
  end

  describe "GET /search_post/count_by_prefecture" do
    it "都道府県ごとの投稿数をJSONで返すこと" do
      get "/search_post/count_by_prefecture"
      expect(response).to have_http_status(200)

      json_response = JSON.parse(response.body)
      expect(json_response).to be_a(Hash)
      expect(json_response["東京都"]).to eq 1
      expect(json_response["北海道"]).to eq 2
    end
  end
end
