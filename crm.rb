require_relative './rolodex.rb'
require_relative './contact.rb'

class CRM

	attr_accessor :name

	def initialize(name)
		@name = name #instance variable
		@rolodex = Rolodex.new
	end

	def print_main_menu
		puts "[1] Add a contact"
		puts "[2] Modify a contact"
		puts "[3] Display one contact"
		puts "[4] Display all contacts"
		puts "[5] Display an attribute"
		puts "[6] Delete a contact"
		puts "[7] Exit"
	end

	def main_menu
		puts "Welcome to #{@name}"
		
		while true
			print_main_menu
			input = gets.chomp.to_i
			chose_option(input)
			return if input == 7
		end
	end

	def chose_option(option)
		case option
		when 1 then add_contact
		when 2 then modify_contact
		when 3 then display_contact
		when 4 then display_contacts
		when 5 then display_attribute
		when 6 then delete_contact
		when 7
			puts "Goodbye!"
			return
		else puts "Incorrect option, try again."
		end
	end

	def add_contact
		puts "Provide Contact Details"

		print "First Name:"
		first_name = gets.chomp

		print "Last Name:"
		last_name = gets.chomp
		
		print "Email:"
		email = gets.chomp

		print "Note:"
		note = gets.chomp

		new_contact = Contact.new(first_name, last_name, email, note)
		@rolodex.add_contact(new_contact)
	end

	def modify_contact
		puts "Enter the ID of the contact you would like to modify."
		id = gets.chomp.to_i
		contact = @rolodex.display_particular_contact(id)
		puts "#{contact.id}, #{contact.first_name}, #{contact.last_name}, #{contact.email}, #{contact.note}"
	
		puts "Are you sure you want to modify the above contact?\nYES/NO:"
		if gets.chomp.to_s.upcase == "YES"
			puts "[1] Change the first name"
			puts "[2] Change the last name"
			puts "[3] Change the email"
			puts "[4] Change the notes"
			
			num = gets.chomp.to_i
			
			puts "Enter a new value for your attribute."
			new_value = gets.chomp.to_s
			
			contact = @rolodex.modify_contact(id, num, new_value)
			puts "The contact is now #{contact.id}, #{contact.first_name}, #{contact.last_name}, #{contact.email}, #{contact.note}"
		else puts "Move on"
		end
	end

	def display_contacts	
		contacts = @rolodex.display_all_contacts
		contacts.each { |contact| puts "#{contact.id}, #{contact.first_name}, #{contact.last_name}, #{contact.email}, #{contact.note}"}
	end

	def display_contact
		puts "Enter the ID of the contact you would like to display."
		id = gets.chomp.to_i
		contact = @rolodex.display_particular_contact(id)
		puts "The contact you chose to display is"
		puts "#{contact.id}, #{contact.first_name}, #{contact.last_name}, #{contact.email}, #{contact.note}"
	end

	def display_attribute
		puts "Enter the ID of the contact you would like to display an attribute for."
		id = gets.chomp.to_i
		
		puts "[1] Display the first name"
		puts "[2] Display the last name"
		puts "[3] Display the email"
		puts "[4] Display the notes"
		
		num = gets.chomp.to_i

		attr = @rolodex.display_info_by_attribute(id, num)
		puts "The attribute you asked for is #{attr}"
	end

	def delete_contact
		puts "Enter the ID of the contact you would like to delete."
		id = gets.chomp.to_i
		@rolodex.delete_contact(id)
		puts "The contact with the ID #{id} has been deleted."
	end
end

bitmaker = CRM.new("Bitmaker Labs CRM")
bitmaker.main_menu

puts bitmaker.name