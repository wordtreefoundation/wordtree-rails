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

