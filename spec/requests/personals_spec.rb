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
      it "ユーザー情報を更新し、個人情報の画面に遷移する" do
        patch personal_path(user), params: { user: { email: "new_email@example.com" } }
        expect(response).to redirect_to(personal_path(user))
        follow_redirect!
        expect(response.body).to include("メールアドレスを更新しました")
      end
    end
  end

  describe "PATCH /personals/:id" do
    context "有効なパスワードのパラメータの場合" do
      it "ユーザー情報を更新し、ログインページに遷移する" do
        patch personal_path(user), params: { user: { password: "new_password", password_confirmation: "new_password" } }
        expect(response).to redirect_to(new_user_session_path)
        follow_redirect!
        expect(response.body).to include("パスワード更新しました")
      end
    end
  end
end
