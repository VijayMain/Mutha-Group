<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.CallableStatement"%>
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
<title>Configure Reports</title>  
<link href="tooplate_style.css" rel="stylesheet" type="text/css" /> 
<style type="text/css">
.tftable { 
	font-family:Arial;
	color: #333333; 
}

.tftable th { 
	background-color: #acc8cc;  
}

.tftable tr {
	background-color: white; 
}

.tftable td {
	font-size: 10px; 
}
</style>
</head>
<body> 
<%
try{
	Connection con = Connection_Util.getLocalDatabase();	
	//------------------------------- Date Logic --------------------------------------------------------
		SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdfDate = new SimpleDateFormat("dd/MM/yyyy");
		Calendar first_Datecal = Calendar.getInstance();   
		first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
		Date dddd = first_Datecal.getTime(); 
		Date tdate = new Date(); 
		String firstDate = sdfFIrstDate.format(dddd); 
		
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		Date lastDate = cal.getTime();
		String nowDate = sdfFIrstDate.format(lastDate);
		
		String DateCurr = sdfDate.format(lastDate); 
		String date_fullfirst = sdfDate.format(dddd);
		
		Date d = new Date();
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }; 			
		if (weekday[d.getDay()].equals("Wednesday")) {
			Calendar cal2 = Calendar.getInstance();
			cal2.add(Calendar.DATE, -2);
			Date lastDate2 = cal2.getTime();
			nowDate = sdfFIrstDate.format(lastDate2);
		}
		System.out.println("Yesterday's date DI = "+ nowDate);	
		// System.out.println("date = " + firstDate + "date 2  = " + date_fullfirst);	
		//-----------------------------------------------------------------------------------------------------
%>
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
                <li><a href="RawMaterials.jsp" class="current">RAW MATERIALS</a></li>
                <li><a href="Sub_ContractorStk.jsp">SUB-CONTRACTOR</a></li>
                <!-- <li><a href="Daily_Report.jsp">MEPL H25</a></li>
                <li><a href="Daily_Report.jsp">MFPL</a></li>
                <li><a href="Daily_Report.jsp">MEPL Unit III</a></li>
                <li><a href="Daily_Report.jsp">DI</a></li>  -->
                <li><a href="Configure.jsp">CONFIGURE</a></li>
                <li><a href="Add_Master.jsp">MASTER</a></li> 
            </ul>
        </div> <!-- end of tooplate_menu -->        
    </div>
</div> <!-- end of header_wrapper -->
 

<div id="tooplate_main">
    <div id="tooplate_content">
    <h5><b style="color:blue;">Select &#8658;</b>
    <a href="RawMaterials.jsp" style="text-decoration: none;font-family: Arial;font-size: 14px;"><b>MFPL</b></a>&nbsp;|&nbsp;
<a href="RawMaterials_k1.jsp" style="text-decoration: none;font-family: Arial;font-size: 14px;"><b>MEPL Unit III</b></a>&nbsp;|&nbsp;
<a href="RawMaterials_DI.jsp" style="text-decoration: none;font-family: Arial;font-size: 14px;"><b style="color: green;">DI</b></a>
    </h5>
    <h6>DI RAW MATERIAL REPORT &#8658;</h6>
 	<table class="tftable" border="1" style="width:50%;font-family: Arial">
 		<tr align="center" style="font-size: 12px;">
 			<th width="25%"><b>Party Name</b></th>
			<th><b>Date</b></th>
			<th><b>Qty in Kgs.</b></th>
			<th><b>Rate per Kg.</b></th> 
			<th><b>Total Rate</b></th>
		</tr>
 	<% 	
 	boolean flag = false;
 	PreparedStatement ps = con.prepareStatement("select * from dailyreports_config_tbl where company_id=105 and reports_id=2");
 	ResultSet rs = ps.executeQuery();
 	while(rs.next()){
 	%> 	
        <tr align="left" style="background-color: #E3E3E3;font-size: 11px;">
			<td colspan="5">&nbsp;&nbsp;&nbsp;<b  style="color: blue"><%=rs.getString("matname") %> &#8658;</b></td>
		</tr> 
		<%
		Connection conDI = Connection_Util.getDIERPConnection();	
		
		// exec "FOUNDRYERPNEW"."dbo"."Sel_GRNRegister";1 '103', '0', '2025,2026', '20150601', '20150610', '103'
		
		CallableStatement cs22 = conDI.prepareCall("{call Sel_GRNRegister(?,?,?,?,?,?)}");
		cs22.setString(1,"105");
		cs22.setString(2,"0"); 
		cs22.setString(3,"2025,2026"); 
		cs22.setString(4,nowDate);
		cs22.setString(5,nowDate); 
		cs22.setString(6,"103,104");
		ResultSet rs22 = cs22.executeQuery();
		while(rs22.next()){	
			if(rs22.getString("MATCODE").equalsIgnoreCase(rs.getString("matcode"))){		
		%>
		<tr align="right"  style="font-size: 9px;">
			<td align="left"><b><%=rs22.getString("AC_NAME") %></b></td>
			<td><%=rs22.getString("PRN_TRANDATE")  %></td>
			<td><%=rs22.getString("RECD_QTY") %></td>
			<td><%=rs22.getString("RATE") %></td>
			<td><%=rs22.getString("RATE") %></td> 
		</tr>
	<%
	flag=true;
			}
		}
		
		if(flag==false){
			%>
			 <tr align="right" style="font-size: 9px;">
					<td align="center">- - - -</td>
					<td align="center">- - - -</td>
					<td align="center">- - - -</td>
					<td align="center">- - - -</td>
					<td align="center">- - - -</td>  
				</tr>
			<%		
				}
				flag=false;
 	}
	%>	
	</table>		
 
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
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>