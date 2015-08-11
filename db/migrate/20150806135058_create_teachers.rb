class CreateTeachers < ActiveRecord::Migration
	def change
		create_table :teachers do |t|
      # column definitions go here
      # Use the AR migration guide for syntax reference
	    	t.string :first_name
		    t.string :last_name
		    t.string :email
		    t.string :address
		    t.string :phone
		    t.timestamps
		end
	end

end