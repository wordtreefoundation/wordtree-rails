CREATE TABLE books (
  id SERIAL PRIMARY KEY,
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


CREATE TABLE ngrams_load (
  ngram_id INTEGER,
  n INTEGER,
  g1 TEXT NOT NULL DEFAULT '-',
  g2 TEXT NOT NULL DEFAULT '-',
  g3 TEXT NOT NULL DEFAULT '-',
  g4 TEXT NOT NULL DEFAULT '-',
  g5 TEXT NOT NULL DEFAULT '-',
  freq INTEGER
);

CREATE INDEX ngrams_load_ngram_id ON ngrams_load (ngram_id);

CREATE INDEX ngrams_load_g1 ON ngrams_load (g1);
CREATE INDEX ngrams_load_g2 ON ngrams_load (g2);
CREATE INDEX ngrams_load_g3 ON ngrams_load (g3);
CREATE INDEX ngrams_load_g4 ON ngrams_load (g4);
CREATE INDEX ngrams_load_g5 ON ngrams_load (g5);


CREATE TABLE ngrams (
  id SERIAL PRIMARY KEY,
  n INTEGER,
  g1 TEXT NOT NULL DEFAULT '-',
  g2 TEXT NOT NULL DEFAULT '-',
  g3 TEXT NOT NULL DEFAULT '-',
  g4 TEXT NOT NULL DEFAULT '-',
  g5 TEXT NOT NULL DEFAULT '-'
);

CREATE INDEX ngrams_g1 ON ngrams (g1);
CREATE INDEX ngrams_g2 ON ngrams (g2);
CREATE INDEX ngrams_g3 ON ngrams (g3);
CREATE INDEX ngrams_g4 ON ngrams (g4);
CREATE INDEX ngrams_g5 ON ngrams (g5);

CREATE TABLE frequencies (
  id SERIAL PRIMARY KEY,
  ngram_id INTEGER,
  book_id INTEGER,
  freq INTEGER NOT NULL DEFAULT 1
);

CREATE INDEX frequencies_book_ids
ON frequencies (book_id);

CREATE UNIQUE INDEX frequencies_unique_ngrams_per_book
ON frequencies (book_id, ngram_id);


CREATE TABLE experiments (
  id SERIAL PRIMARY KEY,
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
  id SERIAL PRIMARY KEY,
  experiment_id INTEGER,
  book_id INTEGER,
  score FLOAT
);

CREATE UNIQUE INDEX comparisons_unique_book_per_experiment
ON comparisons (experiment_id, book_id);

