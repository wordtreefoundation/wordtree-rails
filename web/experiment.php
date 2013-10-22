<?php
  include 'library_link.inc';
  $score_type = "";
  $filter_year = "";
  $experiment_id = (int)$_REQUEST['id'];

  if ($_REQUEST['filter_year'] != "") {
    $filter_year = (int)$_REQUEST['filter_year'];
    $filter_year_sql = "AND b1.year < $filter_year";
  }

  $result = pg_exec($link, 
"
   SELECT e.id, e.name, e.n,
          e.abbrev,
          e.created_at,
          e.book_id,
          e.minus_book_id AS minus_id,
          b1.archive_org_id,
          b1.title AS title,
          b1.year AS year,
          b2.archive_org_id AS minus_archive_org_id,
          b2.title AS minus_title,
          b2.year AS minus_year,
          coalesce(e.sample_size, (SELECT count(*) FROM books)) AS sample_size,
          (SELECT count(*) FROM comparisons WHERE score IS NOT NULL AND experiment_id = $experiment_id) AS sample_done
     FROM experiments e 
LEFT JOIN books b1 ON b1.id = e.book_id 
LEFT JOIN books b2 ON b2.id = e.minus_book_id
    WHERE e.id = $experiment_id
");
  $detail = pg_fetch_assoc($result);

  $power = 1.0;
  if ($_REQUEST['power'] != "")
    $power = (float)$_REQUEST['power'];

  $divisor = 1.0;
  $divide_score = "0";
  if (isset($_REQUEST['divide'])) {
	if ($_REQUEST['divide'] == "1") {
    		$divisor = "b1.wordcount";
    		$divide_score = "1";
  	}
  }

  $statsql = "
   SELECT STDDEV(POWSCORE(c.score, $divisor, $power)) AS stddev_score, 
          AVG(POWSCORE(c.score, $divisor, $power)) AS avg_score 
     FROM comparisons c 
     JOIN books b1 ON b1.id = c.book_id 
    WHERE c.experiment_id = $experiment_id 
      $filter_year_sql
      AND c.score IS NOT NULL 
 GROUP BY c.experiment_id;
";
  $statresult = pg_exec($link, $statsql);
  $stats = pg_fetch_assoc($statresult);
if (isset($_GET['wordcount'])) { $word_count="> ".$_GET['wordcount']; } else { $word_count="IS NOT NULL"; }
  $cresult = pg_exec($link,
"
   SELECT POWSCORE(c.score, $divisor, $power) AS score,
          b1.archive_org_id,
          b1.id AS compare_id,
          b1.title,
          b1.year,
          b1.wordcount
     FROM comparisons c
LEFT JOIN books b1 ON b1.id = c.book_id
    WHERE c.experiment_id = $experiment_id
      AND c.score IS NOT NULL
      AND b1.wordcount ".$word_count."
      $filter_year_sql
 ORDER BY POWSCORE(c.score, $divisor, $power) DESC
    LIMIT 500;
"); 
  $ccount = pg_numrows($cresult);

?>
<html>
<head>
  <link rel="stylesheet" href="main.css" />
</head>
<body>

<table class="data">
<tr>
  <th>Exp. ID</th>
    <td><?= $detail['id'] ?> <a href="chris.php?exp=<?= $detail['id'] ?>">See a scatter plot of this experiment</a></td>
</tr>
<tr>
  <th>Abbrev</th>
    <td><?= $detail['abbrev'] ?></td>
</tr>
<tr>
  <th>Name</th>
    <td><?= $detail['name'] ?></td>
</tr>
<tr>
  <th>Book</th>
    <td><?= $detail['title'] . " (" . $detail['archive_org_id'] . " - " . $detail['year'] . ")" ?></td>
</tr>
<tr>
  <th>(minus) Book</th>
    <td><?= $detail['minus_title'] . " (" . $detail['minus_archive_org_id'] . " - " . $detail['minus_year'] . ")" ?></td>
</tr>
<tr>
  <th>Sample Size</th>
    <td><?= number_format($detail['sample_done']) . " / " .
            number_format($detail['sample_size']) ?></td>
</tr>
<tr>
  <th>Mean Score</th>
    <td><?= number_format($stats['avg_score'], 2) ?></td>
</tr>
<tr>
  <th>StdDev Score</th>
    <td><?= number_format($stats['stddev_score'], 2) ?></td>
</tr>
<tr>
  <th>Created</th>
    <td><?= $detail['created_at'] ?></td>
</tr>
</table>

<p>
<? if ($divide_score == "0"): ?>
  <a href="experiment.php?id=<?= $_REQUEST['id'] ?>&divide=1&score_type=<?= $score_type ?>&score_type=<?= $score_type ?>&filter_year=<?= $filter_year ?>&power=<?= $power ?>">Divide All Scores by Wordcount</a>
<? else: ?>
  <a href="experiment.php?id=<?= $_REQUEST['id'] ?>&score_type=<?= $score_type ?>&score_type=<?= $score_type ?>&filter_year=<?= $filter_year ?>&power=<?= $power ?>">Don't Divide by Wordcount</a>
<? endif ?>
<? if ($filter_year == ""): ?>
  <a href="experiment.php?id=<?= $_REQUEST['id'] ?>&divide=<?= $divide_score ?>&filter_year=1829&power=<?= $power ?>">Filter by Year &lt; 1829</a>
<? else: ?>
  <a href="experiment.php?id=<?= $_REQUEST['id'] ?>&divide=<?= $divide_score ?>&power=<?= $power ?>">Don't Filter by Year</a>
<? endif ?>
<p>

<table class="data">
<tr>
  <th>Rank</th>
  <th>
<? if ($divide_score == "0") {
     echo "Score";
   } else {
     echo "Score / WC";
     if ($power != 1.0) echo " ^ $power"; 
   }
?>
  </th>
  <th>Wordcount</th>
  <th>Book Title</th>
  <th>archive.org ID</th>
  <th>Year</th>
</tr>
<?
  for($ri = 0; $ri < $ccount; $ri++) {
    $row = pg_fetch_assoc($cresult, $ri);
    echo "<tr><td>".($ri+1)."</td><td><a href='book-ngrams3.php?n=$detail[n]&book_id=$detail[book_id]&minus_id=$detail[minus_id]&compare_id=$row[compare_id]&f=gp'>$row[score]</a></td><td>$row[wordcount]</td><td>$row[title]</td><td><a href='http://archive.org/details/$row[archive_org_id]'>$row[archive_org_id]</a></td><td>$row[year]</td></tr>\n";
  }
?>
</table>
