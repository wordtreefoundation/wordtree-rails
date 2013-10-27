<?php
  include 'library_link.inc';
?>

<h2>Upload a Book</h2>

<?php
if ($_POST['submit'] && $_FILES['uploaded']['tmp_name']):

  $filename = basename($_FILES['uploaded']['name']);
  $experiment_id = isset($_POST['experiment_id']) ? $_POST['experiment_id'] : "";

  $destdir = "/research/ngrams/library/" . strtolower(substr($filename, 0, 2));
  echo nl2br(shell_exec("mkdir -p $destdir"));

  $destpath = "$destdir/$filename";

  if (move_uploaded_file($_FILES['uploaded']['tmp_name'], $destpath)) {
    echo "<h3>Processing...</h3>";
    echo nl2br(shell_exec("/research/ngrams/procbook $destpath 2>&1"));

    $result = pg_exec($link, "SELECT id FROM books WHERE filename='$filename'");
    $row = pg_fetch_assoc($result);
    $id = $row['id'];

    $title = pg_escape_literal($_REQUEST['title']);
    $year = (int)$_REQUEST['year'];
    $result = pg_exec($link, "UPDATE books SET title=$title, year=$year WHERE id=$id");

    echo "Add to experiment? " . $experiment_id . "<br>";

    if ($experiment_id != "") {
      $SQL = "INSERT INTO comparisons (experiment_id, book_id) VALUES ($experiment_id, $id)";
      echo $SQL . "<br>";
      $result = pg_exec($link, $SQL);
    }

    echo "<a href='book.php?id=$id'>View Book Details</a>";
  } else {
    echo "Unable to move file to books path";
  }

else: ?>

<form name="uploadForm" enctype="multipart/form-data" method="post" action="upload.php">
  <table>
  <tr>
    <td> Text File:</td>
    <td> <input type="file" name="uploaded" /></td>
  </tr>
  <tr>
    <td> Title:</td>
    <td> <input type="text" name="title" /></td>
  </tr>
  <tr>
    <td> Year:</td>
    <td> <input type="text" name="year" /></td>
  </tr>
  <tr>
    <td> Add to Experiment?:</td>
    <td> <input type="text" name="experiment_id" /></td>
  </tr>
  <tr>
    <td colspan="2" align="center"> 
      <input type="submit" name="submit" value="Upload" />
    </td>
  </tr>
  </table>

</form>
<?php endif; ?>
