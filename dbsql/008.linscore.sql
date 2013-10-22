CREATE OR REPLACE FUNCTION LINSCORE(Ax float, Ay float, Bx float, By float) RETURNS float AS $$
DECLARE
  k float := (Ax*Bx + Ay*By) / (Bx*Bx + By*By);
  Am float := CASE WHEN Ax IS NULL OR Ax = 0 THEN 1000000 ELSE Ay / Ax END;
  Bm float := CASE WHEN Bx IS NULL OR Bx = 0 THEN 1000000 ELSE By / Bx END;
  Cx float := Ax - k * Bx;
  Cy float := Ay - k * By;
BEGIN
  RETURN CASE WHEN Bm < Am THEN 0 ELSE Cx * Cx + Cy * Cy END;
END;
$$ LANGUAGE plpgsql;

