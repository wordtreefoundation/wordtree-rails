require 'qless/worker'
require 'qless/tasks'

namespace :qless do
  task :setup do
    require 'workers/store'
    require 'workers/clean'
    require 'workers/ngram'
    require 'workers/trieify'

    ENV['REDIS_URL'] ||= 'redis://localhost:6379/0'
    ENV['QUEUES'] ||= 'store,clean,ngram,trieify'
    ENV['JOB_RESERVER'] ||= 'Ordered'
    ENV['INTERVAL'] ||= '2' # seconds
    ENV['VERBOSE'] ||= 'true'
  end
end