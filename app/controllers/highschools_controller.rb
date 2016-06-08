class HighschoolsController < ApplicationController
	before_action :highschool, except: [:index, :new, :create]

  def index
  	@highschools = Highschool.all
  end

  def show
  end

  def new
  	@highschool = Highschool.new
  end

  def create
  	@highschool = Highschool.new(highschool_params)
  	if @highschool.save
  		flash[:success] = 'High school created!'
  		redirect_to highschool_path(@highschool) 
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @highschool.update(highschool_params)
  		flash[:success] = 'High school updated!'
  		redirect_to highschool_path(@highschool)
  	else
  		render :edit
  	end
  end

  def destroy
  	@highschool.destroy
  	flash[:success] = 'High school destroyed!'
  	redirect_to highschools_path
  end

  private

  def highschool
  	@highschool = Highschool.find(params[:id])
  end

  def highschool_params
  	params.require(:highschool).permit(:name, :location, :enrollment)
  end

end