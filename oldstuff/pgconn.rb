require "pg"

$conn = PGconn.connect(
  :hostaddr => "127.0.0.1",
  :port => 5432,
  :dbname => "library",
  :user => "duane",
  :password => "duane313")

def to_value(v)
  begin
    Float(v)
    v.to_s
  rescue
    "'#{v.to_s.gsub("'", "''")}'"
  end
end

def select_one(*args)
  result = $conn.exec(*args)
  result.first if result
end

def upsert(table, keys=[], dict={})
  return if dict.empty?
  keyfields = keys.map{ |key| "#{key} = #{to_value(dict[key])}" }.join(", ")
  setfields = dict.map{ |c, v| "#{c} = #{to_value(v)}" }.join(", ")
  insertcols = dict.keys.join(", ")
  insertvals = dict.values.map{ |v| to_value(v) }.join(", ")

  $conn.exec(<<-SQL)
  UPDATE #{table} SET #{setfields} WHERE #{keyfields};
  INSERT INTO #{table} (#{insertcols})
         SELECT #{insertvals}
         WHERE NOT EXISTS (SELECT 1 FROM #{table} WHERE #{keyfields});
  SQL
end

def insert(table, dict={})
  insertcols = dict.keys.join(", ")
  insertvals = dict.values.map{ |v| to_value(v) }.join(", ")

  sql = "INSERT INTO #{table} (#{insertcols}) VALUES (#{insertvals}) RETURNING id"
  puts sql
  result = $conn.exec(sql)
  result.first['id'] if result and result.first
end

def get_book_id(archive_org_id)
  result = $conn.exec("SELECT id FROM books WHERE archive_org_id = $1", [archive_org_id]).first
  result['id'] if result
end

def get_book_archive_org_id(book_id)
  result = $conn.exec("SELECT archive_org_id FROM books WHERE id = $1", [book_id]).first
  result['archive_org_id'] if result
end

def get_experiment(experiment_id)
  result = $conn.exec("SELECT * FROM experiments WHERE id = $1", [experiment_id]).first
end
