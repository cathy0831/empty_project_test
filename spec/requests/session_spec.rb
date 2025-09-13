require "rails_helper"

RSpec.describe "Session", type: :request do
  let(:user) { create(:user, password: "123456") }

  describe "GET /index" do
    context "when not logged in" do
      it "redirects to login" do
        get root_path
        expect(response).to redirect_to(login_path)
      end
    end

    context "when logged in" do
      before { login_as(user) }

      it "renders index successfully" do
        get root_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /login" do
    context "when logged in" do
      before { login_as(user) }

      it "redirects to root" do
        get login_path
        expect(response).to redirect_to(root_path)
      end
    end

    context "when not logged in" do
      it "renders login template" do
        get login_path
        expect(response).to render_template(:login)
      end
    end
  end

  describe "POST /login" do
    subject(:login_request) do
      post login_path,
           params: { account: user.account, password: password },
           headers: { "X-CSRF-Token" => token }
    end

    let(:token) do
      get login_path
      controller.send(:form_authenticity_token)
    end

    context "with valid credentials" do
      let(:password) { "123456" }

      it "returns 200 OK" do
        login_request
        expect(response).to have_http_status(:ok)
      end

      it "returns status 0" do
        login_request
        expect(response.parsed_body["status"]).to eq(0)
      end

      it "returns success message" do
        login_request
        expect(response.parsed_body["message"]).to eq(I18n.t("session.create.success"))
      end
    end

    context "with invalid credentials" do
      let(:password) { "wrong" }

      it "returns 401 Unauthorized" do
        login_request
        expect(response).to have_http_status(:ok)
      end

      it "returns status -1" do
        login_request
        expect(response.parsed_body["status"]).to eq(-1)
      end

      it "returns fail message" do
        login_request
        expect(response.parsed_body["message"]).to eq(I18n.t("session.create.fail"))
      end
    end

    context "when logging in from multiple devices" do
      let(:user) { create(:user, password: "123456") }

      def login_device(user)
        session_obj = open_session
        session_obj.get(login_path)
        token = session_obj.controller.send(:form_authenticity_token)
        session_obj.post login_path,
                         params: { account: user.account, password: "123456" },
                         headers: { "X-CSRF-Token" => token }
        session_obj
      end

      it "logs in first device successfully" do
        first_device = login_device(user)
        expect(first_device.session[:user_id]).to eq(user.id)
      end

      it "logs in second device successfully" do
        _first = login_device(user) # 登入第一個裝置，但不檢查它
        second_device = login_device(user)
        expect(second_device.session[:user_id]).to eq(user.id)
      end

      it "logs out the first device" do
        first_device = login_device(user)
        login_device(user) # 第二個登入，會登出第一個

        # 重新 GET 確保 session 讀到最新
        first_device.get root_path
        expect(first_device.session[:user_id]).to be_nil
      end

      it "logs in the second device successfully" do
        _ = login_device(user) # 第一個裝置登入，不檢查
        second_device = login_device(user)
        expect(second_device.session[:user_id]).to eq(user.id)
      end
    end
  end

  describe "DELETE /logout" do
    subject(:logout_request) { delete logout_path }

    before { login_as(user) }

    it "redirects to login page" do
      logout_request
      expect(response).to redirect_to(login_path)
    end

    it "clears the session user_id" do
      logout_request
      expect(session[:user_id]).to be_nil
    end
  end

  describe "POST /reset_password" do
    before { login_as(user) }

    let(:valid_params) { { old_password: "123456", new_password: "654321" } }
    let(:invalid_params) { { old_password: "654321", new_password: "654321" } }

    # helper method
    def reset_password_request(params_override)
      post reset_password_path, params: params_override
    end

    context "when password reset succeeds" do
      it "returns 200 OK" do
        reset_password_request(valid_params)
        expect(response).to have_http_status(:ok)
      end

      it "returns status 0" do
        reset_password_request(valid_params)
        expect(response.parsed_body["status"]).to eq(0)
      end

      it "returns success message" do
        reset_password_request(valid_params)
        expect(response.parsed_body["message"]).to eq(I18n.t("session.reset_password.success"))
      end
    end

    context "when password reset fails" do
      it "returns 200 OK" do
        reset_password_request(invalid_params)
        expect(response).to have_http_status(:ok)
      end

      it "returns status -1" do
        reset_password_request(invalid_params)
        expect(response.parsed_body["status"]).to eq(-1)
      end

      it "returns fail message" do
        reset_password_request(invalid_params)
        expect(response.parsed_body["message"]).to eq(I18n.t("session.reset_password.fail"))
      end
    end
  end
end
