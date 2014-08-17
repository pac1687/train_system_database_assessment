require 'spec_helper'

describe Train_line do
	it 'initializes a new train line with a name' do
		test_train_line = Train_line.new({'name' => 'Grasshopper'})
		expect(test_train_line).to be_an_instance_of Train_line
	end

	it 'saves a new train_line to the database' do
		test_train_line = Train_line.new({'name' => 'Grasshopper'})
		test_train_line.save
		expect(Train_line.all).to eq [test_train_line]
	end

	it 'associates a train line with a station and returns all stations associated with a train_line' do
		test_train_line = Train_line.new({'name' => 'Grasshopper'})
		test_train_line.save
		test_station = Station.new({'name' => 'Portland'})
		test_station.save
		test_station1 = Station.new({'name' => 'Seattle'})
		test_station1.save
		Train_line.stop(test_train_line.id, test_station.id)
		Train_line.stop(test_train_line.id, test_station1.id)
		stations = Station.train_line_station_list(test_train_line.id)
		expect(stations).to eq [test_station, test_station1]
	end

end
