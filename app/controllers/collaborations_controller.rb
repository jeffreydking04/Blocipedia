class CollaborationsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
    if @wiki.collaborations.nil?
      @users = User.where.not(id: current_user.id)
    else
      @users = []
      users_list = User.where.not(id: current_user.id)
      collaborators_user_id_list = @wiki.collaborations.pluck(:user_id)
      users_list.each do |user|
        if !collaborators_user_id_list.include?(user.id)
          @users << user
        end
      end
    end
    @collaboration = @wiki.collaborations.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaboration = @wiki.collaborations.build(collaboration_params)
    @collaboration.save!
    redirect_to @wiki
  end

  def destroy
    @collaboration = Collaboration.find(params[:id])
    @wiki = Wiki.find_by(id: @collaboration.wiki_id)
    @collaboration.destroy
    redirect_to @wiki
  end

  private

  def collaboration_params
    params.require(:collaboration).permit(:user_id, :wiki_id)
  end
end