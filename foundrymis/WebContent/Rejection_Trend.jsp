<%@page import="java.util.Collections"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rejection Trend</title> 
<STYLE TYPE="text/css" MEDIA=all>
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
} 
button.accordion {
    background-color: #d2e1f9; 
    cursor: pointer;
    padding: 4px;
    width: 100%;
    border: none;
    text-align: left;
    outline: none;
    font-size: 12px;
    font-weight:bold;
    transition: 0.4s;
}
button.accordion2 {
    background-color: #d2e1f9; 
    cursor: pointer;
    padding: 4px;
    width: 100%;
    border: none;
    text-align: left;
    outline: none;
    font-size: 12px;
    font-weight:bold;
    transition: 0.4s;
}
button.accordion3 {
    background-color: #d2e1f9; 
    cursor: pointer;
    padding: 4px;
    width: 100%;
    border: none;
    text-align: left;
    outline: none;
    font-size: 12px;
    font-weight:bold;
    transition: 0.4s;
}

button.accordion.active, button.accordion:hover {
    background-color: #d2e1f9; 
}

div.panel { 
    display: none;
    background-color: white;
    height:50%;
    overflow: scroll;
}
</style>  
</head>
<body  style="font-family: Arial;">
<%
try {
Connection con = null;
String comp =request.getParameter("company");
boolean flag =false;
if(comp.equalsIgnoreCase("all")){
	comp = "103";
	flag=true;
}

/*  String datefrom =request.getParameter("FromDate_heattrend");   */
String dateto =request.getParameter("ToDate_rejectiontrend"); 
 
dateto = dateto.replaceAll("[-+.^:,]","");
String datefrom = dateto.substring(0,4) + dateto.substring(4,6) + "01";
DecimalFormat zeroDForm = new DecimalFormat("###,##0");
DecimalFormat twoDForm = new DecimalFormat("###,##0.00");
String date_From = datefrom.substring(6,8) +"/"+ datefrom.substring(4,6) +"/"+ datefrom.substring(0,4);
String date_to = dateto.substring(6,8) +"/"+ dateto.substring(4,6) +"/"+ dateto.substring(0,4);
 
String datetab = datefrom.substring(4,6);
String nameComp = "";
String db="";

//System.out.println("date = " + datefrom + " = " + dateto);
if(comp.equalsIgnoreCase("103")){
	con = ConnectionUrl.getFoundryERPNEWConnection();
	nameComp = "MFPL"; 
}
if(comp.equalsIgnoreCase("105")){
	con = ConnectionUrl.getDIERPConnection();
	nameComp = "DI"; 
}
if(comp.equalsIgnoreCase("106")){
	con = ConnectionUrl.getK1ERPConnection();
	nameComp = "MEPL UNIT III "; 
}
if(comp.equalsIgnoreCase("101")){
	con = ConnectionUrl.getMEPLH21ERP();
	nameComp = "MEPL H21"; 
}
if(comp.equalsIgnoreCase("102")){
	con = ConnectionUrl.getMEPLH25ERP();
	nameComp = "MEPL H25"; 
}
%> 
<div>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Rejection Trend Report from <%=date_From %> to <%=date_to %>&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>
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
</div>
<div style="width: 33.2%;float: left;">
<strong><%=nameComp %> Rejection</strong> 
<table id="tbl3" class="table2excel" border="1" cellpadding=2 style="width:100%; border: 1px solid #000;"> 
			<tr align="center">
					<th class="th" width="60%">Part Name</th>   
					<th class="th" width="20%">Total Challan Qty</th> 
					<th class="th" width="20%">Total Weight</th>
			</tr>
</table>			 
<%
//Cust Return
//exec "ENGERP"."dbo"."Sel_RptMatSalesReturn";1 '101', '0', '2024', '20170301', '20170412'
String custName="";
int cnt=0;
double chqty=0,totWt=0;

ArrayList custno = new ArrayList(); 
CallableStatement cs11 = con.prepareCall("{call Sel_RptMatSalesReturn(?,?,?,?,?)}");
cs11.setString(1, comp);
cs11.setString(2, "0");
cs11.setString(3, "2024");
cs11.setString(4, datefrom);
cs11.setString(5, dateto);
ResultSet rs122 = cs11.executeQuery();
while (rs122.next()) {
custno.add(rs122.getString("SUBGLACNO"));
}

HashSet<Integer> hashSet = new HashSet<Integer>();
hashSet.clear();
hashSet.addAll(custno);
custno.clear();
custno.addAll(hashSet);
Collections.sort(custno);

String viewCust="";
double viewChlQty=0,viewTotwt=0;

for(int i=0;i<custno.size();i++){
	viewCust ="";
	viewChlQty=0;viewTotwt=0;
	rs122 = cs11.executeQuery();
	while(rs122.next()){
		if(rs122.getString("SUBGLACNO").equalsIgnoreCase(custno.get(i).toString())){
			custName=rs122.getString("SUBGLACNO");
			if(cnt==0){
			 viewCust = rs122.getString("CUST_NAME");
			 viewChlQty = viewChlQty + Double.valueOf(rs122.getString("CHLN_QTY"));
			 viewTotwt = viewTotwt + Double.valueOf(rs122.getString("TOTALWEIGHT")); 
		}
	}
	}
%>
<button class="accordion">
<table id="tbl3" class="table2excel" border="1" cellpadding=2 style="width:100%; border: 1px solid #000;">
			<tr>
					<th class="th" width="60%"><strong><%=viewCust %></strong></th>
					<th class="th" width="20%" align="right"><strong style="color: #e97914;"><%= zeroDForm.format(viewChlQty) %></strong></th> 
					<th class="th" width="20%" align="right"><strong style="color: #e97914;"><%=twoDForm.format(viewTotwt) %></strong> </th>
			</tr>
</table>
<%-- <strong><%=viewCust %>&nbsp;</strong><br/><strong style="color: #e97914;">Challan Qty : <%= zeroDForm.format(viewChlQty) %>&nbsp;&nbsp; Total Weight : <%=twoDForm.format(viewTotwt) %></strong> --%> 

</button>
<div class="panel">
<p>
<table id="tbl3" class="table2excel" border="1" cellpadding=2 style="width:100%; border: 1px solid #000;"> 
			<tr align="center">
					<th class="th">Part Name</th>
					<th class="th">Date</th>  
					<th class="th">Challan Qty</th>   
					<th class="th">Wgt</th>
					<th class="th">Tot Wgt</th>
			</tr>
		<% 
				chqty=0;
				totWt=0;
				rs122 = cs11.executeQuery();
				while(rs122.next()){
					if(rs122.getString("SUBGLACNO").equalsIgnoreCase(custno.get(i).toString())){
						custName=rs122.getString("SUBGLACNO");
			%> 
			<tr  style="background-color: #f7f7f7;cursor: pointer;font-family: Arial;font-size: 10px;">
					<td><%=rs122.getString("MAT_NAME") %></td>
					<td><%=rs122.getString("PRN_TRANDATE") %></td>
					<td align="right"><%= zeroDForm.format(Double.valueOf(rs122.getString("CHLN_QTY"))) %></td>
					<td align="right"><%=twoDForm.format(Double.valueOf(rs122.getString("WEIGHT"))) %></td>
					<td align="right"><%=twoDForm.format(Double.valueOf(rs122.getString("TOTALWEIGHT"))) %></td>
			</tr>
			<%
			cnt++;
					}
			}
		%>
		</table>
</p>
</div> 
			<%		
				custName="";
				cnt=0;
			}
			%>
<script>
var acc = document.getElementsByClassName("accordion");
var i; 
for (i = 0; i < acc.length; i++) {
    acc[i].onclick = function(){
        this.classList.toggle("active");
        var panel = this.nextElementSibling;
        if (panel.style.display === "block") {
            panel.style.display = "none";
        } else {
            panel.style.display = "block";
        }
    }
}
</script>
</div>













<%
if(flag==true){
	con.close();
	comp="105";
	con = ConnectionUrl.getDIERPConnection();
	nameComp = "DI";
	custno.clear(); 
%> 
<div style="width: 33.2%;float: right;">
<strong><%=nameComp %> Rejection</strong> 
<table id="tbl3" class="table2excel" border="1" cellpadding=2 style="width:100%; border: 1px solid #000;"> 
			<tr align="center">
					<th class="th" width="60%">Part Name</th>   
					<th class="th" width="20%">Total Challan Qty</th> 
					<th class="th" width="20%">Total Weight</th>
			</tr>
</table>
<%
//Cust Return
//exec "ENGERP"."dbo"."Sel_RptMatSalesReturn";1 '101', '0', '2024', '20170301', '20170412'
custName="";
cnt=0;
chqty=0;
totWt=0;
custno.clear();  
cs11 = con.prepareCall("{call Sel_RptMatSalesReturn(?,?,?,?,?)}");
cs11.setString(1, comp);
cs11.setString(2, "0");
cs11.setString(3, "2024");
cs11.setString(4, datefrom);
cs11.setString(5, dateto);
rs122 = cs11.executeQuery();
while (rs122.next()) {
custno.add(rs122.getString("SUBGLACNO"));
}
 
hashSet.clear();
hashSet.addAll(custno);
custno.clear();
custno.addAll(hashSet);
Collections.sort(custno);

viewCust="";
viewChlQty=0;
viewTotwt=0;

for(int i=0;i<custno.size();i++){
	viewCust ="";
	viewChlQty=0;viewTotwt=0;
	rs122 = cs11.executeQuery();
	while(rs122.next()){
		if(rs122.getString("SUBGLACNO").equalsIgnoreCase(custno.get(i).toString())){
			custName=rs122.getString("SUBGLACNO");
			if(cnt==0){
			 viewCust = rs122.getString("CUST_NAME");
			 viewChlQty = viewChlQty + Double.valueOf(rs122.getString("CHLN_QTY"));
			 viewTotwt = viewTotwt + Double.valueOf(rs122.getString("TOTALWEIGHT")); 
	   }
	 }
	}
%>
<button class="accordion2">
<table id="tbl3" class="table2excel" border="1" cellpadding=2 style="width:100%; border: 1px solid #000;"> 
			<tr>
					<th class="th" width="60%"><strong><%=viewCust %></strong></th>   
					<th class="th" width="20%" align="right"><strong style="color: #e97914;"><%= zeroDForm.format(viewChlQty) %></strong></th> 
					<th class="th" width="20%" align="right"><strong style="color: #e97914;"><%=twoDForm.format(viewTotwt) %></strong> </th>
			</tr>
</table>			
<%-- <strong><%=viewCust %>&nbsp;</strong><br/><strong style="color: #e97914;">Challan Qty : <%= zeroDForm.format(viewChlQty) %>&nbsp;&nbsp; Total Weight : <%=twoDForm.format(viewTotwt) %></strong> --%> 
</button>
<div class="panel">
<p>
<table id="tbl3" class="table2excel" border="1" cellpadding=2 style="width:100%; border: 1px solid #000;"> 
			<tr align="center">
					<th class="th">Part Name</th>
					<th class="th">Date</th>  
					<th class="th">Challan Qty</th>   
					<th class="th">Wgt</th>
					<th class="th">Tot Wgt</th>
			</tr>
<% 
				chqty=0;
				totWt=0;
				rs122 = cs11.executeQuery();
				while(rs122.next()){
					if(rs122.getString("SUBGLACNO").equalsIgnoreCase(custno.get(i).toString())){
						custName=rs122.getString("SUBGLACNO"); 
			%> 
			<tr  style="background-color: #f7f7f7;cursor: pointer;font-family: Arial;font-size: 10px;">
					<td><%=rs122.getString("MAT_NAME") %></td>
					<td><%=rs122.getString("PRN_TRANDATE") %></td>
					<td align="right"><%= zeroDForm.format(Double.valueOf(rs122.getString("CHLN_QTY"))) %></td>
					<td align="right"><%=twoDForm.format(Double.valueOf(rs122.getString("WEIGHT"))) %></td>
					<td align="right"><%=twoDForm.format(Double.valueOf(rs122.getString("TOTALWEIGHT"))) %></td>
			</tr>
			<%
			cnt++;
					}
			}
		%>
		</table>
</p>
</div> 
			<%		
				custName="";
				cnt=0;
			}
			%> 
			
<script>
var acc = document.getElementsByClassName("accordion2");
var i; 
for (i = 0; i < acc.length; i++) {
    acc[i].onclick = function(){
        this.classList.toggle("active");
        var panel = this.nextElementSibling;
        if (panel.style.display === "block") {
            panel.style.display = "none";
        } else {
            panel.style.display = "block";
        }
    }
}
</script>
</div>
<%
	con.close();
	comp="106";
	con = ConnectionUrl.getK1ERPConnection();
	nameComp = "MEPL UIII";
	custno.clear();
%>
<div style="width: 33.2%;float: right;">
<strong><%=nameComp %> Rejection</strong>
<table id="tbl3" class="table2excel" border="1" cellpadding=2 style="width:100%; border: 1px solid #000;"> 
			<tr align="center">
					<th class="th" width="60%">Part Name</th>   
					<th class="th" width="20%">Total Challan Qty</th> 
					<th class="th" width="20%">Total Weight</th>
			</tr>
</table>
<%
//Cust Return
//exec "ENGERP"."dbo"."Sel_RptMatSalesReturn";1 '101', '0', '2024', '20170301', '20170412'
custName="";
cnt=0;
chqty=0;
totWt=0;
custno.clear();  
cs11 = con.prepareCall("{call Sel_RptMatSalesReturn(?,?,?,?,?)}");
cs11.setString(1, comp);
cs11.setString(2, "0");
cs11.setString(3, "2024");
cs11.setString(4, datefrom);
cs11.setString(5, dateto);
rs122 = cs11.executeQuery();
while (rs122.next()) {
custno.add(rs122.getString("SUBGLACNO"));
}
 
hashSet.clear();
hashSet.addAll(custno);
custno.clear();
custno.addAll(hashSet);
Collections.sort(custno);

viewCust="";
viewChlQty=0;
viewTotwt=0;

for(int i=0;i<custno.size();i++){
	viewCust ="";
	viewChlQty=0;viewTotwt=0;
	rs122 = cs11.executeQuery();
	while(rs122.next()){
		if(rs122.getString("SUBGLACNO").equalsIgnoreCase(custno.get(i).toString())){
			custName=rs122.getString("SUBGLACNO");
			if(cnt==0){
			 viewCust = rs122.getString("CUST_NAME");
			 viewChlQty = viewChlQty + Double.valueOf(rs122.getString("CHLN_QTY"));
			 viewTotwt = viewTotwt + Double.valueOf(rs122.getString("TOTALWEIGHT")); 
	   }
	 }
	}
%>
<button class="accordion3">
<table id="tbl3" class="table2excel" border="1" cellpadding=2 style="width:100%; border: 1px solid #000;"> 
			<tr>
					<th class="th" width="60%"><strong><%=viewCust %></strong></th>   
					<th class="th" width="20%" align="right"><strong style="color: #e97914;"><%= zeroDForm.format(viewChlQty) %></strong></th> 
					<th class="th" width="20%" align="right"><strong style="color: #e97914;"><%=twoDForm.format(viewTotwt) %></strong> </th>
			</tr>
</table>			
<%-- <strong><%=viewCust %>&nbsp;</strong><br/><strong style="color: #e97914;">Challan Qty : <%= zeroDForm.format(viewChlQty) %>&nbsp;&nbsp; Total Weight : <%=twoDForm.format(viewTotwt) %></strong> --%> 
</button>
<div class="panel">
<p>
<table id="tbl3" class="table2excel" border="1" cellpadding=2 style="width:100%; border: 1px solid #000;"> 
			<tr align="center">
					<th class="th">Part Name</th>
					<th class="th">Date</th>  
					<th class="th">Challan Qty</th>   
					<th class="th">Wgt</th>
					<th class="th">Tot Wgt</th>
			</tr>
<% 
				chqty=0;
				totWt=0;
				rs122 = cs11.executeQuery();
				while(rs122.next()){
					if(rs122.getString("SUBGLACNO").equalsIgnoreCase(custno.get(i).toString())){
						custName=rs122.getString("SUBGLACNO"); 
			%> 
			<tr  style="background-color: #f7f7f7;cursor: pointer;font-family: Arial;font-size: 10px;">
					<td><%=rs122.getString("MAT_NAME") %></td>
					<td><%=rs122.getString("PRN_TRANDATE") %></td>
					<td align="right"><%= zeroDForm.format(Double.valueOf(rs122.getString("CHLN_QTY"))) %></td>
					<td align="right"><%=twoDForm.format(Double.valueOf(rs122.getString("WEIGHT"))) %></td>
					<td align="right"><%=twoDForm.format(Double.valueOf(rs122.getString("TOTALWEIGHT"))) %></td>
			</tr>
			<%
			cnt++;
					}
			}
		%>
		</table>
</p>
</div> 
			<%		
				custName="";
				cnt=0;
			}
			%> 
<script>
var acc = document.getElementsByClassName("accordion3");
var i; 
for (i = 0; i < acc.length; i++) {
    acc[i].onclick = function(){
        this.classList.toggle("active");
        var panel = this.nextElementSibling;
        if (panel.style.display === "block") {
            panel.style.display = "none";
        } else {
            panel.style.display = "block";
        }
    }
}
</script>
</div>
<%
}  
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>