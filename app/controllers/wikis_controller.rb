class WikisController < ApplicationController
    before_action :authorize_user, except: [:index, :new, :create]

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was created successfully."
      redirect_to(@wiki)
    else
      flash.now[:alert] = "Error creating wiki.  Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to(@wiki)
    else
      flash.now[:alert] = "Error updating wiki.  Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "Error deleting the wiki. Please try again."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def authorize_user
    @wiki = Wiki.find(params[:id])
    if @wiki.private?
      redirect_to(action: :index) unless current_user == @wiki.user || current_user.admin? || @wiki.collaborations.pluck(:user_id).include?(current_user.id)
    end
  end
end
