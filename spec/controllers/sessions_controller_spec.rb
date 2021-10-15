require "rails_helper"

RSpec.describe SessionsController, type: :controller do
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
    let!(:user){FactoryBot.create :user}
    context "when valid params" do
      before do
        post :create, params: { session: {
          email: user.email,
          password: user.password,
        }}
      end
      it "redirects to the root_url" do
        expect(response).to redirect_to root_url
      end
    end

    context "when invalid params" do
      before do
        post :create, params: { session: {
          email: "zxczxc@gmail.com",
          password: "123123123",
        }}
      end
      it "display flash message" do
        expect(flash[:danger]).to eq I18n.t("users.login.invalid_login")
      end
      it "render new" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #destroy" do
    let!(:user){FactoryBot.create :user}
    before do
      post :create, params: { session: {
        email: user.email,
        password: user.password,
      }}
    end
    subject {get :destroy}
    it "redirects to the root_url" do
      expect(subject).to redirect_to root_url
    end
  end
end
