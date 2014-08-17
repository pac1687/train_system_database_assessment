class Train_line
	attr_reader :id, :name

	def initialize(attributes)
		@id = attributes['id']
		@name = attributes['name']
	end

	def == another_train_line
		self.id == another_train_line.id && self.name == another_train_line.name
	end

	def save
		results = DB.exec("INSERT INTO train_lines (name) VALUES ('#{name}') RETURNING id;")
		@id = results.first['id']
	end

	def self.all
		results = DB.exec("SELECT * FROM train_lines;")
		train_lines = []
		results.each do |result|
			new_train_line = Train_line.new(result)
			train_lines << new_train_line
		end
		train_lines
	end
end