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
<title>Cash Book </title>
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
	background-color: #F7FBFC;
	border-width: 1px;
	padding: 1px;
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
function getSearchedBal(str,comp,from,to) { 
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
				document.getElementById("filter").innerHTML = xmlhttp.responseText;  
			}
		};
		xmlhttp.open("POST", "SearchedBalance.jsp?q=" + str +"&comp="+comp +"&from="+from +"&to="+to, true);
		xmlhttp.send(); 
	 };

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
		xmlhttp.open("POST", "PartywisePorder_xls.jsp?comp=" + comp +"&sup="+sup+"&from="+from+"&to="+to, true);
		xmlhttp.send();
	};
	
	function validatenumerics(key) {
		//getting key code of pressed key
		var keycode = (key.which) ? key.which : key.keyCode;
		//comparing pressed keycodes
		 
		if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46) {
		    alert("Only allow numeric Data entry");
		    return false;
		}else 
		{
			return true;
		};
		}
</script>
</head>
<body style="font-family: Arial;width: 90%">
	<%
try{
Connection con =null;
String comp =request.getParameter("comp"); 
String from =request.getParameter("from");
String to =request.getParameter("to"); 
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
if(comp.equalsIgnoreCase("101102")){
	comp="0";
	CompanyName = "MUTHA ENGINEERING H-21, H25, UNIT III";
	con = ConnectionUrl.getENGH25CONSConnection();
}
%>
<strong style="color: blue; font-family: Arial; font-size: 12px;"><%=CompanyName %></strong><br>  
	<strong style="color: blue; font-family: Arial; font-size: 12px;">CASH IN HAND</strong><br>
	<strong style="color: #1B5869; font-family: Arial; font-size: 12px;">Date from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %>,
		&nbsp;&nbsp; <strong style="color: #1B5869; font-family: Arial; font-size: 12px;">Credit Balance greater than &#8658;  </strong>&nbsp;
		<input type="text" name="balance" id="balance" size="30" style="background-color: #E3F4FA" onkeyup="getSearchedBal(this.value,'<%=comp %>','<%=from %>','<%=to %>')">
	</strong> 
<%
if(comp.equalsIgnoreCase("101") || comp.equalsIgnoreCase("102") || comp.equalsIgnoreCase("0")){
%>
	<strong style="font-family: Arial; font-size: 13px;"><a href="MachineShop_Home.jsp" style="text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;GO BACK </a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
}else{
%>
<strong style="font-family: Arial; font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&nbsp;&nbsp;&nbsp;&nbsp;GO BACK  </a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
}
%>	
<br />

<%--
	<span id="exportId">
		<button id="filebutton"
			onclick="getExcel_Report('<%=comp%>','<%=sup%>','<%=from%>','<%=to%>')"
			style="cursor: pointer; font-family: Arial; font-size: 12px;">Generate
			Excel</button> <img alt="#" src="images/fileload.gif" id="fileloading"
		style="visibility: hidden;" />
	</span> --%>
 
 <span id="filter">
		<table id="t1" class="t1" border="1" style="width: 80%; border: 1px solid #000;"> 
			<tr style="font-size: 12px; font-family: Arial;"> 
				<th scope="col" class="th">Date</th>
				<th scope="col" class="th">Voucher</th>
				<th scope="col" class="th">Type & No</th>
				<th scope="col" class="th">Account Name</th>
				<th scope="col" class="th">Particulars</th>
				<th scope="col" class="th">Debit Amount</th>
				<th scope="col" class="th">Credit Amount</th> 
				<!-- <th scope="col" class="th">Balance</th>  -->
			</tr> 
			<%
			String dateCheck = "";
			double debit=0;
			int cnt=0;
			double balance = 0;
			ArrayList cmpr = new ArrayList();
			// exec "DIERP"."dbo"."Sel_CashBankBook";1 '105', '0', 101160001, '20140401', '20150331', 1, 1
			CallableStatement cs = con.prepareCall("{call Sel_CashBankBook(?,?,?,?,?,?,?)}");
			cs.setString(1, comp);
			cs.setString(2, "0");
			cs.setString(3, "101160001");
			cs.setString(4, from);
			cs.setString(5, to);
			cs.setString(6, "1");
			cs.setString(7, "1"); 
			ResultSet rs = cs.executeQuery(); 
			while (rs.next()) {
				cmpr.add(rs.getString("TRAN_DATE"));
			}	
			rs = cs.executeQuery();
			while (rs.next()) {
			
				if(dateCheck==""){
			%>
			<tr style="font-family: Arial;font-size: 10px;">
				<td colspan="3"><strong>Date : <%=rs.getString("PRN_TRANDATE") %></strong> </td>
				<td><strong>OPENING BALANCE</strong></td>
				<td></td> 
				<td align="right"><strong><%=rs.getString("DR_AMT") %></strong></td>
				<td colspan="2"></td>
			</tr>
			<%
			balance = Double.parseDouble(rs.getString("DR_AMT"));
				}else{
			%>
					 <tr style="font-family: Arial;font-size: 10px;">
					 	<td><%=rs.getString("PRN_TRANDATE") %></td>
						<td align="center"><%=rs.getString("VOUCHER_TYPE")%></td>
						<td align="center"><%=rs.getString("TRAN_NO") %></td>
						<td><strong><%=rs.getString("AC_NAME") %></strong></td> 
						<td><%=rs.getString("PARTICULARS") %></td>
						<%
						if(rs.getString("CR_AMT").equalsIgnoreCase("0.00")){
						%> 
						<td>&nbsp;</td>
						<%
						}else{
						%>
						<td align="right"><strong><%=rs.getString("CR_AMT") %></strong></td>
						<%	
						}
						%> 
						<td align="right"><%=rs.getString("DR_AMT")%></td>
						<%
						balance = (balance+ Double.parseDouble(rs.getString("CR_AMT"))) - Double.parseDouble(rs.getString("DR_AMT")) ;
						balance = Math.round(balance * 100.0) / 100.0;
						%>
						<%-- <td align="right"><%=balance %></td> --%>
						  
					</tr>  
			<%	 
				}
				dateCheck = rs.getString("TRAN_DATE");
			}
			%>
		</table> 
</span>
<%
con.close();
} catch (Exception e) {
e.printStackTrace();
e.getMessage();
}
%> 
	<br>
	<br> 

</body>
</html>