<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script language="JavaScript"> 
var nHist = window.history.length;
if(window.history[nHist] != window.location)
  window.history.forward(); 
</script> 
<title>Potwise Founders</title>
</head>
<script type="text/javascript">
function ChangeColor(tableRow, highLight) {
	if (highLight) {
		tableRow.style.backgroundColor = '#F7F5FC';
	} else {
		tableRow.style.backgroundColor = '#DEDFE0';
	}
}
</script>
<script language="javascript">
	function button1(val) {
		var val1 = val; 
		document.getElementById("pot").value = val1;
		edit.submit();
	}
</script>
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
<body bgcolor="#EBE4E7" style="font-family: Arial;">
<%
try{  
String comp =request.getParameter("comp");
String datefrom =request.getParameter("datefrom");
String dateto =request.getParameter("dateto");
String db =request.getParameter("db");
String code =request.getParameter("code");
 

String date_From = datefrom.substring(6,8) +"/"+ datefrom.substring(4,6) +"/"+ datefrom.substring(0,4); 
String date_To = dateto.substring(6,8) +"/"+ dateto.substring(4,6) +"/"+ dateto.substring(0,4);

DecimalFormat zeroDForm = new DecimalFormat("###,##0");

%> 
<strong style="color: blue;font-family: Arial;font-size: 14px;">MUTHA FOUNDERS PVT.LTD.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">POTWISE Production from <%=date_From %> to <%=date_To %>   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>
<br/>
<strong style="font-family: Arial;font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
<br/>
<div style="width: 50%;padding-left: 7em;"> 
		<form action="PotwiseDetailReportFND.jsp" method="post" id="edit" name="edit"> 
 <%
 int srno=0;
 Connection con = ConnectionUrl.getFoundryFMShopConnection();
	CallableStatement cs = con.prepareCall("{call Sel_RptFurnaceWiseProd(?,?,?,?)}");
 	cs.setString(1, comp);
 	cs.setString(2, code);
	cs.setString(3, datefrom);
	cs.setString(4, dateto); 
	ResultSet rs1 = cs.executeQuery(); 
 %>
 <input type="hidden" name="comp" value="<%=comp%>">
 <input type="hidden" name="datefrom" value="<%=datefrom%>">
 <input type="hidden" name="dateto" value="<%=dateto%>">
 <input type="hidden" name="db" value="<%=db%>">
 <input type="hidden" name="pot" id="pot">
 
			<table border="1" class="tftable"> 
				<tr>
					<th scope="col">Sr. No.</th>
					<th scope="col">Furnace Name</th>
					<th scope="col">Capacity (Kg)</th>
					<th scope="col">Todays Qty</th>
					<th scope="col">Cumulative Qty</th>  
				</tr>
				<%
				 while(rs1.next()){  
					srno ++;
				%>
				<tr align="center" title="Click to get details" style="background-color: #DEDFE0;cursor: pointer;" align="center" onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" onclick="button1('<%=rs1.getString("FUR_NAME") %>');">
					<td align="right"><%=srno%></td>		
					<td align="left"><%=rs1.getString("FUR_NAME") %></td> 
					<td align="right"><%=rs1.getString("CAPACITY") %></td>
					<td align="right"><%=zeroDForm.format(Double.parseDouble(rs1.getString("TODAY_QTY"))) %></td>			
					<td align="right"><%=zeroDForm.format(Double.parseDouble(rs1.getString("CUMULATIVE_QTY"))) %></td>					 
				</tr>
				<%
				 }
				%> 
			</table> 

<!--============================================================================-->
<!--============================================================================-->
<%
}catch(Exception e){
	e.printStackTrace();
}
%>

		</form>
	</div>
 


</body>
</html>