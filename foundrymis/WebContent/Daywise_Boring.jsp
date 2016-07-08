<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
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
<title>Daywise Boring</title>
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
<style type="text/css">
.tftable {
	font-size: 10px;
	color: #333333;
	width: 100%;
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
//fd="+firstdate+"&ld="+lastdate+"&cp="+company+"&db="+db+"&m="+month+"&y="+year);	
Connection con = null;	
Connection condisp = null;	
String comp =request.getParameter("cp");  
String db =request.getParameter("db");
String month=request.getParameter("m");
String year=request.getParameter("y");
String firstdate=request.getParameter("fd");
String lastdate=request.getParameter("ld");

String CompanyName="",matcode="";

String mnth = firstdate.substring(4, 6);

DecimalFormat zeroDForm = new DecimalFormat("#####0;-#####0");
DecimalFormat twoDForm = new DecimalFormat("###,##0.00;-###,##0.00");
month = new DateFormatSymbols().getMonths()[Integer.parseInt(month) -1];

if(comp.equalsIgnoreCase("101")){
	CompanyName = "H-21";
	con = ConnectionUrl.getMEPLH21FMShop();  
	condisp = ConnectionUrl.getMEPLH21ERP();
	  PreparedStatement ps=con.prepareStatement("select * from ENGERP..MSTMATERIALS where MATERIAL_TYPE='105'");
	  ResultSet rs=ps.executeQuery();
	  while(rs.next()){
		  matcode+=rs.getString("code");		  
	  } 
	 // System.out.println("code = " + matcode);
}else{
	CompanyName = "H-25";
	con	= ConnectionUrl.getMEPLH25FMShop();
	condisp = ConnectionUrl.getMEPLH25ERP();
	PreparedStatement ps=con.prepareStatement("select * from H25ERP..MSTMATERIALS where MATERIAL_TYPE='105'");
	ResultSet rs=ps.executeQuery();
	while(rs.next()){
		  matcode+=rs.getString("code");
	}
}  

%> 
<strong style="color: blue;font-family: Arial;font-size: 14px;"><%=CompanyName %>&nbsp;MUTHA ENGINEERING PVT.LTD. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Boring Generation Status of <%=month %>&nbsp;<%=year %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>
<br/>
<strong style="font-family: Arial;font-size: 13px;"><a href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span style="font-family: Arial;font-size: 10px;color: brown;"><b>( Note : Click on record to get details &#8628; )</b></span>
<br/>
<div style="width: 100%;padding-left: 0.1em; float: left;"> 
		<form action="PotwiseDetailReportK1.jsp" method="post" id="edit" name="edit"> 
	
	<%
	String ct = lastdate.substring(6); 
	String st = lastdate.substring(0, 6); 
	DecimalFormat formatter = new DecimalFormat("00");
	String dateTocomp = "";
	String aFormatted = "";
	
//exec "ENGFMSHOP"."dbo"."Sel_RptMachineWiseSetupStk";1 '101', '20150201', '20150222', 'ENGERP','83749832749837298739587458'
HashMap brg = new HashMap(); 
double boringwt=0;
int dayct=0;
	CallableStatement cs = con.prepareCall("{call Sel_RptMachineWiseSetupStk(?,?,?,?,?)}");
	cs.setString(1,comp);
	cs.setString(2,firstdate);
	cs.setString(3,lastdate);
	cs.setString(4,db);
	cs.setString(5,matcode);
	ResultSet rs = null;
		
	int d=0;
	String brwt="",prdqty="";
	
	for(int i=1;i<=Integer.parseInt(ct);i++){
		
			boringwt=0;
		 	aFormatted = formatter.format(i);
		 	dateTocomp=st+aFormatted; 
			rs = cs.executeQuery();
			
			while(rs.next()){
				if(rs.getString("TRAN_DATE").equalsIgnoreCase(dateTocomp)){
					brwt = rs.getString("BORING_WT");
					prdqty = rs.getString("PROD_QTY");
					if(brwt==null || brwt.length()==0){
						brwt = "0";
					}
					
					if(prdqty==null || prdqty.length()==0){
						prdqty = "0";
					} 
					boringwt += (Double.parseDouble(brwt) * Double.parseDouble(prdqty));
					d=i;					
				}
			}			
			if(d==i){ 
			brg.put(i, boringwt);
			}
	}
	
	 
	double total=0;
	Set<Integer> keys = brg.keySet();  
	for(Integer i: keys)
	{
	    total += Double.parseDouble(brg.get(i).toString());
	}
	
	HashMap sumBorGen = new HashMap(); 
	%>
			<table border="1" class="tftable">
				<tr>
					<th width="2%">Sr No</th>
					<th>Parameter</th>
					<th>DayWise&#8658;<br> Total&#8659;</th>
					<%
					for(int i=1;i<=Integer.parseInt(ct);i++){
					%>
					<th align="right"><%=i %></th>
					<%		 
					}
					%>  
				</tr>  
				<tr> 
				<tr>
					<td align="center"><strong>1</strong> </td>
					<td align="left"><strong>Generated Kgs</strong> </td> 	
					<td align="right"><strong><%=twoDForm.format(total) %></strong></td> 
					<%
					for(int i=1;i<=Integer.parseInt(ct);i++){
						
						boringwt=0;
					 	aFormatted = formatter.format(i);
					 	dateTocomp=st+aFormatted; 
						rs = cs.executeQuery();
						
						while(rs.next()){
							if(rs.getString("TRAN_DATE").equalsIgnoreCase(dateTocomp)){
								brwt = rs.getString("BORING_WT");
								prdqty = rs.getString("PROD_QTY");
								if(brwt==null || brwt.length()==0){
									brwt = "0";
								}
								
								if(prdqty==null || prdqty.length()==0){
									prdqty = "0";
								} 
								boringwt += (Double.parseDouble(brwt) * Double.parseDouble(prdqty));
															
							}
						}
						
						
						cs.setString(1,comp);
						cs.setString(2,firstdate);
						cs.setString(3,lastdate);
						cs.setString(4,db);
						cs.setString(5,matcode);
					%>
					<td align="right">
<a href="Inhouse_Boring_Generation.jsp?cp=<%=comp%>&fd=<%=firstdate%>&ld=<%=lastdate%>&db=<%=db%>&m=<%=mnth%>&y=<%=year%>&filter=<%=i%>"><%=zeroDForm.format(boringwt)%></a></td>
																			 
					<%
					sumBorGen.put(i, boringwt);
						}
					%>   
				</tr> 
				<%
				String chl="";
				double chqty=0,totalcq=0;
				HashMap cq=new HashMap();
				//exec "ENGERP"."dbo"."Sel_BoringRegister";1 '101', '0', '20140401', '20150223', '103,131'
				CallableStatement csvend = condisp.prepareCall("{call Sel_BoringRegister(?,?,?,?,?)}");
				csvend.setString(1,comp);
				csvend.setString(2,"0");
				csvend.setString(3,firstdate);
				csvend.setString(4,lastdate);
				csvend.setString(5,"103,131");
				ResultSet rsvend = null;
				for(int i=1;i<=Integer.parseInt(ct);i++){				
					chqty=0;
				 	aFormatted = formatter.format(i);
				 	dateTocomp=st+aFormatted; 
				 	rsvend = csvend.executeQuery();
					
					while(rsvend.next()){
						if(rsvend.getString("TRAN_DATE").equalsIgnoreCase(dateTocomp)){ 
							chl = rsvend.getString("CHLN_QTY"); 
							
							if(chl==null || chl.length()==0){
								chl = "0";
							} 
							chqty += Double.parseDouble(chl); 
						}
					}
					totalcq += chqty;
					cq.put(i, chqty);					
					} 
				%>
				<tr>
					<td align="center"><strong>2</strong> </td>
					<td align="left"><strong>Vendor Receipt Kgs</strong></td>
					<td align="right"><strong><%=twoDForm.format(totalcq) %></strong></td>
					<%
					for(int i=1;i<=Integer.parseInt(ct);i++){
					%>
					<td align="right">
					<a href="Inhouse_BoringReceipt.jsp?cp=<%=comp%>&fd=<%=firstdate%>&ld=<%=lastdate%>&db=<%=db%>&m=<%=mnth%>&y=<%=year%>&filter=<%=i%>">
					<%=zeroDForm.format(cq.get(i)) %></a> </td> 
					<% 
					}
					%>  
				</tr>
				<%
				double sumbore = total + totalcq;
				double daywiseSum=0;
				HashMap mpDiff = new HashMap();
				%>
				<tr style="background-color: #EBEBEB;">
					<td align="center"><strong>3</strong> </td>
					<td align="left"><strong>Sum of Boring Kgs</strong></td>
					<td align="right"><strong><%=twoDForm.format(sumbore) %></strong></td>
					<%
					for(int i=1;i<=Integer.parseInt(ct);i++){
						daywiseSum = Double.parseDouble(sumBorGen.get(i).toString()) + Double.parseDouble(cq.get(i).toString());
					%>
					<td align="right"><%=zeroDForm.format(daywiseSum) %></td> 
					<% 
					mpDiff.put(i, daywiseSum);
					}
					%>  
				</tr>
				<%
				HashMap brg_dispatch = new HashMap();
				double disQty=0,totalDisp=0;
				// exec "ENGERP"."dbo"."Sel_SaleRegister";1 '101', '0', '20150201', '20150222', '1155', '0'
				CallableStatement csdes = condisp.prepareCall("{call Sel_SaleRegister(?,?,?,?,?,?)}");
				csdes.setString(1,comp);
				csdes.setString(2, "0");
				csdes.setString(3,firstdate);
				csdes.setString(4,lastdate);
				csdes.setString(5,"1155");
				csdes.setString(6,"0");
				ResultSet rsdes = null; 
				for(int i=1;i<=Integer.parseInt(ct);i++){
					disQty=0;
					aFormatted = formatter.format(i);
		 			dateTocomp=st+aFormatted; 
		 			rsdes = csdes.executeQuery();
		 			while(rsdes.next()){
					if(rsdes.getString("TRAN_DATE").equalsIgnoreCase(dateTocomp) &&
							(rsdes.getString("MAT_CODE").equalsIgnoreCase("1013100007") ||
							rsdes.getString("MAT_CODE").equalsIgnoreCase("1013100002") ||
							 rsdes.getString("MAT_CODE").equalsIgnoreCase("1013100016") || 
							 rsdes.getString("MAT_CODE").equalsIgnoreCase("1013100017"))){ 
						 disQty += Double.parseDouble(rsdes.getString("QTY"));
						}
		 			}
		 			brg_dispatch.put(i, disQty);
		 			totalDisp += disQty;
				}
				%>				
			 	<tr>
					<td align="center"><strong>4</strong> </td>
					<td align="left"><strong>Dispatched Kgs</strong></td>
					<td align="right"><strong><%=twoDForm.format(totalDisp) %></strong></td>
					<%
					for(int i=1;i<=Integer.parseInt(ct);i++){ 
					%>
					<td align="right">
					<a href="Inhouse_BoringDispatched.jsp?cp=<%=comp%>&fd=<%=firstdate%>&ld=<%=lastdate%>&db=<%=db%>&m=<%=mnth%>&y=<%=year%>&filter=<%=i%>">
					<%=zeroDForm.format(brg_dispatch.get(i))%></a> </td>
					<%
					}
					%>  
				</tr> 
				<%
				double diffBor = sumbore - totalDisp;
				%>				
				<tr style="background-color: #EBEBEB;">
					<td align="center"><strong>5</strong> </td>
					<td align="left"><strong>Difference</strong></td>
					<td align="right"><strong><%=twoDForm.format(diffBor)%> </strong></td>
					<%
					double diff=0;
					for(int i=1;i<=Integer.parseInt(ct);i++){
						diff = Double.parseDouble(mpDiff.get(i).toString()) - Double.parseDouble(brg_dispatch.get(i).toString());
						
					%>
					<td align="right"><%=zeroDForm.format(diff) %></td> 
					<% 
					}
					%>  
				</tr>
			</table>  
<!--============================================================================-->
<!--============================================================================--> 
		</form>
	</div>
 <div style="width: 46%;float: right;"> 
 
 </div>


<%
con.close();
}catch(Exception e){
	e.printStackTrace();
}
%>

</body>
</html>