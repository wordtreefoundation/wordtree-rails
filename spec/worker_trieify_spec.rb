require_relative 'spec_helper'
require 'workers/trieify'
require 'qless'

describe Worker::Trieify do
  let(:client) { Qless::Client.new }
  let(:job)    { Qless::Job.build(client, Worker::Trieify, :data => data) }

  context "simple 2grams" do
    let(:data) { {
      "freqfile" => fixture("simple.freq.2grams"),
      "output" => tmp("simple.trie.2grams"),
      "unchain" => true
    } }

    after do
      FileUtils.rm(tmp("simple.trie.2grams.da"))
      FileUtils.rm(tmp("simple.trie.2grams.tail"))
    end

    it "slices into ngrams" do
      Worker::Trieify.perform(job)
      File.exist?(tmp("simple.trie.2grams.da")).should be_true
      File.exist?(tmp("simple.trie.2grams.tail")).should be_true
    end
  end
end