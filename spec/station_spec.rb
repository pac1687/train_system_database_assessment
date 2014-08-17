require 'spec_helper'

describe Station do
	it 'initializes a new station with a name' do
		test_station = Station.new({'name' => 'Portland'})
		expect(test_station).to be_an_instance_of Station
	end

	it 'saves a new station to the database' do
		test_station = Station.new({'name' => 'Portland'})
		test_station.save
		expect(Station.all).to eq [test_station]
	end

	it 'associates a train line with a station and returns all train lines associated with a station' do
		test_train_line = Train_line.new({'name' => 'Grasshopper'})
		test_train_line.save
		test_train_line1 = Train_line.new({'name' => 'The Norris'})
		test_train_line1.save
		test_station = Station.new({'name' => 'Portland'})
		test_station.save
		Train_line.stop(test_train_line.id, test_station.id)
		binding.pry
		Train_line.stop(test_train_line1.id, test_station.id)
		train_lines = Train_line.station_train_line_list(test_station.id)
		expect(train_lines).to eq [test_train_line, test_train_line1]
	end
end