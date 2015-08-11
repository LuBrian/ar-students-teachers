class Student < ActiveRecord::Base
  # implement your Student model here
  belongs_to :teacher
  validates :email,uniqueness: true,format: { with: /.{2,20}[@]\w{2,}[.]\w{2,5}/, message: 'must be in the format of email' }
  validates_numericality_of :age, greater_than: 3
  before_save :cannot_assign_to_retired_teacher
  after_save :save_added_date_to_teacher, if: :teacher_id
  def save_added_date_to_teacher
  	self.teacher.last_student_added_at = Date.today
  	self.teacher.save
  end

  def cannot_assign_to_retired_teacher
  	if self.teacher.retire_date && self.teacher.retire_date <= Date.today
  		self.teacher_id = nil
  		errors.add(:teacher_id, "the teacher already retired!")
  	end
  end


  def age
  	now = Date.today
    age = now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)   
  end
  def name
  	first_name + ' ' + last_name
  end
end
