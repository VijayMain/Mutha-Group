<%@page import="java.text.Normalizer.Form"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
<html>
<head>
<script language="JavaScript"> 
var nHist = window.history.length;
if(window.history[nHist] != window.location)
  window.history.forward(); 
</script>
<title>Party Wise Purchase Order</title>
<STYLE TYPE="text/css" MEDIA=all>
.td1 {
	font-size: 10px;
	border-width: 1px;
	border-style: solid;
	border-color: #729ea5;
}

.tftable tr {
font-family:Arial;
	background-color: white;
	font-size: 10px;
}

.th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 8px;
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
	font-size: 10px;
	position: relative;
	width: 99%;
	height: 550px;
	overflow: hidden;
	background: #fff;
	border-style: ridge;
}

.div_verticalscroll {
	font-size: 10px;
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
	font-size: 10px;
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
<script type="text/javascript">
	function getExcel_Report(comp,sup,from,to) {
		document.getElementById("fileloading").style.visibility = "visible";
		document.getElementById("filebutton").disabled = true; 
		var xmlhttp;
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("exportId").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Vendor_BoringReceipt_xls.jsp?comp=" + comp +"&sup="+sup+"&from="+from+"&to="+to, true);
		xmlhttp.send();
	};
</script>
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
	<%
try{
Connection con =null;  
String comp =request.getParameter("comp");
String sup =request.getParameter("sup"); 
String from =request.getParameter("fromdate");
String to =request.getParameter("todate");  

ArrayList check_list = new ArrayList();

String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);

DecimalFormat twoDForm = new DecimalFormat("###0.00");
DecimalFormat noDForm = new DecimalFormat("####0");

String CompanyName="";  
if(comp.equalsIgnoreCase("101")){
	CompanyName = "H-21";
	con = ConnectionUrl.getMEPLH21ERP();   
}
if(comp.equalsIgnoreCase("102")){
	CompanyName = "H-25";
	con	= ConnectionUrl.getMEPLH25ERP(); 
}
%>
	<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName %>&nbsp;MUTHA ENGINEERING PVT.LTD.
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;">Vendor Boring Receipt Report of&nbsp;<%=sup %>&nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %>
		&nbsp;&nbsp;&nbsp;
	</strong>
	<br />

	<strong style="font-family: Arial; font-size: 13px;"><a
		href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	<span id="exportId">
		<button id="filebutton"  onclick="getExcel_Report('<%=comp%>','<%=sup%>','<%=from%>','<%=to%>')"
			style="cursor: pointer; font-family: Arial; font-size: 12px;">Generate Excel</button> <img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;" />
	</span>

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
		<table id="t1" class="t1" border="1"
			style="width: 90%; border: 1px solid #000;">
			
		<!--  PRN_TRANDATE	 GRN_NO	CHLNNO	CHLNDATE	INWNO	CHLN_QTY	MATNAME  -->						
			
			<tr style="font-size: 12px; font-family: Arial;">
			<%
			if(sup.equalsIgnoreCase("All_Suppliers")){
			%>
			<th scope="col" class="th" width="30%">Suppliers Name</th>
			<%
			}
			%>
			<th scope="col" class="th" width="30%">Item Name</th>
			<th scope="col" class="th">GRN Date</th>
			<th scope="col" class="th" width="7%">GRN NO.</th> 
			<th scope="col" class="th">Challan No</th> 
			<th scope="col" class="th">Challan Date</th> 	
			<th scope="col" class="th">Gate IN No</th> 
			<th scope="col" class="th">Challan Qty</th> 
			</tr>
	<%
	//  exec "ENGERP"."dbo"."Sel_BoringRegister";1 '101', '0', '20140401', '20150223', '103,131'
	
 	CallableStatement cs = con.prepareCall("{call Sel_BoringRegister(?,?,?,?,?)}");
	cs.setString(1,comp);
	cs.setString(2,"0");
	cs.setString(3,from);
	cs.setString(4,to);
	cs.setString(5,"103,131"); 
	 
	ResultSet rs = null; 
	
if(sup.equalsIgnoreCase("All_Suppliers")){
	
	ResultSet rs_check = cs.executeQuery();
	while(rs_check.next()){
	check_list.add(rs_check.getString("AC_NAME"));	
	}
	rs_check.close(); 
	
	HashSet hs = new HashSet();
	hs.addAll(check_list);
	check_list.clear();
	check_list.addAll(hs); 
	
	for(int i=0;i<check_list.size();i++){
	rs = cs.executeQuery();
	while(rs.next()){
		if(rs.getString("AC_NAME").equalsIgnoreCase(check_list.get(i).toString())){
 %> 
		<tr style="font-family:Arial; font-size: 10px;">
		 
			<td align="left"><%= rs.getString("AC_NAME") %></td>		 
			<td align="left"><%= rs.getString("MATNAME") %></td>
			<td align="right"><%= rs.getString("PRN_TRANDATE") %></td>
			<td align="right"><%= rs.getString("GRN_NO") %></td> 
			<td align="right"><%= rs.getString("CHLNNO") %></td> 
			<td align="right"><%= rs.getString("CHLNDATE") %></td> 
			<td align="right"><%= rs.getString("INWNO") %></td>  
			<td align="right"><%= rs.getString("CHLN_QTY") %></td> 
		</tr>
	<%		 
			}
		}
	}
}else{
	rs = cs.executeQuery();
while(rs.next()){
	if(sup.equalsIgnoreCase(rs.getString("AC_NAME"))){
%>
		<tr style="font-family:Arial; font-size: 10px;">
		<td align="left"><%= rs.getString("MATNAME") %></td>
		<td align="right"><%= rs.getString("PRN_TRANDATE") %></td>
		<td align="right"><%= rs.getString("GRN_NO") %></td>
		<td align="right"><%= rs.getString("CHLNNO") %></td> 
		 <td align="right"><%= rs.getString("CHLNDATE") %></td> 
		<td align="right"><%= rs.getString("INWNO") %></td>  
		 <td align="right"><%= rs.getString("CHLN_QTY") %></td> 
		</tr>
<%		 
		}
	}
}
%>
	 
		</table>
<%
con.close();
} catch (Exception e) {
e.printStackTrace();
e.getMessage();
}
%>
	</div>
	<br>
	<br>
	<script type="text/javascript">
		var freezeRow = 1; //change to row to freeze at
		var freezeCol = 8; //change to column to freeze at
		var myRow = freezeRow;
		var myCol = freezeCol;
		var speed = 130; //timeout speed for freez column
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