require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_wiki) { create(:wiki, user: my_user) }

  context "un-signed in user" do
    describe "GET #index" do
      it "should redirect to sign up" do
        get :index
        expect(response).to redirect_to("/users/sign_in")
      end
    end

    describe "GET #show" do
      it "should redirect to sign up" do
        get :show, id: my_wiki.id
        expect(response).to redirect_to("/users/sign_in")
      end
    end

    describe "GET #new" do
      it "should redirect to sign up" do
        get :new
        expect(response).to redirect_to("/users/sign_in")
      end
    end

    describe "GET #edit" do
      it "should redirect to sign up" do
        get :edit, id: my_wiki.id
        expect(response).to redirect_to("/users/sign_in")
      end
    end
  end

  context "signed in user" do
    before { sign_in my_user }

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns Wiki.all to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([my_wiki])
      end      
    end
  
    describe "GET #show" do
      it "returns http success" do
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "assigns my_wiki to @wiki" do
        get :show, id: my_wiki.id
        expect(assigns(:wiki)).to eq(my_wiki)
      end 
    end
  
    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "should initialize @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end      
    end

    describe "POST create" do
      it "increases the number of wikis by 1" do
        expect{ post :create, wiki: {title: "This title", body: "This body", private: false } }.to change(Wiki,:count).by(1)
      end

      it "assigns Wiki.last to @wiki" do
        post :create, wiki: {title: "This title", body: "This body", private: false }
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, wiki: {title: "This title", body: "This body", private: false }
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, {id: my_wiki.id}
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq my_wiki.id
        expect(wiki_instance.title).to eq my_wiki.title
        expect(wiki_instance.body).to eq my_wiki.body
      end
    end

    describe "PUT update" do
      it "updates wiki with expected attributes" do
        put :update, id: my_wiki.id, wiki: {title: "A new title.", body: "What we all want."}
        updated_wiki = assigns(:wiki)

        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.title).to eq "A new title."
        expect(updated_wiki.body).to eq "What we all want."
      end

      it "redirects to the updated wiki" do
        put :update, id: my_wiki.id, wiki: {title: "A new title.", body: "What we all want."}
        expect(response).to redirect_to my_wiki
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, {id: my_wiki.id}
        count = Wiki.where({id: my_wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wiki index" do
        delete :destroy, {id: my_wiki.id}
        expect(response).to redirect_to wikis_path
      end
    end
  end
end
