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
<title>Party Wise WO OP wise</title>
<STYLE TYPE="text/css" MEDIA=all>
.td1 {
	font-size: 10px;
	border-width: 1px;
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
	function getExcel_Report1(comp,sup,from,to) {		
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
		xmlhttp.open("POST", "PartywiseWorkOrderOP_xls.jsp?comp=" + comp +"&sup="+sup+"&from="+from+"&to="+to, true);
		xmlhttp.send();
	};
	
	function getExcel_Report(comp,sup,from,to,appr,close) {
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
		xmlhttp.open("POST", "PartywiseWorkOrderOPApp_xls.jsp?comp=" + comp +"&sup="+sup+"&from="+from+"&to="+to+"&approved="+appr+"&closed="+close, true);
		xmlhttp.send();
	};

	
	function ApprovedOrder(comp,sup,from,to) {
		document.getElementById("fileloading").style.visibility = "visible";
		document.getElementById("filebutton").disabled = true;
		var xmlhttp;
		var flag = document.getElementById("approved").checked;
		var flag_close = document.getElementById("closed").checked;
 		
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("MyApproval").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "PartywsWorder_ApproveOP.jsp?comp=" + comp +"&sup="+sup+"&from="+from+"&to="+to+"&flag="+flag+"&flag_close="+flag_close, true);
		xmlhttp.send();
	};
</script>
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
<span id="MyApproval">
<%
try{
	
System.out.println("OP wise ");	
Connection con =null;
String comp =request.getParameter("comp");
String sup =request.getParameter("sup");

String from =request.getParameter("fromdate");
String to =request.getParameter("todate");
String passSuppliers = sup;
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
  

// ArrayList<String> al = new ArrayList<String>();
boolean allFlag = false;
 if(sup.equalsIgnoreCase("All_Supplier")){
	 allFlag = true;
/*  int cnt=0;
 PreparedStatement ps_sp=con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE=12");
 ResultSet rs_sp=ps_sp.executeQuery();
 while(rs_sp.next()){
	 if(cnt ==0 ){
		 sup = rs_sp.getString("SUB_GLACNO");
		 al.add(rs_sp.getString("SUB_GLACNO"));
		 cnt=1;
	 }else{
		 sup += rs_sp.getString("SUB_GLACNO");
		 al.add(rs_sp.getString("SUB_GLACNO"));
	 }
 	} */
 }else{
	 PreparedStatement ps_sp=con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLACNO='"+sup+"'");
	 ResultSet rs_sp=ps_sp.executeQuery();
	 while(rs_sp.next()){
		 sup = rs_sp.getString("SUBGL_LONGNAME");
	 }
 }
%>
	<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName %>&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;">Party Wise WO OP wise from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %>
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
<input type="checkbox" name="approved" id="approved" onclick="ApprovedOrder('<%=comp%>','<%=passSuppliers%>','<%=from%>','<%=to%>')"><strong style="font-size: 10px;">Approved</strong> 
<input type="checkbox" name="closed" id="closed" onclick="ApprovedOrder('<%=comp%>','<%=passSuppliers%>','<%=from%>','<%=to%>')"><strong style="font-size: 10px;">Closed</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	<span id="exportId">
		<button id="filebutton" onclick="getExcel_Report1('<%=comp%>','<%=passSuppliers%>','<%=from%>','<%=to%>')" style="cursor: pointer; font-family: Arial; font-size: 12px;">Generate Excel</button> <img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;" />
	</span>

	<div class="div_freezepanes_wrapper">
		<div class="div_verticalscroll" onmouseover="this.style.cursor='pointer'">
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
			style="width: 98%; border: 1px solid #000;">
			
		<!--  PO NO.	PO DATE	Amd 	wef	Sr No	DHANASHREE IND.	Wgt kgs	Rs/kg	Rs/Pc No. -->						
			
			<tr style="font-size: 12px; font-family: Arial;">
			<th scope="col" class="th" width="5%">PO NO.</th>
			<th scope="col" class="th">Amend No</th> 
			<th scope="col" class="th">PO DATE</th>
			<th scope="col" class="th">Supplier Name</th>
			<th scope="col" class="th">Part Name</th>  
				<th scope="col" class="th">Sr No</th>
				<th scope="col" class="th">Wgt kgs</th>
				<th scope="col" class="th">Boring Wgt kgs</th> 
				<th scope="col" class="th">Rs/Pc</th> 
				<th scope="col" class="th">Remark</th>
			</tr>
			<%	
// exec "ENGERP"."dbo"."Sel_RptPartyWsPurchOrderRegister";1 '101', '0', '4031,4032', '20140401', '20150313', 0, '101120238'
// exec "H25ERP"."dbo"."Sel_RptPORegister";1 '102', '0', '4038,4034,4033,4039', '20110401', '20160813', 0

 	CallableStatement cs11 = con.prepareCall("{call Sel_RptPORegister(?,?,?,?,?,?)}");
	cs11.setString(1,comp);
	cs11.setString(2,"0");
	cs11.setString(3,"4038,4039");
	cs11.setString(4,from);
	cs11.setString(5,to);
	cs11.setString(6,"0");
	ResultSet rs = cs11.executeQuery();
	
	CallableStatement cs = con.prepareCall("{call Sel_RptPORegister(?,?,?,?,?,?)}");
	cs.setString(1,comp);
	cs.setString(2,"0");
	cs.setString(3,"4038,4039");
	cs.setString(4,from);
	cs.setString(5,to);
	cs.setString(6,"11");
	ResultSet rs_close = cs.executeQuery();
	
	if(allFlag==true){
		while(rs.next()){
 %>
			 <tr style="font-size: 10px;">
			 <td width="6%" align="right"><%=rs.getString("TRNNO").substring(3, 7)%> <b>-</b> <%=rs.getString("PO_NO") %></td>
			 <td align="right"><%=rs.getString("AMEND_NO") %></td>
			 <td align="right"><%=rs.getString("PRN_PODATE")%></td>  
			 <td><%=rs.getString("SUPP_NAME") %></td>
			 <td><%=rs.getString("MAT_NAME") %></td> 
			 	<td align="right"><%=rs.getString("SR_NO") %></td>
			 	<td align="right"><%=rs.getString("WEIGHT") %></td> 
			 	<td align="right"><%=rs.getString("BORI_WEIGHT") %></td>  
			 	<td align="right"><%=rs.getString("RATE") %></td> 
			 	<td><%=rs.getString("PAY_REMRK") %></td>
			</tr>
	<%			 
		}
		while(rs_close.next()){
			 %>
						 <tr style="font-size: 10px;">
						 <td width="6%" align="right"><%=rs_close.getString("TRNNO").substring(3, 7)%> <b>-</b> <%=rs_close.getString("PO_NO") %></td>
						 <td align="right"><%=rs_close.getString("AMEND_NO") %></td>
						 <td align="right"><%=rs_close.getString("PRN_PODATE")%></td>  
						 <td><%=rs_close.getString("SUPP_NAME") %></td>
						 <td><%=rs_close.getString("MAT_NAME") %></td> 
						 	<td align="right"><%=rs_close.getString("SR_NO") %></td>
						 	<td align="right"><%=rs_close.getString("WEIGHT") %></td> 
						 	<td align="right"><%=rs_close.getString("BORI_WEIGHT") %></td>  
						 	<td align="right"><%=rs_close.getString("RATE") %></td> 
						 	<td><%=rs_close.getString("PAY_REMRK") %></td>
						</tr>
				<%			 
					}
	}else{
		while(rs.next()){
			if(sup.equalsIgnoreCase(rs.getString("SUPP_NAME"))){
		%>
			 <tr style="font-size: 10px;">
			 <td width="6%" align="right"><%=rs.getString("TRNNO").substring(3, 7)%> <b>-</b> <%=rs.getString("PO_NO") %></td>
			 <td align="right"><%=rs.getString("AMEND_NO") %></td>
			 <td align="right"><%=rs.getString("PRN_PODATE")%></td>  
						 <td><%=rs.getString("SUPP_NAME") %></td>
						 <td><%=rs.getString("MAT_NAME") %></td>
						 	<td align="right"><%=rs.getString("SR_NO") %></td>
						 	<td align="right"><%=rs.getString("WEIGHT") %></td>
						 	<td align="right"><%=rs.getString("BORI_WEIGHT") %></td>  
						 	<td align="right"><%=rs.getString("RATE") %></td> 
						 	<td><%=rs.getString("PAY_REMRK") %></td>
			</tr>
	<%
		}
		}
		
		while(rs_close.next()){
			if(sup.equalsIgnoreCase(rs_close.getString("SUPP_NAME"))){
		%>
			 <tr style="font-size: 10px;">
			 <td width="6%" align="right"><%=rs_close.getString("TRNNO").substring(3, 7)%> <b>-</b> <%=rs_close.getString("PO_NO") %></td>
			 <td align="right"><%=rs_close.getString("AMEND_NO") %></td>
			 <td align="right"><%=rs_close.getString("PRN_PODATE")%></td>  
			<td><%=rs_close.getString("SUPP_NAME") %></td>
			<td><%=rs_close.getString("MAT_NAME") %></td>
			<td align="right"><%=rs_close.getString("SR_NO") %></td>
			<td align="right"><%=rs_close.getString("WEIGHT") %></td>
			<td align="right"><%=rs_close.getString("BORI_WEIGHT") %></td>  
			<td align="right"><%=rs_close.getString("RATE") %></td> 
			<td><%=rs_close.getString("PAY_REMRK") %></td>
			</tr>
	<%
		}
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
		var freezeCol = 9; //change to column to freeze at
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