require "rails_helper"

RSpec.describe Shop::ShopsController, type: :controller do
  describe "GET #show" do
    before do
      @user = FactoryBot.create :user
      sign_in @user
    end
    context "when shop does not exist" do
      before do
        get :show, params: {user_id: @user.id}
      end
      it "return flash danger" do
        expect(flash[:danger]).to eq I18n.t("shops.not_found")
      end
      it "redirects to root_url" do
        expect(response).to redirect_to root_url
      end
    end

    context "when shop exist" do
      let!(:shop){FactoryBot.create(:shop, user_id: @user.id)}
      before do
        get :show, params: {user_id: @user.id}
      end
      it "return all books" do
        expect(assigns(:books)).to eq @user.shop.all_books
      end
    end

    context "when invalid user" do
      let!(:shop){FactoryBot.create(:shop, user_id: @user.id)}
      before do
        get :show, params: {user_id: 4}
      end
      it "return flash danger" do
        expect(flash[:danger]).to eq I18n.t("shared.invalid_permision")
      end
      it "redirects to root_url" do
        expect(response).to redirect_to root_url
      end
    end
  end
end
