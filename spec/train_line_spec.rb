require 'spec_helper'

describe Train_line do
	it 'initializes a new train line with a name' do
		test_train_line = Train_line.new({'name' => 'Grasshopper'})
		expect(test_train_line).to be_an_instance_of Train_line
	end
end
