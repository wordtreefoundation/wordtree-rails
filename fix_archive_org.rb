require 'httparty'
require 'json'
require 'date'

start_year = ARGV[0]
end_year = ARGV[1]

def make_query_url(start_year, end_year, page = 1, per_page = 50)
  %{http://archive.org/advancedsearch.php?q=mediatype%3Atexts+AND+-mediatype%3Acollection+AND+date%3A[#{start_year}-01-02%20TO%20#{end_year}-12-31]+AND+language%3A%28eng%29&fl[]=identifier&fl[]=title&fl[]=creator&fl[]=date&fl[]=language&fl[]=mediatype&sort[]=date+asc&rows=#{per_page}&page=#{page}&output=json}
end

page = 1
ao_list = File.open("ao_list_fix#{start_year}-#{end_year}.csv", "w")

loop do
  puts "Page: #{page}"
  if got = HTTParty.get(make_query_url(start_year, end_year, page))
    header = got["responseHeader"]
    if response = got["response"]
      found = response["numFound"]
      start = response["start"]
      break if start > found
      puts "Start: #{start} of #{found}"

      if docs = response["docs"]
        docs.each do |doc|
          begin
            begin
              year = Date.parse(doc["date"]).year
            rescue ArgumentError
            end
            id = doc["identifier"]
            title = doc["title"]
            creator = doc["creator"].respond_to?(:first) ? doc["creator"].first : nil
  
            xml = HTTParty.get("http://archive.org/download/#{id}/#{id}_files.xml")
            formats = xml.parsed_response["files"]["file"].group_by{ |f| f["format"] }
            if props = formats["DjVuTXT"]
              filename = props.first["name"]
              puts "Text"
            elsif props = formats["EPUB"]
              filename = props.first["name"]
              puts "EPUB"
            else
              filename = nil
              puts "No formats: #{formats.keys.join(', ')}"
            end
            if filename
              csv_line = "#{id}\t#{title}\t#{year}\t#{creator}\t#{filename}"
              ao_list.puts csv_line
              puts csv_line
            else
              puts "NOT FOUND: #{id}\t#{title}\t#{year}\t#{creator}"
            end
          rescue Exception => e
            $stderr.puts "Exception: #{e}"
          end
        end
      end
    end
  end
  page += 1
end

ao_list.close