# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Settings.application_name = 'CompareTexts'

Settings.queue_host = '127.0.0.1'
Settings.queue_port = 6379

if Group.where(:name => "Public").empty?
  public_group = Group.create(name: "Public")
  Settings.public_group_id = public_group.id
end

if Group.where(:name => "Admin").empty?
  admin_group = Group.create(name: "Admin")
  Settings.admin_group_id = admin_group.id
end

if Shelf.where(:name => "Public").empty?
  public_shelf = Shelf.create(name: "Public2", group_id: Settings.public_group_id)
  Settings.public_shelf_id = public_shelf.id
end
