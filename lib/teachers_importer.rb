class TeachersImporter
	def initialize(filename=File.absolute_path('db/data/teachers.csv'))
    @filename = filename
  end

  def import
    field_names = ['first_name', 'last_name', 'email','address', 'phone']
    puts "Importing teachers from '#{@filename}'"
    failure_count = 0
    Teacher.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          Teacher.create!(attribute_hash)
          print '.'
        rescue ActiveRecord::UnknownAttributeError
          failure_count += 1
          print '!'
        ensure
          STDOUT.flush
        end
      end
    end
    failures = failure_count > 0 ? "(failed to create #{failure_count} student records)" : ''
    puts "\nDONE #{failures}\n\n"
  end
end