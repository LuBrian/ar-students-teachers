class TeacherEmployment < ActiveRecord::Migration
	def change
		change_table :teachers do |t|
			t.date :hire_date
			t.date :retire_date
		end
	end


end