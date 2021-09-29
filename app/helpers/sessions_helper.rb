module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def load_book_id_in_cart
    current_cart.keys
  end

  def add_book_to_cart book_id, quantity
    current_cart.delete(book_id.to_s)
    current_cart[book_id.to_s.to_sym] = quantity
  end

  def current_cart
    @current_cart ||= session[:cart]
  end
end
