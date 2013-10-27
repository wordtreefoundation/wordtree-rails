# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Settings.application_name = 'CompareTexts'

public_group = Group.create(name: "Public")

Settings.public_group_id = public_group.id

public_shelf = Shelf.create(name: "Public", group: public_group)

Settings.public_shelf_id = public_shelf.id
