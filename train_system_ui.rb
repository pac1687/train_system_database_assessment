require "./lib/train_line"
require "./lib/station"
require "pg"
require "pry"

DB = PG.connect(:dbname => 'train_system')

def main_menu
	puts "Are you an operator or rider:"
	puts "Press 'o' for operator."
	puts "Press 'r' for rider."
	puts "Press 'x' to exit the program."

	user_decision = gets.chomp
	if user_decision == 'o'
		operator_menu
	elsif user_decision == 'r'
		rider_menu
	elsif user_decision == 'x'
		puts "Thanks!  Have a great day!"
		exit
	else
		puts "Invalid entry.  Please try again!"
		main_menu
	end
end

def operator_menu
	puts "*** Operator Menu ***"
	puts "Welcome, train system operator.  Please choose an option:"
	puts "Press 't' to view train menu."
	puts "Press 's' to view station menu."
	puts "Press 'v' to view stop menu."
	puts "Press 'm ' to view the main menu."
	puts "Press 'x' to exit the program."

	user_decision = gets.chomp
	if user_decision == 't'
		operator_train_line_menu
	elsif user_decision == 's'
		operator_station_menu
	elsif user_decision == 'v'
		operator_stop_menu
	elsif user_decision == 'x'
		operator_menu
	elsif user_decision == 'x'
		puts "Thanks!  Have a great day!"
		exit
	else
		puts "Invalid entry.  Please try again!"
		operator_menu
	end
end

def rider_menu
	puts "*** Rider Menu ***"
	puts "Press 't' to view the train line menu."
	puts "Press 's' to view the station menu."
	puts "Press 'm ' to view the main menu."
	puts "Press 'x' to exit the program."

	user_decision = gets.chomp
	if user_decision == 't'
		rider_train_line_menu
	elsif user_decision == 's'
		rider_station_menu
	elsif user_decision == 'x'
		puts "Thanks!  Have a great day!"
		exit
	else
		puts "Invalid entry.  Please try again!"
		rider_menu
	end
end

def operator_train_line_menu
	puts "*** Operator Train Line Menu ***"
	puts "Press 'a' to add a train line."
	puts "Press 'l' to list all train lines."
	puts "Press 'o' to return to the operator menu."
	puts "Press 'm' to return to the main menu."
	puts "Press 'x' to exit the program."

	user_decision = gets.chomp

	if user_decision == 'a'
		add_train_line
	elsif user_decision == 'l'
		list_train_lines
		operator_train_line_menu
	elsif user_decision == 'o'
		operator_train_line_menu
	elsif user_decision == 'm'
		main_menu
	elsif user_decision == 'x'
		puts "Thanks!  Have a great day!"
		exit
	else 
		puts "Invalid entry.  Please try again!"
	end
end

def add_train_line
	puts "*** Add Train Line Menu ***"
	puts "Press 'a' to add a train line."
	puts "Press 'x' to return to the train line menu."

	user_decision = gets.chomp

	if user_decision == 'a'
		puts "Please enter in the new train line name:"
		operator_train_line = gets.chomp
		new_train_line = Train_line.new({'name' => operator_train_line})
		new_train_line.save
		puts "'#{new_train_line.name}' has been added."
		operator_train_line_menu
	elsif user_decision == 'x'
		operator_train_line_menu
	end
end

def list_train_lines
	puts "Current train lines:"
	Train_line.all.each do |train_line|
		puts "#{train_line.id}. #{train_line.name}"
	end

	puts "Press 'l' to list all stations associated with a train line."
	puts "Press 'x' to return to the previous menu."

	user_decision = gets.chomp

	if user_decision == 'l'
		puts "Enter the number of the train line you'd like to list stations for:"
		user_station = gets.chomp.to_i
		Station.train_line_station_list(user_station).each do |station|
			puts "#{station.id}. #{station.name}\n\n"
		end
	elsif user_decision == 'x'
	end
end

def operator_station_menu
	puts "*** Operator Station Menu ***"
	puts "Press 'a' to add a station."
	puts "Press 'l' to list all stations."
	puts "Press 'o' to return to the operator menu."
	puts "Press 'm' to return to the main menu."
	puts "Press 'x' to exit the program."

	user_decision = gets.chomp

	if user_decision == 'a'
		add_station
	elsif user_decision == 'l'
		list_stations
		operator_station_menu
	elsif user_decision == 'o'
		operator_menu
	elsif user_decision == 'm'
		main_menu
	elsif user_decision == 'x'
		puts "Thanks!  Have a great day!"
		exit
	else 
		puts "Invalid entry.  Please try again!"
	end
end

def add_station
	puts "*** Add Station Menu ***"
	puts "Press 'a' to add a station."
	puts "Press 'x' to return to the station menu."

	user_decision = gets.chomp

	if user_decision == 'a'
		puts "Please enter in the new station name:"
		operator_station = gets.chomp
		new_station = Station.new({'name' => operator_station})
		new_station.save
		puts "'#{new_station.name}' has been added."
		operator_station_menu
	elsif user_decision == 'x'
		operator_station_menu
	end
end

def list_stations
	puts "Current stations:"
	Station.all.each do |station|
		puts "#{station.id}. #{station.name}"
	end
	puts "Press 'l' to list all trains associated with a station."
	puts "Press 'x' to return to the previous menu."

	user_decision = gets.chomp

	if user_decision == 'l'
		puts "Enter the number of the station you'd like to list train lines for:"
		user_station = gets.chomp.to_i
		Train_line.station_train_line_list(user_station).each do |train_line|
			puts "#{train_line.id}. #{train_line.name}\n\n"
		end
	elsif user_decision == 'x'
	end
end

def operator_stop_menu
	puts "*** Operator Stop Menu ***"
	puts "Press 'a' to add a stop."
	puts "Press 'o' to return to the operator menu."
	puts "Press 'm' to return to the main menu."
	puts "Press 'x' to exit the program."

	user_decision = gets.chomp

	if user_decision == 'a'
		add_stop
	elsif user_decision == 'o'
		operator_menu
	elsif user_decision == 'm'
		main_menu
	elsif user_decision == 'x'
		puts "Thanks!  Have a great day!"
		exit
	else 
		puts "Invalid entry.  Please try again!"
	end
end

def add_stop
	puts "*** Add Stop Menu ***"
	puts "Press 'a' to add a stop."
	puts "Press 'x' to return to the stop menu."

	user_decision = gets.chomp
	if user_decision == 'a'
		puts "Current train lines:"
		puts "Current stations:"
		Station.all.each do |station|
			puts "#{station.id}. #{station.name}"
		end
		puts "Current stations:"
		puts "Current stations:"
		Station.all.each do |station|
			puts "#{station.id}. #{station.name}"
		end
		puts "To create a stop, enter the number of the train line:"
		train_line = gets.chomp.to_i
		puts "Then enter in the station you want to associate:"
		station = gets.chomp.to_i
		Train_line.stop(train_line, station)
		puts "'#{train_line}' now stops at '#{station}'."
		operator_stop_menu
	elsif user_decision == 'x'
		puts "Thanks!  Have a great day!"
		exit
	end
end

def rider_train_line_menu
	puts "*** Rider Train Line Menu ***"
	puts "Press 'l' to list all train lines."
	puts "Press 'r' to return to the rider menu."
	puts "Press 'm' to return to the main menu."
	puts "Press 'x' to exit the program."

	user_decision = gets.chomp

	if user_decision == 'l'
		list_train_lines
		puts "Press 'x' to return to train menu."
		user_decision = gets.chomp
		if user_decision == 'x'
			rider_train_line_menu
		end
	elsif user_decision == 'r'
		rider_menu
	elsif user_decision == 'm'
		main_menu
	elsif user_decision == 'x'
		puts "Thanks!  Have a great day!"
		exit
	else 
		puts "Invalid entry.  Please try again!"
	end
end

def rider_station_menu
	puts "*** Rider Station Menu ***"
	puts "Press 'l' to list all stations."
	puts "Press 'r' to return to the rider menu."
	puts "Press 'm' to return to the main menu."
	puts "Press 'x' to exit the program."

	user_decision = gets.chomp

	if user_decision == 'l'
		list_stations
		rider_station_menu
	elsif user_decision == 'r'
		rider_menu
	elsif user_decision == 'm'
		main_menu
	elsif user_decision == 'x'
		puts "Thanks!  Have a great day!"
		exit
	else 
		puts "Invalid entry.  Please try again!"
	end
end	

main_menu



