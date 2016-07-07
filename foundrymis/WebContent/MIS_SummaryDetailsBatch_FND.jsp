<%@page import="java.util.Arrays"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<html>
<head> 
<title>MIS BatchWise Founders</title>
<STYLE TYPE="text/css" MEDIA=all>
.td1 { 
	font-size: 10px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
.tftable tr {
	background-color: white;
	font-size: 10px;
}

.th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
	text-align: center;
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
	font-size:10px;
	position: relative; 
	width: 99%;
	height: 550px;
	overflow: hidden;
	background: #fff;
	border-style: ridge;
	
}

.div_verticalscroll {
	font-size:10px;
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
	font-size:10px;
	position: absolute;
	bottom: 0px;
	width: 0%;
	height: 0px;
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
<%
try {
String comp =request.getParameter("comp");
String fromdate =request.getParameter("fromdate");
String todate =request.getParameter("todate"); 
String db =request.getParameter("db"); 
int j=0;
String frDATE = fromdate.substring(6,8) +"/"+ fromdate.substring(4,6) +"/"+ fromdate.substring(0,4); 
String toDATE =  todate.substring(6,8) +"/"+ todate.substring(4,6) +"/"+ todate.substring(0,4);
%> 
<strong style="font-family: Arial;font-size: 14px;">MUTHA FOUNDERS PVT.LTD.<br/> 
MIS Batch Production From (&nbsp;<%=frDATE%> to <%=toDATE%>&nbsp;)
</strong>
<br/>
<strong style="font-family: Arial;font-size: 13px;"><a href=" MIS_SummaryDetails_FND.jsp?comp=<%=comp %>&ondate=<%=todate %>&db=<%=db %>" style="text-decoration: none;">&lArr;BACK</a>
</strong>    
<div> 
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

			<div class="div_horizontalscroll" onmouseover="this.style.cursor='pointer'">
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
 ArrayList prddate = new  ArrayList(); 
 Connection con = ConnectionUrl.getFoundryFMShopConnection();
 CallableStatement batch = con.prepareCall("{call Sel_RptBatchProduction(?,?,?,?)}");
	batch.setString(1, comp);
	batch.setString(2, fromdate);
	batch.setString(3, todate); 
	batch.setString(4, db); 
	ResultSet rabatch = batch.executeQuery();
	while(rabatch.next()){
		if(rabatch.getString("MAT_CODE").equalsIgnoreCase("1011400003")){
		prddate.add(rabatch.getString("TRAN_DATE"));		
		}
	}
	batch.close();
	rabatch.close();

 %> 
			<table id="t1" border="1" cellpadding=2 style="border: 1px solid #000;">  
				<tr> 
					<th class="th" colspan="6">Batch Production</th>    
				</tr>
				<tr>
					<th class="th">Prod. Date</th>
					<th class="th">Batch No.</th>
					<th class="th" width="45%">Material Name</th> 
					<th class="th">Qty</th>
					<th class="th">Unit</th> 
					<th class="th">Total Mixes</th> 
				</tr> 
				 
				 <%
				CallableStatement batchcs = con.prepareCall("{call Sel_RptBatchProduction(?,?,?,?)}");
				batchcs.setString(1, comp);
				batchcs.setString(2, fromdate);
				batchcs.setString(3, todate); 
				batchcs.setString(4, db); 
				ResultSet rabatchrc = batchcs.executeQuery();
				while(rabatchrc.next()){
				%>
				<tr>
					<%
					if(rabatchrc.getString("MAT_CODE").equalsIgnoreCase("1011400003")){
					%>
					<td class="td1" ><%=prddate.get(j) %></td>
					<% 
					}else{
					%>
					<td class="td1" >&nbsp;</td>
					<%
					}
					%>
					<td class="td1"  align="left"><%=rabatchrc.getString("BATCH_NO") %></td>
					<td class="td1"  align="left"><%=rabatchrc.getString("MAT_NAME") %></td>
					<td class="td1"  align="right"><%=rabatchrc.getString("QTY") %></td>
					<td class="td1"  align="right"><%=rabatchrc.getString("UNIT_CODE") %></td>
					<td class="td1"  align="right"><%=rabatchrc.getString("TOT_MIXES") %></td>
				</tr>
				<%
				}
				%>
			</table>
<%
//System.out.println("Update = " + DayWIseSum);
con.close();
} catch (Exception e) {
e.printStackTrace();
e.getMessage();
}
%>
		</div>
		<br> <br>
	</div>
<script type="text/javascript">
		var freezeRow = 2; //change to row to freeze at
		var freezeCol = 7; //change to column to freeze at
		var myRow = freezeRow;
		var myCol = freezeCol;
		var speed = 100; //timeout speed for freez column
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