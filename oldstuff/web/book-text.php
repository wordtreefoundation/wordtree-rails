<?php
  include 'link.inc';

  $result = pg_exec($link, "SELECT id, filename FROM books WHERE id=$_REQUEST[id]");
  $row = pg_fetch_assoc($result);

  $filename = $row['filename'];
  $filepath = "/research/ngrams/books/$filename";

  if (file_exists($filepath)) {
    echo nl2br(file_get_contents($filepath));
  } else {
    echo "Could not find file $filepath";  
  }
?>
