# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
puts 'SETTING UP DEFAULT ROLES'
Role.create!(:name => 'admin')
Role.create!(:name => 'user')
Role.create!(:name => 'sponsor')
puts 'New roles created: admin, user, sponsor'

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'First User', :email => 'user@example.org', :username => 'user', :password => 'password', :password_confirmation => 'password', :agree => true
user.confirm!
puts 'New user created: ' << user.name

puts 'SETTING UP DEFAULT ADMIN LOGIN'
admin = User.create! :name => 'Admin User', :email => 'admin@example.org', :username => 'admin', :password => 'adminpassword', :password_confirmation => 'adminpassword', :agree => true
admin.confirm!
admin.make_admin
puts 'New admin created: ' << admin.name

#puts 'SETTING UP A COUPLE OF VIDEO ENTRIES'
#video = Video.create! :


#puts 'SETTING A FEW TAGS'

