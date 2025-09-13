require "rails_helper"

RSpec.describe "Setting::Permissions", type: :request do
  let!(:permission) { create(:permission) }
  let!(:user) { create(:user, :admin) }

  before do
    login_as(user)
  end

  describe "GET /index" do
    before { get setting_permissions_path }

    it "returns 200 OK" do
      expect(response).to have_http_status(:ok)
    end

    it "assigns permissions list" do
      expect(assigns(:permissions)).to include(PermissionBlueprint.render_as_hash(permission, view: :list))
    end
  end

  describe "GET /new" do
    before { get new_setting_permission_path }

    it "returns 200 OK" do
      expect(response).to have_http_status(:ok)
    end

    it "assigns a new Permission instance" do
      expect(assigns(:permission)).to be_a_new(Permission)
    end

    it "sets the default state to enable" do
      expect(assigns(:permission).state).to eq("enable")
    end
  end

  describe "GET /edit/:id" do
    context "when permission exists" do
      before { get edit_setting_permission_path(permission) }

      it "returns 200 OK" do
        expect(response).to have_http_status(:ok)
      end

      it "assigns the correct permission" do
        expect(assigns(:permission)[:id]).to eq(permission.id)
      end
    end

    context "when permission does not exist" do
      it "returns 404 Not Found" do
        get edit_setting_permission_path(id: 0)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST /create" do
    subject(:create_request) do
      post setting_permissions_path, params: params, headers: { "X-CSRF-Token" => token }
    end

    let(:params) do
      {
        name: "New Permission",
        content: PermissionHelper.permission_with_modules([:user, :permission]).to_json,
      }
    end

    let(:token) do
      get new_setting_permission_path
      controller.send(:form_authenticity_token)
    end

    it "creates a new permission" do
      expect { create_request }.to change(Permission, :count).by(1)
    end

    it "returns 200 OK" do
      create_request
      expect(response).to have_http_status(:ok)
    end

    it "returns status 0 after creation" do
      create_request
      expect(response.parsed_body["status"]).to eq(0)
    end

    it "returns success message after creation" do
      create_request
      expect(response.parsed_body["message"]).to eq(I18n.t("setting.permissions.create.success"))
    end
  end

  describe "PATCH /update/:id" do
    subject(:update_request) do
      patch setting_permission_path(permission), params: update_params, headers: { "X-CSRF-Token" => token }
    end

    let(:update_params) do
      {
        name: "Updated Permission",
        content: PermissionHelper.permission_with_modules([:user]).to_json,
      }
    end

    let(:token) do
      get edit_setting_permission_path(permission)
      controller.send(:form_authenticity_token)
    end

    it "updates the permission name" do
      update_request
      expect(permission.reload.name).to eq("Updated Permission")
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
      expect(response.parsed_body["message"]).to eq(I18n.t("setting.permissions.update.success"))
    end
  end
end
