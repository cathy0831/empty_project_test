require "rails_helper"

RSpec.describe "Setting::Users", type: :request do
  let!(:permission) { create(:permission) }
  let!(:user) { create(:user, :admin) }

  before do
    login_as(user)
  end

  describe "GET /index" do
    before do
      get setting_users_path
    end

    it "returns 200 OK" do
      expect(response).to have_http_status(:ok)
    end

    it "assigns user list" do
      expect(assigns(:users)).to include(UserBlueprint.render_as_hash(user, view: :list))
    end

    context "with search params" do
      it "filters by name" do
        get setting_users_path, params: { name: user.name }
        expect(assigns(:users).pluck(:name)).to include(user.name)
      end

      it "filters by account" do
        get setting_users_path, params: { account: user.account }
        expect(assigns(:users).pluck(:account)).to include(user.account)
      end
    end
  end

  describe "GET /new" do
    before do
      get new_setting_user_path
    end

    it "returns 200 OK" do
      expect(response).to have_http_status(:ok)
    end

    it "assigns a new User instance" do
      expect(assigns(:user)).to be_a_new(User)
    end

    it "sets the default state to enable" do
      expect(assigns(:user).state).to eq("enable")
    end
  end

  describe "GET /edit/:id" do
    context "when user exists" do
      before { get edit_setting_user_path(user) }

      it "returns 200 OK" do
        expect(response).to have_http_status(:ok)
      end

      it "loads the correct user" do
        expect(assigns(:user)[:id]).to eq(user.id)
      end

      it "assigns the user form data" do
        expect(assigns(:user)).to include(UserBlueprint.render_as_hash(user, view: :form))
      end
    end

    context "when user does not exist" do
      it "returns 404 Not Found" do
        get edit_setting_user_path(id: 0)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST /create" do
    subject(:create_request) do
      post setting_users_path, params: params, headers: { "X-CSRF-Token" => token }
    end

    let(:params) do
      {
        account: "newuser",
        name: "New User",
        password: "password123",
        permission_id: permission.id,
        note: "note",
        state: "enable",
      }
    end

    let(:token) do
      get new_setting_user_path
      controller.send(:form_authenticity_token)
    end

    it "creates a new user record" do
      expect { create_request }.to change(User, :count).by(1)
    end

    it "sets the correct account" do
      create_request
      expect(User.last.account).to eq("newuser")
    end

    it "sets the correct name" do
      create_request
      expect(User.last.name).to eq("New User")
    end

    it "returns 200 OK" do
      create_request
      expect(response).to have_http_status(:ok)
    end

    it "returns status 0 after create" do
      create_request
      expect(response.parsed_body["status"]).to eq(0)
    end

    it "returns success message after create" do
      create_request
      expect(response.parsed_body["message"]).to eq(I18n.t("setting.users.create.success"))
    end
  end

  describe "PATCH /update/:id" do
    subject(:update_request) do
      patch setting_user_path(user), params: update_params, headers: { "X-CSRF-Token" => token }
    end

    let(:update_params) { { name: "Updated Name" } }

    let(:token) do
      get edit_setting_user_path(user)
      controller.send(:form_authenticity_token)
    end

    it "updates the user name" do
      update_request
      expect(user.reload.name).to eq("Updated Name")
    end

    it "returns 200 OK after update" do
      update_request
      expect(response).to have_http_status(:ok)
    end

    it "returns status 0 after update" do
      update_request
      expect(response.parsed_body["status"]).to eq(0)
    end

    it "returns success message after update" do
      update_request
      expect(response.parsed_body["message"]).to eq(I18n.t("setting.users.update.success"))
    end
  end
end
