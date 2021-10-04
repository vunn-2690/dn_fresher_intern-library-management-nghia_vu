class OrdersController < ApplicationController
  before_action :load_shop, :check_owner, only: :index

  def index
    @orders = @shop.all_orders
                   .page(params[:page]).per(Settings.length.digit_10)
  end

  private

  def load_shop
    @shop = Shop.find_by id: params[:shop_id]
    return if @shop

    flash[:danger] = t("shops.not_found")
    redirect_to root_url
  end

  def check_owner
    return if @shop.user_id == current_user.id

    flash[:danger] = t "shared.invalid_permision"
    redirect_to root_url
  end
end
