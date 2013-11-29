require 'archivist'
# require 'tempfile'
require 'tmpdir'

module Worker
  class Store; end
  class ArchiveOrgQuery
    def self.get_params(params)
      {
        :page => params['page'] || 1,
        :rows => params['per_page'] || 50,
        :start_year => Integer(params['start_year']),
        :end_year => Integer(params['end_year'])
      }
    end

    def self.perform(job)
      begin
        params = get_params(job.data)
      rescue ArgumentError
        puts "Invalid params in archive.org query (#{job.data.inspect})"
        # Do nothing
        return
      end

      puts "Query archive.org for #{params.inspect} ..." if ENV['VERBOSE']

      @client = Archivist::Client.new
      books = @client.search(params)
      unless books.empty?
        # Start another job downloading the next page
        unless job.data['unchain']
          puts "Asking for next page (p. #{params[:page] + 1})..." if ENV['VERBOSE']
          job.client.queues['transfer'].put(Worker::ArchiveOrgQuery,
            params.merge(:page => params[:page] + 1))
        end

        # Download all books from this page
        dir = Dir.mktmpdir('archive_org')
        books.each do |book|
          puts "Downloading book #{book.identifier} to #{dir}" if ENV['VERBOSE']
          # file = Tempfile.new('book')
          File.join(dir, book.identifier + '.txt').tap do |textfile|
            File.open(textfile, 'w') do |file|
              file.write book.download
            end
            job.client.queues['store'].put(Worker::Store, :textfile => textfile)
          end
        end
      end

      puts "Done querying archive.org #{params[:page]}" if ENV['VERBOSE']
    end
  end
end
