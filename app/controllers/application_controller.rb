class ApplicationController < ActionController::Base
  before_action :set_locale, :load_cart, :load_info_receiver

  include SessionsHelper
  include OrdersHelper

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "please_login"
    redirect_to login_path
  end

  def load_cart
    session[:cart] ||= {}
  end

  def load_info_receiver
    session[:info_receiver] ||= {}
  end
end
