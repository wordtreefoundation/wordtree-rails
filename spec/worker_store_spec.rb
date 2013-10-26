require_relative 'spec_helper'
require 'workers/store'
require 'qless'

describe Worker::Store do
  let(:client) { Qless::Client.new }
  let(:job)    { Qless::Job.build(client, Worker::Store, :data => data) }
  let(:library_root) { fixture("library") }
  let(:textfile) { fixture("messy_copy.txt") }

  before do
    FileUtils.cp(fixture("messy.txt"), fixture("messy_copy.txt"))
  end

  context "messy document" do
    let(:data) { {
      "textfile" => textfile,
      "library_root" => library_root,
      "unchain" => true
    } }

    after do
      FileUtils.rm_rf(library_root)
    end

    it "can be cleaned" do
      Worker::Store.perform(job)
      File.directory?(File.join(library_root, 'm', 'e', 's'))
      File.exist?(File.join(library_root, 'm', 'e', 's', 'messy_copy.txt')).should be_true
    end
  end
end