class UsersController < ApplicationController
  def show
  end

  def update
    @user = User.find(params[:id] || current_user)
    @user.role = "standard"
    @user.save!
    
    redirect_to wikis_path
  end
end
