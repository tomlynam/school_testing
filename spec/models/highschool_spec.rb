require 'rails_helper'

RSpec.describe Highschool, type: :model do
	let(:highschool) { FactoryGirl.create(:highschool)}
	let(:hugeschool) { FactoryGirl.create(:highschool, :large)}
	let(:okayschool) { FactoryGirl.create(:highschool, :medium)}
	let(:smallschool) { FactoryGirl.create(:highschool, :small)}

	describe 'validations' do
		it { should validate_presence_of :name }
		it { should validate_presence_of :location }
		it { should validate_presence_of :enrollment }
	end

	# hash symbol means we are testing an instance method
	describe '#name_location' do
		it 'returns name and location message' do
			expect(highschool.name_location).to eq("#{highschool.name} is located in #{highschool.location}.")
		end
	end

	describe '#enrollment_size' do
		it "returns large if enrollment size is > 2000" do
			expect(hugeschool.enrollment_size).to eq('Large')
		end
		
		it "returns medium if enrollment size is > 500" do
			expect(okayschool.enrollment_size).to eq('Medium')
		end
		
		it "returns small if enrollment size is < 500" do
			expect(smallschool.enrollment_size).to eq('Small')
		end
	end

end