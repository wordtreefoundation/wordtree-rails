-- Load table
CREATE TABLE ngrams_load (gram TEXT[], freq INTEGER);

-- Load 1grams into ngrams_load table
pv 1grams.abbrev.freq | sed 's/-/,/g' | awk '{print "{" $1 "}" " " $2}' | fgrep -v ',,' | psql -c "\COPY ngrams_load (gram, freq) FROM pstdin DELIMITER ' '" library

-- Transfer from ngrams_load to ngrams
INSERT INTO ngrams (n, gram)
SELECT array_length(gram, 1), gram FROM ngrams_load;

-- Update the frequencies table for book 0 (all books)
INSERT INTO frequencies (book_id, ngram_id, freq)
SELECT 0, g.id, freq FROM ngrams_load t
INNER JOIN ngrams g ON g.n = array_length(t.gram, 1)
  AND g.gram = t.gram WHERE g.id IS NOT NULL;

