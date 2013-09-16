InvalidWord = Class.new(ArgumentError)

def pair_index(str)
  raise "string has #{str.size} characters" if str.size != 2
  m = str[0].ord - 97
  raise InvalidWord, "#{str[0]}" if m < 0 or m > 25
  n = str[1].ord - 97
  raise InvalidWord, "#{str[1]}" if n < 0 or n > 25
  return (m * 26) + n
end

def word_parts(word, part_size = 2)
  word.split('').each_cons(part_size).map do |*parts|
    parts.join
  end
end

def data_for_word(word)
  raise ArgumentError, "word can't be nil" if word.nil?
  raise "word too large: #{word}" if word.size >= 40

  data = [0] * (26 * 26)
  word_parts(word, 2).each do |nchar|
    data[pair_index(nchar)] = 1
  end
  size_data = [0] * 40
  size_data[word.size-1] = 1

  data += size_data

  return data
end

