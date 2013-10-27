<?php

  $files_count = shell_exec("ls -1 /research/ngrams/library/ | wc -l");
  $tail_dl = shell_exec("tail /research/ngrams/library/ao_list2.csv | awk -F '\t' '{ printf \"<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>\", $1, $3, $2, $4 }'");

?>

<html>
<head>
  <link rel="stylesheet" href="main.css">
</head>
<body>
  <dt>Files Downloaded from archive.org:</dt>
  <dd><?= number_format($files_count); ?></dd>
  
  <table class="data">
  <?= $tail_dl ?>
  </table>
</body>
</html>  
