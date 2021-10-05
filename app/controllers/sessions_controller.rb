class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user.try(:authenticate, params[:session][:password])
      log_in user
      check_remember user
      redirect_back_or root_url
    else
      flash.now[:danger] = t "users.login.invalid_login"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
