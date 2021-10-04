module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by id: user_id
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by id: user_id
      log_in user
      @current_user = user
    end
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

  def reset_cart
    current_cart.clear
  end

  def delete_cart_item id
    current_cart.delete(id.to_s)
  end

  def add_book_to_cart book_id, quantity
    current_cart.delete(book_id.to_s)
    current_cart[book_id.to_s.to_sym] = quantity
  end

  def current_cart
    @current_cart ||= session[:cart]
  end

  def current_info_receiver
    @current_info_receiver ||= session[:info_receiver]
  end

  def load_param_name
    if current_info_receiver.any?
      current_info_receiver["name"]
    else
      current_user.name
    end
  end
end
