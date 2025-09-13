require "rails_helper"

RSpec.describe "Setting::Imports", type: :request do
  let!(:user) { create(:user, :system) }

  before { login_as(user) }

  describe "GET /index" do
    it "returns 200 OK" do
      get setting_import_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /import" do
    # context "when import_type is customer" do
    #   let(:file) {
    #     fixture_file_upload("customers.xlsx", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
    #   }
    #   let(:params) { { import_type: "customer", file: file } }
    #   let(:token) do
    #     get setting_import_path
    #     controller.send(:form_authenticity_token)
    #   end

    #   it "creates new customers after import" do
    #     expect {
    #       post setting_import_path, params: params, headers: { "X-CSRF-Token" => token }
    #     }.to change(Customer, :count).by_at_least(1)
    #   end

    #   it "returns 200 OK after update" do
    #     post setting_import_path, params: params, headers: { "X-CSRF-Token" => token }
    #     expect(response).to have_http_status(:ok)
    #   end

    #   it "returns status 0 after import" do
    #     post setting_import_path, params: params, headers: { "X-CSRF-Token" => token }
    #     json = response.parsed_body
    #     expect(json[:status]).to eq(0)
    #   end

    #   it "returns success message after import" do
    #     post setting_import_path, params: params, headers: { "X-CSRF-Token" => token }
    #     json = response.parsed_body
    #     expect(json[:message]).to eq(I18n.t("setting.import.import.success"))
    #   end
    # end

    context "when import_type is invalid" do
      let(:params) { { import_type: "unknown" } }

      let(:token) do
        get setting_import_path
        controller.send(:form_authenticity_token)
      end

      it "returns no_match_type state" do
        post setting_import_path, params: params, headers: { "X-CSRF-Token" => token }
        json = response.parsed_body
        expect(json[:status]).to eq(-1)
      end

      it "returns no_match_type message" do
        post setting_import_path, params: params, headers: { "X-CSRF-Token" => token }
        json = response.parsed_body
        expect(json[:message]).to eq(I18n.t("setting.import.import.no_match_type"))
      end
    end
  end
end
