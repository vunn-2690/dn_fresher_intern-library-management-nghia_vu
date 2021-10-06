class BooksController < ApplicationController
  before_action :load_book, only: :show

  def show; end

  def import
    Book.import(params[:file], params[:shop_id])
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t "books.add_fail"
    redirect_to root_path
  else
    flash[:success] = t "books.add_success"
    redirect_to root_path
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t "books.not_found"
    redirect_to static_pages_home_path
  end
end
