require "rails_helper"

RSpec.describe "Api::Auth::Sessions", type: :request do
  describe "POST /api/auth/sign_in" do
    subject { post(api_user_session_path, params: params) }

    context "登録済のユーザー情報を送信したとき" do
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user, email: user.email, password: user.password) }

      it "ログインできる" do
        subject
        header = response.header
        expect(header["access-token"]).to be_present
        expect(header["client"]).to be_present
        expect(headers["uid"]).to be_present
        expect(response).to have_http_status(:ok)
      end
    end

    context "email が一致しないとき" do
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user, email: "hoge", password: user.password) }

      it "ログインできない" do
        subject
        res = JSON.parse(response.body)
        header = response.header
        expect(res["errors"]).to include "ログイン用の認証情報が正しくありません。再度お試しください。"
        expect(header["access-token"]).to be_blank
        expect(header["client"]).to be_blank
        expect(headers["uid"]).to be_blank
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "password が一致しない場合" do
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user, email: user.email, password: "hoge") }

      it "ログインできない" do
        subject
        res = JSON.parse(response.body)
        header = response.header
        expect(res["errors"]).to include "ログイン用の認証情報が正しくありません。再度お試しください。"
        expect(header["access-token"]).to be_blank
        expect(header["client"]).to be_blank
        expect(headers["uid"]).to be_blank
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /api/auth/sign_in" do
    subject { delete(destroy_api_user_session_path, headers: headers) }

    context "ログアウトに必要な情報を送信したとき" do
      let(:user) { create(:user) }
      let!(:headers) { user.create_new_auth_token }

      it "ログアウトできる" do
        expect { subject }.to change { user.reload.tokens }.from(be_present).to(be_blank)
        expect(response).to have_http_status(:ok)
      end
    end

    context "誤った情報を送信したとき" do
      let!(:token) { user.create_new_auth_token }
      let(:user) { create(:user) }
      let!(:headers) { { "access-token" => "", "token-type" => "", "client" => "", "expiry" => "", "uid" => "" } }

      it "ログアウトできない" do
        subject
        expect(response).to have_http_status(:not_found)
        res = JSON.parse(response.body)
        expect(res["errors"]).to include "ユーザーが見つからないか、ログインしていません。"
      end
    end
  end
end
