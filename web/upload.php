<?php
  include 'link.inc';
?>

<h2>Upload a Book</h2>

<h3>TEMPORARILY DISABLED</h3>

<?php
if ($_POST['submit'] && $_FILES['uploaded']['tmp_name']):

  $filename = basename($_FILES['uploaded']['name']);
  $destpath = "/research/ngrams/books/" . $filename;
  if (move_uploaded_file($_FILES['uploaded']['tmp_name'], $destpath)) {
    echo "Disabled";
    # echo "<h3>Processing...</h3>";
    # echo nl2br(shell_exec("/research/ngrams/procbook $destpath 2>&1"));

    # $result = pg_exec($link, "SELECT id FROM books WHERE filename='$filename'");
    # $row = pg_fetch_assoc($result);
    # $id = $row['id'];

    # $title = pg_escape_literal($_REQUEST['title']);
    # $year = (int)$_REQUEST['year'];
    # $result = pg_exec($link, "UPDATE books SET title=$title, year=$year WHERE id=$id");

    # echo "<a href='book.php?id=$id'>View Book Details</a>";
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
    <td colspan="2" align="center"> 
      <input type="submit" name="submit" value="Upload" />
    </td>
  </tr>
  </table>

</form>
<?php endif; ?>
