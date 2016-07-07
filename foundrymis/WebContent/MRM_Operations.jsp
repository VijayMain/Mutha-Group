<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<script language="JavaScript"> 
var nHist = window.history.length;
if(window.history[nHist] != window.location)
  window.history.forward(); 
</script> 
<title>MRM Operations</title> 
<STYLE TYPE="text/css" MEDIA=all>
.td1 { 
	font-size: 13px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
.tftable tr {
	background-color: white;
	font-size: 13px;
}

.th {
	font-size: 14px;
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
		Connection con = null,conlocal=null , conerp = null;
		Connection coninhouse = Connection_Utility.getConnection();
		String maindb = "",yearfor = "";
		
		String comp =request.getParameter("comp");
		String month =request.getParameter("month");
		String db =request.getParameter("db");
		String monthName =request.getParameter("monthname");
		String OnDateMIS = 01 +"/" + month.substring(4,6) +"/"+ month.substring(0,4);
		DecimalFormat twoDForm = new DecimalFormat("#####0.00");
		//	System.out.println("Data = " +month+"  =  " +  monthName + "  =  01/" + month.substring(4,6) +"/"+ month.substring(0,4));
		String forLastDt = month.substring(4,6) + "/01/" + month.substring(0,4);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		Date convertedDate = dateFormat.parse(forLastDt); 
		
		Calendar c = Calendar.getInstance();
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		Date lastDayOfMonth = c.getTime(); 
		String lastString = dateFormat.format(lastDayOfMonth);
		
		String monthString = new DateFormatSymbols().getMonths()[Integer.parseInt(month.substring(4,6))-1];
		
		
		String nameComp = ""; 
		if(comp.equalsIgnoreCase("103")){
			con = ConnectionUrl.getFoundryFMShopConnection();
			conerp = ConnectionUrl.getFoundryERPNEWConnection();
			db = "FOUNDRYERP";
			maindb = "FOUNDRYFMSHOP"; 
			nameComp = "MUTHA FOUNDERS PVT.LTD.";
		}
		if(comp.equalsIgnoreCase("105")){
			con = ConnectionUrl.getDIFMShopConnection();
			conerp = ConnectionUrl.getDIERPConnection();
			db = "DIERP";
			maindb = "DIFMSHOP";
			nameComp = "DHANASHREE INDUSTRIES";
		}
		if(comp.equalsIgnoreCase("106")){
			con = ConnectionUrl.getK1FMShopConnection();
			conerp = ConnectionUrl.getK1ERPConnection();
			db = "K1ERP";
			maindb = "K1FMSHOP";
			nameComp = "MUTHA ENGINEERING PVT.LTD.UNIT III ";
		}  
		
		int mntid = Integer.parseInt(month.substring(4,6));

		if(mntid==1 || mntid==2 || mntid==3){
			yearfor = String.valueOf(Integer.parseInt(month.substring(0,4))-1) + month.substring(0,4).substring(month.substring(0,4).length()-2);
		}else{
			yearfor = month.substring(0,4) + String.valueOf(Integer.parseInt(month.substring(0,4).substring(month.substring(0,4).length()-2))+1);
		} 
	%>
<strong style="color: blue;font-family: Arial;font-size: 14px;"><%= nameComp %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">MRM Operation Report upto <%=monthString %> <%=month.substring(0,4) %></strong>
<%-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b style="font-family: Arial;font-size: 12px;">( Total Working Days : <%= total_days%> | Total worked days : <%=workDays_over %> )</b> --%>
<br/> 
<strong style="font-family: Arial;font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
<div style="height: 550px;overflow: scroll;background-color: white;">  
<%
ArrayList days_list = new ArrayList();
int calMonth = Integer.parseInt(month.substring(4,6));
//---------------------------------------------------------------------------------------------------------------------
ArrayList listyear = new ArrayList();
ArrayList listmonth = new ArrayList();
ArrayList listpara = new ArrayList(); 
ArrayList listWorkdays = new ArrayList(); 

listpara.add("Actual Days");
listpara.add("No of working days");
listpara.add("Sales, Rs Lacs");
listpara.add("Sales, MT");
listpara.add("Sale / Day, MT");
listpara.add("Rev Sales, Rs Lacs");
listpara.add("Rev Sales, MT");
listpara.add("Prod, MT");
listpara.add("Prod / Day, MT");
listpara.add("Good.Prod, MT");

DateFormatSymbols dfs = new DateFormatSymbols();
String[] months = dfs.getShortMonths();

int cnt = calMonth-1; 
int yearcnt = Integer.parseInt(month.substring(0,4));

//  to adjust months to display =====>
outerLoop:
for(int i=0;i<4;i++){
	if(mntid>=4){
		if(cnt==2){
	 		break outerLoop;
 		}
	}else{
 		if(cnt==3){
	 		break outerLoop;
 		}
	}
 listyear.add(months[cnt] + yearcnt);
 listmonth.add(cnt);
 
 	//	System.out.println("Looop = " + cnt + " loop = " +  months[cnt] + " year = " + yearcnt);
 
 if(cnt==0){
	 cnt=11;
	 yearcnt--;
 }else{
	 cnt--;
 }
}

Collections.reverse(listyear);
Collections.reverse(listmonth);
String batchonDate = "";
String bdateto = "";
int monthdays=0,yeardays=0;
int tuesdays=0;
int holliday = 0;
conlocal = ConnectionUrl.getLocalDatabase(); 
int workDays_over = 0;
String total_days = "";
CallableStatement cs = null;		
ResultSet rs = null;
double sumsale = 0;
// -----------------------------------------------------------------------------------------------------------------
%>
		<table id="t1" border="1" cellpadding=2 style="border: 1px solid #000; font-family: Arial;width: 70%">
				<tr align="center">
					<th class="th" colspan="2">Description</th> 
					<td class="td1" style="background-color: #e0c6a9"><b>Average</b></td> 
					<%
					for(int d=0;d<listyear.size();d++){
					%>
					<th class="th"><%=listyear.get(d).toString() %></th>
					<%
					}
					%>
				</tr>				
		<%
		// -----------------------------------------------------------------------------------------------------------------
			//	System.out.println("List Month = " + listmonth);
			//	System.out.println("Date in Months = " + listmonth.get(h).toString());
		%>
		<!----------------------------------------------------------------------------------------------------------->
		<!------------------------------------------ Actual Days ---------------------------------------------------->
		<!----------------------------------------------------------------------------------------------------------->
		<tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
		<td class="td1" colspan="2"><b><%=listpara.get(0).toString() %></b></td>
		<!-------------------------------------------- Average ------------------------------------------------------>
		<%
		double avg = 0;
		int cntavg=0;
		for(int e=0;e<listyear.size();e++){
			
			monthdays = Integer.parseInt(listmonth.get(e).toString())+1;
			// System.out.println("date the sustem = " + listmonth);
			// System.out.println("date the sustem year = " + listyear.get(e).toString().substring(listyear.get(e).toString().length()-4)); 
			forLastDt = monthdays + "/01/" + listyear.get(e).toString().substring(listyear.get(e).toString().length()-4);
			
			yeardays = Integer.parseInt(listyear.get(e).toString().substring(listyear.get(e).toString().length()-4));
	 		c.clear();
			
			convertedDate = dateFormat.parse(forLastDt);
			c.setTime(convertedDate);
			c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
			
			lastDayOfMonth = c.getTime();
			lastString = dateFormat.format(lastDayOfMonth);
							
			batchonDate = "01/" + listmonth.get(e).toString() +"/"+ listyear.get(e).toString().substring(listyear.get(e).toString().length()-4);
			bdateto = lastString.substring(3,5) +"/"+ lastString.substring(0,2) +"/"+ lastString.substring(6,10);
			
			total_days = lastString.substring(3,5); 
			avg = avg + Integer.parseInt(total_days);
			cntavg++;
		} 
		avg = avg/cntavg;
		%>
		<td class="td1" align="right"><b><%= Math.round(avg) %></b></td>
		<!----------------------------------------------------------------------------------------------------------->		
		<%
		avg=0;
		cntavg=0;
		for(int e=0;e<listyear.size();e++){
		
		monthdays = Integer.parseInt(listmonth.get(e).toString())+1;
		// System.out.println("date the sustem = " + listmonth);
		// System.out.println("date the sustem year = " + listyear.get(e).toString().substring(listyear.get(e).toString().length()-4)); 
		forLastDt = monthdays + "/01/" + listyear.get(e).toString().substring(listyear.get(e).toString().length()-4);
		
		yeardays = Integer.parseInt(listyear.get(e).toString().substring(listyear.get(e).toString().length()-4));
 		c.clear();
		
		convertedDate = dateFormat.parse(forLastDt);
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime();
		lastString = dateFormat.format(lastDayOfMonth);
						
		batchonDate = "01/" + listmonth.get(e).toString() +"/"+ listyear.get(e).toString().substring(listyear.get(e).toString().length()-4);
		bdateto = lastString.substring(3,5) +"/"+ lastString.substring(0,2) +"/"+ lastString.substring(6,10);
		
		total_days = lastString.substring(3,5);
		%>
			<td class="td1" align="right"><%=total_days%></td>
		<%
			}
		%>
	</tr>
		<!----------------------------------------------------------------------------------------------------------->
		<!------------------------------------------ No of working days --------------------------------------------->
		<!----------------------------------------------------------------------------------------------------------->		
				<tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
				<td class="td1" colspan="2"><b><%=listpara.get(1).toString() %></b></td>
		<!----------------------------------------------- Average --------------------------------------------------->
		<%
		avg=0;
		cntavg=0;
		tuesdays=0;
		for(int e=0;e<listyear.size();e++){
			
			monthdays = Integer.parseInt(listmonth.get(e).toString())+1;
			// System.out.println("date the sustem = " + listmonth);
			// System.out.println("date the sustem year = " + listyear.get(e).toString().substring(listyear.get(e).toString().length()-4)); 
			forLastDt = monthdays + "/01/" + listyear.get(e).toString().substring(listyear.get(e).toString().length()-4);
			
			yeardays = Integer.parseInt(listyear.get(e).toString().substring(listyear.get(e).toString().length()-4));

			c.clear();
			
			convertedDate = dateFormat.parse(forLastDt); 
			c.setTime(convertedDate);
			c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
			
			lastDayOfMonth = c.getTime(); 
			lastString = dateFormat.format(lastDayOfMonth);
			
			
							
			batchonDate = "01/" + listmonth.get(e).toString() +"/"+ listyear.get(e).toString().substring(listyear.get(e).toString().length()-4);
			bdateto = lastString.substring(3,5) +"/"+ lastString.substring(0,2) +"/"+ lastString.substring(6,10);
			
			total_days = lastString.substring(3,5);
							
			
							
			for (int d = 1;  d <= Integer.parseInt(total_days);  d++) {
			c.set(Calendar.DAY_OF_MONTH, d);
			int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
			if (Calendar.TUESDAY == dayOfWeek) {
				tuesdays++;
				}
			}
							
			PreparedStatement ps_week = conlocal.prepareStatement("select count(*) from montlyweekdays_tbl where month="+ monthdays+" and year="+ yeardays);
			ResultSet rs_week = ps_week.executeQuery();
			while (rs_week.next()) {
				holliday = Integer.parseInt(rs_week.getString("count(*)"));
				}
							
			workDays_over = Integer.parseInt(total_days) - (holliday + tuesdays); 
			avg = workDays_over + avg;
			cntavg++; 
			tuesdays=0;
			holliday=0;
		}
		avg = avg/cntavg;  
		%>
		<td class="td1" align="right"><b><%=Math.round(avg) %></b></td>
		<!----------------------------------------------------------------------------------------------------------->
		<%
		avg=0;
		cntavg=0;
		
		for(int e=0;e<listyear.size();e++){
		
		monthdays = Integer.parseInt(listmonth.get(e).toString())+1;  
		forLastDt = monthdays + "/01/" + listyear.get(e).toString().substring(listyear.get(e).toString().length()-4);
		
		yeardays = Integer.parseInt(listyear.get(e).toString().substring(listyear.get(e).toString().length()-4));

		c.clear();
		
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		
		batchonDate = "01/" + listmonth.get(e).toString() +"/"+ listyear.get(e).toString().substring(listyear.get(e).toString().length()-4);
		bdateto = lastString.substring(3,5) +"/"+ lastString.substring(0,2) +"/"+ lastString.substring(6,10);
		
		total_days = lastString.substring(3,5); 
		for (int d = 1;  d <= Integer.parseInt(total_days);  d++) {
			c.set(Calendar.DAY_OF_MONTH, d);
			int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
			if (Calendar.TUESDAY == dayOfWeek) {
				tuesdays++;
			}
		}
						
		PreparedStatement ps_week = conlocal.prepareStatement("select count(*) from montlyweekdays_tbl where month="+ monthdays+" and year="+ yeardays);
		ResultSet rs_week = ps_week.executeQuery();
			while (rs_week.next()) {
			holliday = Integer.parseInt(rs_week.getString("count(*)"));
		}
		 
			
		workDays_over = Integer.parseInt(total_days) - (holliday + tuesdays);
						
	//	System.out.println("WOrk Days = " + workDays_over);
				
	listWorkdays.add(workDays_over);
				
					%>
					<td class="td1" align="right"><%=workDays_over%></td>
					<%
					holliday = 0;
					tuesdays=0;
					}
					%>
		</tr>
<%
PreparedStatement ps_bud = null;
ResultSet rs_bud = null;
int bud=0,chkflag=0;
double sumBud=0;
%>		
		<!----------------------------------------------------------------------------------------------------------->
		<!------------------------------------------ Sales, Rs Lacs ------------------------------------------------->
		<!----------------------------------------------------------------------------------------------------------->
		<tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
			<td class="td1" rowspan="2"><b><%=listpara.get(2).toString() %></b></td>
			<td class="td1" style="background-color: #7bea9a"><b style="font-size: 11px;">Budget</b></td>
			
		<!------------------------------------------------- Average ----------------------------------------------------->
		<%
		for(int d=0;d<listyear.size();d++){
		// System.out.println("data = " + listmonth.get(d) + " year = " + yearfor + "para = " + listpara);
		ps_bud = coninhouse.prepareStatement("select * from mrm_operation where company='"+comp+"' and month_cnt='"+listmonth.get(d).toString()+"' and foryear='"+yearfor+"' and para_code=1");
		rs_bud = ps_bud.executeQuery();
		while(rs_bud.next()){ 
			if(!rs_bud.getString("budget").equalsIgnoreCase("")){
			sumBud = Integer.parseInt(rs_bud.getString("budget")) + sumBud;
			}
		}
		}
		sumBud = sumBud/listyear.size(); 
		%>
		<td class="td1" align="right"><%=Math.round(sumBud) %></td>
		<!--------------------------------------------------------------------------------------------------------------->		
					<%
					sumBud=0;
					for(int d=0;d<listyear.size();d++){
					//	System.out.println("data = " + listmonth.get(d) + " year = " + yearfor + "para = " + listpara);
					ps_bud = coninhouse.prepareStatement("select * from mrm_operation where  company='"+comp+"' and month_cnt='"+listmonth.get(d).toString()+"' and foryear='"+yearfor+"' and para_code=1");
					rs_bud = ps_bud.executeQuery();
					
					rs_bud.last();
					chkflag = rs_bud.getRow();
					rs_bud.beforeFirst();
					if(chkflag>0){
						while(rs_bud.next()){
					%>
					<td class="td1" align="right"><%=rs_bud.getString("budget") %></td>
					<%		
						}
					}else{
					%> 
					<td class="td1">&nbsp;</td>
					<%
					}
					}
					%>
				</tr>	
				<tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
				<td class="td1" style="background-color: #fff38a"><b style="font-size: 11px;">Actual</b></td>
				
		<!------------------------------------------- Average ------------------------------------------------------->
		<%
		avg=0;
		cntavg=0; 
		sumsale=0;
		for(int d=0;d<listyear.size();d++){
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + listyear.get(d) + "  =  " + bdateto);
						
						cs = conerp.prepareCall("{call Sel_DailySale(?,?,?,?)}");
						cs.setString(1, comp);
						cs.setString(2, "0");
						cs.setString(3, bdateto);
						cs.setString(4, "1");	
						rs = cs.executeQuery();
						while(rs.next()){
							sumsale = Double.parseDouble(rs.getString("CURR_MTH_SLAMT")) + sumsale;
						}
						if(sumsale>0){
							sumsale = Double.parseDouble(twoDForm.format(sumsale)); 
						}
						avg = sumsale;
						cntavg++; 	
		}
		sumsale=0;
		avg = avg/cntavg; 
		%>
		<!----------------------------------------------------------------------------------------------------------->
		<td class="td1" align="right"><%=Math.round(avg) %></td>
		<%
		avg=0;
		cntavg=0;
		cs = null;		
		rs = null;
		sumsale = 0;
		for(int d=0;d<listyear.size();d++){
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + listyear.get(d) + "  =  " + bdateto);
						
						cs = conerp.prepareCall("{call Sel_DailySale(?,?,?,?)}");
						cs.setString(1, comp);
						cs.setString(2, "0");
						cs.setString(3, bdateto);
						cs.setString(4, "1");	
						rs = cs.executeQuery();
						while(rs.next()){
							sumsale = Double.parseDouble(rs.getString("CURR_MTH_SLAMT")) + sumsale;
						}
						if(sumsale>0){
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
					%> 
					<td class="td1" align="right"><%=sumsale %></td>
					<%
					sumsale=0;
					}
					%>
				</tr>
				
	 			
		<!----------------------------------------------------------------------------------------------------------->
		<!------------------------------------------ Sales, MT ------------------------------------------------->
		<!----------------------------------------------------------------------------------------------------------->
				 <tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
					<td class="td1" rowspan="2"><b><%=listpara.get(3).toString() %></b></td>
					<td class="td1" style="background-color: #7bea9a"><b style="font-size: 11px;">Budget</b></td>
					
		<!------------------------------------------------- Average ----------------------------------------------------->
		<%
		for(int d=0;d<listyear.size();d++){
		ps_bud = coninhouse.prepareStatement("select * from mrm_operation where  company='"+comp+"' and month_cnt='"+listmonth.get(d).toString()+"' and foryear='"+yearfor+"' and para_code=2");
		rs_bud = ps_bud.executeQuery();
		while(rs_bud.next()){
			if(!rs_bud.getString("budget").equalsIgnoreCase("")){
			sumBud = Integer.parseInt(rs_bud.getString("budget")) + sumBud;
			}
		}
		}
		sumBud = sumBud/listyear.size();
		%>
		<td class="td1" align="right"><%=Math.round(sumBud) %></td>
		<!--------------------------------------------------------------------------------------------------------------->		
					<%
					sumBud=0;
					for(int d=0;d<listyear.size();d++){
					ps_bud = coninhouse.prepareStatement("select * from mrm_operation where  company='"+comp+"' and month_cnt='"+listmonth.get(d).toString()+"' and foryear='"+yearfor+"' and para_code=2");
					rs_bud = ps_bud.executeQuery();
					
					rs_bud.last();
					chkflag = rs_bud.getRow();
					rs_bud.beforeFirst();
					if(chkflag>0){
						while(rs_bud.next()){
					%>
					<td class="td1" align="right"><%=rs_bud.getString("budget") %></td>
					<%		
						}
					}else{
					%> 
					<td class="td1">&nbsp;</td>
					<%
					}
					}
					%> 
		<!--------------------------------------------------------------------------------------------------------------------------------------------------------------->			
				</tr>	
				<tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
				<td class="td1" style="background-color: #fff38a"><b style="font-size: 11px;">Actual</b></td>   
		<!------------------------------------------- Average ------------------------------------------------------->
		
		<%
		cs = null; 			
		rs = null;
		sumsale = 0;
		avg=0;
		cntavg=0;
		for(int d=0;d<listyear.size();d++){
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + listyear.get(d) + "  =  " + bdateto);
		// exec "FOUNDRYFMSHOP"."dbo"."Sel_RptMISMonthlySumm";1 '103', '20160229', 'FOUNDRYERP'
		
						cs = con.prepareCall("{call Sel_RptMISMonthlySumm(?,?,?)}");
		 				cs.setString(1, comp);
		 				cs.setString(2, bdateto);
		 				cs.setString(3, db); 
						rs = cs.executeQuery(); 
						while(rs.next()){
							sumsale = Double.parseDouble(rs.getString("TD_DESP_QTY")) + sumsale;
						}
						if(sumsale>0){
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
						avg = sumsale;
						cntavg++;
		}
		avg = avg/cntavg;
		%>
		<!----------------------------------------------------------------------------------------------------------->			
		<td class="td1" align="right"><%= Math.round(avg) %></td>
		<%
		cs = null; 			
		rs = null;
		sumsale = 0;
		avg=0;
		cntavg=0;
		for(int d=0;d<listyear.size();d++){
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + listyear.get(d) + "  =  " + bdateto);
		// exec "FOUNDRYFMSHOP"."dbo"."Sel_RptMISMonthlySumm";1 '103', '20160229', 'FOUNDRYERP'
		
						cs = con.prepareCall("{call Sel_RptMISMonthlySumm(?,?,?)}");
		 				cs.setString(1, comp);
		 				cs.setString(2, bdateto);
		 				cs.setString(3, db); 
						rs = cs.executeQuery(); 
						while(rs.next()){
							sumsale = Double.parseDouble(rs.getString("TD_DESP_QTY")) + sumsale;
						}
						if(sumsale>0){
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
		%>
					<td class="td1" align="right"><%=sumsale %></td>
					<%
					sumsale=0;
					}
					%>
		</tr>
		<!----------------------------------------------------------------------------------------------------------->
		<!------------------------------------------ Sales / Day , MT ----------------------------------------------->
		<!----------------------------------------------------------------------------------------------------------->
		<tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
			<td class="td1" colspan="2"><b><%=listpara.get(4).toString() %></b></td> 
		<!------------------------------------------- Average ------------------------------------------------------->
		<%
		cs = null; 			
		rs = null;
		sumsale = 0;
		avg=0;
		cntavg=0;
		for(int d=0;d<listyear.size();d++){
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		 
		// System.out.println("Dates = " + listyear.get(d) + "  =  " + bdateto);
		// exec "FOUNDRYFMSHOP"."dbo"."Sel_RptMISMonthlySumm";1 '103', '20160229', 'FOUNDRYERP'
		
						cs = con.prepareCall("{call Sel_RptMISMonthlySumm(?,?,?)}");
		 				cs.setString(1, comp);
		 				cs.setString(2, bdateto);
		 				cs.setString(3, db); 
						rs = cs.executeQuery(); 
						while(rs.next()){
							sumsale = (Double.parseDouble(rs.getString("TD_DESP_QTY"))/Integer.parseInt(listWorkdays.get(d).toString())) + sumsale;
						}
						if(sumsale>0){
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
				avg = sumsale;
				cntavg++;
		}
		avg=avg/cntavg;
		%>
		<!----------------------------------------------------------------------------------------------------------->
		<td class="td1" align="right"><%=Math.round(avg)%></td> 		
		<%
		cs = null; 			
		rs = null;
		sumsale = 0;
		avg=0;
		cntavg=0;
		for(int d=0;d<listyear.size();d++){
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		 
		// System.out.println("Dates = " + listyear.get(d) + "  =  " + bdateto);
		// exec "FOUNDRYFMSHOP"."dbo"."Sel_RptMISMonthlySumm";1 '103', '20160229', 'FOUNDRYERP'
		
						cs = con.prepareCall("{call Sel_RptMISMonthlySumm(?,?,?)}");
		 				cs.setString(1, comp);
		 				cs.setString(2, bdateto);
		 				cs.setString(3, db); 
						rs = cs.executeQuery(); 
						while(rs.next()){ 
							sumsale = Double.parseDouble(rs.getString("TD_DESP_QTY")) + sumsale;
						}
						if(sumsale>0){ 
							sumsale = sumsale/Integer.parseInt(listWorkdays.get(d).toString()); 
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
						
					%> 
					<td class="td1" align="right"><%=sumsale %></td>
					<%
					sumsale=0;
					}
					%>
				</tr>
		<!----------------------------------------------------------------------------------------------------------->
		<!------------------------------------------ Rev Sales, Rs Lacs --------------------------------------------->
		<!----------------------------------------------------------------------------------------------------------->
				 <tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
					<td class="td1" rowspan="3"><b><%=listpara.get(5).toString() %></b></td>
					<td class="td1" style="background-color: #7bea9a"><b style="font-size: 11px;">Budget</b></td>
<!------------------------------------------------- Average ----------------------------------------------------->
		<%
		ArrayList budlist = new ArrayList();
		ArrayList actlist = new ArrayList();
		
		for(int d=0;d<listyear.size();d++){ 
		ps_bud = coninhouse.prepareStatement("select * from mrm_operation where  company='"+comp+"' and month_cnt='"+listmonth.get(d).toString()+"' and foryear='"+yearfor+"' and para_code=3");
		rs_bud = ps_bud.executeQuery();
		
		rs_bud.last();
		chkflag = rs_bud.getRow();
		rs_bud.beforeFirst();
		if(chkflag>0){
		while(rs_bud.next()){
			if(!rs_bud.getString("budget").equalsIgnoreCase("")){
			sumBud = Integer.parseInt(rs_bud.getString("budget")) + sumBud;
			}
		}
		}else{
			sumBud=0;
		}
		}
		
		if(sumBud>0){
		sumBud = sumBud/listyear.size();
		}
		%>
		<td class="td1" align="right"><%=Math.round(sumBud) %></td>
		<!--------------------------------------------------------------------------------------------------------------->		
		<%
					sumBud=0;
					for(int d=0;d<listyear.size();d++){
					ps_bud = coninhouse.prepareStatement("select * from mrm_operation where  company='"+comp+"' and month_cnt='"+listmonth.get(d).toString()+"' and foryear='"+yearfor+"' and para_code=3");
					rs_bud = ps_bud.executeQuery();
					
					rs_bud.last();
					chkflag = rs_bud.getRow();
					rs_bud.beforeFirst();
					if(chkflag>0){
						while(rs_bud.next()){
						budlist.add(rs_bud.getString("budget"));
		%>
					<td class="td1" align="right"><%=rs_bud.getString("budget") %></td>
		<%		
						}
					}else{
						budlist.add("");
					%> 
					<td class="td1">&nbsp;</td>
					<%
					}
					}
					%> 
		<!--------------------------------------------------------------------------------------------------------------------------------------------------------------->
				</tr>	
		<tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
			<td class="td1" style="background-color: #fff38a"><b style="font-size: 11px;">Actual</b></td> 	
		<!------------------------------------------- Average ------------------------------------------------------>	
		<%
		cs = null; 			
		rs = null;
		sumsale = 0;
		avg=0;
		cntavg=0;
		for(int d=0;d<listyear.size();d++){
						
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + listyear.get(d) + "  =  " + bdateto);
						
						cs = conerp.prepareCall("{call Sel_DailySale(?,?,?,?)}");
						cs.setString(1, comp);
						cs.setString(2, "0");
						cs.setString(3, bdateto);
						cs.setString(4, "1");	
						rs = cs.executeQuery();
						while(rs.next()){
							sumsale = Double.parseDouble(rs.getString("CURR_MTH_SLAMT")) + sumsale;
						}
						if(sumsale>0){
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
			avg = sumsale;
			cntavg++;
		}		
		avg = avg/cntavg;
		%> 
		<td class="td1" align="right"><%=Math.round(avg) %></td>
		
		<!----------------------------------------------------------------------------------------------------------->
		<%
		cs = null; 			
		rs = null;
		sumsale = 0;
		avg=0;
		cntavg=0;
		double arch=0,archsum=0;
		for(int d=0;d<listyear.size();d++){
						
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + listyear.get(d) + "  =  " + bdateto);
						
						cs = conerp.prepareCall("{call Sel_DailySale(?,?,?,?)}");
						cs.setString(1, comp);
						cs.setString(2, "0");
						cs.setString(3, bdateto);
						cs.setString(4, "1");	
						rs = cs.executeQuery();
						while(rs.next()){
							sumsale = Double.parseDouble(rs.getString("CURR_MTH_SLAMT")) + sumsale;
						}
						if(sumsale>0){
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
					%> 
					<td class="td1" align="right"><%=sumsale %></td>
					<%
					actlist.add(sumsale);
					sumsale=0;
					}
					%>
				</tr>
				<tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
				<td class="td1" style="background-color: #8b99f8"><b style="font-size: 11px;">Arch %</b></td>
				<%
					for(int d=0;d<budlist.size();d++){
						if(!actlist.get(d).toString().equalsIgnoreCase("") && !budlist.get(d).toString().equalsIgnoreCase("")){
						arch = (Double.parseDouble(actlist.get(d).toString()) / Double.parseDouble(budlist.get(d).toString()))*100;
						archsum = archsum + arch;
						}
					}	
				archsum = archsum/budlist.size();
					%>
				<td class="td1" align="right"><%=Math.round(archsum) %></td>
					<%
					for(int d=0;d<budlist.size();d++){
						if(!actlist.get(d).toString().equalsIgnoreCase("") && !budlist.get(d).toString().equalsIgnoreCase("")){
						arch = (Double.parseDouble(actlist.get(d).toString()) / Double.parseDouble(budlist.get(d).toString()))*100;
					%>
					<td class="td1" align="right"><%=Math.round(arch) %></td>
					<%
						}else{
					%>
					<td class="td1" align="right">&nbsp;</td>
					<%		
						}
					}
					archsum=0;
					arch=0;
					%> 
				</tr> 
		<!----------------------------------------------------------------------------------------------------------->
		<!------------------------------------------ Rev Sales, MT -------------------------------------------------->
		<!----------------------------------------------------------------------------------------------------------->
				 <tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
					<td class="td1" rowspan="2"><b><%=listpara.get(6).toString() %></b></td>
					<td class="td1" style="background-color: #7bea9a"><b style="font-size: 11px;">Budget</b></td>
					
				<!------------------------------------------------- Average ----------------------------------------------------->
		<% 
		for(int d=0;d<listyear.size();d++){
		ps_bud = coninhouse.prepareStatement("select * from mrm_operation where  company='"+comp+"' and month_cnt='"+listmonth.get(d).toString()+"' and foryear='"+yearfor+"' and para_code=4");
		rs_bud = ps_bud.executeQuery();
		while(rs_bud.next()){ 
			if(!rs_bud.getString("budget").equalsIgnoreCase("")){
			sumBud = Integer.parseInt(rs_bud.getString("budget")) + sumBud;
			}
		}
		} 
		sumBud = sumBud/listyear.size();
		%>
		<td class="td1" align="right"><%=Math.round(sumBud) %></td>
		<!--------------------------------------------------------------------------------------------------------------->		
					<%
					sumBud=0;
					for(int d=0;d<listyear.size();d++){
					ps_bud = coninhouse.prepareStatement("select * from mrm_operation where  company='"+comp+"' and month_cnt='"+listmonth.get(d).toString()+"' and foryear='"+yearfor+"' and para_code=4");
					rs_bud = ps_bud.executeQuery();
					
					rs_bud.last();
					chkflag = rs_bud.getRow();
					rs_bud.beforeFirst();
					if(chkflag>0){
						while(rs_bud.next()){
					%>
					<td class="td1" align="right"><%=rs_bud.getString("budget") %></td>
					<%		
						}
					}else{
					%> 
					<td class="td1">&nbsp;</td>
					<%
					}
					}
					%> 
			<!--------------------------------------------------------------------------------------------------------------------------------------------------------------->
				</tr>	
				<tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
				<td class="td1" style="background-color: #fff38a"><b style="font-size: 11px;">Actual</b></td>
		<!------------------------------------------- Average ---------------------------------------------------->
					<%
					cs = null; 			
					rs = null;
					sumsale = 0;
					for(int d=0;d<listyear.size();d++){
						
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + listyear.get(d) + "  =  " + bdateto);
		// exec "FOUNDRYFMSHOP"."dbo"."Sel_RptMISMonthlySumm";1 '103', '20160229', 'FOUNDRYERP'
		
						cs = con.prepareCall("{call Sel_RptMISMonthlySumm(?,?,?)}");
		 				cs.setString(1, comp);
		 				cs.setString(2, bdateto);
		 				cs.setString(3, db); 
						rs = cs.executeQuery(); 
						while(rs.next()){
							sumsale = Double.parseDouble(rs.getString("TD_DESP_QTY")) + sumsale;
						}
						if(sumsale>0){
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
				avg = sumsale;
				cntavg++;
			}			
			avg = avg/cntavg;	
		%>
				   <td class="td1" align="right"><%=Math.round(avg) %></td>
				   
		<!----------------------------------------------------------------------------------------------------------->
				   
		<%
		cs = null; 			
		rs = null;
		sumsale = 0;
		for(int d=0;d<listyear.size();d++){
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + listyear.get(d) + "  =  " + bdateto);
		// exec "FOUNDRYFMSHOP"."dbo"."Sel_RptMISMonthlySumm";1 '103', '20160229', 'FOUNDRYERP'
		
						cs = con.prepareCall("{call Sel_RptMISMonthlySumm(?,?,?)}");
		 				cs.setString(1, comp);
		 				cs.setString(2, bdateto);
		 				cs.setString(3, db); 
						rs = cs.executeQuery(); 
						while(rs.next()){
							sumsale = Double.parseDouble(rs.getString("TD_DESP_QTY")) + sumsale;
						}
						if(sumsale>0){
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
		%> 
					<td class="td1" align="right"><%=sumsale %></td>
					<%
					sumsale=0;
					}
					%>
				</tr>
		<!----------------------------------------------------------------------------------------------------------->
		<!------------------------------------------ Prod, MT  ------------------------------------------------------>
		<!----------------------------------------------------------------------------------------------------------->
				 <tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
					<td class="td1" rowspan="2"><b><%=listpara.get(7).toString() %></b></td>
					<td class="td1" style="background-color: #7bea9a"><b style="font-size: 11px;">Budget</b></td>
					 
					 <!------------------------------------------------- Average ----------------------------------------------------->
		<%
		for(int d=0;d<listyear.size();d++){ 
		ps_bud = coninhouse.prepareStatement("select * from mrm_operation where  company='"+comp+"' and month_cnt='"+listmonth.get(d).toString()+"' and foryear='"+yearfor+"' and para_code=5");
		rs_bud = ps_bud.executeQuery();
		while(rs_bud.next()){
			if(!rs_bud.getString("budget").equalsIgnoreCase("")){
			sumBud = Integer.parseInt(rs_bud.getString("budget")) + sumBud;
		}
		}
		}
		sumBud = sumBud/listyear.size();
		%>
		<td class="td1" align="right"><%=Math.round(sumBud) %></td>
<!--------------------------------------------------------------------------------------------------------------->		
					<%
					sumBud=0;
					for(int d=0;d<listyear.size();d++){
					ps_bud = coninhouse.prepareStatement("select * from mrm_operation where  company='"+comp+"' and month_cnt='"+listmonth.get(d).toString()+"' and foryear='"+yearfor+"' and para_code=5");
					rs_bud = ps_bud.executeQuery();
					
					rs_bud.last();
					chkflag = rs_bud.getRow();
					rs_bud.beforeFirst();
					if(chkflag>0){
						while(rs_bud.next()){
					%>
					<td class="td1" align="right"><%=rs_bud.getString("budget") %></td>
					<%		
						}
					}else{
					%> 
					<td class="td1">&nbsp;</td>
					<%
					}
					}
					%> 
<!--------------------------------------------------------------------------------------------------------------------------------------------------------------->
					 
				</tr>	
				<tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
				<td class="td1" style="background-color: #fff38a"><b style="font-size: 11px;">Actual</b></td>
				
			<!------------------------------------------------- Average ---------------------------------------------->	
					<%
					cs = null; 			
					rs = null;
					avg=0;
					cntavg=0;
					sumsale = 0;
					for(int d=0;d<listyear.size();d++){
						
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		
		batchonDate = lastString.substring(6,10)+lastString.substring(0,2)+"01";
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + batchonDate + "  =  " + bdateto);
		// exec "FOUNDRYFMSHOP"."dbo"."Sel_RptMISMonthlySumm";1 '103', '20160229', 'FOUNDRYERP'
		
				cs = con.prepareCall("{call Sel_RptProdAndRej(?,?,?,?,?,?,?)}");
		 		cs.setString(1, comp);
		 		cs.setString(2, "652");
		 		cs.setString(3, "101102103104"); 
		 		cs.setString(4, batchonDate);
		 		cs.setString(5, bdateto);
		 		cs.setString(6, db); 
		 		cs.setString(7, maindb); 
				rs = cs.executeQuery(); 
				while(rs.next()){
							sumsale = (Double.parseDouble(rs.getString("TOTAL_WT_WITHOUTRR"))/1000) + sumsale;
						}
						if(sumsale>0){
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
						avg = sumsale;
						cntavg++;
			}		
			avg = avg/cntavg;		
			%>		
				<td class="td1" align="right"><%=Math.round(avg) %></td>   
		<!----------------------------------------------------------------------------------------------------------->		
		<%
		cs = null; 			
		rs = null;
		sumsale = 0;
		avg=0;
		cntavg=0;
		for(int d=0;d<listyear.size();d++){
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		
		batchonDate = lastString.substring(6,10)+lastString.substring(0,2)+"01";
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + batchonDate + "  =  " + bdateto);
		// exec "FOUNDRYFMSHOP"."dbo"."Sel_RptMISMonthlySumm";1 '103', '20160229', 'FOUNDRYERP'
		
				cs = con.prepareCall("{call Sel_RptProdAndRej(?,?,?,?,?,?,?)}");
		 		cs.setString(1, comp);
		 		cs.setString(2, "652");
		 		cs.setString(3, "101102103104"); 
		 		cs.setString(4, batchonDate);
		 		cs.setString(5, bdateto);
		 		cs.setString(6, db); 
		 		cs.setString(7, maindb); 
				rs = cs.executeQuery(); 
				while(rs.next()){
							sumsale = (Double.parseDouble(rs.getString("TOTAL_WT_WITHOUTRR"))/1000) + sumsale;
						}
						if(sumsale>0){
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
			%> 
					<td class="td1" align="right"><%=sumsale %></td>
					<%
					sumsale=0;
					}
					%>
				</tr>
		<!----------------------------------------------------------------------------------------------------------->
		<!------------------------------------------ Prod / Day, MT ------------------------------------------------->
		<!----------------------------------------------------------------------------------------------------------->
				 <tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
					<td class="td1" colspan="2"><b><%=listpara.get(8).toString() %></b></td>
					
		<!--------------------------------------------- Average ----------------------------------------------------->
		<%
		cs = null;
		rs = null;
		sumsale = 0;
		avg=0;
		cntavg=0;
		
		for(int d=0;d<listyear.size();d++){
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		
		batchonDate = lastString.substring(6,10)+lastString.substring(0,2)+"01";
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + batchonDate + "  =  " + bdateto);
		// exec "FOUNDRYFMSHOP"."dbo"."Sel_RptMISMonthlySumm";1 '103', '20160229', 'FOUNDRYERP'
		
				cs = con.prepareCall("{call Sel_RptProdAndRej(?,?,?,?,?,?,?)}");
		 		cs.setString(1, comp);
		 		cs.setString(2, "652");
		 		cs.setString(3, "101102103104"); 
		 		cs.setString(4, batchonDate);
		 		cs.setString(5, bdateto);
		 		cs.setString(6, db); 
		 		cs.setString(7, maindb); 
				rs = cs.executeQuery(); 
				while(rs.next()){
							sumsale = ((Double.parseDouble(rs.getString("TOTAL_WT_WITHOUTRR"))/1000)/Integer.parseInt(listWorkdays.get(d).toString())) + sumsale;
						}
						if(sumsale>0){ 
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
				avg = sumsale;
				cntavg++;
		}				
		avg = avg/cntavg;
		%> 
		<td class="td1" align="right"><%=Math.round(avg) %></td>
		<!----------------------------------------------------------------------------------------------------------->	 
		<%
		cs = null;
		rs = null;
		avg=0;
		cntavg=0;
		sumsale = 0;
		for(int d=0;d<listyear.size();d++){
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		
		batchonDate = lastString.substring(6,10)+lastString.substring(0,2)+"01";
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + batchonDate + "  =  " + bdateto);
		// exec "FOUNDRYFMSHOP"."dbo"."Sel_RptMISMonthlySumm";1 '103', '20160229', 'FOUNDRYERP'
		
				cs = con.prepareCall("{call Sel_RptProdAndRej(?,?,?,?,?,?,?)}");
		 		cs.setString(1, comp);
		 		cs.setString(2, "652");
		 		cs.setString(3, "101102103104"); 
		 		cs.setString(4, batchonDate);
		 		cs.setString(5, bdateto);
		 		cs.setString(6, db); 
		 		cs.setString(7, maindb); 
				rs = cs.executeQuery(); 
				while(rs.next()){
							sumsale = (Double.parseDouble(rs.getString("TOTAL_WT_WITHOUTRR"))/1000) + sumsale;
						}
						if(sumsale>0){
							sumsale = sumsale/Integer.parseInt(listWorkdays.get(d).toString()); 
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
		%>
		<td class="td1" align="right"><%=sumsale %></td>
		<%
			sumsale=0;
		}
		%>
		</tr>
		<!----------------------------------------------------------------------------------------------------------->
		<!------------------------------------------ Good.Prod, MT -------------------------------------------------->
		<!----------------------------------------------------------------------------------------------------------->
				 <tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
					<td class="td1" rowspan="2"><b><%=listpara.get(9).toString() %></b></td>
					<td class="td1" style="background-color: #7bea9a"><b style="font-size: 11px;">Budget</b></td>
					 
		<!------------------------------------------------- Average ----------------------------------------------------->
		<%
		for(int d=0;d<listyear.size();d++){ 
		ps_bud = coninhouse.prepareStatement("select * from mrm_operation where  company='"+comp+"' and month_cnt='"+listmonth.get(d).toString()+"' and foryear='"+yearfor+"' and para_code=6");
		rs_bud = ps_bud.executeQuery();
		while(rs_bud.next()){
			if(!rs_bud.getString("budget").equalsIgnoreCase("")){
			sumBud = Integer.parseInt(rs_bud.getString("budget")) + sumBud;
			}
		}
		}
		sumBud = sumBud/listyear.size();
		%>
		<td class="td1" align="right"><%=Math.round(sumBud) %></td>
<!--------------------------------------------------------------------------------------------------------------->		
					<%
					sumBud=0;
					for(int d=0;d<listyear.size();d++){
					ps_bud = coninhouse.prepareStatement("select * from mrm_operation where  company='"+comp+"' and month_cnt='"+listmonth.get(d).toString()+"' and foryear='"+yearfor+"' and para_code=6");
					rs_bud = ps_bud.executeQuery();
					
					rs_bud.last();
					chkflag = rs_bud.getRow();
					rs_bud.beforeFirst();
					if(chkflag>0){
						while(rs_bud.next()){
					%>
					<td class="td1" align="right"><%=rs_bud.getString("budget") %></td>
					<%		
						}
					}else{
					%> 
					<td class="td1">&nbsp;</td>
					<%
					}
					}
					%> 
<!--------------------------------------------------------------------------------------------------------------------------------------------------------------->			 
					 
				</tr>	
		<tr onmouseover="this.style.background='#b0b0b0';" onmouseout="this.style.background='';" style="cursor: pointer;">
			<td class="td1" style="background-color: #fff38a"><b style="font-size: 11px;">Actual</b></td>
		<!-------------------------------------------- Average -------------------------------------------------->
		<%
		cs = null; 			
		rs = null;
		sumsale = 0;
		avg=0;
		cntavg=0;
		for(int d=0;d<listyear.size();d++){
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		
		batchonDate = lastString.substring(6,10)+lastString.substring(0,2)+"01";
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + batchonDate + "  =  " + bdateto);
		// exec "FOUNDRYFMSHOP"."dbo"."Sel_RptMISMonthlySumm";1 '103', '20160229', 'FOUNDRYERP'
		
				cs = con.prepareCall("{call Sel_RptProdAndRej(?,?,?,?,?,?,?)}");
		 		cs.setString(1, comp);
		 		cs.setString(2, "652");
		 		cs.setString(3, "101102103104"); 
		 		cs.setString(4, batchonDate);
		 		cs.setString(5, bdateto);
		 		cs.setString(6, db); 
		 		cs.setString(7, maindb); 
				rs = cs.executeQuery(); 
				while(rs.next()){
							sumsale = ((Double.parseDouble(rs.getString("TOTAL_WT_WITHOUTRR")) - Double.parseDouble(rs.getString("WEIGHT")))/1000) + sumsale;
						}
						if(sumsale>0){
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
				avg = sumsale;
				cntavg++;
		}			
		avg = avg/cntavg;
		%>
		<td class="td1" align="right"><%=Math.round(avg)%></td>
		<!-----------------------------------------------------------------------------------------------------------> 		   
		<%
		cs = null; 			
		rs = null;
		avg=0;
		cntavg=0;
		sumsale = 0;
		for(int d=0;d<listyear.size();d++){
						
		monthdays = Integer.parseInt(listmonth.get(d).toString())+1;
		forLastDt = monthdays + "/01/" + listyear.get(d).toString().substring(listyear.get(d).toString().length()-4);
		c.clear();
		convertedDate = dateFormat.parse(forLastDt); 
		c.setTime(convertedDate);
		c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		lastDayOfMonth = c.getTime(); 
		lastString = dateFormat.format(lastDayOfMonth);
		
		batchonDate = lastString.substring(6,10)+lastString.substring(0,2)+"01";
		bdateto = lastString.substring(6,10)+lastString.substring(0,2)+lastString.substring(3,5);
		
		// System.out.println("Dates = " + batchonDate + "  =  " + bdateto);
		// exec "FOUNDRYFMSHOP"."dbo"."Sel_RptMISMonthlySumm";1 '103', '20160229', 'FOUNDRYERP'
		
				cs = con.prepareCall("{call Sel_RptProdAndRej(?,?,?,?,?,?,?)}");
		 		cs.setString(1, comp);
		 		cs.setString(2, "652");
		 		cs.setString(3, "101102103104"); 
		 		cs.setString(4, batchonDate);
		 		cs.setString(5, bdateto);
		 		cs.setString(6, db); 
		 		cs.setString(7, maindb); 
				rs = cs.executeQuery(); 
				while(rs.next()){
							sumsale = (Double.parseDouble(rs.getString("TOTAL_WT_WITHOUTRR")) - Double.parseDouble(rs.getString("WEIGHT"))) + sumsale;
						}
						if(sumsale>0){ 
							sumsale = sumsale/1000;
							sumsale = Double.parseDouble(twoDForm.format(sumsale));
						}
					%> 
					<td class="td1" align="right"><%=sumsale %></td>
					<%
					sumsale=0;
					}
					%>
				</tr>
		<!----------------------------------------------------------------------------------------------------------->
		
	</table>
		</div>  
			<%
				con.close();
				} catch (Exception e) {
					e.printStackTrace();
					e.getMessage();
				}
			%>
</body>
</html>