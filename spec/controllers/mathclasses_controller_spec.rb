require 'rails_helper'

RSpec.describe MathclassesController, type: :controller do
  let(:mathclass) { FactoryGirl.create(:mathclass) }
  let(:highschool) { Highschool.find(mathclass.highschool_id) }

  describe "GET #index" do
    it "returns http success" do
      get :index, highschool_id: highschool.id
      expect(response).to have_http_status(:success)
    end

    it 'sets the mathclass instance variable' do
      get :index, highschool_id: highschool.id
      expect(assigns(:mathclasses)).to eq(highschool.mathclasses)
    end

    it 'renders the index template' do
      get :index, highschool_id: highschool.id
      expect(response).to render_template(:index)
    end

    it 'has math classes in the mathclasses instance variable' do
      mathclasses = create_list(:mathclass, 3, highschool_id: 1)
      get :index, highschool_id: highschool.id
      expect((mathclasses).length).to eq(3)
    end
  end


  describe "GET #show" do
    it "returns http success" do
      get :show, highschool_id: highschool.id, id: mathclass.id
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get :show, highschool_id: highschool.id, id: mathclass.id
      expect(response).to render_template(:show)
    end

    it 'sets the mathclass instance variable' do
      get :show, highschool_id: highschool.id, id: mathclass.id
      expect(assigns(:mathclass).name).to eq(mathclass.name)
    end
  end


  describe "GET #new" do
    it "returns http success" do
      get :new, highschool_id: highschool.id
      expect(response).to have_http_status(:success)
    end

    it 'renders new template' do
      get :new, highschool_id: highschool.id
      expect(response).to render_template(:new)
    end

    it 'sets mathclass instance var' do
      get :new, highschool_id: highschool.id
      expect(assigns(:mathclass)).to_not eq(nil)
    end
  end


  describe "POST #create" do
    before(:each) do 
      @mathclass_params = { highschool_id: highschool.id, 
                            mathclass:
                            { 
                              name: 'Linear Algebra', 
                              students: 8,
                            }
                          }
      @filthclass_params = { highschool_id: highschool.id, 
                            mathclass:
                            { 
                              name: 'Differential Equations', 
                              students: '',
                            }
                          }  
    end

    it 'sets the mathclass instance variable' do
      post :create, @mathclass_params
      expect(assigns(:mathclass)).to_not eq(nil)
      expect(assigns(:mathclass).name).to eq(@mathclass_params[:mathclass][:name])
    end

    it 'creates a new math class' do
      # Any way to restrict factorygirl here?
      expect(Mathclass.count).to eq(1)
      post :create, @mathclass_params
      expect(Mathclass.count).to eq(2)
      expect(Mathclass.last.name).to eq(@mathclass_params[:mathclass][:name])
    end

    it 'redirects to show page on success' do
      post :create, @mathclass_params
      expect(response).to redirect_to(highschool_mathclass_path(Mathclass.last.highschool_id, Mathclass.last.id))
    end

    it 'renders the new template on fail' do
      # Any way to restrict factorygirl here?
      post :create, @filthclass_params
      expect(Mathclass.count).to eq(1)
      expect(response).to render_template(:new)
    end

    it 'sets the flash success on successful create' do
      post :create, @mathclass_params
      expect(flash[:success]).to eq('Math class created!')
    end
  end


  describe "GET #edit" do
    it "returns http success" do
      get :edit, highschool_id: highschool.id, id: mathclass.id
      expect(response).to have_http_status(:success)
    end

    it "renders edit template" do
      get :edit, highschool_id: highschool.id, id: mathclass.id
      expect(response).to render_template(:edit)
    end

    it "sets mathclass instance variable" do
      get :edit, highschool_id: highschool.id, id: mathclass.id
      expect(assigns(:mathclass).id).to eq(mathclass.id)
    end
  end


  describe "PUT #update" do
    before(:each) do
      put :update, { highschool_id: highschool.id, 
                      id: mathclass.id,
                      mathclass: {
                        name: 'Triangles'
                      }
                    }
    end

    it 'has http success' do
      expect(response).to have_http_status(302)
    end

    it 'sets the mathclass instance variable' do
      mathclass
    end

    it 'updates the mathclass' do
      expect(mathclass.reload.name).to eq('Triangles')
    end

    it 'redirects to the show on success' do
      expect(response).to redirect_to(highschool_mathclass_path(Mathclass.last.highschool_id, Mathclass.last.id))
    end

    it 'renders the edit template on fail' do
      put :update, { highschool_id: highschool.id, 
                                id: mathclass.id,
                                mathclass: {
                                  name: ''
                                }
                              }
      expect(response).to render_template(:edit)
    end

    it 'sets the flash success on update' do
      expect(flash[:success]).to eq('Math class updated!')
    end
  end


  describe "DELETE #destroy" do
    it 'sets the mathclass instance variable' do
      mathclass
    end

    it 'destroys the mathclass successfully' do
      mathclass
      expect(Mathclass.count).to eq(1)
      delete :destroy, highschool_id: highschool.id, id: mathclass.id
      expect(Mathclass.count).to eq(0)
    end

    it 'sets the flash success message' do
      delete :destroy, highschool_id: highschool.id, id: mathclass.id
      expect(flash[:success]).to eq('Math class destroyed!')
    end

    it 'redirects to the index path after destroy' do
      delete :destroy, highschool_id: highschool.id, id: mathclass.id
      expect(response).to redirect_to(highschool_mathclasses_path(assigns(:highschool)))
    end
  end

end