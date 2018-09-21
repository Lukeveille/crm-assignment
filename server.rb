require "sinatra"
require_relative "crm"

get "/" do
  redirect to("/home")
end

get "/home" do
  @title = "Home"
  @list_size = Contact.count
  @all_contacts = Contact.all
  erb :home
end
