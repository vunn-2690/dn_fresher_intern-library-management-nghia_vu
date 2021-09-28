class ShopsController < ApplicationController
  before_action :load_shop, only: :show

  def show
    @books = @shop.books.recent_books.page(params[:page
      ]).per(Settings.length.digit_5)
  end

  private

  def load_shop
    @shop = Shop.find_by id: params[:id]
    return if @shop

    flash[:danger] = t("shops.not_found")
    redirect_to root_url
  end
end
