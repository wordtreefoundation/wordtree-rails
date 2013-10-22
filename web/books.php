<?php
  include 'library_link.inc';

  $result = pg_exec($link, "SELECT COUNT(*) AS book_count FROM books");
  $rcount = pg_fetch_assoc($result);

  $page = 1;
  $offset = 0;
  if ($_REQUEST['page'] != "") {
    $page = $_REQUEST['page'];
    $offset = ($page - 1) * 100;
  }

  $sortorder = "title ASC";
  if ($_REQUEST['sort'] == "id.a" || $_REQUEST['sort'] == "id") $sortorder = "id ASC";
  if ($_REQUEST['sort'] == "id.d") $sortorder = "id DESC";
  if ($_REQUEST['sort'] == "file.a" || $_REQUEST['sort'] == "file") $sortorder = "filename ASC";
  if ($_REQUEST['sort'] == "file.d") $sortorder = "filename DESC";
  if ($_REQUEST['sort'] == "wc.a") $sortorder = "wordcount ASC";
  if ($_REQUEST['sort'] == "wc.d") {
    $sortorder = "wordcount DESC";
    $where = "WHERE wordcount IS NOT NULL";
  }

  $sql = "SELECT id, filename, wordcount, title, author, year FROM books $where ORDER BY $sortorder OFFSET $offset LIMIT 100";
  $result = pg_exec($link, $sql);
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
  | <a href="books.php?sort=<?= $_REQUEST['sort'] ?>&page=<?= $page + 1 ?>">Next Page</a>
  | <a href="upload.php">Upload a New Book</a>
  | <a href="experiments.php">List of Experiments</a>
</p>
<table class="data">
<tr>
  <th><a href="books.php?sort=id.<?= $othersortdir ?>">Book ID:</a></th>
  <th>Title:</th>
  <th>Year:</th>
  <th><a href="books.php?sort=file.<?= $othersortdir ?>">File:</a></th>
  <th><a href="books.php?sort=wc.<?= $othersortdir ?>">Word Count:</a></th>
</tr>
<?
  for($ri = 0; $ri < $numrows; $ri++) {
    $row = pg_fetch_assoc($result, $ri);
    $id = $row['id'];
    $filename = $row['filename'];
    $wc = number_format($row['wordcount']);
    $title = $row['title'];
    $year = $row['year'];
    $url = "book.php?id=$id";
    $texturl = "book-text.php?id=$id";
    echo "<tr><td>$id</td><td><a href='book.php?id=$id'>$title</a></td><td>$year</td><td>$filename</td><td align='right'>$wc</td></tr>\n";
  }
?>
</table>

