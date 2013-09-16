<?php
  include 'link.inc';

  $result = pg_exec($link, "SELECT * FROM BOOKS WHERE id=$_REQUEST[id]");
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

<table class="data">
<tr>
  <td></td>
  <td></td>
  <td colspan="2" align="center">1grams</td>
  <td colspan="2" align="center">2grams</td>
  <td colspan="2" align="center">3grams</td>
  <td colspan="2" align="center">4grams</td>
  <td colspan="2" align="center">5grams</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>BoM</td><td nowrap>BoM - KJV</td>
  <td>BoM</td><td nowrap>BoM - KJV</td>
  <td>BoM</td><td nowrap>BoM - KJV</td>
  <td>BoM</td><td nowrap>BoM - KJV</td>
  <td>BoM</td><td nowrap>BoM - KJV</td>
</tr>
<tr>
  <td rowspan="2">Whole BoM</td>
  <td>Score</td>
  <td><a href="book-ngrams.php?id=<?= $_REQUEST['id'] ?>&section=bom&subset=bom&n=1"><?= number_format($row['score_bom_1g'], 5) ?></a></td>
  <td><a href="book-ngrams.php?id=<?= $_REQUEST['id'] ?>&section=bom&subset=nokjv&n=1"><?= number_format($row['score_bom_nokjv_1g'], 5) ?></a></td>
  <td><a href="book-ngrams.php?id=<?= $_REQUEST['id'] ?>&section=bom&subset=bom&n=2"><?= number_format($row['score_bom_2g'], 5) ?></a></td>
  <td><a href="book-ngrams.php?id=<?= $_REQUEST['id'] ?>&section=bom&subset=nokjv&n=2"><?= number_format($row['score_bom_nokjv_2g'], 5) ?></a></td>
  <td><a href="book-ngrams.php?id=<?= $_REQUEST['id'] ?>&section=bom&subset=bom&n=3"><?= number_format($row['score_bom_3g'], 5) ?></a></td>
  <td><a href="book-ngrams.php?id=<?= $_REQUEST['id'] ?>&section=bom&subset=nokjv&n=3"><?= number_format($row['score_bom_nokjv_3g'], 5) ?></a></td>
  <td><a href="book-ngrams.php?id=<?= $_REQUEST['id'] ?>&section=bom&subset=bom&n=4"><?= number_format($row['score_bom_4g'], 5) ?></a></td>
  <td><a href="book-ngrams.php?id=<?= $_REQUEST['id'] ?>&section=bom&subset=nokjv&n=4"><?= number_format($row['score_bom_nokjv_4g'], 5) ?></a></td>
  <td><a href="book-ngrams.php?id=<?= $_REQUEST['id'] ?>&section=bom&subset=bom&n=5"><?= number_format($row['score_bom_5g'], 5) ?></a></td>
  <td><a href="book-ngrams.php?id=<?= $_REQUEST['id'] ?>&section=bom&subset=nokjv&n=5"><?= number_format($row['score_bom_nokjv_5g'], 5) ?></a></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_bom_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_bom_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_bom_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_bom_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_bom_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_bom_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_bom_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_bom_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_bom_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_bom_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">Prelude</td>
  <td>Score</td>
  <td><?= number_format($row['score_pre_1g'], 5) ?></td>
  <td><?= number_format($row['score_pre_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_pre_2g'], 5) ?></td>
  <td><?= number_format($row['score_pre_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_pre_3g'], 5) ?></td>
  <td><?= number_format($row['score_pre_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_pre_4g'], 5) ?></td>
  <td><?= number_format($row['score_pre_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_pre_5g'], 5) ?></td>
  <td><?= number_format($row['score_pre_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_pre_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_pre_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_pre_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_pre_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_pre_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_pre_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_pre_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_pre_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_pre_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_pre_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">1 Nephi</td>
  <td>Score</td>
  <td><?= number_format($row['score_1ne_1g'], 5) ?></td>
  <td><?= number_format($row['score_1ne_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_1ne_2g'], 5) ?></td>
  <td><?= number_format($row['score_1ne_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_1ne_3g'], 5) ?></td>
  <td><?= number_format($row['score_1ne_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_1ne_4g'], 5) ?></td>
  <td><?= number_format($row['score_1ne_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_1ne_5g'], 5) ?></td>
  <td><?= number_format($row['score_1ne_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_1ne_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_1ne_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_1ne_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_1ne_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_1ne_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_1ne_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_1ne_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_1ne_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_1ne_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_1ne_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">2 Nephi</td>
  <td>Score</td>
  <td><?= number_format($row['score_2ne_1g'], 5) ?></td>
  <td><?= number_format($row['score_2ne_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_2ne_2g'], 5) ?></td>
  <td><?= number_format($row['score_2ne_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_2ne_3g'], 5) ?></td>
  <td><?= number_format($row['score_2ne_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_2ne_4g'], 5) ?></td>
  <td><?= number_format($row['score_2ne_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_2ne_5g'], 5) ?></td>
  <td><?= number_format($row['score_2ne_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_2ne_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_2ne_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_2ne_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_2ne_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_2ne_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_2ne_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_2ne_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_2ne_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_2ne_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_2ne_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">Jacob</td>
  <td>Score</td>
  <td><?= number_format($row['score_jac_1g'], 5) ?></td>
  <td><?= number_format($row['score_jac_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_jac_2g'], 5) ?></td>
  <td><?= number_format($row['score_jac_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_jac_3g'], 5) ?></td>
  <td><?= number_format($row['score_jac_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_jac_4g'], 5) ?></td>
  <td><?= number_format($row['score_jac_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_jac_5g'], 5) ?></td>
  <td><?= number_format($row['score_jac_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_jac_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jac_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jac_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jac_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jac_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jac_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jac_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jac_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jac_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jac_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">Enos</td>
  <td>Score</td>
  <td><?= number_format($row['score_eno_1g'], 5) ?></td>
  <td><?= number_format($row['score_eno_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_eno_2g'], 5) ?></td>
  <td><?= number_format($row['score_eno_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_eno_3g'], 5) ?></td>
  <td><?= number_format($row['score_eno_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_eno_4g'], 5) ?></td>
  <td><?= number_format($row['score_eno_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_eno_5g'], 5) ?></td>
  <td><?= number_format($row['score_eno_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_eno_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eno_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eno_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eno_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eno_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eno_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eno_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eno_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eno_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eno_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">Jarom</td>
  <td>Score</td>
  <td><?= number_format($row['score_jar_1g'], 5) ?></td>
  <td><?= number_format($row['score_jar_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_jar_2g'], 5) ?></td>
  <td><?= number_format($row['score_jar_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_jar_3g'], 5) ?></td>
  <td><?= number_format($row['score_jar_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_jar_4g'], 5) ?></td>
  <td><?= number_format($row['score_jar_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_jar_5g'], 5) ?></td>
  <td><?= number_format($row['score_jar_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_jar_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jar_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jar_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jar_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jar_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jar_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jar_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jar_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jar_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_jar_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">Omni</td>
  <td>Score</td>
  <td><?= number_format($row['score_omn_1g'], 5) ?></td>
  <td><?= number_format($row['score_omn_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_omn_2g'], 5) ?></td>
  <td><?= number_format($row['score_omn_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_omn_3g'], 5) ?></td>
  <td><?= number_format($row['score_omn_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_omn_4g'], 5) ?></td>
  <td><?= number_format($row['score_omn_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_omn_5g'], 5) ?></td>
  <td><?= number_format($row['score_omn_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_omn_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_omn_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_omn_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_omn_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_omn_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_omn_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_omn_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_omn_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_omn_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_omn_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">Words of Mormon</td>
  <td>Score</td>
  <td><?= number_format($row['score_wom_1g'], 5) ?></td>
  <td><?= number_format($row['score_wom_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_wom_2g'], 5) ?></td>
  <td><?= number_format($row['score_wom_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_wom_3g'], 5) ?></td>
  <td><?= number_format($row['score_wom_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_wom_4g'], 5) ?></td>
  <td><?= number_format($row['score_wom_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_wom_5g'], 5) ?></td>
  <td><?= number_format($row['score_wom_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_wom_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_wom_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_wom_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_wom_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_wom_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_wom_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_wom_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_wom_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_wom_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_wom_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">Mosiah</td>
  <td>Score</td>
  <td><?= number_format($row['score_mos_1g'], 5) ?></td>
  <td><?= number_format($row['score_mos_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_mos_2g'], 5) ?></td>
  <td><?= number_format($row['score_mos_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_mos_3g'], 5) ?></td>
  <td><?= number_format($row['score_mos_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_mos_4g'], 5) ?></td>
  <td><?= number_format($row['score_mos_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_mos_5g'], 5) ?></td>
  <td><?= number_format($row['score_mos_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_mos_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mos_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mos_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mos_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mos_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mos_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mos_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mos_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mos_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mos_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">Alma</td>
  <td>Score</td>
  <td><?= number_format($row['score_alm_1g'], 5) ?></td>
  <td><?= number_format($row['score_alm_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_alm_2g'], 5) ?></td>
  <td><?= number_format($row['score_alm_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_alm_3g'], 5) ?></td>
  <td><?= number_format($row['score_alm_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_alm_4g'], 5) ?></td>
  <td><?= number_format($row['score_alm_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_alm_5g'], 5) ?></td>
  <td><?= number_format($row['score_alm_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_alm_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_alm_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_alm_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_alm_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_alm_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_alm_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_alm_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_alm_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_alm_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_alm_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">Helaman</td>
  <td>Score</td>
  <td><?= number_format($row['score_hel_1g'], 5) ?></td>
  <td><?= number_format($row['score_hel_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_hel_2g'], 5) ?></td>
  <td><?= number_format($row['score_hel_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_hel_3g'], 5) ?></td>
  <td><?= number_format($row['score_hel_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_hel_4g'], 5) ?></td>
  <td><?= number_format($row['score_hel_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_hel_5g'], 5) ?></td>
  <td><?= number_format($row['score_hel_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_hel_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_hel_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_hel_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_hel_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_hel_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_hel_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_hel_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_hel_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_hel_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_hel_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">3 Nephi</td>
  <td>Score</td>
  <td><?= number_format($row['score_3ne_1g'], 5) ?></td>
  <td><?= number_format($row['score_3ne_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_3ne_2g'], 5) ?></td>
  <td><?= number_format($row['score_3ne_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_3ne_3g'], 5) ?></td>
  <td><?= number_format($row['score_3ne_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_3ne_4g'], 5) ?></td>
  <td><?= number_format($row['score_3ne_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_3ne_5g'], 5) ?></td>
  <td><?= number_format($row['score_3ne_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_3ne_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_3ne_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_3ne_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_3ne_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_3ne_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_3ne_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_3ne_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_3ne_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_3ne_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_3ne_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">4 Nephi</td>
  <td>Score</td>
  <td><?= number_format($row['score_4ne_1g'], 5) ?></td>
  <td><?= number_format($row['score_4ne_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_4ne_2g'], 5) ?></td>
  <td><?= number_format($row['score_4ne_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_4ne_3g'], 5) ?></td>
  <td><?= number_format($row['score_4ne_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_4ne_4g'], 5) ?></td>
  <td><?= number_format($row['score_4ne_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_4ne_5g'], 5) ?></td>
  <td><?= number_format($row['score_4ne_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_4ne_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_4ne_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_4ne_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_4ne_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_4ne_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_4ne_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_4ne_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_4ne_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_4ne_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_4ne_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">Mormon</td>
  <td>Score</td>
  <td><?= number_format($row['score_mor_1g'], 5) ?></td>
  <td><?= number_format($row['score_mor_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_mor_2g'], 5) ?></td>
  <td><?= number_format($row['score_mor_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_mor_3g'], 5) ?></td>
  <td><?= number_format($row['score_mor_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_mor_4g'], 5) ?></td>
  <td><?= number_format($row['score_mor_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_mor_5g'], 5) ?></td>
  <td><?= number_format($row['score_mor_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_mor_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mor_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mor_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mor_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mor_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mor_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mor_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mor_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mor_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mor_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">Ether</td>
  <td>Score</td>
  <td><?= number_format($row['score_eth_1g'], 5) ?></td>
  <td><?= number_format($row['score_eth_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_eth_2g'], 5) ?></td>
  <td><?= number_format($row['score_eth_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_eth_3g'], 5) ?></td>
  <td><?= number_format($row['score_eth_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_eth_4g'], 5) ?></td>
  <td><?= number_format($row['score_eth_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_eth_5g'], 5) ?></td>
  <td><?= number_format($row['score_eth_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_eth_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eth_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eth_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eth_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eth_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eth_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eth_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eth_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eth_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_eth_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>
<tr>
  <td rowspan="2">Moroni</td>
  <td>Score</td>
  <td><?= number_format($row['score_mni_1g'], 5) ?></td>
  <td><?= number_format($row['score_mni_nokjv_1g'], 5) ?></td>
  <td><?= number_format($row['score_mni_2g'], 5) ?></td>
  <td><?= number_format($row['score_mni_nokjv_2g'], 5) ?></td>
  <td><?= number_format($row['score_mni_3g'], 5) ?></td>
  <td><?= number_format($row['score_mni_nokjv_3g'], 5) ?></td>
  <td><?= number_format($row['score_mni_4g'], 5) ?></td>
  <td><?= number_format($row['score_mni_nokjv_4g'], 5) ?></td>
  <td><?= number_format($row['score_mni_5g'], 5) ?></td>
  <td><?= number_format($row['score_mni_nokjv_5g'], 5) ?></td>
</tr>
<tr>
  <td>Score / Wordcount</td>
  <td><?= number_format($row['score_mni_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mni_nokjv_1g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mni_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mni_nokjv_2g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mni_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mni_nokjv_3g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mni_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mni_nokjv_4g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mni_5g'] / $row['wordcount'], 5) ?></td>
  <td><?= number_format($row['score_mni_nokjv_5g'] / $row['wordcount'], 5) ?></td>
</tr>

</table>


