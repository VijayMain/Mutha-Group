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
<title>Heats Trend</title> 
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
	text-align: center;
}  
</STYLE> 
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
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
String dateto =request.getParameter("ToDate_heattrend"); 
 
dateto = dateto.replaceAll("[-+.^:,]","");
String datefrom = dateto.substring(0,4) + dateto.substring(4,6) + "01";

String date_From = datefrom.substring(6,8) +"/"+ datefrom.substring(4,6) +"/"+ datefrom.substring(0,4);
String date_to = dateto.substring(6,8) +"/"+ dateto.substring(4,6) +"/"+ dateto.substring(0,4);

DecimalFormat zeroDForm = new DecimalFormat("###,##0");
DecimalFormat twoDForm = new DecimalFormat("###,##0.00");
String datetab = datefrom.substring(4,6);
String nameComp = "";
String db="";

//System.out.println("date = " + datefrom + " = " + dateto);

if(comp.equalsIgnoreCase("103")){
	con = ConnectionUrl.getFoundryFMShopConnection();
	nameComp = "MFPL";
	db = "FOUNDRYERP";
}
if(comp.equalsIgnoreCase("105")){
	con = ConnectionUrl.getDIFMShopConnection();
	nameComp = "DI";
	db = "DIERP";
}
if(comp.equalsIgnoreCase("106")){
	con = ConnectionUrl.getK1FMShopConnection();
	nameComp = "UNIT III ";
	db = "K1ERP";
}
if(comp.equalsIgnoreCase("101")){
	con = ConnectionUrl.getMEPLH21FMShop();
	nameComp = "MEPL H21";
	db = "ENGERP";
}
if(comp.equalsIgnoreCase("102")){
	con = ConnectionUrl.getMEPLH25FMShop();
	nameComp = "MEPL H25";
	db = "H25ERP";
}
if(comp.equalsIgnoreCase("111")){
	con = ConnectionUrl.getENGH25CONSConnection();
	nameComp = "MEPL H21 & MEPL H25 Consolidated";
}

// exec "DIFMSHOP"."dbo"."Sel_TransactionsFoundry";1 '105', '65202', 'ADMIN', '20170301', '20170331', 'FOUNDRYERP'
ArrayList days = new ArrayList();
				CallableStatement cs11 = con.prepareCall("{call Sel_TransactionsFoundry(?,?,?,?,?,?)}");
				cs11.setString(1, comp);
				cs11.setString(2, "65202");
				cs11.setString(3, "ADMIN");
				cs11.setString(4, datefrom);
				cs11.setString(5, dateto);
				cs11.setString(6, db);
				ResultSet rs122 = cs11.executeQuery();
				while (rs122.next()) {
					days.add(rs122.getString("TRAN_DATE").substring(6));
				}
				HashSet<Integer> hashSet = new HashSet<Integer>();
				hashSet.addAll(days);
				days.clear();
				days.addAll(hashSet);
				Collections.sort(days);
%>
<div>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Heat Trend Report from <%=date_From %> to <%=date_to %>&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>
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
<div style="width: 80%;float: left;">
<div style="width: 33.3%;float: left;"> 
<table id="tbl1" class="table2excel" border="1" cellpadding=2 style="width:100%; border: 1px solid #000;"> 
		<tr align="center">
					<th class="th" colspan="5"><%=nameComp %> HEATS</th> 
		</tr>
		<tr align="center">
					<th class="th">Day</th>
					<th class="th">Shift1</th>
					<th class="th">Shift2</th>
					<th class="th">Shift3</th>
					<th class="th">Total</th>
		</tr>
			<%
			int s1=0,s2=0,s3=0,sum=0;
			for(int i=0;i<days.size();i++){
				rs122 = cs11.executeQuery();
				while(rs122.next()){
					if(rs122.getString("TRAN_DATE").substring(6).equalsIgnoreCase(days.get(i).toString()) && rs122.getString("SHIFT").equalsIgnoreCase("1") && rs122.getString("STATUS_CODE").equalsIgnoreCase("0")){
						s1++;
					}
					if(rs122.getString("TRAN_DATE").substring(6).equalsIgnoreCase(days.get(i).toString()) && rs122.getString("SHIFT").equalsIgnoreCase("2") && rs122.getString("STATUS_CODE").equalsIgnoreCase("0")){
						s2++;
					}
					if(rs122.getString("TRAN_DATE").substring(6).equalsIgnoreCase(days.get(i).toString()) && rs122.getString("SHIFT").equalsIgnoreCase("3") && rs122.getString("STATUS_CODE").equalsIgnoreCase("0")){
						s3++;
					}
				}
				sum = s1+s2+s3;
			%>
			<tr align="center" style="background-color: #f7f7f7;cursor: pointer;font-family: Arial;font-size: 10px;" align="center">
					<td align="right"><b><%=days.get(i).toString() %></b></td>
					<td align="right"><b><%=s1 %></b></td>
					<td align="right"><b><%=s2 %></b></td>
					<td align="right"><b><%=s3 %></b></td>
					<td align="right"><b><%=sum %></b></td>
			</tr>
			<%
			sum = 0;
			s1=0;
			s2=0;
			s3=0;
			}
			%>
			</table>

</div>
<%
if(flag==true){
%>
<div style="width: 33.3%;float: left;">
<%
//exec "DIFMSHOP"."dbo"."Sel_TransactionsFoundry";1 '105', '65202', 'ADMIN', '20170301', '20170331', 'FOUNDRYERP'
comp="105";
days.clear();
con = ConnectionUrl.getDIFMShopConnection();
nameComp = "DI";
db = "DIERP";

cs11 = con.prepareCall("{call Sel_TransactionsFoundry(?,?,?,?,?,?)}");
cs11.setString(1, comp);
cs11.setString(2, "65202");
cs11.setString(3, "ADMIN");
cs11.setString(4, datefrom);
cs11.setString(5, dateto);
cs11.setString(6, db);
rs122 = cs11.executeQuery();
while (rs122.next()) {
	days.add(rs122.getString("TRAN_DATE").substring(6));
}
hashSet.clear();
hashSet.addAll(days);
days.clear();
days.addAll(hashSet);
Collections.sort(days);
%>
<table id="tbl2" class="table2excel" border="1" cellpadding=2 style="width:100%; border: 1px solid #000;"> 
		<tr align="center">
					<th class="th" colspan="5"><%=nameComp %> HEATS</th> 
			</tr>
			<tr align="center">
					<th class="th">Day</th>
					<th class="th">Shift1</th>  
					<th class="th">Shift2</th>   
					<th class="th">Shift3</th>
					<th class="th">Total</th>
			</tr>
			<%
			
			
			s1=0;s2=0;s3=0;sum=0;
			for(int i=0;i<days.size();i++){
				rs122 = cs11.executeQuery();
				while(rs122.next()){
					if(rs122.getString("TRAN_DATE").substring(6).equalsIgnoreCase(days.get(i).toString()) && rs122.getString("SHIFT").equalsIgnoreCase("1") && rs122.getString("STATUS_CODE").equalsIgnoreCase("0")){
						s1++;
					}
					if(rs122.getString("TRAN_DATE").substring(6).equalsIgnoreCase(days.get(i).toString()) && rs122.getString("SHIFT").equalsIgnoreCase("2") && rs122.getString("STATUS_CODE").equalsIgnoreCase("0")){
						s2++;
					}
					if(rs122.getString("TRAN_DATE").substring(6).equalsIgnoreCase(days.get(i).toString()) && rs122.getString("SHIFT").equalsIgnoreCase("3") && rs122.getString("STATUS_CODE").equalsIgnoreCase("0")){
						s3++;
					}
				}
				sum=s1+s2+s3;
			%>
			<tr align="center" style="background-color: #f7f7f7;cursor: pointer;font-family: Arial;font-size: 10px;" align="center">
					<td align="right"><b><%=days.get(i).toString() %></b></td>
					<td align="right"><b><%=s1 %></b></td>
					<td align="right"><b><%=s2 %></b></td>
					<td align="right"><b><%=s3 %></b></td>
					<td align="right"><b><%=sum %></b></td>
			</tr>
			<%
			sum=0;
			s1=0;
			s2=0;
			s3=0;
			}
			%>
			</table>


</div>
<div style="width: 33.3%;float: right;">
<%
//exec "DIFMSHOP"."dbo"."Sel_TransactionsFoundry";1 '105', '65202', 'ADMIN', '20170301', '20170331', 'FOUNDRYERP'
comp="105";
days.clear();
	comp = "106";
	con = ConnectionUrl.getK1FMShopConnection();
	nameComp = "MEPL UNIT III ";
	db = "K1ERP";

cs11 = con.prepareCall("{call Sel_TransactionsFoundry(?,?,?,?,?,?)}");
cs11.setString(1, comp);
cs11.setString(2, "65202");
cs11.setString(3, "ADMIN");
cs11.setString(4, datefrom);
cs11.setString(5, dateto);
cs11.setString(6, db);
rs122 = cs11.executeQuery();
while (rs122.next()) {
	days.add(rs122.getString("TRAN_DATE").substring(6));
}
hashSet.clear();
hashSet.addAll(days);
days.clear();
days.addAll(hashSet);
Collections.sort(days);
%>
<table id="tbl3" class="table2excel" border="1" cellpadding=2 style="width:100%; border: 1px solid #000;"> 
		<tr align="center">
					<th class="th" colspan="5"><%=nameComp %> HEATS</th> 
			</tr>
			<tr align="center">
					<th class="th">Day</th>
					<th class="th">Shift1</th>  
					<th class="th">Shift2</th>   
					<th class="th">Shift3</th>
					<th class="th">Total</th>
			</tr>
			<% 
			s1=0;s2=0;s3=0;sum=0;
			for(int i=0;i<days.size();i++){
				rs122 = cs11.executeQuery();
				while(rs122.next()){
					if(rs122.getString("TRAN_DATE").substring(6).equalsIgnoreCase(days.get(i).toString()) && rs122.getString("SHIFT").equalsIgnoreCase("1") && rs122.getString("STATUS_CODE").equalsIgnoreCase("0")){
						s1++;
					}
					if(rs122.getString("TRAN_DATE").substring(6).equalsIgnoreCase(days.get(i).toString()) && rs122.getString("SHIFT").equalsIgnoreCase("2") && rs122.getString("STATUS_CODE").equalsIgnoreCase("0")){
						s2++;
					}
					if(rs122.getString("TRAN_DATE").substring(6).equalsIgnoreCase(days.get(i).toString()) && rs122.getString("SHIFT").equalsIgnoreCase("3") && rs122.getString("STATUS_CODE").equalsIgnoreCase("0")){
						s3++;
					}
				}
				sum = s1+s2+s3;
			%>
			<tr  style="background-color: #f7f7f7;cursor: pointer;font-family: Arial;font-size: 10px;">
					<td align="right"><b><%=days.get(i).toString() %></b></td>
					<td align="right"><b><%=s1 %></b></td>
					<td align="right"><b><%=s2 %></b></td>
					<td align="right"><b><%=s3 %></b></td>
					<td align="right"><b><%=sum %></b></td>
			</tr>
			<%
			sum=0;
			s1=0;
			s2=0;
			s3=0;
			}
			%>
			</table>
</div>
</div>
<%
}
%>
 
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>