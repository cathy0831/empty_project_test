require "rails_helper"

RSpec.describe Permission, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:users).dependent(:restrict_with_error) }

    context "when trying to destroy with associated users" do
      let(:permission) { create(:permission) }
      let(:user) { create(:user, permission: permission) }

      it "does not delete the record" do
        expect { permission.destroy }.not_to change(described_class, :count)
      end
    end
  end

  describe "validations" do
    subject { build(:permission) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe "enumerize state" do
    it "has defined states" do
      expect(described_class.state.values).to eq(ModelEnum.permission_state_enum.keys.map(&:to_s))
    end
  end

  describe "#allowed?" do
    let(:permission_content) do
      {
        user: { search: "1", edit: "0" },
        customer: { search: "1", edit: "1" },
      }
    end

    let(:permission) { create(:permission, content: permission_content) }

    context "when action is allowed" do
      it "returns true for user search" do
        expect(permission.allowed?("user", "search")).to be true
      end

      it "returns true for customer edit" do
        expect(permission.allowed?("customer", "edit")).to be true
      end
    end

    context "when action is disallowed" do
      it "returns false for user edit" do
        expect(permission.allowed?("user", "edit")).to be false
      end
    end

    context "when module or action is missing" do
      it "returns false for missing module" do
        expect(permission.allowed?("quote", "search")).to be false
      end

      it "returns false for missing action" do
        expect(permission.allowed?("user", "delete")).to be false
      end
    end

    context "when state is disable" do
      before { permission.update!(state: "disable") }

      it "returns false even for allowed action" do
        expect(permission.allowed?("user", "search")).to be false
      end
    end

    context "when content is nil" do
      before { permission.update!(content: nil) }

      it "returns false even for allowed action" do
        expect(permission.allowed?("user", "search")).to be false
      end
    end
  end
end
