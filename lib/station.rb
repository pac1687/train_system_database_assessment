class Station
	attr_reader :id, :name

	def initialize(attributes)
		@id = attributes['id'].to_i
		@name = attributes['name']
	end

	def == another_station
		self.id == another_station.id && self.name == another_station.name
	end

	def save
		results = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;")
		@id = results.first['id'].to_i
	end

	def self.all
		results = DB.exec("SELECT * FROM stations;")
		stations = []
		results.each do |result|
			new_station = Station.new(result)
			stations << new_station
		end
		stations
	end
end