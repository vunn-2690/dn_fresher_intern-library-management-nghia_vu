class CartsController < ApplicationController
  before_action :load_book, only: :create

  def create
    add_book_to_cart(params[:book_id], params[:quantity]) if check_quantity
    respond_to do |format|
      format.js
    end
  end

  private

  def check_quantity
    @quantity = @book.quantity >= params[:quantity].to_i
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book

    flash[:danger] = t "books.not_found"
    redirect_to static_pages_home_path
  end
end
