require 'spec_helper'
require 'workers/store'
require 'qless'

describe Worker::Store do
  let(:client) { Qless::Client.new }
  let(:job)    { Qless::Job.build(client, Worker::Store, :data => data) }
  let(:library_root) { tmp("library") }
  let(:textfile) { tmp("messy_copy.txt") }

  before do
    FileUtils.cp(fixture("messy.txt"), tmp("messy_copy.txt"))
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
      File.directory?(File.join(library_root, 'm', 'e', 'p', 'y'))
      fullpath = File.join(library_root, 'm', 'e', 'p', 'y', 'messy_copy.txt')
      File.exist?(fullpath).should be_true
    end
  end
end