<%@page import="java.util.HashSet"%>
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
<title>Rate Amendment Summary</title>
</head> 
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
	border-style: solid;
	border-color: #729ea5;
}
</style>
<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = '#FFFFFF';
		}
	}
</script>
<script language="javascript">
	function button1(val,val1,val2,val3,val4) {
		var subgl = val;
		var comp = val1;
		var from = val2;
		var to = val3;
		var name = val4;
		window.location="RateAmend_Details.jsp?sub="+subgl+"&comp="+comp+"&from="+from+"&to="+to+"&name="+name;
	}
	function button2(val,val1,val2,val3) {
		var name = val;
		var comp = val1;
		var from = val2;
		var to = val3; 
		window.location="RateAmendReduction_Details.jsp?name="+name+"&comp="+comp+"&from="+from+"&to="+to;
	}
</script>
<body bgcolor="#EBE4E7" style="font-family: Arial;">
<%
try{
	Connection con=null;
	Connection con25=null;
	String comp =request.getParameter("comp");
	String compall =request.getParameter("comp");
	String from =request.getParameter("from"); 
	String to =request.getParameter("to"); 
	
	
	
	String matcode ="";
	String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
	String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);

	DecimalFormat zeroDForm = new DecimalFormat("#####0.00");


	String group="";
	int ct=0;
	String CompanyName="",compName2="",compName3="";
	if(comp.equalsIgnoreCase("101")){
		CompanyName = "H-21";
		compName2 = "H-21";
		con = ConnectionUrl.getMEPLH21ERP();  
	}
	if(comp.equalsIgnoreCase("102")){
		CompanyName = "H-25";
		compName2 = "H-25";
		con	= ConnectionUrl.getMEPLH25ERP(); 
	}
	if(comp.equalsIgnoreCase("all")){
		CompanyName = "H-25 & H-21";
		compName2 = "H-21";
		compName3 = "H-25";
		comp="101";
		con25	= ConnectionUrl.getMEPLH25ERP(); 
		con = ConnectionUrl.getMEPLH21ERP();
	}
	%>
	<div style="width: 100%; float: left;">
	<strong style="color: blue;font-family: Arial;font-size: 14px;"><%=CompanyName %>&nbsp;MUTHA ENGINEERING PVT.LTD. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
	<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Rate Amendment Summary Report from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>

	<strong style="font-family: Arial;font-size: 13px;"><a href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	<%-- <span id="exportId"> 
	<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=from%>','<%=to%>')" style="cursor: pointer;font-family: Arial;font-size: 12px;">Generate Excel</button>
	<img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;"/>
	</span>  --%>
	</div>
		 <div style="width:54.5%; float: left;">
	 		<table border="1" class="tftable"> 
				<tr style="font-family: Arial;font-size: 13px;">
					<th scope="col" colspan="4"><b style="font-size: 13px;"><%=compName2 %> Rate Amendment Received</b></th> 
				</tr>
				<tr style="font-family: Arial;font-size: 12px;">
					<th scope="col" width="9%">Sr. No.</th>
					<th scope="col" width="50%;">Customer Name</th>
					<th scope="col">Basic Amount </th>
					<th scope="col">Bill Amount</th>
				</tr> 
				<%
				// exec "ENGERP"."dbo"."Sel_SaleRegisterForAudit";1 '101', '0', '20140401', '20150329', '11525,11510,11515', '0'
				ArrayList subglno = new ArrayList();
				CallableStatement cs = con.prepareCall("{call Sel_SaleRegisterForAudit(?,?,?,?,?,?)}");
				cs.setString(1,comp);
				cs.setString(2,"0");
				cs.setString(3,from);
				cs.setString(4,to);
				cs.setString(5,"11525,11510,11515"); 
				cs.setString(6,"0");
				ResultSet rs = cs.executeQuery(); 
				while(rs.next()){
					subglno.add(rs.getString("SUB_GLACNO"));
				}
				HashSet hs = new HashSet();
				hs.addAll(subglno);   
				subglno.clear();
				subglno.addAll(hs);
				subglno.remove(null); 
				
				ResultSet rs_up=null;
				String name ="";
				double billamount=0,basicamount=0,billtotal=0,basictotal=0; 
				
				for(int i=0;i<subglno.size();i++){
					rs_up=cs.executeQuery();
					while(rs_up.next()){
					if(subglno.get(i).toString().equalsIgnoreCase(rs_up.getString("SUB_GLACNO"))){
						name = rs_up.getString("CUSTOMER_NAME"); 
						basicamount = basicamount +  Double.parseDouble(rs_up.getString("BASIC_AMT")); 
						billamount = billamount + Double.parseDouble(rs_up.getString("BILL_AMOUNT"));
					}
					}
				%>
				<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);"
						onclick="button1('<%=subglno.get(i).toString() %>','<%=comp %>','<%=from %>','<%=to %>','<%=name %>');" style="cursor: pointer;" title="Click To Get Details">
					<td scope="col" align="center"><b><%=i+1 %></b></td>
					<td scope="col" align="left"><%=name %></td>
					<td scope="col" align="right"><%=zeroDForm.format(basicamount) %></td>
					<td scope="col" align="right"><%=zeroDForm.format(billamount) %></td>
				</tr> 
				<%
				basictotal = basictotal + Double.parseDouble(zeroDForm.format(basicamount));
				billtotal = billtotal + Double.parseDouble(zeroDForm.format(billamount));
				
				basicamount=0;    
				billamount=0;
				}
				%>
				<tr style="font-family: Arial;font-size: 13px;"> 
					<td scope="col" align="right" colspan="2"><b>Grand Total </b>&#8658;</td>
					<td scope="col" align="right"><b><%=zeroDForm.format(basictotal) %></b></td>
					<td scope="col" align="right"><b><%=zeroDForm.format(billtotal) %></b></td>
				</tr> 
			</table>
			<br>  
			<%
			ArrayList acName_List = new ArrayList();
			// exec "ENGERP"."dbo"."Sel_GRNRegister";1 '101', '0', '2027,20219', '20150301', '20150329', '103'
						CallableStatement cs_rc = con.prepareCall("{call Sel_GRNRegister(?,?,?,?,?,?)}");
							cs_rc.setString(1,comp);
							cs_rc.setString(2,"0");
							cs_rc.setString(3,"2027,20219");
							cs_rc.setString(4,from);
							cs_rc.setString(5,to); 
							cs_rc.setString(6,"103");
							ResultSet rs21 = cs_rc.executeQuery(); 
							while(rs21.next()){
							acName_List.add(rs21.getString("AC_NAME"));	
							}
							
							HashSet hsnm = new HashSet();
							hsnm.addAll(acName_List);   
							acName_List.clear();
							acName_List.addAll(hsnm);
							acName_List.remove(null); 	 
			%> 
			<table border="1" class="tftable"> 
				<tr style="font-family: Arial;font-size: 14px;">
					<th scope="col" colspan="3"><b style="font-size: 14px;"><%=compName2 %> Rate Reduction Given</b></th> 
				</tr>
				<tr style="font-family: Arial;font-size: 13px;"> 
					<th scope="col" align="center" width="9%"><b>Sr. No.</b></th>
					<th scope="col" align="left">Supplier Name</th>
					<th scope="col" align="left">Basic Amount</th>
				</tr> 
				 <%
				 ResultSet rsUp21 = null;
				 String ac_Name = "";
				 double amount=0;
				 double sumAmount =0;
				 for(int i=0;i<acName_List.size();i++){
					 rsUp21 = cs_rc.executeQuery();
						while(rsUp21.next()){
						if(acName_List.get(i).toString().equalsIgnoreCase(rsUp21.getString("AC_NAME"))){
							ac_Name = rsUp21.getString("AC_NAME");
							amount = amount + Double.parseDouble(rsUp21.getString("AMOUNT"));
						}
						}
				%>
				<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" style="font-family: Arial;font-size: 13px; cursor: pointer;" onclick="button2('<%=ac_Name%>','<%=comp %>','<%=from %>','<%=to %>');"   title="Click To Get Details">
					<td scope="col" align="center" width="9%"><b><%=i+1 %></b></td>
					<td scope="col" align="left"><%=ac_Name %></td>
					<td scope="col" align="right"><%=zeroDForm.format(amount) %></td>
				</tr>
				<%		
				sumAmount = sumAmount + Double.parseDouble(zeroDForm.format(amount));
				amount = 0;
						}
				 %>			
				 <tr  style="font-family: Arial;font-size: 13px; cursor: pointer;"> 
					<td scope="col" align="right" colspan="2"><b>Total</b>&#8658;</td> 
					<td scope="col" align="right"><%=zeroDForm.format(sumAmount) %></td>
				</tr>	 
			</table>			
			<% 
			sumAmount=0;
			if(CompanyName.equalsIgnoreCase("H-25 & H-21")){			
			%>			
			<br>
			<table border="1" class="tftable"> 
				<tr style="font-family: Arial;font-size: 14px;">
					<th scope="col" colspan="4"><b style="font-size: 14px;"><%=compName3 %> Rate Amendment Received</b></th> 
				</tr>
				<tr style="font-family: Arial;font-size: 12px;">
					<th scope="col" width="9%">Sr. No.</th>
					<th scope="col" width="50%;">Customer Name</th>
					<th scope="col">Basic Amount </th>
					<th scope="col">Bill Amount</th>  
				</tr> 
				<%
				// exec "ENGERP"."dbo"."Sel_SaleRegisterForAudit";1 '101', '0', '20140401', '20150329', '11525,11510,11515', '0'
				subglno.clear();
				CallableStatement cs25 = con25.prepareCall("{call Sel_SaleRegisterForAudit(?,?,?,?,?,?)}");
				cs25.setString(1,"102");
				cs25.setString(2,"0");
				cs25.setString(3,from);
				cs25.setString(4,to);
				cs25.setString(5,"11525,11510,11515"); 
				cs25.setString(6,"0");
				ResultSet rs25 = cs25.executeQuery(); 
				while(rs25.next()){
					subglno.add(rs25.getString("SUB_GLACNO")); 
				}
				HashSet hs25 = new HashSet();
				hs25.addAll(subglno);   
				subglno.clear();
				subglno.addAll(hs25);
				subglno.remove(null); 
				 
				ResultSet rs_up25=null;
				name ="";
				billamount=0;
				basicamount=0;
				billtotal=0;
				basictotal=0; 
				
				for(int i=0;i<subglno.size();i++){
					rs_up25=cs25.executeQuery();
					while(rs_up25.next()){
					if(subglno.get(i).toString().equalsIgnoreCase(rs_up25.getString("SUB_GLACNO"))){
						name = rs_up25.getString("CUSTOMER_NAME"); 
						basicamount = basicamount +  Double.parseDouble(rs_up25.getString("BASIC_AMT")); 
						billamount = billamount + Double.parseDouble(rs_up25.getString("BILL_AMOUNT"));
					}
					}
				%>
				 <tr  onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);"
						onclick="button1('<%=subglno.get(i).toString() %>','102','<%=from %>','<%=to %>','<%=name %>');" style="cursor: pointer;" title="Click To Get Details">
					<td scope="col" align="center"><b><%=i+1 %></b></td>
					<td scope="col" align="left"><%=name %></td>
					<td scope="col" align="right"><%=zeroDForm.format(basicamount) %></td>
					<td scope="col" align="right"><%=zeroDForm.format(billamount) %></td>
				</tr> 
				<%
				basictotal = basictotal + Double.parseDouble(zeroDForm.format(basicamount));
				billtotal = billtotal + Double.parseDouble(zeroDForm.format(billamount));
				
				basicamount=0;
				billamount=0;
				}
				%>
				<tr style="font-family: Arial;font-size: 13px;"> 
					<td scope="col" align="right" colspan="2"><b>Grand Total </b>&#8658;</td>
					<td scope="col" align="right"><b><%=zeroDForm.format(basictotal) %></b></td>
					<td scope="col" align="right"><b><%=zeroDForm.format(billtotal) %></b></td>
				</tr> 
			</table>  
			 <br>
			<!-- ****************************************************************************************************** -->
			<!-- ****************************************************************************************************** -->
			<%
			ArrayList acName25_List = new ArrayList();
			// exec "ENGERP"."dbo"."Sel_GRNRegister";1 '101', '0', '2027,20219', '20150301', '20150329', '103'
						CallableStatement cs_rc25 = con25.prepareCall("{call Sel_GRNRegister(?,?,?,?,?,?)}");
							cs_rc25.setString(1,"102");
							cs_rc25.setString(2,"0");
							cs_rc25.setString(3,"2027,20219");
							cs_rc25.setString(4,from);
							cs_rc25.setString(5,to); 
							cs_rc25.setString(6,"103");
							ResultSet rsRC25 = cs_rc25.executeQuery(); 
							while(rsRC25.next()){
								acName25_List.add(rsRC25.getString("AC_NAME"));	
							}
							
							HashSet hsRC = new HashSet();
							hsRC.addAll(acName25_List);   
							acName25_List.clear();
							acName25_List.addAll(hsRC);
							acName25_List.remove(null); 	 
			%> 
			<table border="1" class="tftable"> 
				<tr style="font-family: Arial;font-size: 14px;">
					<th scope="col" colspan="3"><b style="font-size: 14px;"><%=compName3 %> Rate Reduction Given</b></th> 
				</tr>
				<tr style="font-family: Arial;font-size: 13px;"> 
					<th scope="col" align="center" width="9%"><b>Sr. No.</b></th>
					<th scope="col" align="left">Supplier Name</th>
					<th scope="col" align="left">Basic  Amount</th>
				</tr> 
				 <%
				 ResultSet rsUpRC25 = null;
				 ac_Name = "";
				 amount=0;
				 double grantSum2 = 0; 
				 for(int i=0;i<acName25_List.size();i++){
					 rsUpRC25 = cs_rc25.executeQuery();
						while(rsUpRC25.next()){
						if(acName25_List.get(i).toString().equalsIgnoreCase(rsUpRC25.getString("AC_NAME"))){ 
							ac_Name = rsUpRC25.getString("AC_NAME");
							amount = amount + Double.parseDouble(rsUpRC25.getString("AMOUNT"));
						}
						}
				%>
				<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);"  style="font-family: Arial;font-size: 13px;cursor: pointer;" onclick="button2('<%=ac_Name%>','102','<%=from %>','<%=to %>');"   title="Click To Get Details">
					<td scope="col" align="center" width="9%"><b><%=i+1 %></b></td>
					<td scope="col" align="left"><%=ac_Name %></td>
					<td scope="col" align="right"><%=zeroDForm.format(amount) %></td>
				</tr>
				<%
				grantSum2 = grantSum2 + Double.parseDouble(zeroDForm.format(amount));
				amount = 0;
						}
				 %>		
				 <tr style="font-family: Arial;font-size: 14px;cursor: pointer;">
				 <td scope="col" align="right" colspan="2"><b>Total</b>&#8658;</td> 
					<td scope="col" align="right"><%=zeroDForm.format(grantSum2) %></td>
				</tr>		 
			</table>  
				<!-- ****************************************************************************************************** -->
				<!-- ****************************************************************************************************** -->
			<%
			grantSum2 =0;
			} 
			%>
	</div>
 <div style="width: 45%;float: right;"> 
<!--  <table border="1" class="tftable"> 
				<tr style="font-family: Arial;font-size: 14px;">
					<th scope="col" colspan="3"><b style="font-size: 14px;">Rate Amendment Given</b></th> 
				</tr>
				<tr style="font-family: Arial;font-size: 13px;"> 
					<th scope="col" align="center" width="9%"><b>Sr. No.</b></th>
					<th scope="col" align="left">Customer Name</th>
					<th scope="col" align="left">Amount</th>
				</tr>
				 
			</table>  
			<br>
			<table border="1" class="tftable"> 
				<tr style="font-family: Arial;font-size: 14px;">
					<th scope="col" colspan="3"><b style="font-size: 14px;">Rate Reduction Given</b></th> 
				</tr>
				<tr style="font-family: Arial;font-size: 13px;"> 
					<th scope="col" align="center" width="9%"><b>Sr. No.</b></th>
					<th scope="col" align="left">Customer Name</th>
					<th scope="col" align="left">Amount</th>
				</tr>
			</table> -->
 </div>
<%
con.close();
con25.close();
}catch(Exception e){
	e.printStackTrace();
}
%>

</body>
</html>