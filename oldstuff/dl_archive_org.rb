require_relative 'pgconn'
require 'fileutils'
require 'httparty'
require 'json'
require 'date'

DIR = File.dirname(__FILE__)

def make_query_url(start_year, end_year, page = 1, per_page = 50)
  %{http://archive.org/advancedsearch.php?q=mediatype%3Atexts+AND+-mediatype%3Acollection+AND+date%3A[#{start_year}-01-01%20TO%20#{end_year}-12-31]+AND+(language%3A(eng)+OR+language%3A(English))&fl[]=identifier&fl[]=title&fl[]=creator&fl[]=date&fl[]=language&fl[]=mediatype&sort[]=date+asc&rows=#{per_page}&page=#{page}&output=json}
end

page = 1
ao_list = File.open("archive_org.1834-1850.csv", "w")

$start_year = ARGV[0]
$end_year = ARGV[1]

FileUtils.chdir(File.join(DIR, 'library')) do
  loop do
    puts "Page: #{page}"
    begin
      got = HTTParty.get(make_query_url($start_year, $end_year, page))
    rescue Timeout::Error => e
      puts "Timeout #{e}, skipping page"
      next
    end
    next unless got
    header = got["responseHeader"]
    if response = got["response"]
      found = response["numFound"]
      start = response["start"]
      break if start > found
      puts "Start: #{start} of #{found}"

      if docs = response["docs"]
        docs.each do |doc|
          begin
            # skip anything that we already have in the database
            if db_book_id = get_book_id(doc["identifier"])
              puts "Already in DB #{db_book_id}"
              next
            end

            id = doc["identifier"]
            title = doc["title"]
            creator = doc["creator"].respond_to?(:first) ? doc["creator"].first : nil
            begin
              year = Date.parse(doc["date"]).year
            rescue ArgumentError
            end
  
            xml = HTTParty.get("http://archive.org/download/#{id}/#{id}_files.xml")
            formats = xml.parsed_response["files"]["file"].group_by{ |f| f["format"] }
            if props = formats["DjVuTXT"]
              filename = props.first["name"]
              puts "Text"
            elsif props = formats["EPUB"]
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
                `mv #{filename} #{id[0..1]}/#{id}.txt`
              end
            end
          rescue Exception => e
            $stderr.puts "Exception: #{e}"
          end
        end
      end
    end
    page += 1
  end
end

ao_list.close
