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

	def self.train_line_station_list(train_line_id)
		results = DB.exec("SELECT stations.* FROM train_lines JOIN stops ON (train_lines.id = stops.train_line_id) JOIN stations ON (stops.station_id = stations.id) WHERE train_lines.id = #{train_line_id};")
		stations = []
		results.each do |result|
			new_station = Station.new(result)
			stations << new_station
		end
		stations
	end
end