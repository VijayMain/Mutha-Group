<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
                <li><a href="Sub_ContractorStk.jsp">SUB-CONTRACTOR</a></li>
                <!-- <li><a href="Daily_Report.jsp">MEPL H25</a></li>
                <li><a href="Daily_Report.jsp">MFPL</a></li>
                <li><a href="Daily_Report.jsp">MEPL Unit III</a></li>
                <li><a href="Daily_Report.jsp">DI</a></li>  -->
                <li><a href="Configure.jsp">CONFIGURE</a></li>
                <li><a href="Add_Master.jsp" class="current">MASTER</a></li> 
            </ul>
        </div> <!-- end of tooplate_menu -->        
    </div>
</div> <!-- end of header_wrapper -->
 

<div id="tooplate_main">
    <div id="tooplate_content">
    <h4>Master Data Entry &#8658;</h4> 
    <a href="CompanyWise_Reports.jsp" style="text-decoration: none;">To configure Company wise Reports</a><br/>
    <a href="Comp_Vendor.jsp" style="text-decoration: none;">To configure Company-Report wise Vendor</a><br/>
    <a href="Configure.jsp" style="text-decoration: none;">To configure Company wise Part Names</a><br/>
    <a href="Configure.jsp" style="text-decoration: none;">To configure Sub-Contractor Stock Status</a><br/>
    
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