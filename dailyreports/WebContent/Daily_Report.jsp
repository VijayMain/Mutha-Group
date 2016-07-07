<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="javax.swing.plaf.basic.BasicScrollPaneUI.VSBChangeListener"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.HashSet"%>
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
	String matcode="";
	
	ArrayList vdName = new ArrayList();

	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.DATE, -1);
	Date lastDate = cal.getTime();
	String nowDate = sdfFIrstDate.format(lastDate);
	String DateCurr = sdfDate.format(lastDate); 
	System.out.println("Yesterday's date = "+ nowDate + " last date = "+DateCurr);	
	//-----------------------------------------------------------------------------------------------------
	
	Connection con = Connection_Util.getMEPLH21ERP();
	Connection con_ENGFMSHOP = Connection_Util.getMEPLH21FMShop();
	Connection con_Local = Connection_Util.getLocalDatabase();
	
	//-----------------------------------------------------------------------------------------------------
	
	PreparedStatement ps_rep=null,ps_rep2=null;
	ResultSet rs_rep=null;
	DecimalFormat twoDForm = new DecimalFormat("##0.##");
	DecimalFormat zeroDForm = new DecimalFormat("##0");
	// *****************************************************************************************************
	// ************************************ RECEIPT PRODUCTION DETAILS *************************************
	// *****************************************************************************************************
	PreparedStatement psmat=con.prepareStatement("select * from MSTCOMMEMPLOYEE");
	ResultSet rsmat=psmat.executeQuery();
	while(rsmat.next()){
		matcode+=rsmat.getString("CODE");
	}
	
	ArrayList matop = new ArrayList();
	String opString = "";
	PreparedStatement psmat_op=con.prepareStatement("select * from MSTMATOPERATION where IS_NEXTPDISTAGE=1");
	ResultSet rsmat_op=psmat_op.executeQuery();
	while(rsmat_op.next()){
		opString = rsmat_op.getString("MAT_CODE")+rsmat_op.getString("OPERATION_CODE"); 
		matop.add(opString);
	}	

	// exec "ENGFMSHOP"."dbo"."Sel_RptDailyProductionSupWise";1 '101', '20150601', '20150619', 'ENGERP', 'matcode'	

	ArrayList prod_op = new ArrayList();
	int a=0;
	String prod_opstring ="";
		CallableStatement cs_op = con_ENGFMSHOP.prepareCall("{call Sel_RptDailyProductionSupWise(?,?,?,?,?)}");
		cs_op.setString(1, "101"); 
		cs_op.setString(2, firstDate);
		cs_op.setString(3, nowDate);
		cs_op.setString(4, "ENGERP");
		cs_op.setString(5, matcode);
		ResultSet rs_op = cs_op.executeQuery();
		while(rs_op.next()){
			prod_opstring = rs_op.getString("PRODUCT_CODE") + rs_op.getString("OPERATION_CODE"); 
			if(matop.contains(prod_opstring)){ 
				prod_op.add(prod_opstring); 
			}
			a++;
		} 
		
		HashSet hs = new HashSet();
		hs.addAll(prod_op);
		prod_op.clear();
		prod_op.addAll(hs); 
	//*****************************************************************************************************
%>
<div id="tooplate_header_wrapper"> 
    <div id="tooplate_header"> 
        <div id="site_title">
        <p>
        <marquee behavior="alternate" SCROLLAMOUNT=5 direction="right"><strong style="font-size: 14px;font-family: Arial; color: #38314A;">Mutha Group of Foundries Daily Reports</strong></marquee>
        </p> 
        </div> <!-- end of site_title -->        
        <!-- <div id="header_phone_no"> Toll Free: <span>08 324 552 409</span> </div>  -->
        <div id="tooplate_menu"> 	
            <div id="home_menu"><a href="Home.jsp"></a></div>                
            <ul>
                <li><a href="Daily_Report.jsp" class="current">DAILY SALE</a></li>
                <li><a href="RawMaterials.jsp">RAW MATERIALS</a></li>
                <li><a href="Sub_ContractorStk.jsp">SUB-CONTRACTOR</a></li>
                <!-- <li><a href="Daily_Report.jsp">MFPL</a></li>
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
        <table class="tftable" border="1" style="width:50%;">
        <tr align="center">
			<td colspan="10" style="font-size: 14px;"><b>DAILY SALE REPORT</b></td>
		</tr>
        <%
        int sr_no=1;
        String repName="",partName="",prodOP_Codes="";
        double recd = 0,dayrecd=0,avg=0;
        int avgrec=0; 
        double disp=0,daydisp=0,dispAvg=0;
		int avgcnt=0;
		
        
		double dayprod_qty=0,cumProd_qty=0,avgprod_qty=0;
		int prodAvgCnt=0;
		
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
    	
		// exec "ENGERP"."dbo"."Sel_RptProdWiseSaleSumm";1 '101', '0', '1159,1158,1151', '20150501', '20150524'
		// exec "ENGERP"."dbo"."Sel_SaleRegister";1 '101', '0', '20150501', '20150611', '1159,1158,1151', '0'
		CallableStatement cs22 = con.prepareCall("{call Sel_SaleRegister(?,?,?,?,?,?)}");
		cs22.setString(1,"101");
		cs22.setString(2,"0"); 
		cs22.setString(3,firstDate);
		cs22.setString(4,nowDate);
		cs22.setString(5,"1159,1158,1151");
		cs22.setString(6,"0");
		
		ResultSet rsdisp = null;
		PreparedStatement ps_del = null,rec_sagg =null;
		int del = 0,rec=0;
		
    	
    	while(rs.next()){
    		PreparedStatement ps_repName = con_Local.prepareStatement("select * from reports_tbl where reports_id="+rs.getInt("reports_id"));
    		ResultSet rs_repName = ps_repName.executeQuery();
    		while(rs_repName.next()){
    			repName = rs_repName.getString("report");
    			}
        	%>
        		<tr align="left">
				<td colspan="10" style="font-size: 14px;"><b style="color: #AD5C00;"><%=sr_no %>&nbsp; &#8658; </b> <b  style="color: #AD5C00;"><%=repName %></b></td>
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
	
	        	//**********************************************************************************************************************
	        	ResultSet rs_LocalSetup = ps_rep.executeQuery();
	        	while(rs_LocalSetup.next()){ 
	        		ps_del = con_Local.prepareStatement("delete FROM erp_database.receipt_sandbox_tbl where ref_matcode='"+rs_LocalSetup.getString("ref_matcode")+"'");
	        		del = ps_del.executeUpdate();
	        	}
				//**********************************************************************************************************************
				ps_rep2 = con_Local.prepareStatement("select * from dailyreports_config_tbl where reports_id="+rs.getInt("reports_id")+" and company_id=101");
				rs_rep = ps_rep2.executeQuery();
	        	while(rs_rep.next()){
	        		//-------------------------------------------------------------------------------------------------------------------------------------
	        		rs122 = cs11.executeQuery(); 
	        			while(rs122.next()){
	        				if(rs122.getString("MATCODE").equalsIgnoreCase(rs_rep.getString("ref_matcode"))){
	        					
	        					rec_sagg = con_Local.prepareStatement("insert into receipt_sandbox_tbl(ac_name,ref_matCode,trandate,recd_qty)values(?,?,?,?)");
		        				rec_sagg.setString(1, rs122.getString("AC_NAME"));
		        				rec_sagg.setString(2, rs122.getString("MATCODE"));
		        				rec_sagg.setString(3, rs122.getString("TRAN_DATE"));
		        				rec_sagg.setString(4, rs122.getString("RECD_QTY"));
		        				
		        				rec = rec_sagg.executeUpdate();
		        				
		        				vdName.add(rs122.getString("AC_NAME"));
	        					
	        				 	partName = rs_rep.getString("matname"); 
	        					recd = recd + Double.parseDouble(rs122.getString("RECD_QTY"));
	        					avgrec++;
	        					
		        				if(rs122.getString("TRAN_DATE").equalsIgnoreCase(nowDate)){
		        		    		dayrecd = dayrecd + Double.parseDouble(rs122.getString("RECD_QTY"));
		        		    	}
		        				
	        				}
	        			}
	        		if(recd>0){	
	        		avg = recd/avgrec;
	        		}
	        		// Day Disp Cumm Avg 
	        		//-------------------------------------------------------------------------------------------------------------------------------------
	        		rsdisp = cs22.executeQuery(); 
	        			while(rsdisp.next()){
	        				if(rsdisp.getString("MAT_CODE").equalsIgnoreCase(rs_rep.getString("matcode"))){ 
	        					disp = disp + Double.parseDouble(rsdisp.getString("QTY"));
	        					avgcnt++; 
		        				if(rsdisp.getString("TRAN_DATE").equalsIgnoreCase(nowDate)){
		        				daydisp = daydisp + Double.parseDouble(rsdisp.getString("QTY"));
		        		    	}
	        				}
	        			}
	        			if(disp>0){
	        			dispAvg = disp/avgcnt;
	        			}
	        		//-------------------------------------------------------------------------------------------------------------------------------------
	        		//-------------------------------------------------------------------------------------------------------------------------------------
	        		ResultSet rs_Productionop = cs_op.executeQuery();
	        		while(rs_Productionop.next()){
	        			if(rs_rep.getString("matcode").equalsIgnoreCase(rs_Productionop.getString("PRODUCT_CODE"))){
	        				
	        			prodOP_Codes = rs_Productionop.getString("PRODUCT_CODE") + rs_Productionop.getString("OPERATION_CODE");
	        			for(int c=0;c<prod_op.size();c++){
	        				if(prod_op.get(c).toString().equalsIgnoreCase(prodOP_Codes)){
	        					if(rs_Productionop.getString("TRAN_DATE").equalsIgnoreCase(nowDate)){
			        		    		dayprod_qty = dayprod_qty + Double.parseDouble(rs_Productionop.getString("PROD_QTY"));
	        					}
	        					cumProd_qty = cumProd_qty + Double.parseDouble(rs_Productionop.getString("PROD_QTY"));
	        					prodAvgCnt++;
	        					}
	        				}
	        			  }
	        			}
	        		if(cumProd_qty>0){
	        		avgprod_qty = cumProd_qty/prodAvgCnt;
	        		}
	        		//-------------------------------------------------------------------------------------------------------------------------------------
	        		
	        		if(recd!=0){
	        	%>
	        	<tr>
					<td colspan="10" align="left" style="font-size: 13px;"><b style="color: blue;"><%=partName %>&#8658;</b></td>
				</tr>
	    		<tr style="font-size: 12px;">
					<td align="center"><b><%=DateCurr %></b></td>
					<td align="right"><b><%=zeroDForm.format(dayrecd) %></b></td>
					<td align="right"><b><%=zeroDForm.format(recd) %></b></td>
					<td align="right"><b><%=twoDForm.format(avg) %></b></td>
					       
					<td align="right"><b><%=zeroDForm.format(dayprod_qty) %></b></td>
					<td align="right"><b><%=zeroDForm.format(cumProd_qty) %></b></td>
					<td align="right"><b><%=twoDForm.format(avgprod_qty) %></b></td>
					
					<td align="right"><%=zeroDForm.format(daydisp) %></td>
					<td align="right"><%=zeroDForm.format(disp) %></td>
					<td align="right"><%=twoDForm.format(dispAvg) %></td> 
				</tr>
	        	<% 
	        		}
	        		avg=0;
	        		avgrec=0;
		        	dayrecd=0;
		        	recd=0; 
		        	disp=0;
		        	avgcnt=0;
		        	daydisp=0;
		        	dispAvg=0;
		    		avgcnt=0;
		    		dayprod_qty=0;
		    		cumProd_qty=0;
		    		avgprod_qty=0;
		    		prodAvgCnt=0;
	        	}
        	rs_rep.close();
        }
		%>
        </table>
        <br />        
        <table class="tftable" border="1" style="width:50%;">
        <tr align="left">
			<td colspan="4" style="font-size: 13px;"><b style="color: #AD5C00;">PARTY WISE RECEIPT DETAILS &#8658;</b></td>
		</tr>
		<%
		PreparedStatement ps_partyName = null;
		ResultSet rs_partName=null;
		
		double recds_qty=0,recdcumms_qty=0,avgs_qty=0;
		int cnts=0;
		LinkedHashSet<String> lhs = new LinkedHashSet<String>();
			lhs.addAll(vdName); 
			vdName.clear(); 
			vdName.addAll(lhs);
		// System.out.println("Arraylist  = " + vdName);	
		
		PreparedStatement ps_party = con_Local.prepareStatement("select * from dailyreports_config_tbl where company_id=101");
		ResultSet rs_party = ps_party.executeQuery();
		while(rs_party.next()){
				
		%>
		<tr align="center" style="background-color: #E3E3E3;">
			<td colspan="4" align="left" style="font-size: 13px;"><b style="color: blue;"><%=rs_party.getString("matname") %></b></td>
		</tr>
		<tr align="center">
			<th align="center">Party Name</th>
			<th align="center">Day Receipt</th>
			<th align="center">Cumm</th>
			<th align="center">Avg</th>
		</tr>
		<%
		for(int i=0;i<vdName.size();i++){
			ps_partyName = con_Local.prepareStatement("select * from receipt_sandbox_tbl where ref_matCode='"+rs_party.getString("ref_matCode")+"' and ac_name='"+vdName.get(i).toString()+"'");
			rs_partName = ps_partyName.executeQuery();
				while(rs_partName.next()){
					recdcumms_qty = recdcumms_qty + Double.parseDouble(rs_partName.getString("recd_qty"));
					cnts++;
    				if(rs_partName.getString("trandate").equalsIgnoreCase(nowDate)){
    					recds_qty = recds_qty + Double.parseDouble(rs_partName.getString("recd_qty"));
    		    	}
				}
				if(recdcumms_qty>0){
					avgs_qty = recdcumms_qty/cnts;
	        	}
		%> 
		<tr>
			<td align="left"><%=vdName.get(i).toString() %></td> 
			<td align="right"><%=zeroDForm.format(recds_qty) %></td>
			<td align="right"><%=zeroDForm.format(recdcumms_qty) %></td>
			<td align="right"><%=twoDForm.format(avgs_qty) %></td>
		</tr>
		<%
		recdcumms_qty=0;
		cnts=0;  
		recds_qty=0;
		avgs_qty=0;
		}
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