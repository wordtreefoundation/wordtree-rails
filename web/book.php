<?php
  include 'library_link.inc';

  $book_id = (int)$_REQUEST['id'];
  $result = pg_exec($link, "SELECT * FROM books WHERE id=$book_id");
  $row = pg_fetch_assoc($result);
?>

<style>
table.data tr:nth-child(even) { background-color: #eef; }
table.data tr:nth-child(odd) { background-color: #eee; }
table.data td { padding: 4px 5px; }
</style>

<table class="data">
<tr>
  <td>Book ID:</td>
  <td><? echo $row['id'] ?></td>
</tr>
<tr>
  <td>Title:</td>
  <td><? echo $row['title'] ?></td>
</tr>
<tr>
  <td>Year:</td>
  <td><? echo $row['year'] ?></td>
</tr>
<tr>
  <td>File:</td>
  <td><? echo $row['filename'] ?>
  <?
    if ($row['archive_org_id'] != "")
      echo "<br/><a href='http://archive.org/details/$row[archive_org_id]'>View @ Internet Archive</a>";
  ?>
</td>
</tr>
<tr>
  <td>Word Count:</td>
  <td><?= $row['wordcount'] ?></td>
</tr>
</table>

<p><a href="books.php">Return to Books List</a></p>
<br/>

