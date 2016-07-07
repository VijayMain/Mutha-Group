<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<title>Scrolling Freeze Panes html table like excel</title>
<STYLE TYPE="text/css" MEDIA=all>
.td1 {
	background: #EEEEEE;
	color: #000;
	border: 1px solid #000;
}

.th {
	background: blue;
	color: white;
	border: 1px solid #000;
}

A:link {
	COLOR: #0000EE;
}

A:hover {
	COLOR: #0000EE;
}

A:visited {
	COLOR: #0000EE;
}

A:hover {
	COLOR: #0000EE;
}

.div_freezepanes_wrapper {
	position: relative;
	width: 99%;
	height: 550px;
	overflow: hidden;
	background: #fff;
	border-style: ridge;
}

.div_verticalscroll {
	position: absolute;
	right: 0px;
	width: 18px;
	height: 100%;
	background: #EAEAEA;
	border: 1px solid #C0C0C0;
}

.buttonUp {
	width: 20px;
	position: absolute;
	top: 2px;
}

.buttonDn {
	width: 20px;
	position: absolute;
	bottom: 22px;
}

.div_horizontalscroll {
	position: absolute;
	bottom: 0px;
	width: 100%;
	height: 18px;
	background: #EAEAEA;
	border: 1px solid #C0C0C0;
}

.buttonRight {
	width: 20px;
	position: absolute;
	left: 0px;
	padding-top: 2px;
}

.buttonLeft {
	width: 20px;
	position: absolute;
	right: 22px;
	padding-top: 2px;
}
</STYLE>
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
	<div>
		<h5> 
DHANASHREE INDUSTRIES<br/>
Plot No.D-12 OLD MIDC SATARA 415004.<br/>
Day wise Production For The Month October 2014
		</h5> 
		<div class="div_freezepanes_wrapper">

			<div class="div_verticalscroll"
				onmouseover="this.style.cursor='pointer'">
				<div style="height: 50%;" onmousedown="upp();" onmouseup="upp(1);">
					<img class="buttonUp" src="images/up.png">
				</div>
				<div style="height: 50%;" onmousedown="down();" onmouseup="down(1);">
					<img class="buttonDn" src="images/down.png">
				</div>
			</div>

			<div class="div_horizontalscroll"
				onmouseover="this.style.cursor='pointer'">
				<div style="float: left; width: 50%; height: 100%;"
					onmousedown="right();" onmouseup="right(1);">
					<img class="buttonRight" src="images/left.png">
				</div>
				<div style="float: right; width: 50%; height: 100%;"
					onmousedown="left();" onmouseup="left(1);">
					<img class="buttonLeft" src="images/forward.png">
				</div>
			</div>



<%
Connection con = ConnectionUrl.getDIFMShopConnection();
CallableStatement callsp1 = con.prepareCall("{call Sel_RptDaywiseCastingSale('105', '201410', 'DIERP')}"); 
ResultSet rs = callsp1.executeQuery();
while(rs.next()){
	System.out.println("Testing Mat Name = " + rs.getString("MAT_Name"));
}
%>
			<table id="t1" border="1" cellpadding=2 style="border: 1px solid #000;">

				<tr>
					<th class="th">Sr. No</th>
					<th class="th">Item Name</th>
					<th class="th">Grade</th>
					<th class="th">Prod Plan Qty</th>
					<th class="th">Prod Day Qty</th>
					<th class="th">Avg Qty</th>
					<th class="th">Total Qty</th>
					<th class="th">01</th>
					<th class="th">02</th>
					<th class="th">03</th>
					<th class="th">04</th>
					<th class="th">05</th>
					<th class="th">06</th>
					<th class="th">07</th>
					<th class="th">08</th>
					<th class="th">09</th>
					<th class="th">10</th>
					<th class="th">11</th>
					<th class="th">12</th>
					<th class="th">13</th>
					<th class="th">14</th>
					<th class="th">15</th>
					<th class="th">16</th>

				</tr>
				
				
				<tr onmouseover="this.style.background='#EEEEEE';"
					onmouseout="this.style.background='';">
					<td class="td1">00M</td>
					<td nowrap>THIGPEN FIELD</td>
					<td nowrap>BAY SPRINGS</td>
					<td nowrap>MS</td>
					<td nowrap>31</td>
					<td nowrap>31</td>
					<td nowrap>57</td>
					<td nowrap>13</td>
					<td nowrap>N</td>
					<td nowrap>089</td>
					<td nowrap>89</td>
					<td nowrap>14</td>
					<td nowrap>4</td>
					<td nowrap>W</td>
					<td nowrap>11</td>
					<td nowrap></td>
					<td nowrap>13</td>
					<td nowrap>N</td>
					<td nowrap>089</td>
					<td nowrap>89</td>
					<td nowrap>14</td>
					<td nowrap>4</td>
					<td nowrap>W</td> 
				</tr>
				<tr onmouseover="this.style.background='#EEEEEE';"
					onmouseout="this.style.background='';">
					<td class="td1">00M</td>
					<td nowrap>THIGPEN FIELD</td>
					<td nowrap>BAY SPRINGS</td>
					<td nowrap>MS</td>
					<td nowrap>31</td>
					<td nowrap>31</td>
					<td nowrap>57</td>
					<td nowrap>13</td>
					<td nowrap>N</td>
					<td nowrap>089</td>
					<td nowrap>89</td>
					<td nowrap>14</td>
					<td nowrap>4</td>
					<td nowrap>W</td>
					<td nowrap>11</td>
					<td nowrap></td>
					<td nowrap>13</td>
					<td nowrap>N</td>
					<td nowrap>089</td>
					<td nowrap>89</td>
					<td nowrap>14</td>
					<td nowrap>4</td>
					<td nowrap>W</td> 
				</tr>
				<tr onmouseover="this.style.background='#EEEEEE';"
					onmouseout="this.style.background='';">
					<td class="td1">00M</td>
					<td nowrap>THIGPEN FIELD</td>
					<td nowrap>BAY SPRINGS</td>
					<td nowrap>MS</td>
					<td nowrap>31</td>
					<td nowrap>31</td>
					<td nowrap>57</td>
					<td nowrap>13</td>
					<td nowrap>N</td>
					<td nowrap>089</td>
					<td nowrap>89</td>
					<td nowrap>14</td>
					<td nowrap>4</td>
					<td nowrap>W</td>
					<td nowrap>11</td>
					<td nowrap></td>
					<td nowrap>13</td>
					<td nowrap>N</td>
					<td nowrap>089</td>
					<td nowrap>89</td>
					<td nowrap>14</td>
					<td nowrap>4</td>
					<td nowrap>W</td> 
				</tr>
				<tr onmouseover="this.style.background='#EEEEEE';"
					onmouseout="this.style.background='';">
					<td class="td1">00M</td>
					<td nowrap>THIGPEN FIELD</td>
					<td nowrap>BAY SPRINGS</td>
					<td nowrap>MS</td>
					<td nowrap>31</td>
					<td nowrap>31</td>
					<td nowrap>57</td>
					<td nowrap>13</td>
					<td nowrap>N</td>
					<td nowrap>089</td>
					<td nowrap>89</td>
					<td nowrap>14</td>
					<td nowrap>4</td>
					<td nowrap>W</td>
					<td nowrap>11</td>
					<td nowrap></td>
					<td nowrap>13</td>
					<td nowrap>N</td>
					<td nowrap>089</td>
					<td nowrap>89</td>
					<td nowrap>14</td>
					<td nowrap>4</td>
					<td nowrap>W</td> 
				</tr>
				
				<tr onmouseover="this.style.background='#EEEEEE';"
					onmouseout="this.style.background='';">
					<td class="td1">00M</td>
					<td nowrap>THIGPEN FIELD</td>
					<td nowrap>BAY SPRINGS</td>
					<td nowrap>MS</td>
					<td nowrap>31</td>
					<td nowrap>31</td>
					<td nowrap>57</td>
					<td nowrap>13</td>
					<td nowrap>N</td>
					<td nowrap>089</td>
					<td nowrap>89</td>
					<td nowrap>14</td>
					<td nowrap>4</td>
					<td nowrap>W</td>
					<td nowrap>11</td>
					<td nowrap></td>
					<td nowrap>13</td>
					<td nowrap>N</td>
					<td nowrap>089</td>
					<td nowrap>89</td>
					<td nowrap>14</td>
					<td nowrap>4</td>
					<td nowrap>W</td> 
				</tr>

			</table>

		</div>

		<br> <br>
	</div>
	<script type="text/javascript">
		var freezeRow = 1; //change to row to freeze at
		var freezeCol = 7; //change to column to freeze at
		var myRow = freezeRow;
		var myCol = freezeCol;
		var speed = 100; //timeout speed
		var myTable;
		var noRows;
		var myCells, ID;

		function setUp() {
			if (!myTable) {
				myTable = document.getElementById("t1");
			}
			myCells = myTable.rows[0].cells.length;
			noRows = myTable.rows.length;

			for ( var x = 0; x < myTable.rows[0].cells.length; x++) {
				colWdth = myTable.rows[0].cells[x].offsetWidth;
				myTable.rows[0].cells[x].setAttribute("width", colWdth - 4);

			}
		}

		function right(up) {
			if (up) {
				window.clearTimeout(ID);
				return;
			}
			if (!myTable) {
				setUp();
			}

			if (myCol < (myCells)) {
				for ( var x = 0; x < noRows; x++) {
					myTable.rows[x].cells[myCol].style.display = "";
				}
				if (myCol > freezeCol) {
					myCol--;
				}
				ID = window.setTimeout('right()', speed);
			}
		}

		function left(up) {
			if (up) {
				window.clearTimeout(ID);
				return;
			}
			if (!myTable) {
				setUp();
			}

			if (myCol < (myCells - 1)) {
				for ( var x = 0; x < noRows; x++) {
					myTable.rows[x].cells[myCol].style.display = "none";
				}
				myCol++;
				ID = window.setTimeout('left()', speed);

			}
		}

		function down(up) {
			if (up) {
				window.clearTimeout(ID);
				return;
			}
			if (!myTable) {
				setUp();
			}

			if (myRow < (noRows - 1)) {
				myTable.rows[myRow].style.display = "none";
				myRow++;

				ID = window.setTimeout('down()', speed);
			}
		}

		function upp(up) {
			if (up) {
				window.clearTimeout(ID);
				return;
			}
			if (!myTable) {
				setUp();
			}
			if (myRow <= noRows) {
				myTable.rows[myRow].style.display = "";
				if (myRow > freezeRow) {
					myRow--;
				}
				ID = window.setTimeout('upp()', speed);
			}
		}
	</script>

</body>
</html>






