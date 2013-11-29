require 'spec_helper'
require 'workers/archive_org_query'
require 'qless'

describe Worker::ArchiveOrgQuery do
  let(:client) { Qless::Client.new }
  let(:job)    { Qless::Job.build(client, Worker::ArchiveOrgQuery, :data => data) }

  context "simple 2grams" do
    let(:data) { {
      "page" => 1,
      "per_page" => 10,
      "start_year" => 1500,
      "end_year" => 1520
    } }

    it "requests pages" do
      Worker::ArchiveOrgQuery.perform(job)
    end
  end
end