require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  let(:my_user) { create(:user) }

  context "unsigned in user" do 
    describe "GET #index" do
      it "should redirect to sign up" do
        get :index
        expect(response).to redirect_to("/users/sign_in")
      end
    end
  
    describe "GET #about" do
      it "should redirect to sign up" do
        get :about
      expect(response).to redirect_to("/users/sign_in") 
      end
    end
  end

  context "signed in user" do 
    before { sign_in my_user }

    describe "GET #index" do
      it "should render the #index view" do
        get :index
        expect(response).to render_template(:index)
      end
    end
  
    describe "GET #about" do
      it "should render the #about view" do
        get :about
      expect(response).to render_template(:about) 
      end
    end
  end
end