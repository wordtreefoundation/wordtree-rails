<?php
  error_reporting(E_ALL ^ E_NOTICE);

  $book_id = (int)$_REQUEST['book_id'];
  $minus_id = (int)$_REQUEST['minus_id'];
  $compare_id = (int)$_REQUEST['compare_id'];

  //setup shell query
  $top = "python /research/ngrams/score.py";
  $cmd = "$top $book_id $minus_id $compare_id | " .
         "awk '{ printf \"<tr><td>%s</td><td>%s</td></tr>\\n\", $1, $2 }'"; 
  
?>

<html>
<head>
  <link rel="stylesheet" href="main.css" />
  <title>List of Matched Phrases (ngrams)</title>  
</head>
<body>

<b>Starting Comparison...</b>

<table class="data">
<tr>
  <th>Matched Phrase (ngram)</th>
  <th>Score</th>
</tr>
<?= shell_exec($cmd); ?>
</table>

</body>
