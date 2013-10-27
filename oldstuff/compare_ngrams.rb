require 'json'

DIR = File.dirname(__FILE__)

def book_path(id, *args)
  parts = [DIR, "library", id[0..1].downcase, id]
  parts += args
  File.join(*parts)
end

def book_ngram_file(id, n, suffix=nil, format=nil)
  suffix ||= 'grams'
  format ||= 'freq'
  book_path(id, id + ".#{format}.#{n}#{suffix}")
end

def baseline_ngram_file(n, suffix=nil, format=nil)
  suffix ||= 'grams'
  format ||= 'freq'
  File.join(DIR, "baseline", "baseline.#{format}.#{n}#{suffix}")
end

def load_json_ngrams(filename)
  return nil unless File.exist?(filename)
  JSON::load(File.read(filename))
end

def load_ngrams(filename)
  return nil unless File.exist?(filename)
  lookup = {}
  IO.popen("(zcat '#{filename}' 2>/dev/null) || cat '#{filename}'") do |file|
  # File.open(filename) do |file|
    file.each_line do |line|
      ngram, frequency = line.chomp.split(' ')
      lookup[ngram] = frequency.to_i unless ngram.include?('--') or ngram.include?('0')
    end
  end
  lookup
end

def load_book_ngrams(archive_org_id, n, grams=nil)
  grams ||= 'grams'
  puts "Loading #{n}#{grams} for #{archive_org_id}"
  load_ngrams(book_ngram_file(archive_org_id, n, grams))
end

def load_baseline_ngrams(n, grams=nil)
  grams ||= 'grams'
  load_json_ngrams(baseline_ngram_file(n, grams, 'json')) || 
    load_ngrams(baseline_ngram_file(n, grams, 'freq'))
end

def subtract_ngrams(ngrams, base, minus)
  if ngrams[minus]
    key = "#{base}-#{minus}"
    if not ngrams.has_key?(key)
      puts "Subtracting #{minus} from #{base}..."
      base_ngrams = ngrams[base]
      minus_ngrams = ngrams[minus] 
      ngrams[key] = base_ngrams.dup
      ngrams[key].delete_if { |k, v| minus_ngrams.include? k }
    end
    ngrams[key]
  else
    ngrams[base]
  end
end

def assure_ngrams(ngrams, row, col, n=4, grams='grams')
  return unless row[col]
  ngrams[row[col]] ||= load_book_ngrams(row[col], n, grams)
end

def add_ngrams(grams1, grams2)
  grams1.each_pair do |k, v|
    if grams1.has_key? k
      grams1[k] += v
    else
      grams1[k] = v
    end
  end
end

