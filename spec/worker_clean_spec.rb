require_relative 'spec_helper'
require 'workers/clean'
require 'qless'

describe Worker::Clean do
  let(:client) { Qless::Client.new }
  let(:job)    { Qless::Job.build(client, Worker::Clean, :data => data) }

  context "messy document" do
    let(:cleanfile) { fixture("messy.clean") }
    let(:data) { {
      "textfile" => fixture("messy.txt"),
      "output" => cleanfile,
      "unchain" => true
    } }

    after do
      FileUtils.rm(cleanfile)
    end

    it "can be cleaned" do
      Worker::Clean.perform(job)
      File.exist?(cleanfile).should be_true
      File.read(cleanfile)[0..102].should ==
        "eliakims address to his readers charitable and gentle reader\n" +
        "to thee the author of this book has little"
    end
  end
end