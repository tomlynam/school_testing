require 'rails_helper'

RSpec.describe HighschoolsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets the highschools instance variable' do
      get :index
      expect(assigns(:highschools)).to eq([])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'has highschools in the highschools instance variable' do
      3.times { |index| Highschool.create(name: "name_#{index}", location: "New York, New York", enrollment: 2000) }
      get :index
      expect(assigns(:highschools).length).to eq(3)
      expect(assigns(:highschools).last.name).to eq('name_2')
    end
  end

  describe "GET #show" do
    it "returns http success" do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 200)
      get :show, id: highschool.id
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 200)
      get :show, id: highschool.id
      expect(response).to render_template(:show)
    end

    it 'sets the highschool instance variable' do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 1200)
      get :show, id: highschool.id
      expect(assigns(:highschool).name).to eq(highschool.name)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'sets the highschool instance variable' do
      get :new
      expect(assigns(:highschool)).to_not eq(nil)
    end
  end

  describe "POST #create" do
    it 'sets the highschool instance variable' do
      highschool_params = { highschool:
                            { 
                              name: 'New School', 
                              location: 'Orlando, Florida', 
                              enrollment: 1700
                            }
                          }
      post :create, highschool_params
      expect(assigns(:highschool)).to_not eq(nil)
      expect(assigns(:highschool).name).to eq(highschool_params[:highschool][:name])
    end

    it 'creates a new highschool' do
      highschool_params = { highschool:
                           { 
                            name: 'New School', 
                            location: 'Orlando, Florida', 
                            enrollment: 1200
                            }
                          }
      expect(Highschool.count).to eq(0)
      post :create, highschool_params
      expect(Highschool.count).to eq(1)
      expect(Highschool.first.name).to eq(highschool_params[:highschool][:name])
    end

    it 'redirects to show page on success' do
      highschool_params = { highschool:
                            { 
                              name: 'New School', 
                              location: 'Orlando, Florida', 
                              enrollment: 1200
                            }
                          }
      post :create, highschool_params
      expect(response).to redirect_to(highschool_path(Highschool.first))
    end

    it 'renders the new template on fail' do
      highschool_params = { highschool:
                           { 
                            name: '', 
                            location: 'Orlando, Florida', 
                            enrollment: 1200
                            }
                          }
      post :create, highschool_params
      expect(Highschool.count).to eq(0)
      expect(response).to render_template(:new)
    end

    it 'sets the flash success on successful create' do
      highschool_params = { highschool:
                           { 
                            name: 'New School', 
                            location: 'Orlando, Florida', 
                            enrollment: 1200
                            }
                          }
      post :create, highschool_params
      expect(flash[:success]).to eq('High school created!')
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 2000)
      get :edit, id: highschool.id
      expect(response).to have_http_status(:success)
    end

    it "renders edit template" do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 2000)
      get :edit, id: highschool.id
      expect(response).to render_template(:edit)
    end

    it "sets high school instance variable" do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 2000)
      get :edit, id: highschool.id
      expect(assigns(:highschool).id).to eq(highschool.id)
    end
  end
  
  describe "PUT #update" do
    it 'sets the high school instance variable' do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 200)
    end

    it 'updates the high school' do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 200)
      put :update, {id: highschool.id, highschool: {name: 'new name'}}
      expect(highschool.reload.name).to eq('new name')
    end

    it 'redirects to the show on success' do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 200)
      put :update, {id: highschool.id, highschool: {name: 'new name'}}
      expect(response).to redirect_to(highschool_path)
    end

    it 'renders the edit template on fail' do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 1200)
      put :update, {id: highschool.id, highschool: {name: ''}}
      expect(response).to render_template(:edit)
    end

    it 'sets the flash success on update' do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 1200)
      put :update, {id: highschool.id, highschool: {name: 'new name'}}
      expect(flash[:success]).to eq('High school updated!')
    end
  end

  describe "DELETE #destroy" do
    it 'sets the high school instance variable' do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 2000)
      delete :destroy, id: highschool.id
      expect(assigns(:highschool)).to eq(highschool)
    end

    it 'destroys the high school successfully' do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 500)
      expect(Highschool.count).to eq(1)
      delete :destroy, id: highschool.id
      expect(Highschool.count).to eq(0)
    end

    it 'sets the flash success message' do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 2000)
      delete :destroy, id: highschool.id
      expect(flash[:success]).to eq('High school destroyed!')
    end

    it 'redirects to the index path after destroy' do
      highschool = Highschool.create(name: "Bronx High School", location: "New York, New York", enrollment: 2000)
      delete :destroy, id: highschool.id
      expect(response).to redirect_to(highschools_path)
    end
  end
end