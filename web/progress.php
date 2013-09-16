<?php

  $files_count = shell_exec("ls -1 /research/ngrams/dl_ao/ | wc -l");
  $tail_dl = shell_exec("tail /research/ngrams/dl_ao/ao_list.csv | awk -F '\t' '{ printf \"<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>\", $1, $3, $2, $4 }'");

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
