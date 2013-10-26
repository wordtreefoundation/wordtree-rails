require 'marisa'

module Worker
  class Trie
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

    def self.perform(job)
      path = job.data['freqfile']
      dest = job.data['output'] || path.sub('.freq.', '.trie.')

      puts "Trieifying #{path}..."
      Worker::Trie.new(path, dest).read_write
      unless job.data['unchain']
        # job.client.queues['ngram'].put(Worker::Ngram, 'cleanfile' => dest)
      end
      puts "Done trieifying #{path}"
    end
  end
end