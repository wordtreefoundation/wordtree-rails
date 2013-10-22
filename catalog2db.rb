#!/usr/bin/env ruby
require_relative "pgconn"

DIR = File.dirname(__FILE__)

$conn.prepare("update_book", 
  "UPDATE books SET title=$1, year=$2, author=$3 " + 
  "WHERE archive_org_id=$4")
$conn.prepare("upsert_book1", "UPDATE books SET title=$1, year=$2, author=$3 WHERE archive_org_id=$4")
$conn.prepare("upsert_book2",
"
INSERT INTO books (title, year, author, archive_org_id)
       SELECT $1, $2, $3, $4
       WHERE NOT EXISTS (SELECT 1 FROM books WHERE archive_org_id=$4)
")

def update_book(archive_org_id, title, year, author)
  $conn.exec_prepared("update_book", [title, year, author, archive_org_id])
end

def upsert_book(archive_org_id, title, year, author)
  $conn.exec_prepared("upsert_book1", [title, year, author, archive_org_id])
  $conn.exec_prepared("upsert_book2", [title, year, author, archive_org_id])
end

$stdin.each_line do |line|
  archive_org_id, title, year, author = line.chomp.split("\t")
  title.force_encoding("UTF-8") if title
  year.force_encoding("UTF-8") if year
  author.force_encoding("UTF-8") if author
  puts "Updating #{archive_org_id}"
  upsert_book(archive_org_id, title, year, author)
end
