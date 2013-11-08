require 'archivist'
require 'tempfile'

module Worker
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

      puts "Query archive.org for page #{params['page']} ..." if ENV['VERBOSE']

      @client = Archivist::Client.new
      books = @client.search(params)
      unless books.empty?
        # Start another job downloading the next page
        unless job.data['unchain']
          job.client.queues['transfer'].put(Worker::ArchiveOrgQuery,
            params.merge(:page => params['page'] + 1))
        end

        # Download all books from this page
        books.each do |book|
          file = Tempfile.new('book')
          file.write book.download
          job.client.queues['store'].put(Worker::Store,
            :textfile => file.path)
        end
      end

      puts "Done querying archive.org #{params['page']}" if ENV['VERBOSE']
    end
  end
end
