<%@page import="java.text.DecimalFormat"%>
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
<script language="JavaScript"> 
var nHist = window.history.length;
if(window.history[nHist] != window.location)
  window.history.forward(); 
</script> 
<title>POTWISE Details K-1</title>
<style type="text/css">
.tftable {
	font-size: 10px;
	font-family: Arial; 
	color: #333333;
	width: 80%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
	text-align: center;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 10px;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
}
</style>
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
Connection con = ConnectionUrl.getK1FMShopConnection();
String comp =request.getParameter("comp");
String datefrom =request.getParameter("datefrom");
String dateto =request.getParameter("dateto");
String db =request.getParameter("db");
String pot =request.getParameter("pot"); 
String date_From = datefrom.substring(6,8) +"/"+ datefrom.substring(4,6) +"/"+ datefrom.substring(0,4);
String date_To = dateto.substring(6,8) +"/"+ dateto.substring(4,6) +"/"+ dateto.substring(0,4); 

DecimalFormat zeroDForm = new DecimalFormat("###,##0");

%>
<div>
<strong style="color: blue;font-family: Arial;font-size: 14px;">MUTHA ENGINEERING PVT.LTD.UNIT III&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Detailed <%=pot %> Production from <%=date_From %> to <%=date_To %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>
<strong style="font-family: Arial;font-size: 13px;"><a href="PotwiseReportK1.jsp?comp=<%=comp %>&datefrom=<%=datefrom %>&dateto=<%= dateto%>&db=<%=db %>&code=652" style="text-decoration: none;">&lArr;BACK</a></strong>
<% 
	int srno=1; 
	CallableStatement cs = con.prepareCall("{call Sel_RptFurnaceWiseProd(?,?,?,?)}");
 	cs.setString(1, comp);
 	cs.setString(2, "652");
	cs.setString(3, datefrom);
	cs.setString(4, dateto); 
	ResultSet rs1 = cs.executeQuery(); 
 %>  
			<table border="1" class="tftable" style="width: 40%"> 
				<tr> 
					<th scope="col">Furnace Name</th>
					<th scope="col">Capacity (Kg)</th>
					<th scope="col">Todays Qty</th>
					<th scope="col">Cumulative Qty</th>  
				</tr>
				<%
				 while(rs1.next()){ 
					if(rs1.getString("FUR_NAME").equalsIgnoreCase(pot)){
				%>
				<tr align="center" style="background-color: #FFFFFF;cursor: pointer;" align="center">
					<td align="center"><strong><%=rs1.getString("FUR_NAME") %></strong> </td> 
					<td align="center"><strong> <%=rs1.getString("CAPACITY") %></strong> </td>
					<td align="center"><strong> <%=zeroDForm.format(Double.parseDouble(rs1.getString("TODAY_QTY"))) %></strong> </td>			
					<td align="center"><strong> <%=zeroDForm.format(Double.parseDouble(rs1.getString("CUMULATIVE_QTY"))) %></strong> </td>					 
				</tr>
				<%
				 }
				 }
				%> 
			</table> 
 
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
				<div style="float: left; width: 50%; height: 100%;" onmousedown="right();" onmouseup="right(1);">
					<img class="buttonRight" src="images/left.png">
				</div>
				<div style="float: right; width: 50%; height: 100%;" onmousedown="left();" onmouseup="left(1);">
					<img class="buttonLeft" src="images/forward.png">
				</div>
			</div>
			
			
			<table id="t1" border="1" cellpadding=2 style="width:90%; border: 1px solid #000;">  
				<tr>  		
					<th class="th">Sr. No</th>
					<th class="th">Date</th>
					<th class="th">Shift</th>
					<th class="th">Item Name</th>
					<th class="th">OK Qty</th>
					<th class="th">Rejected Qty</th>  
					<th class="th">Power ON time </th>  
					<th class="th">Power OFF time </th>  
				</tr>  
			<% 
				String dateForm = "";
				int srNo=1;
				CallableStatement cs_details = con.prepareCall("{call Sel_RptDailyProducion(?,?,?,?,?)}");
			  	cs_details.setString(1, comp);
			 	cs_details.setString(2, "123");
				cs_details.setString(3, datefrom);
				cs_details.setString(4, dateto); 
				cs_details.setString(5, db);  
				ResultSet rs_details = cs_details.executeQuery(); 
				while(rs_details.next()){
					if(rs_details.getString("MATERIAL_TYPE").equalsIgnoreCase("101") && pot.equalsIgnoreCase(rs_details.getString("FURNACE_NAME"))){
					dateForm = rs_details.getString("TRAN_DATE").substring(6,8) +"/"+ rs_details.getString("TRAN_DATE").substring(4,6) +"/"+ rs_details.getString("TRAN_DATE").substring(0,4); 
				%>
			<tr onmouseover="this.style.background='#EEEEEE';" onmouseout="this.style.background='';" >
					<td class="td1" align="center"><%=srNo%> </td>
					<td class="td1" align="right"><%=dateForm%> </td>
					<td class="td1" align="center"><%=rs_details.getString("SHIFT")%> </td> 
					<td class="td1" align="left"><%=rs_details.getString("MAT_NAME")%>  </td>
					<td class="td1" align="right"><%=zeroDForm.format(Double.parseDouble(rs_details.getString("OK_QTY")))%></td>
					<td class="td1" align="right"><%=zeroDForm.format(Double.parseDouble(rs_details.getString("REJECT_QTY")))%></td>
					<td class="td1" align="right"><%=rs_details.getString("POWER_ON_TIME")%>  </td>
					<td class="td1" align="right"><%=rs_details.getString("POWER_OFF_TIME")%>  </td> 
				</tr>
				<%
				srNo++;
					}
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
		var freezeRow = 1; //change to row to freeze at
		var freezeCol = 8; //change to column to freeze at
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