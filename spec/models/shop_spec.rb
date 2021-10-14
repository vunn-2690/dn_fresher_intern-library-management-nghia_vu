require "rails_helper"

RSpec.describe Shop, type: :model do
  let!(:shop){FactoryBot.create :shop}
  describe "validates" do
    context "name" do
      it "have nil return message" do
        expect validate_presence_of(:name).with_message I18n.t("activerecord.errors.models.shop.attributes.name.blank")
      end
      it "must uniqueless" do
        expect validate_uniqueness_of(:name).with_message I18n.t("activerecord.errors.models.shop.attributes.name.taken")
      end
    end

    context "description" do
      it "have length to long return message" do
        expect validate_length_of(:description).is_at_most(256).with_message I18n.t("activerecord.errors.models.shop.attributes.description.too_long")
      end
    end
  end

  describe "methods" do
    context ".all_books" do
      it "return ActiveRecord::Relation object" do
        expect(shop.all_books).to be_an(ActiveRecord::Relation)
      end
    end

    context ".all_orders" do
      it "return ActiveRecord::Relation object" do
        expect(shop.all_orders).to be_an(ActiveRecord::Relation)
      end
    end
  end

  describe "associations" do
    it "must belong to user" do
      is_expected.to belong_to :user
    end
    it "has many books" do
      is_expected.to have_many :books
    end
    it "has many orders" do
      is_expected.to have_many :orders
    end
  end
end
