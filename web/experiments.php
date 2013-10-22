<?php
  include 'library_link.inc';

  $br = pg_exec($link, "SELECT COUNT(*) as ct FROM books");
  $book_count = pg_fetch_assoc($br)['ct'];

  $running = shell_exec("screen -ls");

  $result = pg_exec($link, 
"  
  SELECT e.id,
         e.name,
         e.abbrev,
         e.created_at,
         e.sample_size,
         e.n,
         SUM(CASE WHEN c.score IS NULL THEN 0 ELSE 1 END) AS comparison_count,
         COUNT(c.*) AS comparison_total
    FROM experiments e
    JOIN comparisons c ON c.experiment_id = e.id
GROUP BY e.id, e.name, e.abbrev, e.created_at, e.sample_size, e.n
ORDER BY e.created_at DESC;
");
  $numrows = pg_numrows($result);
?>
<html>
<head>
  <link rel="stylesheet" href="main.css" />
</head>
<body>

<p>Total Experiments: <b><?= number_format($numrows) ?></b></p>
<p>Total # of Books: <b><?= number_format($book_count) ?></b></p>
<p><a href="create_experiment.php">Create New Experiment</a> | <a href="books.php">List of Books</a></p>

<b>Space Used on Hard Drive (total, used, remaining, %used):</b>
<?= nl2br(shell_exec("df -h | grep research")); ?>
<p>
<?= nl2br($running) ?>

<table class="data">
<tr>
  <th>ID</th>
  <th>Abbrev</th>
  <th>Name</th>
  <th>Sample Size</th>
  <th>N</th>
  <th>Created</th>
  <th>Run</th>
</tr>
<?
  for($ri = 0; $ri < $numrows; $ri++) {
    $row = pg_fetch_assoc($result, $ri);
    $size = number_format($row['comparison_count']) . " / " . number_format($row['comparison_total']);

    echo "<tr><td>$row[id]</td><td>$row[abbrev]</td><td><a href='experiment.php?id=$row[id]&divide=1&filter_year=1829&power=1&wordcount=15000'>$row[name]</a></td><td>$size</td><td>$row[n]</td><td>$row[created_at]</td><td><a href='run_experiment.php?n=$row[n]&id=$row[id]'>Start</a> | <a href='stop_experiment.php?id=$row[id]'>Stop</a></tr>\n";
  }
?>
</table>

