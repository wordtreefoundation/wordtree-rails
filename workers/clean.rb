require_relative '../textfile_path'

module Worker
  class Ngram; end

  class Clean
    def initialize(input_path, output_path)
      @input_path, @output_path = input_path, output_path
    end

    def read_write
      File.open(@input_path) do |input|
        File.open(@output_path, 'w') do |output|
          clean_text(input, output)
        end
      end
    end

    def clean_text(input, output, remove_bible_verse_headings = true)
      join = nil
      words = []
      input.each_line do |line|
        if join
          line = join + line
          join = nil
        end
        line = line.encode('UTF-8', :invalid => :replace, :undef => :replace)
        if remove_bible_verse_headings
          line.gsub!(/\b[A-Z][a-z]{1,5}\d{1,3}:\d{1,3}\b/, '')
        end
        # Remove any non-alphabetical characters
        line.gsub!(/[^a-zA-Z\s\-]+/, '')

        if line =~ /\-+\s*$/
          join = line
          line.gsub!(/\-+\s*$/, '')
          next
        end
        next if line =~ /^[\s\-]*$/
        line.gsub!(/^[\s\-]+/, '')
        words += line.downcase.split(/[\s\-]+/)
        while words.size >= 8
          output.write words[0..8].join(" ") + "\n"
          words = words[9..-1] || []
        end
      end
      output.write words[0..8].join(" ") + "\n" if words.size > 0
    end

    def self.perform(job)
      path = TextfilePath.new(job.data['textfile'])
      dest = job.data['output'] || path.dest_clean

      puts "Cleaning #{path.source}..." if ENV['VERBOSE']
      Worker::Clean.new(path.source, dest).read_write
      unless job.data['unchain']
        job.client.queues['ngram'].put(Worker::Ngram, 'cleanfile' => dest)
      end
      puts "Done cleaning #{path.source}" if ENV['VERBOSE']
    end
  end
end