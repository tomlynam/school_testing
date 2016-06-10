require 'rails_helper'

feature 'High Schools Index', js: true do
	
	context 'no highschools' do
		before(:each) do
			visit root_path
		end

		scenario 'header validation' do
			# root_path = schools#index
			expect(find('#header').text.strip).to eq('High Schools')
		end

		scenario 'correct message if no highschools' do
			expect(find('#no-schools-header').text).to eq('No Schools, Summer!')
		end

		scenario 'create a high school' do
			find('#new-highschool-btn').click
			fill_in('highschool[name]', with: 'Montrose Christian')
			fill_in('highschool[location]', with: 'Rockville, MD')
			fill_in('highschool[enrollment]', with: 2000)
			# CODE WAY - find the form by id and call form.submit
			# USER WAY - find the submit button and click on it
			find('#submit-highschool-btn').click
			expect(find('#highschool-header').text).to eq('Montrose Christian')
		end

		scenario 'fill out the form and back out' do
			visit new_highschool_path
			fill_in('highschool[name]', with: 'Montrose Christian')
			fill_in('highschool[location]', with: 'Rockville, MD')
			fill_in('highschool[enrollment]', with: 2000)
			find('#cancel-highschool').click
			expect(find('#header')).to_not eq(nil)
			expect(first('#highschool-header')).to eq(nil)
		end
	end

	context 'with highschools' do
		scenario 'highschool title is correct' do
			highschool_name = 'Montrose Christian'
			highschool = Highschool.create(name: highschool_name, 
																			location: 'Rockville, MD', 
																			enrollment: 800)
			visit root_path
			expect(find('.highschool-title').text).to eq(highschool_name)
		end

		scenario 'highschool show button' do
			highschool_name = 'Montrose Christian'
			highschool = Highschool.create(name: highschool_name, 
																			location: 'Rockville, MD', 
																			enrollment: 800)
			visit root_path
			first('.highschool-link').click
			expect(find('#highschool-header').text).to eq(highschool_name)	
		end
	end

end