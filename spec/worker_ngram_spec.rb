require_relative 'spec_helper'
require 'workers/ngram'
require 'qless'

describe Worker::Ngram do
  let(:client) { Qless::Client.new }
  let(:job)    { Qless::Job.build(client, Worker::Ngram, :data => data) }

  context "messy document" do
    let(:data) { {
      "cleanfile" => fixture("messy.txt"),
      "n" => 3,
      "unchain" => true
    } }

    after do
      FileUtils.rm(fixture("messy.freq.1grams"))
      FileUtils.rm(fixture("messy.freq.2grams"))
      FileUtils.rm(fixture("messy.freq.3grams"))
    end

    it "slices into ngrams" do
      Worker::Ngram.perform(job)
      File.exist?(fixture("messy.freq.1grams")).should be_true
      File.exist?(fixture("messy.freq.2grams")).should be_true
      File.exist?(fixture("messy.freq.3grams")).should be_true
    end
  end
end