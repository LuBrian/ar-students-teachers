class Teacher < ActiveRecord::Base
	has_many :students
	validates :email, presence: true, uniqueness: true
	validate :hire_date_before_retire_date, :retire_date_in_future
	after_save :set_students_teacher_to_nil
	def hire_date_before_retire_date
		if hire_date && retire_date && retire_date < hire_date
			errors.add(:retire_date, "Hire date must be before retire date")
		end
	end

	def retire_date_in_future
		if retire_date && retire_date > Date.today
			errors.add(:retire_date, "retire date can't be in the future!")
		end
	end

	def set_students_teacher_to_nil
		if retire_date
			self.students.each do |student|
				student.teacher_id = nil
				student.save
			end

		end
	end

end