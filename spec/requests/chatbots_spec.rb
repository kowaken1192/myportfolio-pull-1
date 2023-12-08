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
end
