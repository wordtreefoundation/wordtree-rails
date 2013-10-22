-- Load table
CREATE TABLE ngrams_load (
  n INTEGER,
  g1 TEXT,
  g2 TEXT,
  g3 TEXT,
  g4 TEXT,
  g5 TEXT,
  freq INTEGER,
  PRIMARY KEY (g1, g2, g3, g4, g5)
);

-- Load 1grams into ngrams_load table
pv 1grams.abbrev.freq | ./freq2tabcols | psql -c "\COPY ngrams_load (g1, g2, g3, g4, g5, freq) FROM pstdin" library

-- Set 'n' value based on NULLs in columns
UPDATE ngrams_load
SET n = CASE
          WHEN g1 = '-' THEN 0
          WHEN g2 = '-' THEN 1
          WHEN g3 = '-' THEN 2
          WHEN g4 = '-' THEN 3
          WHEN g5 = '-' THEN 4
          ELSE 5
        END;

-- Cull 1grams that are already in the ngrams table
DELETE FROM ngrams_load
USING ngrams
WHERE ngrams_load.g1 = ngrams.g1
  AND ngrams_load.g2 = ngrams.g2
  AND ngrams_load.g3 = ngrams.g3
  AND ngrams_load.g4 = ngrams.g4
  AND ngrams_load.g5 = ngrams.g5;

-- Transfer from ngrams_load to ngrams
INSERT INTO ngrams (n, g1, g2, g3, g4, g5)
SELECT n, g1, g2, g3, g4, g5 FROM ngrams_load;

-- Update the frequencies table for book 0 (all books)
INSERT INTO frequencies (book_id, ngram_id, freq)
SELECT 0, g.id, freq FROM ngrams_load t
INNER JOIN ngrams g
   ON g.g1 = t.g1
  AND g.g2 = t.g2
  AND g.g3 = t.g3
  AND g.g4 = t.g4
  AND g.g5 = t.g5;
