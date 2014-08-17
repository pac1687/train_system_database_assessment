require 'train_line'
require 'station'
require 'pg'
require 'pry'

DB = PG.connect(:dbname => 'train_system_test')

RSpec.configure do |config|
	config.after(:each) do
		DB.exec("DELETE FROM trains *;")
		DB.exec("DELETE FROM stations *;")
		DB.exec("DELETE from stops *;")
	end
end