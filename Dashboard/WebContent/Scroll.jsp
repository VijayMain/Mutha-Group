<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Scrolling Freeze Panes html table like excel</title>



<STYLE TYPE="text/css" MEDIA=all>
.td1 {background:#EEEEEE;color:#000;border:1px solid #000;}
.th{background:blue;color:white;border:1px solid #000;}
A:link {COLOR: #0000EE;}
A:hover {COLOR: #0000EE;}
A:visited {COLOR: #0000EE;}
A:hover {COLOR: #0000EE;}

.div_freezepanes_wrapper{
position:relative;width:90%;height:400px;
overflow:hidden;background:#fff;border-style: ridge;
}

.div_verticalscroll{
position: absolute;right:0px;width:18px;height:100%;
background:#EAEAEA;border:1px solid #C0C0C0;
}

.buttonUp{
width:20px;position: absolute;top:2px;
}

.buttonDn{
width:20px;position: absolute;bottom:22px;
}

.div_horizontalscroll{
position: absolute;bottom:0px;width:100%;height:18px;
background:#EAEAEA;border:1px solid #C0C0C0;
}

.buttonRight{
width:20px;position: absolute;left:0px;padding-top:2px;
}

.buttonLeft{
width:20px;position: absolute;right:22px;padding-top:2px;
}
</STYLE>
</head>
<body>
<div>
<h3>Freeze Panes html table like Excel in a scrollable div - Demo 2</h3>

This is version 2 as an interin to a new release. Note pane is freezed at 2nd column and second row.<br>
Change variables var freezeRow=2; //change to row to freeze at - var freezeCol=2; //change to column to freeze at.
<br><br>
 
<div class="div_freezepanes_wrapper">

<div class="div_verticalscroll" onmouseover="this.style.cursor='pointer'">
	<div style="height:50%;" onmousedown="upp();" onmouseup="upp(1);"><img class="buttonUp" src="images/uF035.png"></div>
	<div style="height:50%;" onmousedown="down();" onmouseup="down(1);"><img class="buttonDn" src="images/uF036.png"></div>
</div>

<div class="div_horizontalscroll" onmouseover="this.style.cursor='pointer'">
	<div style="float:left;width:50%;height:100%;" onmousedown="right();" onmouseup="right(1);"><img class="buttonRight" src="images/uF033.png"></div>
	<div style="float:right;width:50%;height:100%;" onmousedown="left();" onmouseup="left(1);"><img class="buttonLeft" src="images/uF034.png"></div>
</div>

<table id="t1" cellpadding=2 style="border:1px solid #000;">

<tr>
<th class="th" width="300px">PortID</th><th class="th">AirportName</th><th class="th">City</th><th class="th">St</th>
<th class="th">Latitiude</th><th class="th">LatiDeg</th><th class="th">LatiMin</th><th class="th">LatiSec</th>
<th class="th">LatiNS</th><th class="th">Longitude</th><th class="th">LongDeg</th><th class="th">LongMin</th>
<th class="th">LongSec</th><th class="th">LongEW</th><th class="th">FAASiteID</th>

</tr>
<tr onmouseover="this.style.background='#EEEEEE';" onmouseout="this.style.background='';">
<td class="td1">00M</td>
<td nowrap>THIGPEN FIELD</td>
<td nowrap>BAY SPRINGS</td>
<td nowrap>MS</td>
<td nowrap>31-57-13.553N</td>
<td nowrap>31</td>
<td nowrap>57</td>
<td nowrap>13.5530004501343</td>

<td nowrap>N</td>
<td nowrap>089-14-04.217W</td>
<td nowrap>89</td>
<td nowrap>14</td>
<td nowrap>4.21700000762939</td>
<td nowrap>W</td>
<td nowrap>11141.*A</td>
<td nowrap></td>
</tr>
</table>

</div>

<br><br>
</div>
  <script type="text/javascript">
  //****Copywrite CoastWorx http://www.coastworx.com Version 1.1******
  //****Please make a donation if you wish to remove this notice!******
  var freezeRow=2; //change to row to freeze at
  var freezeCol=2; //change to column to freeze at
  var myRow=freezeRow;
  var myCol=freezeCol;
  var speed=100; //timeout speed
  var myTable;
  var noRows;
  var myCells,ID;



function setUp(){
	if(!myTable){myTable=document.getElementById("t1");}
 	myCells = myTable.rows[0].cells.length;
	noRows=myTable.rows.length;

	for( var x = 0; x < myTable.rows[0].cells.length; x++ ) {
		colWdth=myTable.rows[0].cells[x].offsetWidth;
		myTable.rows[0].cells[x].setAttribute("width",colWdth-4);

	}
}


function right(up){
	if(up){window.clearTimeout(ID);return;}
	if(!myTable){setUp();}

	if(myCol<(myCells)){
		for( var x = 0; x < noRows; x++ ) {
			myTable.rows[x].cells[myCol].style.display="";
		}
		if(myCol >freezeCol){myCol--;}
		ID = window.setTimeout('right()',speed);
	}
}

function left(up){
	if(up){window.clearTimeout(ID);return;}
	if(!myTable){setUp();}

	if(myCol<(myCells-1)){
		for( var x = 0; x < noRows; x++ ) {
			myTable.rows[x].cells[myCol].style.display="none";
		}
		myCol++
		ID = window.setTimeout('left()',speed);

	}
}

function down(up){
	if(up){window.clearTimeout(ID);return;}
	if(!myTable){setUp();}

	if(myRow<(noRows-1)){
			myTable.rows[myRow].style.display="none";
			myRow++	;

			ID = window.setTimeout('down()',speed);
	}
}

function upp(up){
	if(up){window.clearTimeout(ID);return;}
	if(!myTable){setUp();}
	if(myRow<=noRows){
		myTable.rows[myRow].style.display="";
		if(myRow >freezeRow){myRow--;}
		ID = window.setTimeout('upp()',speed);
	}
}

</script>

</body>
</html>






