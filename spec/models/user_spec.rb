require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user){FactoryBot.create :user}
  describe "validates" do
    context "name" do
      it "when nil is invalid" do
        expect validate_presence_of(:name).with_message I18n.t("activerecord.errors.models.user.attributes.name.blank")
      end
      it "when too short is invalid" do
        expect validate_length_of(:name).is_at_most(2).with_message I18n.t("activerecord.errors.models.user.attributes.name.too_short")
      end
    end

    context "email" do
      it "when nil is invalid" do
        expect(FactoryBot.build(:user, email: nil)).to be_invalid
      end
      it "must uniqueless" do
        expect validate_uniqueness_of(:email).with_message I18n.t("activerecord.errors.models.user.attributes.email.taken")
      end
      it "when too long is invalid" do
        expect validate_length_of(:email).is_at_most(256).with_message I18n.t("activerecord.errors.models.user.attributes.email.too_long")
      end
      it "when valid format" do
        expect allow_value("example@gmail.com").for(:email)
      end
      it "when invalid format" do
        expect allow_value("examm...@...").for(:email)
                                          .with_message I18n.t("activerecord.errors.models.user.attributes.email.invalid")
      end
    end

    context "password" do
      it "when too short is invalid" do
        expect validate_length_of(:password).is_at_most(2).with_message I18n.t("activerecord.errors.models.user.attributes.password.too_short")
      end
    end
  end
end
