class UsersController < ApplicationController
  def show
  end

  def update
    @user = User.find(params[:id] || current_user)
    @user.role = "standard"
    @user.save!

    self.make_private_wikis_public

    redirect_to wikis_path
  end

  def make_private_wikis_public
    user_wikis = Wiki.where(user_id: current_user.id)
    user_wikis.each do |wiki|
      wiki.private = false
      wiki.save!
    end
  end
end
