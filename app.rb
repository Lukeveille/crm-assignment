require_relative "crm"
require "pry-nav"

# ed = Contact.create(
#   first_name: "Ed",
#   last_name: "Dude",
#   email: "edthedude@gmail.com",
#   note: "This is Ed, he's a dude.",
# )
# ted = Contact.create(
#   first_name: "Ted",
#   last_name: "Fundy",
#   email: "ted@gmail.com",
#   note: "",
# )
# ned = Contact.create(
#   first_name: "Ned",
#   last_name: "Stark",
#   email: "winteriscoming@gmail.com",
#   note: "This is ned, he is dead.",
# )

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
