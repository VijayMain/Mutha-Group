<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.muthagroup.conn_Url.Connection_Util"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>SUB-CONTRACTOR</title>  
<link href="tooplate_style.css" rel="stylesheet" type="text/css" /> 
<style type="text/css">
.tftable {
	font-size: 12px;
	font-family:Arial;
	color: #333333;
	width: 980%; 
}

.tftable th {
	font-size: 13px;
	background-color: #acc8cc;  
}

.tftable tr { 
	background-color: white; 
}

.tftable td {
	font-size: 12px; 
}
</style>
</head>
<body> 
<div id="tooplate_header_wrapper">
    <div id="tooplate_header">
        <div id="site_title">
        <p>
        <marquee behavior="alternate" SCROLLAMOUNT=5 direction="right"><strong style="font-size: 14px;font-family: Arial; color: #38314A;">Mutha Group of Foundries Daily Reports</strong></marquee>
        </p> 
        </div> <!-- end of site_title -->     
        
       <!--  <div id="header_phone_no"> 
			Toll Free: <span>08 324 552 409</span></div> -->  
       
        <div id="tooplate_menu">
            <div id="home_menu"><a href="Home.jsp"></a></div>        
            <ul>
            	<li><a href="Daily_Report.jsp">DAILY SALE</a></li>
                <li><a href="RawMaterials.jsp">RAW MATERIALS</a></li>
                <li><a href="Sub_ContractorStk.jsp" class="current">SUB-CONTRACTOR</a></li>
                
         <!--   <li><a href="Daily_Report.jsp">MEPL H25</a></li>
                <li><a href="Daily_Report.jsp">MFPL</a></li>
                <li><a href="Daily_Report.jsp">MEPL Unit III</a></li>
                <li><a href="Daily_Report.jsp">DI</a></li> 	 -->
                
                <li><a href="Configure.jsp">CONFIGURE</a></li>
                <li><a href="Add_Master.jsp">MASTER</a></li>
            </ul>
        </div> <!-- end of tooplate_menu -->
    </div>
</div> <!-- end of header_wrapper -->

<div id="tooplate_main">
    <div id="tooplate_content">
<%
try{
	
%> 
<h5><b style="color:blue;">Select &#8658;</b>
<a href="Sub_ContractorStk.jsp" style="text-decoration: none;font-family: Arial;font-size: 14px;"><b style="color: green;">MFPL</b></a>&nbsp;|&nbsp;
<a href="Subcontractork1.jsp" style="text-decoration: none;font-family: Arial;font-size: 14px;"><b>MEPL Unit III</b></a>&nbsp;|&nbsp;
<a href="SubcontractorDI.jsp" style="text-decoration: none;font-family: Arial;font-size: 14px;"><b>DI</b></a>
</h5>
    
 <div  style="height: 500px;width:80%; overflow: scroll;">   
 <table class="tftable" border="1" style="width:50%;">
   <tr>
   	<th>Part Name</th>
   	<th>Customer Name</th>
   	<th>Total Stock</th>
   </tr>
   <%
   Connection con = Connection_Util.getLocalDatabase();
   Connection conerp = Connection_Util.getDIERPConnection();
   String comp = "105",chk="",mat_name="",chkvalid="";
   double addtq=0,balancesum=0,balance=0; 
   
   boolean flag = false;
   SimpleDateFormat sdfFIrst = new SimpleDateFormat("yyyyMMdd");
   Calendar cal1 = Calendar.getInstance();
   Date lastDate = cal1.getTime();
   String toDate = sdfFIrst.format(lastDate);
   String fromDate = toDate.substring(0, 6)+"01";
   
   CallableStatement cs_op = conerp.prepareCall("{call Sel_DayWiseSubContractStockLedgerFinal(?,?,?,?)}");
   cs_op.setString(1, comp);
   cs_op.setString(2, "0");
   cs_op.setString(3, fromDate);
   cs_op.setString(4, toDate);
   ResultSet rs_op = null;
   
   ArrayList chkName = new ArrayList(); 
   PreparedStatement ps = con.prepareStatement("select distinct(matname) as matname from dailyreports_config_tbl where company_id="+comp+" and reports_id=3");
   ResultSet rs = ps.executeQuery();
   while(rs.next()){
	   chkName.add(rs.getString("matname"));
   }
   
   for(int i=0;i<chkName.size();i++){
	   ps = con.prepareStatement("select * from dailyreports_config_tbl where company_id="+comp+" and reports_id=3 and matname='"+chkName.get(i).toString()+"'");
	   rs = ps.executeQuery();
	   while(rs.next()){
		   
		   rs_op = cs_op.executeQuery();
		   chk = rs.getString("cust_name");
		   mat_name = rs.getString("matname");
		while(rs_op.next()){
			if(rs_op.getString("MAT_CODE").equalsIgnoreCase(rs.getString("matcode")) && 
					rs_op.getString("AC_NO").equalsIgnoreCase(rs.getString("cust_code"))){
				
				if(chk.equalsIgnoreCase(rs_op.getString("AC_NAME"))){
					if(rs_op.getString("TOTQT")!=null){ 
					addtq = Double.parseDouble(rs_op.getString("TOTQT")) + addtq;
					balancesum = balancesum + Double.parseDouble(rs_op.getString("DESP_QTY")); 
					}
				}else{
					if(rs_op.getString("TOTQT")!=null){
						addtq = Double.parseDouble(rs_op.getString("TOTQT"));
						balancesum = balancesum + Double.parseDouble(rs_op.getString("DESP_QTY")); 
					}
				}
			} 
		}
		%>
		
		<tr>
		<%
		if(chkvalid==""){
		%>
			<td><%=mat_name %></td>
		<%
		}
		if(!mat_name.equalsIgnoreCase(chkvalid) && chkvalid!=""){
		%>
			<td><%=mat_name %></td>
		<%
		}
		
		if(mat_name.equalsIgnoreCase(chkvalid) && chkvalid!=""){
		%>
			<td>&nbsp;</td>
		<%	
		}
		
		%>	 
			<td><%=chk %></td>
			<%
			balance = balancesum - addtq;	
			%>
			<td align="right"><%=Math.round(balance) %></td>
		</tr>
		
		<%
			addtq=0;
			chk="";
			chkvalid=mat_name;
			balancesum=0;
			balance=0;
	   		}
	   		flag=false;
  		}
   		%>
   
   <%-- <%
   if(flag==false){
   %>
   	<td><b><%=rs.getString("matname") %></b></td>
   <%
   flag=true;
   }else{
   %>
   <td>&nbsp;</td>
   <%   
   }
   %>	
   	<td><%=rs.getString("cust_name") %></td>
   	<%
   	if(!rs_op.getString("TOTQT").equalsIgnoreCase("") || rs_op.getString("TOTQT")!=null){
   	%>
   	<td align="right"><%=Math.round(Double.parseDouble(rs_op.getString("TOTQT"))) %></td>
   	<%
   	}else{
   	%>
   	<td align="right">&nbsp;</td>
   	<%		
   	}
   	%> --%>
   
</table>
</div>
<%
con.close();
conerp.close();
}catch(Exception e){
	e.printStackTrace();
}
%>
        <div class="cleaner_h30"></div>
    </div>
</div>
<div class="cleaner"></div>
<div class="cleaner"></div>
<div id="tooplate_footer_wrapper">

     <div id="tooplate_footer" style="color: white;">
     <%
     DateFormat formatter   = new SimpleDateFormat("dd/MM/yyyy"); 
     Date footer_date = new Date();
     %>
    <a href="http://www.muthagroup.com/" style="text-decoration: none;color: white;"><strong>Mutha Group of Foundries</strong> </a> &nbsp; | &nbsp; 
<strong>Mail to :</strong>&nbsp;
<a style="text-decoration: none;color: white;" href="mailto:itsupports@muthagroup.com?Subject=Need%20Assistance" target="_top">itsupports@muthagroup.com</a>&nbsp; | &nbsp;
Date :&nbsp;<strong><%=formatter.format(footer_date) %></strong> 
    
    </div> <!-- end of tooplate_footer -->

</div> 
    
</body>
</html>