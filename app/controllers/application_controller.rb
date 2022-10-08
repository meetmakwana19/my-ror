class ApplicationController < ActionController::Base
    # for preventing CSRF
    protect_from_forgery with: :exception
    # exception is another word for error in ruby

    private
    def confirm_logged_in
      unless session[:user_id]
        flash[:notice] = "Please log in."
        redirect_to(access_login_path)
      end
    end
  
end
