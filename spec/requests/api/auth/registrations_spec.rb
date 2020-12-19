require "rails_helper"

RSpec.describe "Api::Auth::Registrations", type: :request do
  describe "POST /v1/auth" do
    subject { post(api_user_registration_path, params: params) }

    context "必要な情報が存在するとき" do
      let(:params) { attributes_for(:user) }

      it "ユーザーの新規登録ができる" do
        expect { subject }.to change { User.count }.by(1)
        expect(response).to have_http_status(:ok)
        res = JSON.parse(response.body)
        expect(res["data"]["email"]).to eq(User.last.email)
      end

      it "header 情報を取得することができる" do
        subject
        header = response.header
        expect(header["access-token"]).to be_present
        expect(header["client"]).to be_present
        expect(header["expiry"]).to be_present
        expect(header["uid"]).to be_present
        expect(header["token-type"]).to be_present
      end
    end

    context "name が存在しないとき" do
      let(:params) { attributes_for(:user, name: nil) }

      it "エラーが発生する" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["name"]).to include "を入力してください"
      end
    end

    context "email が存在しないとき" do
      let(:params) { attributes_for(:user, email: nil) }

      it "エラーが発生する" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["email"]).to include "を入力してください"
      end
    end

    context "password が存在しないとき" do
      let(:params) { attributes_for(:user, password: nil) }

      it "エラーが発生する" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["password"]).to include "を入力してください"
      end
    end
  end
end
