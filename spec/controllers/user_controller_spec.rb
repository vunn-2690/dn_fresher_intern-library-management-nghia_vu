require "rails_helper"
include SessionsHelper

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    let!(:user){FactoryBot.create :user}
    context "when user exist" do
      before do
        get :show, params: {id: 1}
      end
      it "return user" do
        expect(assigns(:user)).to eq user
      end
    end
    context "when user does not exist" do
      before do
        get :show, params: {id: -1}
      end
      it "display flash message" do
        expect(flash[:danger]).to eq I18n.t("users.not_found")
      end
      it "redirect to root URL" do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #new" do
    subject {get :new}
    it "render new" do
      expect(subject).to render_template(:new)
    end
    it "does not render different template" do
      expect(subject).to_not render_template(:show)
    end
  end

  describe "POST #create" do
    context "when valid params" do
      before do
        post :create, params: { user: {
          name: Faker::Name.name_with_middle,
          email: "zxczxc@gmail.com",
          password: "123123123",
          password_confirmation: "123123123"
        }}
      end
      it "redirects to the root_url" do
        expect(response).to redirect_to root_url
      end
      it "display flash message" do
        expect(flash[:success]).to eq I18n.t("welcome")
      end
    end

    context "when invalid params" do
      before do
        post :create, params: { user: {
          name: "",
          email: "zxczxc@gmail.com",
          password: "123123123",
          password_confirmation: "123123123"
        }}
      end
      it "render new" do
        expect(response).to render_template :new
      end
    end
  end
end
