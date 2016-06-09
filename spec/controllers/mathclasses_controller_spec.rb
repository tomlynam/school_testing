require 'rails_helper'

RSpec.describe MathclassesController, type: :controller do

  describe "GET #index" do
    before(:each) do 
      @highschool = Highschool.create(name: 'East High', location: 'SLC', enrollment: 1500)
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets the mathclass instance variable' do
      get :index
      expect(assigns(:mathclasses)).to eq([])
    end


    it 'renders the index template' do
    end


    it 'has math classes in the mathclasses instance variable' do
    end

  end






























  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

end
