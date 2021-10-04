class Shop::ShopsController < ApplicationController
  before_action :load_shop, :check_user, only: :show

  def show
    @books = current_user.shop
                         .all_books
                         .page(params[:page]).per(Settings.length.digit_5)
  end

  private

  def load_shop
    @shop = current_user.shop
    return if @shop

    flash[:danger] = t("shops.not_found")
    redirect_to root_url
  end

  def check_user
    return if current_user.id == params[:user_id].to_i

    flash[:danger] = t "shared.invalid_permision"
    redirect_to root_url
  end
end
