#!/usr/bin/env ruby
require_relative "pgconn"

DIR = File.dirname(__FILE__)

$conn.prepare("update_book", 
  "UPDATE books SET title=$1, year=$2, author=$3 " + 
  "WHERE archive_org_id=$4")

def update_book(archive_org_id, title, year, author)
  $conn.exec_prepared("update_book", [title, year, author, archive_org_id])
end

$stdin.each_line do |line|
  archive_org_id, title, year, author = line.chomp.split("\t")
  title.force_encoding("UTF-8") if title
  year.force_encoding("UTF-8") if year
  author.force_encoding("UTF-8") if author
  puts "Updating #{archive_org_id}"
  update_book(archive_org_id, title, year, author)
end
