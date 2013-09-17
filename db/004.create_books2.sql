CREATE TABLE books (
  id SERIAL,
  filename TEXT,
  title TEXT,
  author TEXT,
  year INTEGER,
  wordcount INTEGER,
  created_at TIMESTAMP DEFAULT current_timestamp,
  archive_org_id TEXT,
  tags TEXT[]
);

CREATE UNIQUE INDEX books_unique_filenames
ON books (filename);

CREATE INDEX books_titles
ON books (title);

CREATE INDEX books_years
ON books (year);

CREATE UNIQUE INDEX books_archive_org_id
ON books (archive_org_id)
WHERE archive_org_id IS NOT NULL;


CREATE TABLE ngrams (
  id SERIAL,
  n INTEGER,
  gram TEXT[]
);

CREATE UNIQUE INDEX ngrams_ngrams
ON ngrams (n, gram);

CREATE RULE "ngrams_on_duplicate_ignore" AS ON INSERT TO "ngrams"
  WHERE EXISTS(SELECT 1 FROM ngrams WHERE (n, gram)=(NEW.n, NEW.gram))
  DO INSTEAD NOTHING;


CREATE TABLE frequencies (
  id SERIAL,
  ngram_id INTEGER,
  book_id INTEGER,
  freq INTEGER NOT NULL DEFAULT 1
);

CREATE INDEX frequencies_book_ids
ON frequencies (book_id);

CREATE UNIQUE INDEX frequencies_unique_ngrams_per_book
ON frequencies (book_id, ngram_id);


CREATE TABLE experiments (
  id SERIAL,
  name TEXT,
  abbrev TEXT,
  sample_size INTEGER,
  book_id INTEGER,
  minus_book_id INTEGER,
  created_at TIMESTAMP DEFAULT current_timestamp
);

CREATE INDEX experiments_book_ids
ON experiments (book_id);


CREATE TABLE comparisons (
  id SERIAL,
  experiment_id INTEGER,
  book_id INTEGER,
  score FLOAT
);

CREATE UNIQUE INDEX comparisons_unique_book_per_experiment
ON comparisons (experiment_id, book_id);

