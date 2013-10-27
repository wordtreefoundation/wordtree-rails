<?php
  include 'library_link.inc';
?>

<h2>Stop Experiment <?= $_REQUEST['id'] ?></h2>

<?php
if ($_POST['submit']):
  $id = (int)$_POST['id'];

  if ($_POST['id'] == "") {
    echo "Experiment ID is required.";
  } else {
    $get_ps_cmd = "ps auxww|grep SCREEN|grep run-$id|grep -v grep|awk '{print $2}'";
    echo "$get_ps_cmd<br>";
    $ps = shell_exec($get_ps_cmd);
    echo "ps: '$ps'<br>";
    if ($ps != "") {
      $cmd = "kill -QUIT $ps";
      echo nl2br($cmd);
      echo nl2br(shell_exec($cmd));
    }

    echo "<br><a href='experiments.php'>Back to List of Experiments</a>";
  }

else: ?>

<form name="create-form" method="post" action="stop_experiment.php">
  <table>
  <tr>
    <td> Experiment ID:</td>
    <td> <input type="text" name="id" value="<?= $_REQUEST['id'] ?>" /></td>
  </tr>
  <tr>
    <td colspan="2" align="center"> 
      <input type="submit" name="submit" value="Stop" />
    </td>
  </tr>
  </table>

</form>
<?php endif; ?>
