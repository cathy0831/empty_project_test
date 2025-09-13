require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:permission) }
  end

  describe "validations" do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:account) }
    it { is_expected.to validate_uniqueness_of(:account).case_insensitive }
  end

  describe "enumerize state" do
    it "has defined states" do
      expect(described_class.state.values).to eq(ModelEnum.user_state_enum.keys.map(&:to_s))
    end
  end

  describe "#active?" do
    let(:user) { build(:user) }

    it "returns true if state is not disable" do
      user.state = "enable"
      expect(user.active?).to be true
    end

    it "returns false if state is disable" do
      user.state = "disable"
      expect(user.active?).to be false
    end
  end

  describe "has_secure_password" do
    let(:user) { build(:user, password: "password123", password_confirmation: "password123") }

    it "authenticates with correct password" do
      user.save!
      expect(user.authenticate("password123")).to eq(user)
    end

    it "does not authenticate with incorrect password" do
      user.save!
      expect(user.authenticate("wrongpass")).to be false
    end
  end
end
