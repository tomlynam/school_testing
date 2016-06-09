require 'rails_helper'

RSpec.describe Mathclass, type: :model do
	describe 'validations' do
		it { should validate_presence_of :name }
		it { should validate_presence_of :students }
	end

	# hash symbol means we are testing an instance method
	describe '#type_of_math' do
		it 'returns type of math taught in class' do
			@highschool = Highschool.create(name: 'East High', location: 'SLC', enrollment: 1500)
			@mathclass = @highschool.mathclasses.create(name: 'Algebra', students: 150)
			expect(@mathclass.type_of_math).to eq("#{@mathclass.type_of_math}")
		end
	end

	describe '#class_size' do
		before(:each) do 
			@highschool = Highschool.create(name: 'East High', location: 'SLC', enrollment: 1500)
		end

		it "returns lecture if class size is > 25" do
			@mathclass = @highschool.mathclasses.create(name: 'Trigonometry', students: 250)
			expect(@mathclass.class_size).to eq('Lecture')
		end
		
		it "returns lecture if class size is == 25" do
			@mathclass = @highschool.mathclasses.create(name: 'Trigonometry', students: 25)
			expect(@mathclass.class_size).to eq('Lecture')
		end
		
		it "returns seminar if class size is > 5" do
			@mathclass = @highschool.mathclasses.create(name: 'Trigonometry', students: 15)
			expect(@mathclass.class_size).to eq('Seminar')
		end
		
		it "returns wow if class size is < 5" do
			@mathclass = @highschool.mathclasses.create(name: 'Trigonometry', students: 2)
			expect(@mathclass.class_size).to eq("Wow, that's a small class!")
		end
	end

end