module Remix

  def self.filter_google_watermark(input, output)
    google_header = false
    input.each_line do |line|
      google_header = true if line =~ %r{\bgoogle\b}i
      output.write line if not google_header
      google_header = false if line =~ %r{http. ?.. ?books ?\. ?google ?\. ?com}i
    end
  end

  def self.blank_variants(words)
    inside = words[1..-2]
    (0..(2**inside.size-1)).map do |i|
      seq = i.to_s(2).rjust(inside.size, '0').split('').
        each_with_index.map{ |b, j| b == '0' ? '_' : inside[j] }
      [words[0]] + seq + [words[-1]]
    end
  end

  # Given a cleaned up text file with just lowercase words,
  # produce ngrams (of size n) with or without blanks.
  def self.mkngrams(input, output, n, blanks = false)
    words = []
    input.each_line do |line|
      words += line.split(" ")
      while words.size >= n
        if blanks and n > 2
          blank_variants(words[0...n]).each do |seq|
            output.write seq.join(" ") + "\n"
          end
        else
          output.write words[0...n].join(" ") + "\n"
        end
        words.shift
      end
    end
  end

  # Take a messy text file and produce clean lowercase words
  # without punctuation. Joins words that end in '-' at the
  # end of the line. Removes numbers, quotes, etc.
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
end

