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
<title>Dispatch Foundry</title>
<STYLE TYPE="text/css" MEDIA=all>
.td1 { 
	font-size: 12px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
.tftable tr {
	background-color: white;
	font-size: 12px;
	border-width: 1px; 
	border-style: solid;
	border-color: #729ea5;
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
	function getExcel_Report(comp,from,to) {
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
		xmlhttp.open("POST", "Billwisepurchase_xls.jsp?comp=" + comp +"&from="+from+"&to="+to, true);
		xmlhttp.send();
	}
</script>
<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = '#f9f9f9';
		}
	}
</script> 
</head>
<body style="font-family: Arial;">
<%
try{   

// response.sendRedirect("Billwisepurchase.jsp?comp=" + company + "&from=" + date_from + "&to=" + date_to);
Connection con =null;   
String comp =request.getParameter("comp"); 
String from =request.getParameter("from");
String to =request.getParameter("to");  
String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);

DecimalFormat twoDForm = new DecimalFormat("###0.00"); 

int ct=0;
String CompanyName=""; 
if(comp.equalsIgnoreCase("101")){
	CompanyName = "H-21 MUTHA ENGINEERING PVT.LTD.";
	con = ConnectionUrl.getMEPLH21ERP();
}if(comp.equalsIgnoreCase("102")){
	CompanyName = "H-25 MUTHA ENGINEERING PVT.LTD.";
	con = ConnectionUrl.getMEPLH25ERP(); 
}if(comp.equalsIgnoreCase("103")){ 
	CompanyName = "MUTHA FOUNDERS PVT.LTD.";
	con = ConnectionUrl.getFoundryERPNEWConnection(); 
}if(comp.equalsIgnoreCase("105")){
	CompanyName = "DHANASHREE INDUSTRIES";
	con	= ConnectionUrl.getDIERPConnection(); 
}if(comp.equalsIgnoreCase("106")){
	CompanyName = "MUTHA ENGINEERING PVT.LTD.UNIT III";
	con	= ConnectionUrl.getK1ERPConnection(); 
} 
%> 
<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName %>&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong> 
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;">Bill Wise Purchase Details from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- <span style="font-family: Arial;font-size: 10px;color: brown;"><b>( Note : Click on record to get details )</b></span> -->
	</strong>	
	<br />
	<strong style="font-family: Arial; font-size: 13px;"><a
		href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	<span id="exportId">
		<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=from%>','<%=to%>')" style="cursor: pointer; font-family: Arial; font-size: 12px;">Generate Excel</button> <img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;" />
	</span> 
	<table id="t1" class="t1" border="1" style="border: 1px solid #000;">
			<tr style="font-family: Arial;font-size: 12px;"> 
				<th scope="col" class="th" width="5%">Tran.No.</th>
				<th scope="col" class="th">Tran Date</th>
				<th scope="col" class="th">PO No</th>
				<th scope="col" class="th">PO Date</th> 
				<th scope="col" class="th">Bill No</th> 
				<th scope="col" class="th">Bill Date</th> 
				<th scope="col" class="th">Supplier</th>
				<th scope="col" class="th">SST No</th>
				<th scope="col" class="th">SST Date</th>
				<th scope="col" class="th">CST No</th>
				<th scope="col" class="th">CST Date</th> 
				<th scope="col" class="th">Material Name</th>
				<th scope="col" class="th">Qty</th>
				<th scope="col" class="th">TAX Name</th>
				
				<th scope="col" class="th">Basic Amount</th>
				<th scope="col" class="th">Basic Discount</th>
				<th scope="col" class="th">Basic Freight</th> 
				<th scope="col" class="th">Basic Packing</th>
				<th scope="col" class="th">Basic Other</th>
				<th scope="col" class="th">Asses Amount</th> 
				<th scope="col" class="th">Excise Duty</th> 
				<th scope="col" class="th">CESS</th> 
				<th scope="col" class="th">Service Tax</th> 
				<th scope="col" class="th">Service CESS</th> 
				<th scope="col" class="th">HGSEC CESS</th> 
				<th scope="col" class="th">HGSEC SERV CESS</th> 
				<th scope="col" class="th">Taxable Amt</th> 
				<th scope="col" class="th">Sales Tax</th> 
				<th scope="col" class="th">Discount</th> 
				<th scope="col" class="th">Freight</th> 
				<th scope="col" class="th">Packing</th> 
				<th scope="col" class="th">TCS</th> 
				<th scope="col" class="th">Rounding Off</th> 
				<th scope="col" class="th">Other</th>
				<th scope="col" class="th">Insurance</th>
				<th scope="col" class="th">Total</th>
			</tr>
<% 
// exec "DIERP"."dbo"."Sel_PurchaseRegister";1 '105', '0', '0', '1165,1169,11610,1167,1164,1163,11613,1161,1162,11612,1166,11616', '20160801', '20160911', 0	
String concat = "";
CallableStatement sp = con.prepareCall("{call Sel_PurchaseRegister(?,?,?,?,?,?,?)}");
sp.setString(1, comp);
sp.setString(2, "0");
sp.setString(3, "0");
sp.setString(4, "1165,1169,11610,1167,1164,1163,11613,1161,1162,11612,1166,11616");
sp.setString(5, from);
sp.setString(6, to);
sp.setString(7, "0");
ResultSet rs = sp.executeQuery();
while(rs.next()){
	concat = "";
	concat = rs.getString("TRAN_NO").substring(rs.getString("TRAN_NO").length()-6);
//	System.out.println( rs.getString("PRN_TRNDATE")  + "  =  =  " + rs.getString("TRAN_NO").substring(rs.getString("TRAN_NO").length()-6)+ " = = " + rs.getString("SUBGL_LONGNAME") );
%>
<tr style="font-size: 11px;">
<td><%=concat %></td>
<td><%=rs.getString("PRN_TRNDATE") %></td>
<td><%=rs.getString("PONO") %></td>
<td><%=rs.getString("PO_DATE") %></td>
<td><%=rs.getString("REF_TRANNO") %></td>
<td><%=rs.getString("REF_TRANDATE") %></td>
<td><%=rs.getString("SUBGL_LONGNAME") %></td>
<td><%=rs.getString("SST_NO") %></td>
<td><%=rs.getString("SST_DATE") %></td>
<td><%=rs.getString("CST_NO") %></td>
<td><%=rs.getString("CST_DATE") %></td>
<td><%=rs.getString("MAT_NAME") %></td>
<td><%=rs.getString("QTY") %></td>
<td><%=rs.getString("TAX_NAME") %></td>

<td><%=rs.getString("BASIC_AMT") %></td>
<td><%=rs.getString("BASIC_DISCOUNT") %></td>
<td><%=rs.getString("BASIC_FREIGHT") %></td>
<td><%=rs.getString("BASIC_PACKING") %></td>
<td><%=rs.getString("BASIC_OTHER") %></td>
<td><%=rs.getString("ASSES_AMT") %></td>
<td><%=rs.getString("EXCISE_DUTY") %></td>
<td><%=rs.getString("CESS") %></td>
<td><%=rs.getString("SERVICE_TAX") %></td>
<td><%=rs.getString("SERVICE_CESS") %></td>
<td><%=rs.getString("HGSEC_CESS") %></td>
<td><%=rs.getString("HGSEC_SERV_CESS") %></td>
<td><%=rs.getString("TAXABLE_AMT") %></td>
<td><%=rs.getString("SALES_TAX") %></td>
<td><%=rs.getString("DISCOUNT") %></td>
<td><%=rs.getString("FREIGHT") %></td>
<td><%=rs.getString("PACKING") %></td>
<td><%=rs.getString("TCS") %></td>
<td><%=rs.getString("ROUNDING_OFF") %></td>
<td><%=rs.getString("OTHER") %></td>
<td><%=rs.getString("INSURANCE") %></td>
<td><%=rs.getString("TOTAL") %></td>
 </tr>
<%
}
%>
		</table>
<%
//System.out.println("Update = " + DayWIseSum); 
} catch (Exception e) {
e.printStackTrace();
e.getMessage();
}
%> 
<br> <br>  

</body>
</html>