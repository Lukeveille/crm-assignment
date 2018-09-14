class Contact
  # Class variables
  @@list = []
  @@next_id = 1

  # This method should initialize the contact's attributes
  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end

  # This method should call the initializer, 
  # store the newly created contact, and then return it
  def self.create(first_name, last_name, email, note = "N/A")
    new_contact = self.new(first_name, last_name, email, note)
    new_contact.save
    return new_contact
  end

  # This method should return all of the existing contacts
  def self.all
    return @@list
  end

  # This method should accept an id as an argument
  # and return the contact who has that id
  def self.find(id)
    @@list.each do |contact|
      if contact.id == id
        return contact
      end
    end
  end

  # This method should work similarly to the find method above
  # but it should allow you to search for a contact using attributes other than id
  # by specifying both the name of the attribute and the value
  # eg. searching for 'first_name', 'Betty' should return the first contact named Betty
  def self.find_by(attribute, value)
    @@list.each do |contact|
      if contact.send(attribute).to_s.upcase == value.to_s
        return contact
      end
    end
    return nil
  end

  # This method should delete all of the contacts
  def self.delete_all
    print 'Are you sure you want to delete ALL contacts? (y to continue)'
    delete_now = gets.chomp.upcase
    if delete_now == 'Y'
      @@list = []
    end
  end

  # This method should allow you to specify 
  # 1. which of the contact's attributes you want to update
  # 2. the new value for that attribute
  # and then make the appropriate change to the contact
  def update(attribute, value)
    self.send("#{attribute}=", value)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def save
    @id = @@next_id
    @@list << self
    @@next_id += 1
  end

  # This method should delete the contact
  # HINT: Check the Array class docs for built-in methods that might be useful here
  def delete
    @@list.delete(self)
  end

  # Feel free to add other methods here, if you need them.
  attr_accessor :first_name, :last_name, :email, :note, :id
end