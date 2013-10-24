require 'qless/tasks'
namespace :qless do
  task :setup do
    ENV['REDIS_URL'] ||= 'redis://localhost:6379/0'
    ENV['QUEUES'] ||= 'clean,ngram,compare'
    ENV['JOB_RESERVER'] ||= 'Ordered'
    ENV['INTERVAL'] ||= '5' # seconds
    ENV['VERBOSE'] ||= 'true'
  end
end