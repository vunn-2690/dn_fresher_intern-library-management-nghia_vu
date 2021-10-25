require "rails_helper"

RSpec.describe Shop::OrdersController, type: :controller do
  describe "GET #index" do
    context "when user login" do
      before do
        @user = FactoryBot.create :user
        sign_in @user
      end
      context "when user have not shop" do
        before do
          get :index, params: {user_id: @user.id}
        end
        it "return flash danger" do
          expect(flash[:danger]).to eq I18n.t("shops.not_found")
        end
        it "redirects to root_url" do
          expect(response).to redirect_to root_url
        end
      end
  
      context "when user have shop" do
        let!(:shop){FactoryBot.create(:shop, user_id: @user.id)}
        before do
          get :index, params: {user_id: @user.id}
        end
        it "return all orders" do
          expect(assigns(:orders)).to eq shop.all_orders
        end
      end
    end
    
    context "when user not login" do
      before do
        get :index, params: {locale: "en", user_id: 1}
      end
      it "return flash danger" do
        expect(flash[:alert]).to eq I18n.t("devise.failure.unauthenticated")
      end
      it "redirects to login" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #show" do
    context "when user login" do
      before do
        @user = FactoryBot.create :user
        sign_in @user
      end
      context "when user have not shop" do
        let!(:order){FactoryBot.create(:order)}
        let!(:order_detail){FactoryBot.create(:order_detail, order_id: order.id)}
        before do
          get :show, params: {user_id: @user.id, id: order.id}
        end
        it "return flash danger" do
          expect(flash[:danger]).to eq I18n.t("shops.not_found")
        end
        it "redirects to root_url" do
          expect(response).to redirect_to root_url
        end
      end
  
      context "when user have shop" do
        let!(:shop){FactoryBot.create(:shop, user_id: @user.id)}
        context "when shop have order" do
          let!(:order){FactoryBot.create(:order, shop_id: shop.id)}
          let!(:order_detail){FactoryBot.create(:order_detail, order_id: order.id)}
          before do
            get :show, params: {user_id: @user.id, id: order.id}
          end
          it "return all details orders" do
            expect(assigns(:order_details)).to eq order.order_details
          end
        end
  
        context "when shop have not order" do
          before do
            get :show, params: {user_id: @user.id, id: -1}
          end
          it "return flash danger" do
            expect(flash[:danger]).to eq I18n.t("order.not_found")
          end
          it "redirects to root_url" do
            expect(response).to redirect_to root_url
          end
        end
      end
    end

    context "when user not login" do
      before do
        get :show, params: {locale: "en", user_id: 2, id: 5}
      end
      it "return flash danger" do
        expect(flash[:alert]).to eq I18n.t("devise.failure.unauthenticated")
      end
      it "redirects to login" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PUT #approve" do
    context "when user login" do
      before do
        @user = FactoryBot.create :user
        sign_in @user
      end
      context "when user have not shop" do
        let!(:order){FactoryBot.create(:order)}
        let!(:order_detail){FactoryBot.create(:order_detail, order_id: order.id)}
        before do
          put :approve, params: {user_id: @user.id, id: order.id}
        end
        it "return flash danger" do
          expect(flash[:danger]).to eq I18n.t("shops.not_found")
        end
        it "redirects to root_url" do
          expect(response).to redirect_to root_url
        end
      end
  
      context "when user have shop" do
        let!(:shop){FactoryBot.create(:shop, user_id: @user.id)}
        context "when shop have not order" do
          before do
            put :approve, params: {user_id: @user.id, id: -1}
          end
          it "return flash danger" do
            expect(flash[:danger]).to eq I18n.t("order.not_found")
          end
          it "redirects to root_url" do
            expect(response).to redirect_to root_url
          end
        end
  
        context "when shop have order" do
          let!(:shop){FactoryBot.create(:shop, user_id: @user.id)}
          context "when status order is pending" do
            let!(:order_1){FactoryBot.create(:order, shop_id: shop.id)}
            before do
              put :approve, params: {user_id: @user.id, id: order_1.id}
            end
            it "return flash success" do
              expect(flash[:success]).to eq I18n.t("order.approve_success")
            end
          end
  
          context "when status order is orther" do
            let!(:order_2){FactoryBot.create(:order, shop_id: shop.id, status: 1)}
            before do
              put :approve, params: {user_id: @user.id, id: order_2.id}
            end
            it "return flash danger" do
              expect(flash[:danger]).to eq I18n.t("order.approve_failed")
            end
          end
        end
      end
    end

    context "when user not login" do
      let!(:order){FactoryBot.create(:order)}
      let!(:order_detail){FactoryBot.create(:order_detail, order_id: order.id)}
      before do
        put :approve, params: {locale: "en", user_id: 2, id: order.id}
      end
      it "return flash danger" do
        expect(flash[:alert]).to eq I18n.t("devise.failure.unauthenticated")
      end
      it "redirects to login" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PUT #disclaim" do
    context "when user login" do
      before do
        @user = FactoryBot.create :user
        sign_in @user
      end
      context "when user have not shop" do
        let!(:order){FactoryBot.create(:order)}
        let!(:order_detail){FactoryBot.create(:order_detail, order_id: order.id)}
        before do
          put :disclaim, params: {user_id: @user.id, id: order.id}
        end
        it "return flash danger" do
          expect(flash[:danger]).to eq I18n.t("shops.not_found")
        end
        it "redirects to root_url" do
          expect(response).to redirect_to root_url
        end
      end
  
      context "when user have shop" do
        let!(:shop){FactoryBot.create(:shop, user_id: @user.id)}
        context "when shop have not order" do
          before do
            put :disclaim, params: {user_id: @user.id, id: -1}
          end
          it "return flash danger" do
            expect(flash[:danger]).to eq I18n.t("order.not_found")
          end
          it "redirects to root_url" do
            expect(response).to redirect_to root_url
          end
        end
  
        context "when shop have order" do
          let!(:shop){FactoryBot.create(:shop, user_id: @user.id)}
          context "when status order is pending" do
            let!(:order_1){FactoryBot.create(:order, shop_id: shop.id)}
            before do
              put :disclaim, params: {user_id: @user.id, id: order_1.id}
            end
            it "return flash success" do
              expect(flash[:success]).to eq I18n.t("order.disclaim_success")
            end
          end
  
          context "when status order is orther" do
            let!(:order_2){FactoryBot.create(:order, shop_id: shop.id, status: 1)}
            before do
              put :disclaim, params: {user_id: @user.id, id: order_2.id}
            end
            it "return flash danger" do
              expect(flash[:danger]).to eq I18n.t("order.disclaim_failed")
            end
          end
        end
      end
    end

    context "when user not login" do
      let!(:order){FactoryBot.create(:order)}
      let!(:order_detail){FactoryBot.create(:order_detail, order_id: order.id)}
      before do
        put :disclaim, params: {locale: "en", user_id: 2, id: order.id}
      end
      it "return flash danger" do
        expect(flash[:alert]).to eq I18n.t("devise.failure.unauthenticated")
      end
      it "redirects to login" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
