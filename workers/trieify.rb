require 'trie'
require 'fileutils'

module Worker
  class Trieify
    def initialize(input_path, output_path)
      @input_path, @output_path = input_path, output_path
      @trie = Trie.new
    end

    def populate_from_freqfile
      File.open(@input_path) do |file|
        file.each_line do |line|
          word, weight = line.split
          @trie.add(word, weight.to_i)
        end
      end
    end

    def remove_freqfile
      FileUtils.rm @input_path
    end

    def trieify
      populate_from_freqfile
      @trie.save(@output_path)
      remove_freqfile
    end

    def self.perform(job)
      path = job.data['freqfile']
      dest = job.data['output'] || path.sub('.freq.', '.trie.')

      puts "Trieifying #{path}..."
      Worker::Trieify.new(path, dest).trieify
      unless job.data['unchain']
        # job.client.queues['ngram'].put(Worker::Ngram, 'cleanfile' => dest)
      end
      puts "Done trieifying #{path}"
    end
  end
end