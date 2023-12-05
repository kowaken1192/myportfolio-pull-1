require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe "GET /users" do
    it "一覧画面の表示に成功する" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users/:id" do
    it "詳細画面の表示に成功する" do
      get user_path(user)
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET /users/:id/edit" do
    it "編集画面の表示に成功する" do
      get edit_user_path(user)
      expect(response).to have_http_status(200)
    end
  end
  
  describe "PATCH /users/:id" do
    context "有効なパラメータの場合" do
      it "ユーザー情報を更新し、一覧ページにリダイレクトすること" do
        patch user_path(user), params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to(users_path)
        follow_redirect!
        expect(response.body).to include("ユーザーIDが「#{user.id}」の情報を更新しました")
      end
    end

    context "無効なパラメータの場合(名前と名字がない)" do
      it "ユーザー情報の更新に失敗し、編集ページを再描画すること" do
        patch user_path(user), params: { 
          user: { 
            first_name: "", 
            last_name: "", 
            profile: "新しいプロフィール", 
          } 
        }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "GET /users/:id/favorites" do
    it "お気に入り一覧画面の表示に成功する" do
      get favorites_user_path(user)
      expect(response).to have_http_status(200)
    end
  end
  
  describe "PATCH /users/:id/withdraw" do
    it "退会処理が正常に完了し、遷移されること" do
      patch withdraw_user_path(user)
      expect(response).to have_http_status(302) 

      user.reload
      expect(user.is_valid).to be_falsey
    end
  end

  describe "GET /users/:id/unsubscribe" do
    it "退会確認画面の表示に成功する" do
      get confirm_unsubscribe_user_path(user)
      expect(response).to have_http_status(200)
    end
  end
end
