CREATE TABLE chunks (
  id SERIAL PRIMARY KEY,
  book_id INTEGER,
  chunk_number INTEGER,
  wordcount INTEGER
);

CREATE TABLE chunk_similarities (
  id SERIAL PRIMARY KEY,
  experiment_id INTEGER,
  chunk_a_id INTEGER,
  chunk_b_id INTEGER,
  score FLOAT
);

CREATE UNIQUE INDEX chunk_similarities_unique
ON chunk_similarities (experiment_id, chunk_a_id, chunk_b_id);

CREATE INDEX chunk_experiment_id
ON chunk_similarities (experiment_id);

