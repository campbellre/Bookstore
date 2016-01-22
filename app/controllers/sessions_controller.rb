class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
    # login
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email or password entered.'
      render new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
