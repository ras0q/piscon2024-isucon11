ALTER TABLE isu_condition
ADD COLUMN `condition_level` VARCHAR(10) GENERATED ALWAYS AS (
  CASE
    WHEN ((LENGTH(`condition`) - LENGTH(REPLACE(`condition`, '=true', ''))) / LENGTH('=true')) = 3 THEN 'critical'
    WHEN ((LENGTH(`condition`) - LENGTH(REPLACE(`condition`, '=true', ''))) / LENGTH('=true')) > 0 THEN 'warning'
    ELSE 'info'
  END
) VIRTUAL;
