require_relative 'bayes'

$m = SnapshotMadeleine.new("bayes_data") do
  Classifier::Bayes.new('word', 'junk')
end

