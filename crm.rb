require_relative 'contact'

class CRM

  # Main loop, will run until user chooses 6
  def main_menu
    @quit = false
    loop do # repeat indefinitely
      print_main_menu
      user_selected = gets.to_i
      breakpoint
      call_option(user_selected)
      break if @quit == true
    end
  end

  # Prints the main menu selections
  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  # Will interpret the user input and move on to the selected method
  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then
      query = search_by_attribute
      if query != nil
        puts "#{query.id} : #{query.full_name} - #{query.email} - #{query.note}"
        breakpoint
      end
    when 6 then @quit = true
    end
  end

  # Adds a new contact, will prompt
  def add_new_contact
    print 'Enter First Name: '
    first_name = gets.chomp
    breakpoint
    print 'Enter Last Name: '
    last_name = gets.chomp
    breakpoint
    print 'Enter Email Address: '
    email = gets.chomp
    breakpoint
    Contact.create(first_name, last_name, email)
  end

  def modify_existing_contact
    selected_contact = self.search_by_attribute

    if selected_contact != nil
      puts "What would you like to modify?: "
      attribute = make_selection(false)
      value = gets.chomp.to_s
      selected_contact.update(attribute, value)
      breakpoint
    end
  end

  def delete_contact
    selected_contact = self.search_by_attribute
    print "Are you sure you want to delete #{selected_contact.full_name}? (y to continue)"
    delete_now = gets.chomp.upcase
    if delete_now == 'Y'
      selected_contact.delete
    end
  end

  def display_all_contacts
    Contact.all.each do |contact|
      puts "#{contact.id} : #{contact.full_name} - #{contact.email} - #{contact.note}"
    end
    breakpoint
  end

  # Searches for a specific contact using an attribute and a value
  def search_by_attribute

    puts "Find user by: "
    
    attribute = make_selection(true)
    value = gets.chomp.upcase

    contact_to_modify = Contact.find_by(attribute, value)

    breakpoint
    if contact_to_modify != nil
      return contact_to_modify
    else
      puts "There is no user with that #{attribute.gsub("_", " ")}!"
      breakpoint
    end
  end

  def make_selection(id)
    puts '[1] First Name'
    puts '[2] Last Name'
    puts '[3] E-mail'
    puts '[4] Notes'
    if id
      puts '[5] ID'
    end
    
    choose = 0

    loop do
      choose = gets.chomp.to_i
      breakpoint
      if id
        break if choose >= 1 && choose < 6
      else
        break if choose >= 1 && choose < 5
      end
      puts "Invalid selection!"
    end

    case choose
    when 1 then
      puts 'Enter a first name:'
      return "first_name"
    when 2 then
      puts 'Enter a last name:'
      return "last_name"
    when 3 then
      puts 'Enter an e-mail address:'
      return "email"
    when 4 then
      puts 'Enter a note:'
      return "note"
    when 5 then
      if id
        puts 'Enter an ID #:'
        return "id"
      else
        return nil
      end
    else
      return nil
    end
  end

  def breakpoint
    puts "\n-------------------\n\n"
  end

end
