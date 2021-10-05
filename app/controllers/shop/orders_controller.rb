class Shop::OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :load_shop, only: %i(index show)
  before_action :load_order, only: :show

  def index
    @orders = @shop.all_orders
                   .page(params[:page]).per(Settings.length.digit_10)
  end

  def show
    @order_details = @order.order_details.includes(:book)
    @total = @order_details.reduce(0) do |total, order|
      total + order.quantily * order.price
    end
  end

  private

  def load_order
    @order = @shop.orders.find_by id: params[:id]
    return if @order  

    flash[:danger] = t "orders.not_found"
    redirect_to root_url
  end

  def load_shop
    @shop = current_user.shop
    return if @shop.present?

    flash[:danger] = t("shops.not_found")
    redirect_to root_url
  end
end
