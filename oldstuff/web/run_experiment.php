<?php
  include 'library_link.inc';
?>

<h2>Run Experiment <?= $_REQUEST['id'] ?></h2>

<?php
if ($_POST['submit']):
  $id = (int)$_POST['id'];

  if ($id == "") {
    echo "Experiment ID is required.";
  } else {
    $overwrite = "";
    if ($_POST['overwrite'] != "") $overwrite = "-o";
    $delete = "";
    if ($_POST['delete'] != "") $delete = "-d";

    $basedir = $destdir = "/research/ngrams";
    $cmd = "nohup screen -dmS run-$id $basedir/run_experiment -e $id $overwrite $delete 2&>1";
    echo nl2br($cmd);
    echo nl2br(shell_exec($cmd));

    echo "<br><a href='experiments.php'>Back to List of Experiments</a>";
  }

else: ?>

<form name="create-form" method="post" action="run_experiment.php">
  <table>
  <tr>
    <td> Experiment ID:</td>
    <td> <input type="text" name="id" value="<?= $_REQUEST['id'] ?>" /></td>
  </tr>
  <tr>
    <td> Overwrite previous data for this experiment?</td>
    <td> <input type="checkbox" name="overwrite" value="1" /></td>
  </tr>
  <tr>
    <td> Delete previous data for this experiment?</td>
    <td> <input type="checkbox" name="delete" value="1" /></td>
  </tr>
  <tr>
    <td colspan="2" align="center"> 
      <input type="submit" name="submit" value="Run" />
    </td>
  </tr>
  </table>

</form>
<?php endif; ?>
