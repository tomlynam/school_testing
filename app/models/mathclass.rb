class Mathclass < ActiveRecord::Base
	validates_presence_of :name, :students

	belongs_to :highschool

	def type_of_math
		"Welcome to #{name}."
	end

	def class_size
		if(students >= 25)
			"Lecture"
		elsif (students > 5)
			"Seminar"
		else
			"Wow, that's a small class!"
		end
	end

end