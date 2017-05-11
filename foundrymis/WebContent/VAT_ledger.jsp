<%@page import="java.sql.PreparedStatement"%>
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
<title>VAT LEDGER</title>
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
		xmlhttp.open("POST", ".jsp?comp=" + comp +"&from="+from+"&to="+to, true);
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
DecimalFormat zeroDForm = new DecimalFormat("###,##0");
DecimalFormat twoDForm = new DecimalFormat("###,##0.00");
Connection con =null;

String comp =request.getParameter("company");
String from =request.getParameter("FromDatevatledger");
String to =request.getParameter("ToDate_vatledger");

from = from.replaceAll("[-+.^:,]","");
to = to.replaceAll("[-+.^:,]","");

String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);
 
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
Connection con_local = ConnectionUrl.getLocalDatabase();
%> 
<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName %>&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong> 
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;">VAT Ledger from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<!-- <span style="font-family: Arial;font-size: 10px;color: brown;"><b>( Note : Click on record to get details )</b></span> -->
	</strong>	
	<br />
<%
if(comp.equalsIgnoreCase("101") || comp.equalsIgnoreCase("102")){
%>
<strong style="font-family: Arial;font-size: 13px;"><a href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
<%
}else{
%>
<strong style="font-family: Arial;font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
<%	
}
%> 
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	<%-- 
	<span id="exportId">
	<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=from%>','<%=to%>')" style="cursor: pointer; font-family: Arial; font-size: 12px;">Generate Excel</button> <img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;" />
	</span>  
	--%>
	<table border="1" style="border: 1px solid #000;width: 40%">
			<tr style="font-family: Arial;font-size: 12px;font-weight: bold;">
				<th scope="col" class="th">Parameter</th>
				<th scope="col" class="th">DR Amt</th>
				<th scope="col" class="th">CR Amt</th>
			</tr>
<%
/*
VAT Ledger
exec "DIERP"."dbo"."Sel_RptAcctLedger";1 '105', '0',
'101001024101001056101000928101000110101000144101001210101000145101000146101000147101000148101001080101001211101000149101000150101000179101001212101000180101000181101001144101001213', 
'20170401', '20170428', 0
*/ 
PreparedStatement ps=null,ps1=null,ps3=null;
ResultSet rs=null,rs1=null,rs3=null;
int up=0;
String type="";
double cr=0,dr=0;
String cr1="",dr1="";
boolean flag = false;

CallableStatement sp = con.prepareCall("{call Sel_RptAcctLedger(?,?,?,?,?,?)}");
sp.setString(1, comp);
sp.setString(2, "0");
sp.setString(3, "101001024101001056101000928101000110101000144101001210101000145101000146101000147101000148101001080101001211101000149101000150101000179101001212101000180101000181101001144101001213");
sp.setString(4, from);
sp.setString(5, to);
sp.setString(6, "0");
ResultSet rs_getData = sp.executeQuery();
while(rs_getData.next()){
	 ps = con_local.prepareStatement("insert into vat_ledger(label,type,dr_amt,cr_amt)values(?,?,?,?)");
	 ps.setString(1, rs_getData.getString("GL_NAME"));
	 ps.setString(2, rs_getData.getString("SHORT_NAME"));
	 ps.setString(3, rs_getData.getString("DR_AMT"));
	 ps.setString(4, rs_getData.getString("CR_AMT"));
	 up=ps.executeUpdate();
}
ArrayList listglname = new ArrayList();
ArrayList typename = new ArrayList();
ps = con_local.prepareStatement("select distinct(label) as label from vat_ledger");
rs = ps.executeQuery();
while(rs.next()){
listglname.add(rs.getString("label"));
}
ps = con_local.prepareStatement("select distinct(type) as type from vat_ledger");
rs = ps.executeQuery();
while(rs.next()){
	typename.add(rs.getString("type"));
}
for(int i=0;i<listglname.size();i++){
%>
<tr  style="background-color: #0c2cc2;color: white;font-size: 12px;font-weight: bold;">
	<td><strong><%=listglname.get(i).toString() %></strong></td>
<%
ps1 = con_local.prepareStatement("select sum(dr_amt) as dr_amt FROM erp_database.vat_ledger where label='"+listglname.get(i).toString()+"'");
rs1 = ps1.executeQuery();
while(rs1.next()){
	dr = Double.valueOf(rs1.getString("dr_amt"));
}
ps1 = con_local.prepareStatement("select sum(cr_amt) as cr_amt FROM erp_database.vat_ledger where label='"+listglname.get(i).toString()+"'");
rs1 = ps1.executeQuery();
while(rs1.next()){
	cr = Double.valueOf(rs1.getString("cr_amt"));
}
%>
	<td align="right"><%=dr %></td>
	<td align="right"><%=cr %></td>
</tr>
<%
ps1 = con_local.prepareStatement("SELECT distinct(type) FROM erp_database.vat_ledger where label='"+listglname.get(i).toString()+"'");
rs = ps1.executeQuery();
while(rs.next()){ 
			type = rs.getString("type");
			ps3 = con_local.prepareStatement("SELECT sum(dr_amt) as dr FROM erp_database.vat_ledger where label='"+listglname.get(i).toString()+"' and type='"+type+"'");
			rs3 = ps3.executeQuery();
			while(rs3.next()){
			dr1= rs3.getString("dr");
			flag=true;
			}
			ps3 = con_local.prepareStatement("SELECT sum(cr_amt) as cr FROM erp_database.vat_ledger where label='"+listglname.get(i).toString()+"' and type='"+type+"'");
			rs3 = ps3.executeQuery();
			while(rs3.next()){
			cr1= rs3.getString("cr");
			flag=true;
			}
			if(flag==true){
	%>
	<tr style="font-size: 12px;">
		<td><strong><%=type %></strong></td>
		<td align="right"><%=dr1 %></td>
		<td align="right"><%=cr1 %></td>
	</tr>
	<%			
			} 
} 
}
%>
</table>
<% 
ps = con_local.prepareStatement("delete from vat_ledger");
up=ps.executeUpdate();
ps = con_local.prepareStatement("ALTER TABLE vat_ledger AUTO_INCREMENT=1");
up=ps.executeUpdate();  
} catch (Exception e) {
	e.printStackTrace();
	e.getMessage();
}
%>
<br><br>
</body>
</html>