class Shop::BooksController < ApplicationController
  before_action :load_shop, only: :index
  before_action :check_file, only: :import

  def index
    @books = @shop.all_books
                  .page(params[:page]).per(Settings.length.digit_8)
  end

  def import
    Book.import(@file, current_user.shop.id)
    flash[:success] = t "books.add_success"
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t "books.add_fail"
    redirect_to user_shop_books_path(current_user.id)
  else
    redirect_to user_shop_books_path(current_user.id)
  end

  private

  def check_file
    @file = params[:file]
    return @file if CSV.read(@file).count > 1

    flash[:danger] = t "books.require_file"
    redirect_to user_shop_books_path(current_user.id)
  end

  def load_shop
    @shop = current_user.shop
    return if @shop.present?

    flash[:danger] = t("shops.not_found")
    redirect_to root_url
  end
end
