require 'fileutils'
require_relative '../textfile_path'

module Worker
  class Clean; end

  class Store
    def self.perform(job)
      path = TextfilePath.new(job.data['textfile'], job.data['library_root'])
      puts "Moving #{path.source} to library..." if ENV['VERBOSE']

      FileUtils.mkdir_p(path.dest_dirname)
      FileUtils.move(path.source, path.dest_filepath)

      if File.exist?(path.dest_filepath)
        puts "Moved to #{path.dest_filepath}" if ENV['VERBOSE']
        unless job.data['unchain']
          job.client.queues['clean'].put(Worker::Clean,
            'textfile' => path.dest_filepath)
        end
      else
        puts "Failed to move to #{path.dest_filepath}"
      end
    end
  end
end
