require 'rails_helper'

RSpec.describe Highschool, type: :model do
	describe 'validations' do
		it { should validate_presence_of :name }
		it { should validate_presence_of :location }
		it { should validate_presence_of :enrollment }
	end


	# hash symbol means we are testing an instance method
	describe '#name_location' do
		it 'returns name and location message' do
			@highschool = Highschool.create(name: 'East High School', location: 'Salt Lake City, Utah', enrollment: 150)
			expect(@highschool.name_location).to eq("#{@highschool.name} is located in #{@highschool.location}.")
		end
	end


	describe '#enrollment_size' do
		it "returns large if enrollment size is > 2000" do
			@highschool = Highschool.create(name: 'East High School', location: 'Salt Lake City, Utah0', enrollment: 2500)
			expect(@highschool.enrollment_size).to eq('Large')
		end
		
		it "returns large if enrollment size is == 2000" do
			@highschool = Highschool.create(name: 'East High School', location: 'Salt Lake City, Utah', enrollment: 2000)
			expect(@highschool.enrollment_size).to eq('Large')
		end
		
		it "returns medium if enrollment size is > 500" do
			@highschool = Highschool.create(name: 'East High School', location: 'Salt Lake City, Utah', enrollment: 750)
			expect(@highschool.enrollment_size).to eq('Medium')
		end
		
		it "returns small if enrollment size is < 500" do
			@highschool = Highschool.create(name: 'East High School', location: 'Salt Lake City, Utah', enrollment: 120)
			expect(@highschool.enrollment_size).to eq('Small')
		end
	end

end