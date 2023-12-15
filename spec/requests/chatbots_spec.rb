require 'rails_helper'

RSpec.describe 'Chatbots', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
    get new_chatbot_path
  end

  describe 'GET/chatbots/new' do
    it '正常にレスポンスを返すこと' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /chatbots' do
    it 'チャットボットからの応答を返すこと' do
      post chatbots_path, params: { input: '日本の首都は？' }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['response']).to include('東京')
    end
  end
end
