require "rails_helper"

RSpec.describe BooksController, type: :controller do
  describe "GET #show" do
    let!(:book){FactoryBot.create :book}
    context "when book exist" do
      before do
        get :show, params: {id: book.id}
      end
      it "return book" do
        expect(assigns(:book)).to eq book
      end
    end
    context "when book does not exist" do
      before do
        get :show, params: {id: -1}
      end
      it "display flash message" do
        expect(flash[:danger]).to eq I18n.t("books.not_found")
      end
      it "redirect to root URL" do
        expect(response).to redirect_to static_pages_home_path
      end
    end
  end
end
