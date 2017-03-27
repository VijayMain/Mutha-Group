<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<span id="MyApproval">
<%
try{
Connection con =null;  
String comp =request.getParameter("comp");
String sup =request.getParameter("sup"); 
String from =request.getParameter("fromdate");
String to =request.getParameter("todate");
String tick_flag =request.getParameter("flag"); 
String flag_close =request.getParameter("flag_close");
String poDate="";

 

String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);

DecimalFormat twoDForm = new DecimalFormat("###0.00");
DecimalFormat noDForm = new DecimalFormat("####0");
 
int ct=0;
String CompanyName="";  
if(comp.equalsIgnoreCase("101")){
	CompanyName = "H-21 MUTHA ENGINEERING";
	con = ConnectionUrl.getMEPLH21ERP();   
}
if(comp.equalsIgnoreCase("102")){
	CompanyName = "H-25 MUTHA ENGINEERING";
	con	= ConnectionUrl.getMEPLH25ERP(); 
} 
if(comp.equalsIgnoreCase("103")){
	CompanyName = "MUTHA FOUNDERS PVT. LTD.";
	con = ConnectionUrl.getFoundryERPNEWConnection();   
}
if(comp.equalsIgnoreCase("105")){	
	CompanyName = "DHANASHREE INDUSTRIES";
	con=ConnectionUrl.getDIERPConnection();
}
if(comp.equalsIgnoreCase("106")){
	CompanyName = "MUTHA ENGINEERING UNIT III";
	con = ConnectionUrl.getK1ERPConnection();
}
String supName="";
PreparedStatement pssup=con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE=12");
ResultSet rssup=pssup.executeQuery();
 while(rssup.next()){
	 if(rssup.getString("SUB_GLACNO").equalsIgnoreCase(sup)){
		 supName = rssup.getString("SUBGL_LONGNAME");
	 }
 }
%>
	<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName %>&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;">Party Wise Purchase Order from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</strong>
	<br />
<%
if(comp.equalsIgnoreCase("101") || comp.equalsIgnoreCase("102")){
%>
	<strong style="font-family: Arial; font-size: 13px;"><a href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;
<%
}else{
%>
<strong style="font-family: Arial; font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;
<%
}
%>
<input type="checkbox" name="approved" id="approved" onclick="ApprovedOrder('<%=comp%>','<%=sup%>','<%=from%>','<%=to%>')"><strong style="font-size: 10px;">Approved</strong> 
<input type="checkbox" name="closed" id="closed"><strong style="font-size: 10px;">Closed</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	<span id="exportId">
		<button id="filebutton"
			onclick="getExcel_Report('<%=comp%>','<%=sup%>','<%=from%>','<%=to%>')"
			style="cursor: pointer; font-family: Arial; font-size: 12px;">Generate
			Excel</button> <img alt="#" src="images/fileload.gif" id="fileloading"
		style="visibility: hidden;" />
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
			style="width: 96%; border: 1px solid #000;">
			
		<!--  PO NO.	PO DATE	Amd 	wef	Sr No	DHANASHREE IND.	Wgt kgs	Rs/kg	Rs/Pc No. -->						
			
			<tr style="font-size: 12px; font-family: Arial;">
				<th scope="col" class="th" width="5%">PO NO.</th>
				<th scope="col" class="th">PO DATE</th>
				<th scope="col" class="th">Amend No</th>
				<th scope="col" class="th">With Effect From</th>
				<th scope="col" class="th">Sr No</th>
				<th scope="col" class="th"><%=supName %></th>
				<th scope="col" class="th">Wgt kgs</th>
				<th scope="col" class="th">Rs/kg</th>
				<th scope="col" class="th">Rs/Pc</th>
			</tr>
			<%
			// exec "ENGERP"."dbo"."Sel_RptPartyWsPurchOrderRegister";1  '101', '0', '4031,4032', '20140401', '20150313', 0, '101120238'
 	CallableStatement cs11 = con.prepareCall("{call Sel_RptPartyWsPurchOrderRegister(?,?,?,?,?,?,?)}");
	cs11.setString(1,comp);
	cs11.setString(2,"0");
	cs11.setString(3,"4031,4032");
	cs11.setString(4,from);
	cs11.setString(5,to);
	cs11.setString(6,"0");
	cs11.setString(7,sup);
	ResultSet rs = cs11.executeQuery();
while(rs.next()){
poDate = rs.getString("AMEND_DATE").substring(6,8) +"/"+ rs.getString("AMEND_DATE").substring(4,6) +"/"+ rs.getString("AMEND_DATE").substring(0,4);
if((rs.getString("STATUS_CODE").equalsIgnoreCase("0") && tick_flag=="true") && 
   ((rs.getString("STATUS_CODE").equalsIgnoreCase("11") || rs.getString("STATUS_CODE").equalsIgnoreCase("12")) && flag_close=="true")){
	System.out.println("Status Code = " + rs.getString("STATUS_CODE"));
 %>
			<tr style="font-size: 10px;">
			 	<td width="6%" align="right"><%=rs.getString("TRNNO").substring(3, 7)%> <b>-</b> <%=rs.getString("PO_NO") %></td>
			 	<td align="right"><%=poDate%></td>
			 	<td align="right"><%=rs.getString("AMEND_NO") %></td>
			 	<td><%=rs.getString("REMRK") %></td>
			 	<td align="right"><%=rs.getString("SR_NO") %></td>
			 	<td width="40%"><%=rs.getString("MAT_NAME") %></td>
			 	<td align="right"><%=rs.getString("WEIGHT") %></td>
			 	<td align="right"><%=rs.getString("REJ_RATE") %></td> 
			 	<td align="right"><%=rs.getString("RATE") %></td> 
			</tr>
	<%
		}
		if((rs.getString("STATUS_CODE").equalsIgnoreCase("0") && tick_flag=="true") && flag_close=="false"){
			System.out.println("Status Code = " + rs.getString("STATUS_CODE"));
    %>
					<tr style="font-size: 10px;">
					 	<td width="6%" align="right"><%=rs.getString("TRNNO").substring(3, 7)%> <b>-</b> <%=rs.getString("PO_NO") %></td>
					 	<td align="right"><%=poDate%></td>
					 	<td align="right"><%=rs.getString("AMEND_NO") %></td>
					 	<td><%=rs.getString("REMRK") %></td>
					 	<td align="right"><%=rs.getString("SR_NO") %></td>
					 	<td width="40%"><%=rs.getString("MAT_NAME") %></td>
					 	<td align="right"><%=rs.getString("WEIGHT") %></td>
					 	<td align="right"><%=rs.getString("REJ_RATE") %></td>
					 	<td align="right"><%=rs.getString("RATE") %></td>
					</tr>
	<%
		}
		if(tick_flag=="false" && ((rs.getString("STATUS_CODE").equalsIgnoreCase("11") || rs.getString("STATUS_CODE").equalsIgnoreCase("12")) && flag_close=="true")){
			System.out.println("Status Code = " + rs.getString("STATUS_CODE"));
				 %>
							<tr style="font-size: 10px;">
							 	<td width="6%" align="right"><%=rs.getString("TRNNO").substring(3, 7)%> <b>-</b> <%=rs.getString("PO_NO") %></td>
							 	<td align="right"><%=poDate%></td>
							 	<td align="right"><%=rs.getString("AMEND_NO") %></td>
							 	<td><%=rs.getString("REMRK") %></td>
							 	<td align="right"><%=rs.getString("SR_NO") %></td>
							 	<td width="40%"><%=rs.getString("MAT_NAME") %></td>
							 	<td align="right"><%=rs.getString("WEIGHT") %></td>
							 	<td align="right"><%=rs.getString("REJ_RATE") %></td> 
							 	<td align="right"><%=rs.getString("RATE") %></td> 
							</tr>
	<%
		}
		if(tick_flag=="false" && flag_close=="false"){
			System.out.println("Status Code = " + rs.getString("STATUS_CODE"));
	%>
							<tr style="font-size: 10px;">
							 	<td width="6%" align="right"><%=rs.getString("TRNNO").substring(3, 7)%> <b>-</b> <%=rs.getString("PO_NO") %></td>
							 	<td align="right"><%=poDate%></td>
							 	<td align="right"><%=rs.getString("AMEND_NO") %></td>
							 	<td><%=rs.getString("REMRK") %></td>
							 	<td align="right"><%=rs.getString("SR_NO") %></td>
							 	<td width="40%"><%=rs.getString("MAT_NAME") %></td>
							 	<td align="right"><%=rs.getString("WEIGHT") %></td>
							 	<td align="right"><%=rs.getString("REJ_RATE") %></td> 
							 	<td align="right"><%=rs.getString("RATE") %></td> 
							</tr>
	<%
		}
	  }
	%>
</table>
<%
// System.out.println("Update = " + DayWIseSum);
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
		var freezeCol = 7; //change to column to freeze at
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
</span>
</body>
</html>