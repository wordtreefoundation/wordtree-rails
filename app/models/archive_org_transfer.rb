require 'faraday'
require 'qless'
require 'workers/archive_org_query'

class ArchiveOrgTransfer < ActiveRecord::Base
  belongs_to :user
  belongs_to :shelf

  def initiate
    save!
    qless_opts = { :host => Settings.queue_host, :port => Settings.queue_port }
    client = Qless::Client.new(qless_opts)
    client.queues['transfer'].put(Worker::ArchiveOrgQuery,
      :start_year => start_year,
      :end_year => end_year,
      :page => 1
    )
  end
end
