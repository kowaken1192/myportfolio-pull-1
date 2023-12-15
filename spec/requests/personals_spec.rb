require 'rails_helper'

RSpec.describe "Personals", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  
  describe "GET /personals/:id" do
    it "正常にレスポンスを返す" do
      get personal_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /personals/:id" do
    context "有効なパラメータの場合" do
      it "ユーザー情報を更新し、投稿一覧ページにリダイレクトすること" do
        patch personal_path(user), params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to(new_user_session_path)
        follow_redirect!
        expect(response.body).to include("パスワード更新しました")
      end
    end
  end
end
