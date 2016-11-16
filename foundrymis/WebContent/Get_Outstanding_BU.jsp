<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
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
<title>Casting Stock Machine Shop</title>
<STYLE TYPE="text/css" MEDIA=all>
.tftable td {
	font-size: 11px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
.tftable tr {
	background-color: white;
	font-size: 10px;
}
.tftable th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
	text-align: center;
} 
</STYLE>
<script type="text/javascript">
	function getExcel_Report(comp, month, year, cust) { 
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
		xmlhttp.open("POST", "OutstandingBU_xls.jsp?comp=" + comp +"&month="+month+"&year="+year+"&cust="+cust, true);
		xmlhttp.send();
	};
</script>
</head>
<body style="font-family: Arial;">
<%
try{	
Connection con =null;
String comp =request.getParameter("compBU_hid");
String monthBU =request.getParameter("monthBU_hid"); 
String yearBU =request.getParameter("yearBU_hid"); 
String custBU =request.getParameter("custBU_hid"); 

DecimalFormat zeroDForm = new DecimalFormat("###,##0.00");

Calendar cal = new GregorianCalendar(Integer.parseInt(yearBU),Integer.parseInt(monthBU),0);
Date date = cal.getTime();
DateFormat sdf = new SimpleDateFormat("yyyyMMdd");			
String lastdate = sdf.format(date);
String firstdate = sdf.format(date).substring(0, 6) + "01";

String group="";
int ct=0;
String CompanyName="",trn_no="",cust_name="";
if(comp.equalsIgnoreCase("101")){
	CompanyName = "H-21";
	con = ConnectionUrl.getMEPLH21ERP();
	trn_no = "101161711511";
	
	PreparedStatement ps_gl = con.prepareStatement(" select * from MSTACCTGLSUB where SUB_GLACNO="+custBU);
	ResultSet rs_gl = ps_gl.executeQuery();
	while(rs_gl.next()){
		cust_name = rs_gl.getString("SUBGL_LONGNAME");
	} 
}else{
	CompanyName = "H-25";
	con	= ConnectionUrl.getMEPLH25ERP();
	trn_no = "102161711511";
	
	PreparedStatement ps_gl = con.prepareStatement(" select * from MSTACCTGLSUB where SUB_GLACNO="+custBU);
	ResultSet rs_gl = ps_gl.executeQuery();
	while(rs_gl.next()){
		cust_name = rs_gl.getString("SUBGL_LONGNAME");
	} 
}
%>
<strong style="color: blue;font-family: Arial;font-size: 14px;"><%=CompanyName %>&nbsp;MUTHA ENGINEERING PVT.LTD. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;"><%=cust_name %> Outstanding from &nbsp;<%=firstdate %>&nbsp; to &nbsp;<%=lastdate %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>

<strong style="font-family: Arial;font-size: 13px;"><a href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<span id="exportId">
<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=monthBU%>','<%=yearBU %>','<%=custBU %>')" style="cursor: pointer;font-family: Arial;font-size: 11px;height: 20px;">Generate Excel</button>
<img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;"/>
</span>
<div style="padding-left: 40px;">
 <table id="tftable" class="tftable" border="1" style="width:40%; border: 1px solid #000;">
		<tr style="font-size: 12px;font-family: Arial;">
					<th scope="col" class="th">INVOICE NO</th>
					<th scope="col" class="th">INVOICE DATE</th>
					<th scope="col" class="th">INVOICE AMT</th> 
		</tr>
	<%
	PreparedStatement ps = con.prepareStatement("select RIGHT(CONVERT( VARCHAR, TRNACCTMATH.TRAN_NO), 6)  AS INV_NO,DBO.FORMAT_DATE(TRAN_DATE) as TRAN_DATE, TRAN_AMT from TRNACCTMATH where TRAN_NO LIKE '"+trn_no+"%' AND SUB_GLACNO1 ="+custBU+" AND TRAN_DATE BETWEEN  "+firstdate+"  AND "+lastdate+" AND STATUS_CODE =0");
	ResultSet rs = ps.executeQuery();
	while(rs.next()){
	%>
		<tr>
			<td scope="col" align="right"><%=rs.getString("INV_NO") %></td>
			<td scope="col" align="left"><%=rs.getString("TRAN_DATE") %></td>
			<td scope="col" align="right"><%=rs.getString("TRAN_AMT") %></td> 
		</tr>
	<%
	}
	%>	
</table>
</div>
<%  
con.close();
} catch (Exception e) {
e.printStackTrace(); 
}
%> 
		<br> <br>  
</body>
</html>