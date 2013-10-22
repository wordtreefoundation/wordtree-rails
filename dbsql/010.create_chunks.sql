CREATE TABLE chunks (
  id SERIAL PRIMARY KEY,
  experiment_id INTEGER,
  source_book_id INTEGER,
  source_part_id INTEGER,
  compare_book_id INTEGER,
  compare_part_id INTEGER,
  score FLOAT
);

CREATE INDEX chunk_experiment_id
ON chunks (experiment_id);

CREATE INDEX chunk_source_book_id
ON chunks (source_book_id);
