require 'rails_helper'

feature 'Math Classes Index', js: true do
	
	context 'no mathclasses' do
		before(:each) do
			@highschool = Highschool.create(name: 'Montrose Christian', 
												location: 'Rockville, MD', 
												enrollment: 800)
			visit highschool_mathclasses_path(@highschool)
		end

		scenario 'header validation' do
			expect(find('.mathclasses-header').text.strip).to eq('Math Classes')
		end

		scenario 'correct message if no highschools' do
			expect(find('.no-mathclasses-header').text).to eq('No Math Classes, Recess!')
		end

		scenario 'create a math class' do
			find('#new-mathclass-btn').click
			fill_in('mathclass[name]', with: 'Precalculus')
			fill_in('mathclass[students]', with: 15)
			# CODE WAY - find the form by id and call form.submit
			# USER WAY - find the submit button and click on it
			find('#submit-mathclass-btn').click
			expect(find('.mathclass-header').text).to eq('Precalculus')
		end

		scenario 'fill out the form and back out' do
			visit new_highschool_mathclass_path(@highschool)
			fill_in('mathclass[name]', with: 'Precalculus')
			fill_in('mathclass[students]', with: 15)
			find('#cancel-mathclass').click
			expect(find('.mathclasses-header')).to_not eq(nil)
			expect(first('.mathclass-header')).to eq(nil)
		end
	end

	context 'with mathclasses' do
		before(:each) do
			@highschool = Highschool.create(name: 'Montrose Christian', 
												location: 'Rockville, MD', 
												enrollment: 800)
		end

		scenario 'mathclass title is correct' do
			mathclass_name = 'Calculus II'
			mathclass = @highschool.mathclasses.create(name: mathclass_name, 
																								students: 25)
			visit highschool_mathclasses_path(@highschool)
			expect(find('.mathclass-title').text).to eq(mathclass_name)
		end

		scenario 'mathclass show button' do
			mathclass_name = 'Calculus II'
			mathclass = @highschool.mathclasses.create(name: mathclass_name, 
																									students: 25)
			visit highschool_mathclasses_path(@highschool)
			first('.mathclass-link').click
			expect(find('.mathclass-header').text).to eq(mathclass_name)	
		end
	end

end