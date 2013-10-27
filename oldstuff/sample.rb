#!/usr/bin/env ruby

require_relative "pgconn"
require 'fileutils'

DIR = File.dirname(__FILE__)

def random_sample_rows(size, less_than_year=1830)
  $conn.exec(<<-SQL, [size, less_than_year])
   SELECT archive_org_id, year FROM books
   WHERE year IS NOT NULL 
     AND year < $2
     AND id IN
          (SELECT FLOOR(random() * (max_id - min_id + 1))::INTEGER
                  + min_id
             FROM GENERATE_SERIES(1,$1 * 3),
                  (SELECT max(id) as max_id,
                          min(id) as min_id
                     FROM books
                     WHERE year IS NOT NULL 
                       AND year < $2) s1
           LIMIT $1 * 3)
   ORDER BY random() 
   LIMIT $1;
  SQL
end

def random_sample(size, less_than_year=1830, suffix=".clean")
  files = random_sample_rows(size).map { |row| row['archive_org_id'] }.
    map{ |id| File.join(id[0..1].downcase, id, id + suffix) }
  files.each do |f|
    $stderr.puts f
  end
  FileUtils.chdir(File.join(DIR, 'library')) do
    files.select!{ |f| File.exist?(f) }
  end
  files
end 

if $0 == __FILE__
  size = Integer(ARGV[0])
  suffix = ARGV[1] || ".clean"
  puts random_sample(size, suffix).join("\n")
end
