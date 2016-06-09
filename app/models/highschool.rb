class Highschool < ActiveRecord::Base
	validates_presence_of :name, :location, :enrollment

	has_many :mathclasses

	def name_location
		"#{name} is located in #{location}."
	end

	def enrollment_size
		if(enrollment >= 2000)
			"Large"
		elsif (enrollment > 500 )
			"Medium"
		else
			"Small"
		end
	end

end