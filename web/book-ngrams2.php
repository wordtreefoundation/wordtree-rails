<?php
  error_reporting(E_ALL ^ E_NOTICE);

  include 'bg.inc'; 
  $histogram_link = "/histogram.php?".$_SERVER['QUERY_STRING']; //str_replace($search, $replace, $output); 
  $book_id = (int)$_REQUEST['book_id'];
  $minus_id = (int)$_REQUEST['minus_id'];
  $compare_id = (int)$_REQUEST['compare_id'];
  if (isset($_REQUEST['f'])) { $f = $_REQUEST['f']; }
  $n = (int)$_REQUEST['n'];
  if ($_REQUEST['n'] == "") $n = "4";

  //setup shell query
  $top = "/research/ngrams/view_top_ngrams";
  if ($f=="gp"){
    //new ngrams with blanks (4x clarity)
	$cmd = "$top -g $n -i $book_id -u $minus_id -a $compare_id 2>&1 -f grams+";
	$ffactor=0; //this number corrects for the way the new ngram baseline counts are calculated
  } else {
    //old ngrams without blanks
	$cmd = "$top -g $n -i $book_id -u $minus_id -a $compare_id 2>&1";
	$ffactor=0; //this number corrects for the way the new ngram baseline counts are calculated
  }
  
?>

<html>
<head>
  <link rel="stylesheet" href="main.css" />
  <title>List of Matched Phrases (ngrams)</title>  
</head>
<body>

<pre>
<?php
  //ob_implicit_flush(true);
  echo "<h2>Starting Comparison...</h2>";

	//simple caching
	$cachefile="/research/ngrams/web/cache/".md5($cmd);
	if (file_exists($cachefile)){ 
	$output 	=	file_get_contents($cachefile);
	echo "<p>Using Cache. <a href='clear_cache.php?file=".md5($cmd)."'>Clear this cache file.</a></p>";
	}else{
	$output 	= 	(shell_exec($cmd));
	file_put_contents($cachefile, $output);
	}
	$lasthalf 	=  	explode ("MatchScore / NegMatchScore: ",$output,2);
	$lasthalfb	=	explode ("\n",$lasthalf[1],2);
	$info		=	$lasthalf[0]."MatchScore / NegMatchScore: ".$lasthalfb[0]; 
	$output		=	$lasthalfb[1];
	//$search  	= 	array("\n", ' '); 
	//$replace 	= 	array('</td></tr><tr><td>', '</td><td>');
	//$output 	= 	str_replace($search, $replace, $output); 	
	$parts		=	explode ("\n",$output,-1);
	echo "<b>$cmd</b>\n\n";
	echo "<small><i>".$info."</i></small>\n\n";
	
	//parse out the 2 books 
	/*
	Comparing mosiah-1830-clean - bible-kjv+dr with apocryphalnewtes00honeuoft
	Loading 4grams for mosiah-1830-clean
	Loading 4grams for bible-kjv+dr
	Loading 4grams for apocryphalnewtes00honeuoft
	Subtracting bible-kjv+dr from mosiah-1830-clean...
	*/  
	
	$lines=explode ("\n",$info);
	 $temp_array=explode("for ",$lines[1]);
	 $book1=$temp_array[1];
	if (strstr ($lines[3] , "Loading ")){
	 $temp_array=explode("for ",$lines[3]);
	 $book2=$temp_array[1];
	} else {
	 $temp_array=explode("for ",$lines[2]);
	 $book2=$temp_array[1];
	}
	
	echo "<p>Want a Histogram? <a href=".$histogram_link.">Take a closer look</a></p>";
	
//	echo "<table><tr><td>";  


echo '<table class="data"><tbody>
<tr>
  <th>Matched Phrase (ngram)</th>
  <th>Baseline Frequency</th>
  <th>Positions in '.$book2.'</th>
  <th>Positions in '.$book1.'</th>
  <th>A</th>
  <th>B</th>
</tr>';

foreach ($parts as $part) {
	set_time_limit(30);
	$part = explode(" ",$part);
	if ($part[1]==" " || $part[1]=="" || !isset($part[1]) ) { $part[1]=4; } else { $part[1]=$part[1]+$ffactor; }
    $phrase=str_replace("-"," ",$part[0]); 
	echo "<tr><td>".$phrase."</td><td>".$part[1]."</td>
	<td>".$part[2]."</td>
	<td>".$part[3]."</td>
	<td>".$part[4]."</td>
	<td>".$part[5]."</td>
	</tr>"; //end table row
}
echo "</tbody></table>";



/*
echo '<table class="data">
<tr>
  <th>Matched Phrase (ngram)</th>
  <th>Baseline Frequency</th>
  <th>'.$book2.'</th>
  <th>'.$book1.'</th>
  <th>A</th>
  <th>B</th>
</tr><tr><td>';
	echo $output; 
    echo "</table>";
	*/
 ?>
</pre>

</body>
</html>

<?php 
//simple versioning 1.0
exit(); //duane's pre Oct 5, 2013 version
/* ?>
<?php
  include 'bg.inc';

  $book_id = (int)$_REQUEST['book_id'];
  $minus_id = (int)$_REQUEST['minus_id'];
  $compare_id = (int)$_REQUEST['compare_id'];
  $n = (int)$_REQUEST['n'];
  if ($_REQUEST['n'] == "") $n = "4";

  $top = "/research/ngrams/view_top_ngrams";

  $cmd = "$top -g $n -i $book_id -u $minus_id -a $compare_id 2>&1";

?>
<html>
<head>
  <title>ngrams</title>
</head>
<body>

<pre>
<?php
  ob_implicit_flush(true);
  echo "$cmd\n\n";
  system($cmd);
?>
</pre>

</body>
</html>


<?php 
*/
?>
