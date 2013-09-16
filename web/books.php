<?php
  include 'link.inc';

  $result = pg_exec($link, "SELECT COUNT(*) AS book_count FROM BOOKS LIMIT 100");
  $rcount = pg_fetch_assoc($result);

  $page = 1;
  $offset = 0;
  if ($_REQUEST['page'] != "") {
    $page = $_REQUEST['page'];
    $offset = ($page - 1) * 100;
  }

  $sortorder = "score_bom_4g DESC";
  if ($_REQUEST['sort'] == "id.a" || $_REQUEST['sort'] == "id") $sortorder = "id ASC";
  if ($_REQUEST['sort'] == "id.d") $sortorder = "id DESC";
  if ($_REQUEST['sort'] == "file.a" || $_REQUEST['sort'] == "file") $sortorder = "filename ASC";
  if ($_REQUEST['sort'] == "file.d") $sortorder = "filename DESC";
  if ($_REQUEST['sort'] == "wc.a") $sortorder = "wordcount ASC";
  if ($_REQUEST['sort'] == "wc.d") $sortorder = "wordcount DESC";
  if ($_REQUEST['sort'] == "score.a") $sortorder = "score_bom_4g ASC";
  if ($_REQUEST['sort'] == "score.d" || $_REQUEST['sort'] == "score") $sortorder = "score_bom_4g DESC";
  if ($_REQUEST['sort'] == "divscore.a") $sortorder = "(score_bom_4g/(wordcount+1)) ASC";
  if ($_REQUEST['sort'] == "divscore.d" || $_REQUEST['sort'] == "divscore") $sortorder = "(score_bom_4g/(wordcount+1)) DESC";
  if ($_REQUEST['sort'] == "nokjvscore.a") $sortorder = "score_bom_nokjv_4g ASC";
  if ($_REQUEST['sort'] == "nokjvscore.d" || $_REQUEST['sort'] == "nokjvscore") $sortorder = "score_bom_nokjv_4g DESC";
  if ($_REQUEST['sort'] == "divnokjvscore.a") $sortorder = "(score_bom_nokjv_4g/(wordcount+1)) ASC";
  if ($_REQUEST['sort'] == "divnokjvscore.d" || $_REQUEST['sort'] == "divnokjvscore") $sortorder = "(score_bom_nokjv_4g/(wordcount+1)) DESC";

  $result = pg_exec($link, "SELECT id, filename, wordcount, title, author, year, score_bom_4g AS score, score_bom_nokjv_4g AS nokjvscore FROM BOOKS ORDER BY $sortorder OFFSET $offset LIMIT 100");
  $numrows = pg_numrows($result);

  if (preg_match("/DESC$/", $sortorder)) $othersortdir = "a";
  else $othersortdir = "d";
?>

<style>
table.data tr:nth-child(even) { background-color: #eef; }
table.data tr:nth-child(odd) { background-color: #eee; }
table.data td { padding: 4px 5px; }
</style>

<p>Total Books in DB: <b><?= $rcount['book_count'] ?></b></p>
<p>
  <a href="books.php?sort=<?= $_REQUEST['sort'] ?>&page=<?= $page - 1 ?>">Prev Page</a>
  <a href="books.php?sort=<?= $_REQUEST['sort'] ?>&page=<?= $page + 1 ?>">Next Page</a>
  <a href="upload.php">Upload a New Book</a>
</p>
<table class="data">
<tr>
  <td><a href="books.php?sort=id.<?= $othersortdir ?>">Book ID:</a></td>
  <td><a href="books.php?sort=file.<?= $othersortdir ?>">File:</a></td>
  <td><a href="books.php?sort=wc.<?= $othersortdir ?>">Word Count:</a></td>
  <td><a href="books.php?sort=score">Score:</a></td>
  <td><a href="books.php?sort=divscore">Score/WC:</a></td>
  <td><a href="books.php?sort=nokjvscore">No KJV Score:</a></td>
  <td><a href="books.php?sort=divnokjvscore">No KJV Score/WC:</a></td>
</tr>
<?
  for($ri = 0; $ri < $numrows; $ri++) {
    $row = pg_fetch_assoc($result, $ri);
    $id = $row['id'];
    $filename = $row['filename'];
    $wc = number_format($row['wordcount']);
    $score = number_format($row['score'], 5);
    $divscore = number_format($row['score'] / $row['wordcount'], 5);
    $nokjvscore = number_format($row['nokjvscore'], 5);
    $divnokjvscore = number_format($row['nokjvscore'] / $row['wordcount'], 5);
    $url = "book.php?id=$id";
    $texturl = "book-text.php?id=$id";
    echo "<tr><td><a href='$url'>[Details] $id</a></td><td><a href='$texturl'>$filename</a></td><td align='right'>$wc</td><td align='right'>$score</td><td align='right'>$divscore</td><td>$nokjvscore</td><td>$divnokjvscore</td></tr>";
  }
?>
</table>

