class AdminUsersController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in

  def index
    @admin_users = AdminUser.sorted
  end

  def new
    @admin_users = AdminUser.new
  end

  def create
    @admin_users = AdminUser.new(admin_user_params)
    if @admin_users.save
      flash[:notice] = 'Admin user created succcessfully'
      redirect_to(admin_users_path)
    else
      render('new')
    end
  end


  def edit
    @admin_user = AdminUser.find(params[:id])
  end
  
  def update
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.update_attributes(admin_user_params)
      flash[:notice] = 'Admin User updated succcessfully.'
      redirect_to(admin_users_path)
    else
      render('edit')
    end
  end
    
  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    @admin_user = AdminUser.find(params[:id])
    @admin_user.destroy
    flash[:notice] = 'Admin user deleted succcessfully.'
    redirect_to(admin_users_path)
  end

  private
  
  def admin_user_params
    # mass assigning parameters
    params.require(:admin_user).permit(
      :first_name,
      :last_name,
      :email,
      :username,
      :password #it is virtual field, cannot give password_digest to edit on the form.
    )
  end

end
