FactoryGirl.define do 
	factory :highschool, class: Highschool do
		name 'Westport High School'
		location 'Westport, CT'
		enrollment 1500

		trait :large do
			enrollment 2500
		end

		trait :medium do
			enrollment 700
		end

		trait :small do
			enrollment 400
		end

	end
end
