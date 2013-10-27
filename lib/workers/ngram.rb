module Worker
  class Trieify; end

  class Ngram
    NGRAMS_CPP = File.join(File.dirname(__FILE__), '..', '..', 'ngrams-cpp', 'ngrams')
    def initialize(cleanfile, n)
      @cleanfile = cleanfile
      @n = n
    end

    def freqfiles
      (1..@n).map do |n|
        freqfile = @cleanfile.sub(/\.(clean|txt)$/, '.freq') + ".#{n}grams"
      end
    end

    def slice
      prefix = @cleanfile.sub(/\.(clean|txt)$/, '.freq')
      split_dashes = %[awk '/---/{n++}{print > f "." n "grams"}' f="#{prefix}"]
      cmd = "#{NGRAMS_CPP} --n=#{@n} --in=#{@cleanfile} | #{split_dashes}"
      result = `#{cmd}`
      puts result unless result.empty?
      freqfiles
    end

    def self.perform(job)
      cleanfile = job.data['cleanfile']
      n = job.data['n'] || 5
      puts "Slicing #{cleanfile} into 1..#{n}grams..." if ENV['VERBOSE']
      freqfiles = Worker::Ngram.new(cleanfile, n).slice
      unless job.data['unchain']
        dir = File.dirname(cleanfile)
        freqfiles.each do |freqfile|
          job.client.queues['trieify'].put(Worker::Trieify,
            :freqfile => freqfile)
        end
      end
      puts "Done slicing #{cleanfile}" if ENV['VERBOSE']
    end
  end
end