module Worker
  class Ngram
    def initialize(cleanfile, n)
      @cleanfile = cleanfile
      @n = n
      @ngrams_exec = File.join(File.dirname(__FILE__), '..', 'ngrams-cpp', 'ngrams')
    end

    def slice
      prefix = @cleanfile.sub(/\.clean$/, '')
      split_dashes = %[awk '/---/{n++}{print > f "." n "grams"}' f="#{prefix}"]
      `#{@ngrams_exec} --n=#{@n} --in=#{@cleanfile} | #{split_dashes}`
    end

    def self.perform(job)
      cleanfile = job.data['cleanfile']
      n = job.data['n'] || 4
      puts "Slicing #{cleanfile} into 1..#{n}grams..."
      Worker::Ngram.new(cleanfile, n)
      unless job.data['unchain']
        # job.client.queues['treify'].put(Worker::Treify)
      end
      puts "Done slicing #{cleanfile}"
    end
  end
end