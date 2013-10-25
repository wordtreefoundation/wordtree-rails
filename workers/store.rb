require 'fileutils'
require_relative '../path'

module Worker
  class Store
    def self.perform(job)
      path = Path.new(job.data['path'])
      puts "Moving #{path.source}..."

      FileUtils.mkdir_p(path.dest_dirname)
      FileUtils.move(path.source, path.dest_filepath)

      puts "Moved to #{dest_path}"
    end
  end
end
