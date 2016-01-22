module SessionsHelper

  def log_in(user)
    session[:username] = user.username
  end

  def current_user
    @current_user ||= User.find_by(session[:username])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:username)
    @current_user = nil
  end
  
end
