<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Full Row Select</title>
<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#877ACC';
		} else {
			tableRow.style.backgroundColor = 'white';
		}
	}

	function DoNav() {
		//	document.location.href = theUrl;
		document.getElementById("frm1").submit();
	}
</script>
</head>
<body>
	<form action="Register_Controller" id="frm1" method="post">
		<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr onmouseover="ChangeColor(this, true);"
				onmouseout="ChangeColor(this, false);" onclick="DoNav();">
				<!-- onclick="DoNav('Register_Controller');" -->
				<td>1</td>
				<td>2</td>
				<td>3</td>
			</tr>
			<tr onmouseover="ChangeColor(this, true);"
				onmouseout="ChangeColor(this, false);"
				onclick="DoNav('http://www.microsoft.com/');">
				<td>4</td>
				<td>5</td>
				<td>6</td>
			</tr>
			<tr onmouseover="ChangeColor(this, true);"
				onmouseout="ChangeColor(this, false);"
				onclick="DoNav('http://Imar.Spaanjaars.Com/');">
				<td>7</td>
				<td>8</td>
				<td>9</td>
			</tr>
		</table>
	</form>
</body>
</html>