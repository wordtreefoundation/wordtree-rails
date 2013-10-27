require 'qless/worker'
require 'qless/tasks'
namespace :qless do
  task :setup do
    require_relative 'workers/store'
    require_relative 'workers/clean'
    require_relative 'workers/ngram'
    require_relative 'workers/trieify'

    ENV['REDIS_URL'] ||= 'redis://localhost:6379/0'
    ENV['QUEUES'] ||= 'store,clean,ngram,trieify'
    ENV['JOB_RESERVER'] ||= 'Ordered'
    ENV['INTERVAL'] ||= '5' # seconds
    ENV['VERBOSE'] ||= 'true'
  end
end