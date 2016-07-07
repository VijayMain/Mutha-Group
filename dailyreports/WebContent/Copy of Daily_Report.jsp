<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.conn_Url.Connection_Util"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="refresh" content="1800" />
<title>Daily Report</title>  
<link href="tooplate_style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.tftable {
	font-size: 10px;
	font-family:Arial;
	color: #333333;
	width: 980%; 
}

.tftable th {
	font-size: 11px;
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
	//------------------------------- Date Logic --------------------------------------------------------
	SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat sdfDate = new SimpleDateFormat("dd/MM/yyyy");
	Calendar first_Datecal = Calendar.getInstance();   
	first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
	Date dddd = first_Datecal.getTime(); 
	Date tdate = new Date(); 
	String firstDate = sdfFIrstDate.format(dddd);
	String nowDate = sdfFIrstDate.format(tdate);
	String DateCurr = sdfDate.format(tdate); 
	//-----------------------------------------------------------------------------------------------------
	Connection con = Connection_Util.getMEPLH21ERP();
	Connection con_Local = Connection_Util.getLocalDatabase();
	PreparedStatement ps_rep=null;
	ResultSet rs_rep=null;
	DecimalFormat zeroDForm = new DecimalFormat("###,##0.##");
	
	HashMap bomraw = new HashMap();
	
	PreparedStatement ps_bom =con.prepareStatement("select * from MSTMATBOMRAW");
	ResultSet rs_bom = ps_bom.executeQuery();
	while(rs_bom.next()){ 
		bomraw.put(rs_bom.getString("MAT_CODE"),rs_bom.getString("REF_MATCODE"));	
	} 
%>
<div id="tooplate_header_wrapper"> 
    <div id="tooplate_header"> 
        <div id="site_title">
        <p>
        <marquee behavior="alternate" SCROLLAMOUNT=5 direction="right"><strong style="font-size: 14px;font-family: Arial; color: #38314A;">Mutha Group of Foundries Daily Reports</strong></marquee>
        </p> 
        </div> <!-- end of site_title -->        
        <!-- <div id="header_phone_no"> 
			Toll Free: <span>08 324 552 409</span> 
        </div>  -->
        <div id="tooplate_menu"> 	
            <div id="home_menu"><a href="Home.jsp"></a></div>                
            <ul>
                <li><a href="Daily_Report.jsp" class="current">MEPL H21</a></li>
                <li><a href="Daily_Report.jsp">MEPL H25</a></li>
                <li><a href="Daily_Report.jsp">MFPL</a></li>
                <li><a href="Daily_Report.jsp">MEPL Unit III</a></li>
                <li><a href="Daily_Report.jsp">DI</a></li> 
                <li><a href="Configure.jsp">Configure</a></li>
                <li><a href="Add_Master.jsp">Add Master</a></li> 
            </ul>
        </div> <!-- end of tooplate_menu -->        
    </div>
</div> <!-- end of header_wrapper -->
<div id="tooplate_main">
    <div id="tooplate_content">
        <table class="tftable" border="1" style="width:49%;">
        <tr align="center">
			<td colspan="10" align="left" style="font-size: 13px;"><b>Daily Sale Report &#8658;</b></td>
		</tr>
        <%
        int sr_no=1;
        String repName="",partName="";
        double recd = 0,dayrecd=0,avg=0;
        int avgrec=1;
        PreparedStatement ps = con_Local.prepareStatement("select * from company_report_rel_tbl where company_id=101");
    	ResultSet rs = ps.executeQuery();
    	
    	// exec "ENGERP"."dbo"."Sel_GRNRegister";1 '101', '0', '2025,2026', '20150501', '20150524', '103'
		CallableStatement cs11 = con.prepareCall("{call Sel_GRNRegister(?,?,?,?,?,?)}");
		cs11.setString(1,"101");
		cs11.setString(2,"0");
		cs11.setString(3,"2025,2026");	
		cs11.setString(4,firstDate);
		cs11.setString(5,nowDate);
		cs11.setString(6,"103");
		ResultSet rs122 = null;
    	
    	
    	while(rs.next()){
    		PreparedStatement ps_repName = con_Local.prepareStatement("select * from reports_tbl where reports_id="+rs.getInt("reports_id"));
    		ResultSet rs_repName = ps_repName.executeQuery();
    		while(rs_repName.next()){
    			repName = rs_repName.getString("report");
    			}
        	%>
        		<tr align="center">
				<td colspan="12" align="left"><b style="color: blue;"><%=sr_no %>&nbsp; &#8658; </b> <b  style="color: blue;"><%=repName %></b></td>
			<%
				sr_no++;
			%>
				</tr>
				<tr>
				<th>&nbsp;</th>
				<th colspan="3">Receipt</th>
				<th colspan="3">Production</th>
				<th colspan="3">Dispatch</th>   
				</tr>
				<tr>
					<th>Date</th>
					<th>Day Receipt</th>
					<th>Cumm</th>
					<th>Avg</th>
					<th>Day Prod</th>
					<th>Cumm</th>
					<th>Avg</th>
					<th>Day Disp</th>
					<th>Cumm</th>
					<th>Avg</th> 
				</tr>
				<%
				ps_rep = con_Local.prepareStatement("select * from dailyreports_config_tbl where reports_id="+rs.getInt("reports_id")+" and company_id=101");
	        	rs_rep = ps_rep.executeQuery();
	        	while(rs_rep.next()){
	        		rs122 = cs11.executeQuery();
	        		while(rs122.next()){
	        			 
	        		    String  id = rs_rep.getString("matcode");
	        		    if(bomraw.containsKey(id)){
	        		    	/* if(rs_rep.getString("matcode").equalsIgnoreCase(bomraw.get(rs122.getString("MATCODE")).toString())){	        		    		
		        				//	System.out.println("data to be shown = " + rs_rep.getString("MATCODE")+ " test = "+rs122.getString("RECD_QTY")); 
		        				recd = recd + Double.parseDouble(rs122.getString("RECD_QTY"));
		        				avgrec++;
		        				partName = rs122.getString("MATNAME");
		        				if(rs122.getString("TRAN_DATE").equalsIgnoreCase(nowDate)){
		        		    		dayrecd = dayrecd + Double.parseDouble(rs122.getString("RECD_QTY"));
		        		    	}
		        			} */
	        		    	System.out.println("Key matched with ID "+bomraw.get(rs122.getString("MATCODE")).toString());	        		    	
	        		    } else{
	        		        System.out.println("Key not matched with ID");
	        		    }
	        			
	        			/* System.out.println("data to be shown before = " + rs_rep.getString("matcode"));
	        			System.out.println("data to be shown before2222 = " + bomraw.get(rs122.getString("MATCODE")).toString());
	        			if(rs_rep.getString("matcode").equalsIgnoreCase(bomraw.get(rs122.getString("MATCODE")).toString())){
	        				System.out.println("data to be shown = " + rs122.getString("MATCODE"));
	        			} */
	        		}
	        	}	
	        	avg = recd/avgrec;
	    %>
	    		<tr align="center">
					<td colspan="10" align="left"><b><%=partName %>&#8658;</b></td>
				</tr>
	    		<tr>
					<td align="center"><b><%=DateCurr %></b></td>
					<td align="right"><b><%=dayrecd %></b></td>
					<td align="right"><b><%=recd %></b></td>
					<td align="right"><b><%=zeroDForm.format(avg) %></b></td>
					<td>Day Prod</td>
					<td>Cumm</td>
					<td>Avg</td>
					<td>Day Disp</td>
					<td>Cumm</td>
					<td>Avg</td> 
				</tr>
	    <%
	        	
        	rs_rep.close();
        }
		%>
        </table>       
        <div class="cleaner_h30"></div>
    </div>        
        <!-- <div class="button float_r"><a href="#">More...</a></div> -->
        <!-- <div class="image_wrapper fl_img"><img src="images/tooplate_image_01.jpg" alt="Image 01" /></div> -->
        <!-- <div class="button float_r"><a href="#">More...</a></div> -->
        <!-- <div class="cleaner_h30 horizon_divider"></div> -->        
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