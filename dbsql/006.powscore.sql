CREATE OR REPLACE FUNCTION POWSCORE(score float, wordcount integer DEFAULT 1, pw float DEFAULT 0.77) RETURNS float AS $$
BEGIN
  RETURN score * 
    (CASE WHEN wordcount = 1 THEN 1 ELSE 1000 END) / 
    POWER(CASE WHEN wordcount = 0 OR wordcount IS NULL THEN 1000000 ELSE wordcount END, pw);
END;
$$ LANGUAGE plpgsql;
