class AccessController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def menu
    # display text and links
    @username = session[:username]
  end

  def login
    # login form
  end

  def attempt_login
    # 2 parameters(username and password) will be recieved for processing 
    if params[:username].present? && params[:password].present?
      found_user = AdminUser.where(:username => params[:username]).first #this will return an array with values or an empty array[] so wrote .first to get the value from that array
      logger.debug("*****Testing.*****")
      if found_user
        # has this step on the rails console in V88
        authorized_user = found_user.authenticate(params[:password]) #will return false or an user object so caching it in authorized_user variable.
      end
    end

    if authorized_user 
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      flash[:notice] = "You're now logged in."
      redirect_to(admin_path)
    else
      flash.n ow[:notice] = "Invalid username/password."
      render('login')
    end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "Logged out !"
    redirect_to(access_login_path)
  end

  private
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(access_login_path)
    end
  end

end