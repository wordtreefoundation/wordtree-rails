-- Make a rule that ignores ngrams whose constituent parts have no registered 1gram
CREATE RULE "ngrams_on_rare_ignore" AS ON INSERT TO "ngrams"
  WHERE NOT EXISTS(SELECT 1 FROM ngrams WHERE n = 1 AND NEW.gram @> gram)
  DO INSTEAD NOTHING;

