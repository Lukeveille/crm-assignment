require_relative "contact"

class CRM

  # Main loop, will run until user chooses 6.
  def main_menu
    breakpoint
    loop do # repeat indefinitely
      print_main_menu
      user_selected = gets.to_i
      breakpoint
      call_option(user_selected)
    end
  end

  # Prints the main menu selections.
  def print_main_menu
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all the contacts"
    puts "[5] Search by attribute"
    puts "[6] Exit"
    print "\nEnter a number: "
  end

  # Will interpret the user input and move on to the selected method.
  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5
      query = search_by_attribute
      if query != nil
        print_entry(query)
        breakline
      end
    when 6 then exit!
    end
  end

  # Adds a new contact, will prompt for first name, last name, and e-mail.
  def add_new_contact
    print "Enter First Name: "
    first_name = gets.chomp
    breakline

    print "Enter Last Name: "
    last_name = gets.chomp
    breakline

    print "Enter Email Address: "
    email = gets.chomp
    breakline

    puts "Enter a note: "
    note = gets.chomp
    if note == ""
      note = "N/A"
    end
    breakpoint

    query = Contact.create(first_name, last_name, email, note)

    print_entry(query)
    breakline
  end

  # Modify a contact that is already in list.
  def modify_existing_contact
    selected_contact = self.search_by_attribute

    if selected_contact != nil
      print_entry(selected_contact)
      breakline
      puts "What would you like to modify?: "
      attribute = make_selection(false)
      value = gets.chomp.to_s
      if value != ""
        selected_contact.update(attribute, value)
      end
      breakpoint
      print_entry(selected_contact)
      breakline
    end
  end

  # Delete a specific contact
  def delete_contact
    selected_contact = self.search_by_attribute
    if selected_contact != nil
      print "Are you sure you want to delete #{selected_contact.full_name}? (y to continue) "
      delete_now = gets.chomp.upcase
      if delete_now == "Y"
        selected_contact.delete
      end
      breakpoint
    end
  end

  # Prints a list of every contact to the screen.
  def display_all_contacts
    Contact.all.each do |contact|
      print_entry(contact)
    end
    breakline
  end

  # Searches for a specific contact, prompting the user for an attribute and a value.
  def search_by_attribute
    display_all_contacts

    puts "Select user by: "

    attribute = make_selection(true)
    value = gets.chomp.upcase

    contact_to_modify = Contact.find_by(attribute, value)

    breakpoint
    if contact_to_modify != nil
      return contact_to_modify
    else
      puts "There is no user with that #{attribute.gsub("_", " ")}!"
      breakline
    end
  end

  # Chooses which attribute will be accessed. Will only show "[5] ID" for reading, not writing.
  def make_selection(id)
    choose = 0

    loop do
      puts "[1] First Name"
      puts "[2] Last Name"
      puts "[3] E-mail"
      puts "[4] Notes"
      if id
        puts "[5] ID"
      end
      print "\nEnter a number: "

      choose = gets.chomp.to_i
      if id
        breakpoint
        break if choose >= 1 && choose < 6
        display_all_contacts
        puts "Invalid selection!"
        puts "Select user by: "
      else
        breakpoint
        break if choose >= 1 && choose < 5
      end
    end

    if id
      breakpoint
      display_all_contacts
    end

    case choose
    when 1
      print "Enter a first name: "
      return "first_name"
    when 2
      print "Enter a last name: "
      return "last_name"
    when 3
      print "Enter an e-mail address: "
      return "email"
    when 4
      puts "Enter a note:"
      return "note"
    when 5
      if id
        print "Enter an ID #: "
        return "id"
      else
        return nil
      end
    else
      return nil
    end
  end

  # Prints all relevant contact attributes in a standard format
  def print_entry(contact)
    puts "#{contact.id} : #{contact.full_name} - #{contact.email} - #{contact.note}"
  end

  # Prints blank screen or break line, to help readability.
  def breakpoint
    puts "\e[H\e[2J"
  end

  def breakline
    puts "\n-------------------\n\n"
  end
end

at_exit do
  ActiveRecord::Base.connection.close
end
