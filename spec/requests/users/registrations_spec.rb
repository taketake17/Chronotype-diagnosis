require 'rails_helper'

RSpec.describe "Users::Registrations", type: :request do
  let(:user) { build(:user) }
  let!(:chronotype) { create(:chronotype) }

  describe "POST /users" do
    context "通常のサインアップ（クロノタイプIDなし）" do
      it "ユーザーが作成され、質問パート1にリダイレクトされる" do
        post user_registration_path, params: {
          user: {
            email: user.email,
            password: user.password,
            password_confirmation: user.password,
            username: user.username
          }
        }
        expect(response).to redirect_to(question_first_path)
        expect(User.count).to eq(1)
        expect(User.last.user_chronotypes).to be_empty
      end
    end

    context "クロノタイプID付きサインアップ（params経由）" do
      it "UserChronotypeが作成され、カレンダーにリダイレクトされる" do
        post user_registration_path, params: {
          user: {
            email: user.email,
            password: user.password,
            password_confirmation: user.password,
            username: user.username
          },
          chronotype_id: chronotype.id
        }
        expect(response).to redirect_to(calendar_index_path)
        expect(UserChronotype.count).to eq(1)
        expect(UserChronotype.last.chronotype).to eq(chronotype)
      end
    end
  end

  describe "PATCH /users" do
    let(:user) { create(:user) }

    before { sign_in user }

    context "パスワード付き更新" do
      it "パスワードが更新される" do
        patch user_registration_path, params: {
          user: {
            current_password: user.password,
            password: "new_password",
            password_confirmation: "new_password"
          }
        }
        expect(user.reload.valid_password?("new_password")).to be true
      end
    end
  end

  describe "build_resource" do
    it "uidが自動生成される" do
      post user_registration_path, params: { user: attributes_for(:user) }
      expect(User.last.uid).not_to be_nil
    end
  end
end
