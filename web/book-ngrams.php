<?php
  include 'link.inc';

  $id = $_REQUEST['id'];
  $section = $_REQUEST['section'];
  $subset = $_REQUEST['subset'];
  $n = $_REQUEST['n'];

  $filesec = "";
  $filesub = ".int-bom";
  if ($subset == "nokjv") $filesub = ".int-bom.no-kjv";

  $result = pg_exec($link, "SELECT id, filename FROM books WHERE id=$id");
  $row = pg_fetch_assoc($result);

  $filename = $row['filename'];
  $bookprefix = preg_replace("/\.txt$/", "", $filename);
  $ngramfile = "$bookprefix.freq." . $n . "grams$filesec$filesub.triple";
  $filepath = "/research/ngrams/books/$bookprefix/$ngramfile";

  if (file_exists($filepath)) {
    echo "<table><tr><th>" . $n . "grams</th><th>All Books</th><th>BoM</th><th>This Book</th><th>(This*BoM)/All</th></tr>\n";
    echo nl2br(shell_exec("awk '{ printf \"%s %s %s %s %12f\\n\", $1, $2+$3, $3, $4, ($3 * $4 / ($2+$3)) }' $filepath | sort -k5,5nr | awk '{ printf \"<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%12f</td></tr>\", $1, $2, $3, $4, $5 }'"));
    echo "</table>";
  } else {
    echo "Could not find file $filepath";  
  }
?>
