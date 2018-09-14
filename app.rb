require_relative 'crm'
require 'pry-nav'

ed = Contact.create("Ed", "Dude", "edthedude@gmail.com", "This is Ed, he's a dude.")
ted = Contact.create("Ted", "Fundy", "ted@gmail.com")
ned = Contact.create("Ned", "Stark", "winteriscoming@gmail.com", "This is ned, he is dead.")

control = CRM.new

control.main_menu

# puts ed.full_name
# puts ted.full_name
# puts ned.full_name

# puts ed.notes
# puts ted.notes
# puts ned.notes

# puts Contact.all

# puts Contact.find_by("notes", "N/A")

# ted.update("notes", "A new note, by Ted.")

# puts ted.notes

# binding.pry