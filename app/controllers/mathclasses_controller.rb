class MathclassesController < ApplicationController
	before_action :mathclass, except: [:index, :new, :create]
	before_action :highschool, only: [:index, :new, :create, :show]
  
  def index
  	@mathclasses = @highschool.mathclasses
  end

  def show
  end

  def new
  	@mathclass = Mathclass.new
  end

  def create
  	@mathclass = @highschool.mathclasses.new(mathclass_params)
  	if @mathclass.save
  		flash[:success] = 'Math class created!'
  		redirect_to highschool_mathclass_path(@highschool, @mathclass)
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @mathclass.update(mathclass_params)
  		flash[:success] = 'Math class updated!'
  		redirect_to highschool_mathclass_path(@highschool, @mathclass)
  	else
  		render :edit
  	end
  end

  def destroy
  	@mathclass.destroy
 		flash[:success] = 'Math class destroyed!'
  	redirect_to highschool_mathclasses_path
  end

  private

  def highschool
  	@highschool = Highschool.find(params[:highschool_id])
  end

  def mathclass
  	@mathclass = highschool.mathclasses.find(params[:id])
  end

  def mathclass_params
  	params.require(:mathclass).permit(:name, :students)
  end

end