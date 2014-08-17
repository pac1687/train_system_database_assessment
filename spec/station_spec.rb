require 'spec_helper'

describe Station do
	it 'initializes a new station with a name' do
		test_station = Station.new({'name' => 'Portland'})
		expect(test_station).to be_an_instance_of Station
	end
end