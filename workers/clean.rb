require_relative '../path'

module Worker
  class Clean
    def self.clean_text(input, output, remove_bible_verse_headings = true)
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
      path = job.data['path']
      puts "Cleaning #{path}..."
      File.open(path) do |input|
        File.open(path.sub(/\.txt$/, '.clean'), 'w') do |output|
          clean_text(input, output)
        end
      end
      puts "Done cleaning #{path}"
    end
  end
end