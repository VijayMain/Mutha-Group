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
<title>Inter Company Sale MIS</title> 
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
	height: 0;
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
<script language="JavaScript"> 
var nHist = window.history.length;
if(window.history[nHist] != window.location)
  window.history.forward(); 
</script> 
<body bgcolor="#DEDEDE" style="font-family: Arial;">
<%    
try{ 
Connection con = null;
DecimalFormat twoDForm = new DecimalFormat("0.00"); 
String comp = request.getParameter("comp");
String reportof = request.getParameter("reportof");
String from_date = request.getParameter("fromDate");
String to_date = request.getParameter("toDate");

String itemCode = "";

String RootComp = "";
String ChildComp = "";

if(comp.equalsIgnoreCase("101")){
	
	con = ConnectionUrl.getMEPLH21ERP();
	// H21_toH25 H21_tomfpl H21_todi H21_tounitIII 
if(reportof.equalsIgnoreCase("H21_toH25")){
	itemCode = "101110205";
		RootComp = "H21 Mutha Engineering Pvt Ltd";
		ChildComp = "H25 Mutha Engineering Pvt Ltd";
}
if(reportof.equalsIgnoreCase("H21_tomfpl")){
	itemCode = "101110070101110032101110060101110100";
	RootComp = "H21 Mutha Engineering Pvt Ltd";
	ChildComp = "Mutha Founders Pvt Ltd";
	}
if(reportof.equalsIgnoreCase("H21_todi")){
	itemCode = "101110012101110084";
	RootComp = "H21 Mutha Engineering Pvt Ltd";
	ChildComp = "DHANASHREE INDUSTRIES";
}
if(reportof.equalsIgnoreCase("H21_tounitIII")){
	itemCode = "101110347";
	RootComp = "H21 Mutha Engineering Pvt Ltd";
	ChildComp = "MUTHA ENGINEERING PVT.LTD.UNIT III";
}
}


// H25_toH21 H25_tomfpl H25_todi H25_tok1
if(comp.equalsIgnoreCase("102")){
	 
	con = ConnectionUrl.getMEPLH25ERP();
	if(reportof.equalsIgnoreCase("H25_toH21")){
		itemCode = "101110054101110233101110100101110069";
		RootComp = "H25 Mutha Engineering Pvt Ltd";
		ChildComp = "H21 Mutha Engineering Pvt Ltd";
}
if(reportof.equalsIgnoreCase("H25_tomfpl")){
	itemCode = "101110070101110032101110060101110100";
	RootComp = "H25 Mutha Engineering Pvt Ltd";
	ChildComp = "Mutha Founders Pvt Ltd";
	}
if(reportof.equalsIgnoreCase("H25_todi")){
	itemCode = "101110012101110084";
	RootComp = "H25 Mutha Engineering Pvt Ltd";
	ChildComp = "DHANASHREE INDUSTRIES";
}
if(reportof.equalsIgnoreCase("H25_tok1")){
	itemCode = "101110347";
	RootComp = "H25 Mutha Engineering Pvt Ltd";
	ChildComp = "MUTHA ENGINEERING PVT.LTD.UNIT III";
}
}
// mfpl_toH21 mfpl_toH25 mfpl_todi mfpl_tounitIII
if(comp.equalsIgnoreCase("103")){
 
	con = ConnectionUrl.getFoundryERPNEWConnection(); 
	if(reportof.equalsIgnoreCase("mfpl_toH21")){
		itemCode = "101110054101110233101110100101110069";
		RootComp = "Mutha Founders Pvt Ltd";
		ChildComp = "H21 Mutha Engineering Pvt Ltd";
}
if(reportof.equalsIgnoreCase("mfpl_toH25")){
	itemCode = "101110205";
	RootComp = "Mutha Founders Pvt Ltd";
	ChildComp = "H25 Mutha Engineering Pvt Ltd";
	}
if(reportof.equalsIgnoreCase("mfpl_todi")){
	itemCode = "101110012101110084";
	RootComp = "Mutha Founders Pvt Ltd";
	ChildComp = "DHANASHREE INDUSTRIES";
}
if(reportof.equalsIgnoreCase("mfpl_tounitIII")){
	itemCode = "101110347";
	RootComp = "Mutha Founders Pvt Ltd";
	ChildComp = "MUTHA ENGINEERING PVT.LTD.UNIT III";
}
}


	// di_toH21 di_toH25 di_tomfpl di_tounitIII
if(comp.equalsIgnoreCase("105")){ 
	con = ConnectionUrl.getDIERPConnection();
	if(reportof.equalsIgnoreCase("di_toH21")){
		itemCode = "101110054101110233101110100101110069";
		RootComp = "DHANASHREE INDUSTRIES";
		ChildComp = "H21 Mutha Engineering Pvt Ltd";
}
if(reportof.equalsIgnoreCase("di_toH25")){
	itemCode = "101110205";
	RootComp = "DHANASHREE INDUSTRIES";
	ChildComp = "H25 Mutha Engineering Pvt Ltd";
	}
if(reportof.equalsIgnoreCase("di_tomfpl")){
	itemCode = "101110070101110032101110060101110100";
	RootComp = "DHANASHREE INDUSTRIES";
	ChildComp = "Mutha Founders Pvt Ltd";
}
if(reportof.equalsIgnoreCase("di_tounitIII")){
	itemCode = "101110347";
	RootComp = "DHANASHREE INDUSTRIES";
	ChildComp = "MUTHA ENGINEERING PVT.LTD.UNIT III";
}
}
	
	
	// k1_toH21 k1_toH25 k1_tomfpl k1_todi
if(comp.equalsIgnoreCase("106")){
 
	con = ConnectionUrl.getK1ERPConnection();
	if(reportof.equalsIgnoreCase("k1_toH21")){
		itemCode = "101110054101110233101110100101110069";
		RootComp = "MUTHA ENGINEERING PVT.LTD.UNIT III";
		ChildComp = "H21 Mutha Engineering Pvt Ltd";
}
if(reportof.equalsIgnoreCase("k1_toH25")){
	itemCode = "101110205";
	RootComp = "MUTHA ENGINEERING PVT.LTD.UNIT III";
	ChildComp = "H25 Mutha Engineering Pvt Ltd";
	}
if(reportof.equalsIgnoreCase("k1_tomfpl")){
	itemCode = "101110070101110032101110060101110100";
	RootComp = "MUTHA ENGINEERING PVT.LTD.UNIT III";
	ChildComp = "Mutha Founders Pvt Ltd";
}
if(reportof.equalsIgnoreCase("k1_todi")){
	itemCode = "101110012101110084";
	RootComp = "MUTHA ENGINEERING PVT.LTD.UNIT III";
	ChildComp = "DHANASHREE INDUSTRIES";
}
}
	String dateFrom =  from_date.substring(6,8)+"/"+ from_date.substring(4,6) +"/"+ from_date.substring(0,4);
	String dateTo =  to_date.substring(6,8)+"/"+ to_date.substring(4,6) +"/"+ to_date.substring(0,4);
	
	DecimalFormat myFormatter = new DecimalFormat("###,##0");
	DecimalFormat mytotals = new DecimalFormat("###,##0.00"); 
	
%>  
<div>
<strong style="color: blue;font-family: Arial;font-size: 14px;"><%=RootComp %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Sale Summary Report from <%=dateFrom %> to <%=dateTo %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>
<strong style="font-family: Arial;font-size: 13px;"><a href="InterCompany_Sale.jsp?FromDate_ICS=<%=from_date %>&ToDate_ICS=<%=to_date %>" style="text-decoration: none;">&lArr;BACK</a></strong>
 </div> 
 
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
	 
//***********************************************************************************************************
	// System.out.println("All  = " + dayUpdate); 
%> 
			<table id="t1" border="1" cellpadding=2 style="border: 1px solid #000; width: 80%"> 
				<tr align="center">
					<th class="th" style="width: 6%">Sr. No</th>
					<th class="th">Product Name</th> 
					<th class="th" width="12%">Sales Weight in MT</th>
					<th class="th" width="12%">Sales Qty</th>
					<th class="th" width="12%">Sales Amount in Lakhs</th> 
				</tr>
				<tr align="center">
					<td class="td1" colspan="5" align="left"><strong style="font-family: Arial;font-size: 13px;">Customer Name : <%=ChildComp %></strong> </td> 
				</tr>	  
				<%
				//System.out.println("Comp " + comp + "Item COde " + itemCode);
				int srno = 1;
				double amt = 0,salewt=0,saleqty=0;
				CallableStatement ps = con.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				ps.setString(1, comp);
				ps.setString(2, "0");
				ps.setString(3, itemCode);
				ps.setString(4, from_date);
				ps.setString(5, to_date);
				ResultSet rs = ps.executeQuery();
				 while(rs.next()){ 
				%>
	 			<tr onmouseover="this.style.background='#FFFFFF';" onmouseout="this.style.background='';" >
					<td class="td1" align="right"><%=srno %></td>
					<td class="td1" align="left"><%=rs.getString("PRODUCT_NAME") %></td> 
					<td class="td1" align="right"><%=twoDForm.format(Double.parseDouble(rs.getString("SALES_WEIGHT"))/1000) %></td>
					<td class="td1" align="right"><%=myFormatter.format(Double.parseDouble(rs.getString("SALES_QTY"))) %></td>
					<td class="td1" align="right"><%=mytotals.format(Double.parseDouble(rs.getString("SALES_AMOUNT"))/100000) %></td>   					 
				</tr>
				<%
				srno++;
				amt+= Double.parseDouble(rs.getString("SALES_AMOUNT"));
				salewt+= Double.parseDouble(rs.getString("SALES_WEIGHT"));
				saleqty+= Double.parseDouble(rs.getString("SALES_QTY"));
				 } 
				%>
				<tr>
					<td style="font-family: Arial;font-size: 10px;" class="td1" align="right" colspan="2"><strong>Total &#8658; </strong> </td>
					<td style="font-family: Arial;font-size: 10px;" class="td1" align="right"><strong><%=twoDForm.format(salewt/1000) %></strong></td>
					<td style="font-family: Arial;font-size: 10px;" class="td1" align="right"><strong><%=myFormatter.format(saleqty) %></strong></td> 
					<td style="font-family: Arial;font-size: 10px;" class="td1" align="right"><strong><%=mytotals.format(amt/100000) %></strong></td>
				</tr>
			</table>
<%
con.close();
} catch (Exception e) {
e.printStackTrace(); 
}
%>
		</div>
		<br> <br> 
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