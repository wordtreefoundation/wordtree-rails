-- Ignoring the topmost 5%, get the next top 20%
-- and use the average of those books to calibrate
-- X and Y for our line
WITH
  high_scoring AS (
    SELECT c.score, b.wordcount
      FROM books b JOIN comparisons c ON b.id = c.book_id
     WHERE c.experiment_id = 36
       AND c.score IS NOT NULL
       AND b.year < 1829
    ORDER BY POWSCORE(c.score, b.wordcount, 1)
    DESC -- Sort TOP down
    LIMIT 27000   -- 20% of 135,000
    OFFSET 6750), -- 5% of 135,000
  base_line AS (
    SELECT AVG(score) AS base_x, AVG(wordcount) AS base_y
    FROM high_scoring)
SELECT base_x, base_y
FROM base_line;

-- Ignore bottom-most 5% and use next 20% for lower coord
WITH
  high_scoring AS (
    SELECT c.score, b.wordcount
      FROM books b JOIN comparisons c ON b.id = c.book_id
     WHERE c.experiment_id = 36
       AND c.score IS NOT NULL
       AND b.year < 1829
    ORDER BY POWSCORE(c.score, b.wordcount, 1)
    ASC -- Sort BOTTOM up
    LIMIT 27000   -- 20% of 135,000
    OFFSET 6750), -- 5% of 135,000
  base_line AS (
    SELECT AVG(score) AS base_x, AVG(wordcount) AS base_y
    FROM high_scoring)
SELECT base_x, base_y
FROM base_line;

-- Rank books using (x_bot, y_bot) and (x_top, y_top)
-- as the coordinates of the calibration line, and
-- LINSCORE to get the 2D orthogonal projection of
-- each book as a score
WITH
  coords AS (
    SELECT 1.7 AS x_bot, 64300 AS y_bot,
           25 AS x_top, 98618 AS y_top)
SELECT b.id, b.archive_org_id, c.score, b.wordcount,
       SQRT(LINSCORE(c.score-coords.x_bot, b.wordcount-coords.y_bot, coords.x_top, coords.y_top)) AS linscore
  FROM coords, books b JOIN comparisons c ON b.id = c.book_id
 WHERE c.experiment_id = 36
   AND LINSCORE(c.score-coords.x_bot, b.wordcount-coords.y_bot, coords.x_top, coords.y_top) IS NOT NULL
   AND b.year < 1829
ORDER BY LINSCORE(c.score-coords.x_bot, b.wordcount-coords.y_bot, coords.x_top, coords.y_top) DESC
LIMIT 20;

