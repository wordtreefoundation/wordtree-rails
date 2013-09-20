require 'httparty'
require 'json'
require 'date'

def make_query_url(page = 1, per_page = 50)
  %{http://archive.org/advancedsearch.php?q=mediatype%3Atexts+AND+-mediatype%3Acollection+AND+date%3A[1835-01-02%20TO%201859-12-31]+AND+language%3A%28eng%29&fl[]=identifier&fl[]=title&fl[]=creator&fl[]=date&fl[]=language&fl[]=mediatype&sort[]=date+asc&rows=#{per_page}&page=#{page}&output=json}
end

page = 1
ao_list = File.open("ao_list3.csv", "w")

loop do
  puts "Page: #{page}"
  if got = HTTParty.get(make_query_url(page))
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
              # filename = props.first["name"]
              filename = nil
              puts "EPUB, skipping #{id}"
            else
              filename = nil
              puts "No formats: #{formats.keys.join(', ')}"
            end
            if filename
              csv_line = "#{id}\t#{title}\t#{year}\t#{creator}\t#{filename}"
              ao_list.puts csv_line
              puts csv_line
              if File.exist?(filename)
                puts "File already exists, skipping (#{filename})"
              else
                relpath = "#{id[0..1].downcase}/#{id}"
                `wget -nv "http://archive.org/download/#{id}/#{filename}"`
                `mkdir -p #{relpath}`
                `mv #{filename} #{relpath}/#{id}.txt`
              end
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
