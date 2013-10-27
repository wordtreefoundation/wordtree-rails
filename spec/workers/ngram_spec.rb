require 'spec_helper'
require 'workers/ngram'
require 'qless'

describe Worker::Ngram do
  let(:client) { Qless::Client.new }
  let(:job)    { Qless::Job.build(client, Worker::Ngram, :data => data) }

  context "messy document" do
    let(:data) { {
      "cleanfile" => tmp("messy.txt"),
      "n" => 3,
      "unchain" => true
    } }

    before do
      FileUtils.cp(fixture("messy.txt"), tmp("messy.txt"))
    end

    after do
      FileUtils.rm(tmp("messy.freq.1grams"))
      FileUtils.rm(tmp("messy.freq.2grams"))
      FileUtils.rm(tmp("messy.freq.3grams"))
    end

    it "slices into ngrams" do
      Worker::Ngram.perform(job)
      File.exist?(tmp("messy.freq.1grams")).should be_true
      File.exist?(tmp("messy.freq.2grams")).should be_true
      File.exist?(tmp("messy.freq.3grams")).should be_true
      File.exist?(tmp("messy.freq.4grams")).should_not be_true
    end
  end
end