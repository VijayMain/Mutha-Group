<%@page import="java.text.DateFormatSymbols"%>
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
<title>Category Wise Outstanding</title>
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
	width: 98%;
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
<script type="text/javascript">
	function getExcel_Report(comp,from) { 
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
		xmlhttp.open("POST", "Outstanding_xls.jsp?comp=" + comp +"&from="+from, true);
		xmlhttp.send();
	};
</script>
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
<% 
try { //response.sendRedirect("Categorywise_Outstanding.jsp?comp="+company+"&ondate="+OnDateMIS);
Connection con = null;
String comp =request.getParameter("comp");
 

String datefrom =request.getParameter("ondate");
String date_From = datefrom.substring(6,8) +"/"+ datefrom.substring(4,6) +"/"+ datefrom.substring(0,4);
String nameComp="",code="1010011101000210100141010008101001510100091010006101000310100121010007101000110100161010005101001010100041010013";



DecimalFormat zeroDForm = new DecimalFormat("###,##0");
DecimalFormat twoDForm = new DecimalFormat("###,##0.00");

String datetab = datefrom.substring(4,6);
String[] mm = new DateFormatSymbols().getMonths();
 int tab = Integer.parseInt(datetab);
 int taby = Integer.parseInt(datefrom.substring(0,4));
 ArrayList monthlist = new ArrayList();
 for(int s=0;s<6;s++){
		if(tab==0){
			tab = 12;
			taby = taby-1;
			// System.out.println("Months 111 = " + mm[tab-1]+" year = " + taby);
			monthlist.add(mm[tab-1]+taby);
 			
		}else{
			// System.out.println("Months 222 = " + mm[tab-1]+" year = " + taby);
			monthlist.add(mm[tab-1]+taby);
		}
		tab--; 
 }
 Collections.reverse(monthlist);
		  
 
if(comp.equalsIgnoreCase("103")){
	con = ConnectionUrl.getFoundryERPNEWConnection(); 
	nameComp = "MUTHA FOUNDERS PVT.LTD.";
}
if(comp.equalsIgnoreCase("105")){
	con = ConnectionUrl.getDIERPConnection();
	nameComp = "DHANASHREE INDUSTRIES";
}
if(comp.equalsIgnoreCase("106")){
	con = ConnectionUrl.getK1ERPConnection(); 
	nameComp = "MUTHA ENGINEERING PVT.LTD.UNIT III ";
}
if(comp.equalsIgnoreCase("101")){
	con = ConnectionUrl.getMEPLH21ERP();
	nameComp = "H21 MUTHA ENGINEERING PVT.LTD.";
}
if(comp.equalsIgnoreCase("102")){
	con = ConnectionUrl.getMEPLH25ERP();
	nameComp = "H25 MUTHA ENGINEERING PVT.LTD.";
}
if(comp.equalsIgnoreCase("111")){
	con = ConnectionUrl.getENGH25CONSConnection();
	nameComp = "MEPL H21 & MEPL H25 Consolidated";
}
%>
<div> 
<strong style="color: blue;font-family: Arial;font-size: 14px;"><%=nameComp %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Category Wise Outstanding As on <%=date_From %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>
<strong style="font-family: Arial;font-size: 13px;">
<%
if(comp.equalsIgnoreCase("101") || comp.equalsIgnoreCase("102") || comp.equalsIgnoreCase("111")){
%>
<a href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a>
<%
}else{
%>
<a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a>
<%	
}
%>
</strong>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span id="exportId"> 
<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=datefrom%>')" style="cursor: pointer;font-family: Arial;font-size: 10px;height: 20px;">Generate Excel</button>
<img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;"/>
</span>
<%  
	int srno=1; 
	double otsum = 0;
	CallableStatement cs = con.prepareCall("{call Sel_RptOutstanding(?,?,?,?,?,?)}");
	
	if(comp.equalsIgnoreCase("111")){
 	cs.setString(1, "0");
 	cs.setString(2, "0");
	cs.setString(3, code);
	cs.setString(4, datefrom); 
	cs.setString(5, "0"); 
	cs.setString(6, "0"); 
	}else{
		cs.setString(1, comp);
	 	cs.setString(2, "0");
		cs.setString(3, code);
		cs.setString(4, datefrom); 
		cs.setString(5, "0"); 
		cs.setString(6, "0");
	}
	
	
	ResultSet rs1 = cs.executeQuery();
 %>  
			  
 
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
			
			
			<table id="t1" border="1" cellpadding=2 style="width:95%; border: 1px solid #000;">  
				<tr align="center">
					<th class="th">Sr. No</th>
					<th class="th" width="35%">Name Of The Party</th>
					<%
					for(int ot=0;ot<monthlist.size();ot++){
						if(ot==0){
					%>
					<th class="th">Before <%=monthlist.get(ot).toString() %><br>Amount </th>
					<%		
						}
					%> 
					<th class="th"><%=monthlist.get(ot).toString() %><br>Amount</th>  
					<%
					}
					%>
					<th class="th">Total<br>Amount</th>
				</tr> 
				<%
				double add1=0;
				while(rs1.next()){
				%>
				<tr align="center" style="background-color: #FEFCFF;cursor: pointer;font-family: Arial;font-size: 10px;" align="center">
					<td align="center"><strong><%=srno %> </strong> </td>
					<td align="left"><strong><%=rs1.getString("SUPP_NAME") %> </strong> </td>  
					<td nowrap style="font-family: Arial;font-size: 10px;" align="right"><%=twoDForm.format(Double.parseDouble(rs1.getString("B4CurAMOUNT_6")))%></td>
					<%
					add1 = Double.parseDouble(rs1.getString("B4CurAMOUNT_6"))+Double.parseDouble(rs1.getString("CurAMOUNT_5"));
					%>
					<td nowrap style="font-family: Arial;font-size: 10px;" align="right"><%=twoDForm.format(add1)%></td>
					<%
					add1 = add1 + Double.parseDouble(rs1.getString("CurAMOUNT_4"));
					%>
					<td nowrap style="font-family: Arial;font-size: 10px;" align="right"><%=twoDForm.format(add1)%></td>
					<%
					add1 = add1 + Double.parseDouble(rs1.getString("CurAMOUNT_3"));
					%>
					<td nowrap style="font-family: Arial;font-size: 10px;" align="right"><%=twoDForm.format(add1)%></td>
					<%
					add1 = add1 + Double.parseDouble(rs1.getString("CurAMOUNT_2"));
					%>
					<td nowrap style="font-family: Arial;font-size: 10px;" align="right"><%=twoDForm.format(add1)%></td>
					<%
					add1 = add1 + Double.parseDouble(rs1.getString("CurAMOUNT_1"));
					%> 	
					<td nowrap style="font-family: Arial;font-size: 10px;" align="right"><%=twoDForm.format(add1)%></td>
					<%
					add1 = add1 + Double.parseDouble(rs1.getString("CurAMOUNT"));
					%>
					<td nowrap style="font-family: Arial;font-size: 10px;" align="right"><%=twoDForm.format(add1)%></td>
					<%
					otsum = 
					 Double.parseDouble(rs1.getString("B4CurAMOUNT_6"))+
					 Double.parseDouble(rs1.getString("CurAMOUNT_5"))+
					 Double.parseDouble(rs1.getString("CurAMOUNT_4"))+
					 Double.parseDouble(rs1.getString("CurAMOUNT_3"))+
					 Double.parseDouble(rs1.getString("CurAMOUNT_2"))+
					 Double.parseDouble(rs1.getString("CurAMOUNT_1"))+
					 Double.parseDouble(rs1.getString("CurAMOUNT"));					
					%>
					<td nowrap style="font-family: Arial;font-size: 10px;" align="right"><%=twoDForm.format(otsum)%></td>					 				 
				</tr>
				<%
				srno++;
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
		var freezeCol = 2; //change to column to freeze at
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