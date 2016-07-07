<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
<title>Detailed MIS Founders</title>
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
<script type="text/javascript">
	function getExcel_Report(comp,OnDateMIS,db) {
		
		document.getElementById("fileloading").style.visibility = "visible";
		document.getElementById("filebutton").disabled = true;
		var xmlhttp;
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("exportId").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "MIS_Summaryxls.jsp?comp=" +comp+ "&OnDateMIS="+OnDateMIS+"&db="+db, true);
		xmlhttp.send();
	}; 
</script>
<style type="text/css">
.tftable {
	font-size: 10px;
	color: #333333;
	width: 90%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 4px;
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
	padding: 4px;
	border-style: solid;
	border-color: #729ea5;
}
</style>
<body bgcolor="#EBE4E7" style="font-family: Arial;">
<%
try{
String comp =request.getParameter("comp");
String OnDateMIS =request.getParameter("ondate"); 
String db =request.getParameter("db"); 
int j=10;
String OnDate = OnDateMIS.substring(6,8) +"/"+ OnDateMIS.substring(4,6) +"/"+ OnDateMIS.substring(0,4);
String batchonDate = "01"+"/"+ OnDateMIS.substring(4,6) +"/"+ OnDateMIS.substring(0,4);
String bdateto = OnDateMIS.substring(0,4) +OnDateMIS.substring(4,6)+OnDateMIS.substring(6,8);
String bdatefrom = OnDateMIS.substring(0,4) +OnDateMIS.substring(4,6)+"01";
		//***************************************************************************************************************
		//***************************************************************************************************************
		String testDate = OnDateMIS.substring(6,8) +"-"+ OnDateMIS.substring(4,6) +"-"+ OnDateMIS.substring(0,4); 
		String from_date = OnDateMIS.substring(0,4) + OnDateMIS.substring(4,6) +"01"; 
		DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		Date today = formatter.parse(testDate); 
        Calendar calendar = Calendar.getInstance();  
        calendar.setTime(today); 
        calendar.add(Calendar.MONTH, 1);  
        calendar.set(Calendar.DAY_OF_MONTH, 1);  
        calendar.add(Calendar.DATE, -1); 
        Date lastDayOfMonth = calendar.getTime(); 
//****************************************************************************************************************************************
double avg2=0;
Connection conlocal = ConnectionUrl.getLocalDatabase();
Calendar calAvg = Calendar.getInstance();
int month = Integer.parseInt(OnDateMIS.substring(4,6)); 
%>
<strong style="color: blue; font-family: Arial;font-size: 14px;">MUTHA FOUNDERS PVT.LTD.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">MIS Summary Report (&nbsp;<%= OnDate%>&nbsp;)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<br/><br/>
<strong style="font-family: Arial;font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
SimpleDateFormat sdfparse = new SimpleDateFormat("dd/MM/yyyy");  
int total_dd = 0;
int holliday = 0;
Date datesq = new Date();
int day = Integer.parseInt(OnDateMIS.substring(6,8) );

//System.out.println("day = = = = " + month + "  " + day);

PreparedStatement ps_week = conlocal.prepareStatement("select count(*) from montlyweekdays_tbl where month=" + month + " and day<" + day);
ResultSet rs_week = ps_week.executeQuery();
while (rs_week.next()) {
holliday = Integer.parseInt(rs_week.getString("count(*)"));
}

//System.out.println("Hollidays= = " + month + "  " + day);

int dd = today.getDate();
int tues = 0;
for (int i = 1; i < dd; i++) {
calAvg.set(Calendar.DAY_OF_MONTH, i);
if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY) {
	tues++;
}
}

int workdays = dd - tues;
total_dd = workdays;
//System.out.println("ALl tuesdays = " + total_dd);

total_dd = total_dd - holliday;


// ***************************************************************************************************************
int space = 0;
PreparedStatement ps_allHol = conlocal.prepareStatement("select count(montlyWeekdays_id) from montlyweekdays_tbl where month=" + month);
ResultSet rs_allHol = ps_allHol.executeQuery();
while (rs_allHol.next()) {
space = Integer.parseInt(rs_allHol.getString("count(montlyWeekdays_id)"));
} 

int count_mnt = lastDayOfMonth.getDate();

int tue_month = 0;
for (int i = 1; i < count_mnt; i++) {
calAvg.set(Calendar.DAY_OF_MONTH, i);
if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY) {
	tue_month++;
}
}

count_mnt = count_mnt - tue_month; 
count_mnt = count_mnt - space;
// System.out.println("Total Woring Days = " + count_mnt);
%>
<%-- <span style="font-family: Arial;font-size: 12px;">Total Working Days : <b><%=total_dd %>&nbsp;&nbsp;&nbsp;</b>Working Days Over : <b><%=workdays %></b></span> --%>
<span style="font-family: Arial;font-size: 12px;">Total Working Days : <b><%=count_mnt %>&nbsp;&nbsp;</b>Working Days Over : <b><%=total_dd %></b></span>
&nbsp;&nbsp;<span style="font-family: Arial;font-size: 10px;color: brown;"><b>( Note : Click on record to get details &#8628; )</b></span>&nbsp;&nbsp; 
<span id="exportId">
		<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=OnDateMIS%>','<%=db%>')"
			style="cursor: pointer; font-family: Arial; font-size: 12px;">Generate Excel</button> <img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;" />
</span>
<br/> 
<div style="width: 58%; float: left;">
<form action="PotwiseDetailReportK1.jsp" method="post" id="edit" name="edit"> 
 <% 
 Connection con = ConnectionUrl.getFoundryFMShopConnection();
 DecimalFormat zeroDForm = new DecimalFormat("##0.00");
 double total1=0,total2=0;
 double yield1 =0,yield2=0,yield=0,yieldtt1 =0,yieldtt2=0,yieldtt=0;
 %>
 <input type="hidden" name="comp" value="<%=comp%>">
 <input type="hidden" name="datefrom" value="<%=OnDateMIS%>"> 
 <input type="hidden" name="db" value="<%=db%>">
 <input type="hidden" name="gradeName" id="gradeName">
  
			<table border="1" class="tftable"> 
				<tr>
					<th scope="col">&nbsp;</th>
					<th scope="col" colspan="3">On Date</th>  
					<th scope="col">&nbsp;</th>
					<th scope="col" colspan="3">To Date</th>
					<th scope="col">&nbsp;</th>  
				</tr>
				<tr>
					<th scope="col">Head</th>
					<th scope="col">CI</th>
					<th scope="col">SGI</th>
					<th scope="col">Total</th>
					<th scope="col">&nbsp;</th>    
					<th scope="col">CI</th>
					<th scope="col">SGI</th>
					<th scope="col">Total</th>  
					<th scope="col">Average</th>  
				</tr> 
				<% 
				ArrayList cast=new ArrayList();
				ArrayList sg=new ArrayList();
				ArrayList head=new ArrayList();
				
				double inh_rej_total1 = 0,inh_rej_total2 = 0;
				double inh_rej_total11 = 0,inh_rej_total22 = 0;
				
				double cust_rej_total1 = 0,cust_rej_total2 = 0;
				double cust_rej_total12 = 0,cust_rej_total22 = 0;
				
				head.add("TOTAL MELTING , MT");
				head.add("TOTAL PROD, MT");
				head.add("YIELD, %");
				head.add("INHOUSE REJ, MT");
				head.add("GOOD PROD, MT");
				head.add("SALES, MT");
				head.add("CUSTOMER RETURNS, MT");
				head.add("INHOUSE REJ %");
				head.add("CUSTOMER RET, %");
				head.add("SALES, Rs Lacs"); 

				
				CallableStatement cs = con.prepareCall("{call Sel_RptMISMonthlySumm(?,?,?)}");
		 		cs.setString(1, comp);
		 		cs.setString(2, OnDateMIS);
		 		cs.setString(3, db); 
				ResultSet rs1 = cs.executeQuery(); 
				while(rs1.next()){
					if(rs1.getString("GRADE").equalsIgnoreCase("101")){
						sg.add(rs1.getString("OD_TOTAL_MELTING"));
						sg.add(rs1.getString("OD_TOTAL_PROD"));
						sg.add(rs1.getString("OD_YIELD"));
						sg.add(rs1.getString("OD_REJ_QTY"));
						sg.add(rs1.getString("OD_GOOD_PROD"));
						sg.add(rs1.getString("OD_DESP_QTY"));
						sg.add(rs1.getString("OD_CUST_RTN"));
						sg.add(rs1.getString("OD_REJ_PER"));
						sg.add(rs1.getString("OD_CUST_RTN_PER"));
						sg.add(rs1.getString("OD_DESP_AMT"));
						sg.add(rs1.getString("TD_TOTAL_MELTING"));
						sg.add(rs1.getString("TD_TOTAL_PROD"));
						sg.add(rs1.getString("TD_YIELD"));
						sg.add(rs1.getString("TD_REJ_QTY"));
						sg.add(rs1.getString("TD_GOOD_PROD"));
						sg.add(rs1.getString("TD_DESP_QTY"));
						sg.add(rs1.getString("TD_CUST_RTN"));
						sg.add(rs1.getString("TD_REJ_PER"));
						sg.add(rs1.getString("TD_CUST_RTN_PER"));
						sg.add(rs1.getString("TD_DESP_AMT"));
					} 	 	    
					if(rs1.getString("GRADE").equalsIgnoreCase("102")){
						cast.add(rs1.getString("OD_TOTAL_MELTING"));
						cast.add(rs1.getString("OD_TOTAL_PROD"));
						cast.add(rs1.getString("OD_YIELD"));
						cast.add(rs1.getString("OD_REJ_QTY"));
						cast.add(rs1.getString("OD_GOOD_PROD"));
						cast.add(rs1.getString("OD_DESP_QTY"));
						cast.add(rs1.getString("OD_CUST_RTN"));
						cast.add(rs1.getString("OD_REJ_PER"));
						cast.add(rs1.getString("OD_CUST_RTN_PER"));
						cast.add(rs1.getString("OD_DESP_AMT"));
						cast.add(rs1.getString("TD_TOTAL_MELTING"));
						cast.add(rs1.getString("TD_TOTAL_PROD"));
						cast.add(rs1.getString("TD_YIELD"));
						cast.add(rs1.getString("TD_REJ_QTY"));
						cast.add(rs1.getString("TD_GOOD_PROD"));
						cast.add(rs1.getString("TD_DESP_QTY"));
						cast.add(rs1.getString("TD_CUST_RTN"));
						cast.add(rs1.getString("TD_REJ_PER"));
						cast.add(rs1.getString("TD_CUST_RTN_PER"));
						cast.add(rs1.getString("TD_DESP_AMT"));
					}
				}
			 	for(int i=0;i<10;i++){
			 	%>
			 	<tr> 
					<td scope="col" align="left"><%=head.get(i).toString() %></td>
					<td title="Click to get details" scope="col" align="right"><a href="MIS_SummaryDetails_GradeFND.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&grade=Cast Iron" style="text-decoration: none;"><%=cast.get(i).toString() %></a> </td>
					<td title="Click to get details" scope="col" align="right"><a href="MIS_SummaryDetails_GradeFND.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&grade=SG Iron" style="text-decoration: none;"><%=sg.get(i).toString() %></a> </td> 
					<%
					//System.out.println("Header = " + i + "  " +head.get(i).toString());
					total1 = Double.parseDouble(cast.get(i).toString()) + Double.parseDouble(sg.get(i).toString());
					total2 = Double.parseDouble(cast.get(j).toString()) + Double.parseDouble(sg.get(j).toString());
					
					if(head.get(i).toString().equalsIgnoreCase("INHOUSE REJ, MT")){
						inh_rej_total1 = total1;
						inh_rej_total2 = total2;
					//	System.out.println("data = " + inh_rej_total1 + " = " + inh_rej_total2);
					}
					if(head.get(i).toString().equalsIgnoreCase("TOTAL PROD, MT")){
						inh_rej_total11 = total1;
						inh_rej_total22 = total2;
						
					}
					
					if(head.get(i).toString().equalsIgnoreCase("INHOUSE REJ %")){ 
						total1 = (inh_rej_total1/inh_rej_total11)*100;
						total2 = (inh_rej_total2/inh_rej_total22)*100; 
					}					
					
					if(head.get(i).toString().equalsIgnoreCase("CUSTOMER RETURNS, MT")){
						cust_rej_total1 = total1;
						cust_rej_total2 = total2;
					//	System.out.println("one = " + cust_rej_total1 + " = " +cust_rej_total2);
					}
					if(head.get(i).toString().equalsIgnoreCase("SALES, MT")){
						cust_rej_total12 = total1;
						cust_rej_total22 = total2; 
					//	System.out.println("Two = " + cust_rej_total12 + " = " +cust_rej_total22);
					}
					if(head.get(i).toString().equalsIgnoreCase("CUSTOMER RET, %")){
						total2 = (cust_rej_total2/cust_rej_total22)*100;
						total1 = (cust_rej_total1/cust_rej_total12)*100;
					}
					
					if(i==0){
						yield1 = total1;
						yieldtt1 = total2;
					}
					if(i==1){
						yield2 = total1;
						yieldtt2 = total2;
					}	
					if(i==2){
						yield = yield2/yield1*100;
						yieldtt = yieldtt2/yieldtt1*100;
					%>
					<td title="Click to get details" scope="col" align="right"><%=zeroDForm.format(yield) %></td>
					<td title="Click to get details" scope="col" align="right">&nbsp;</td>						
					<td title="Click to get details" scope="col" align="right"><a href="MIS_SummaryDetails_GradeFND.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&grade=Cast Iron" style="text-decoration: none;"><%=cast.get(j).toString() %></a> </td>
					<td title="Click to get details" scope="col" align="right"><a href="MIS_SummaryDetails_GradeFND.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&grade=SG Iron" style="text-decoration: none;"><%=sg.get(j).toString() %></a> </td>
					 <td title="Click to get details" scope="col" align="right"><%=zeroDForm.format(yieldtt) %></td>
					<%
					yield1=0;yield2=0;yield=0;
					}
					if(i!=2){
					%>
					<td title="Click to get details" scope="col" align="right"><%=zeroDForm.format(total1) %></td>
					<td title="Click to get details" scope="col" align="right">&nbsp;</td>
					<td title="Click to get details" scope="col" align="right"><a href="MIS_SummaryDetails_GradeFND.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&grade=Cast Iron" style="text-decoration: none;"><%=cast.get(j).toString() %></a> </td>
					<td title="Click to get details" scope="col" align="right"><a href="MIS_SummaryDetails_GradeFND.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&grade=SG Iron" style="text-decoration: none;"><%=sg.get(j).toString() %></a> </td>
					<td title="Click to get details" scope="col" align="right"><%=zeroDForm.format(total2) %></td>
					<%
					}
					if(head.get(i).toString().equalsIgnoreCase("TOTAL MELTING , MT") || head.get(i).toString().equalsIgnoreCase("TOTAL PROD, MT") || head.get(i).toString().equalsIgnoreCase("INHOUSE REJ, MT") 
							|| head.get(i).toString().equalsIgnoreCase("GOOD PROD, MT") || head.get(i).toString().equalsIgnoreCase("SALES, Rs Lacs") || head.get(i).toString().equalsIgnoreCase("CUSTOMER RETURNS, MT")){
					avg2 = Double.parseDouble(zeroDForm.format(total2))/workdays;
					}else{
						avg2 = 0;
					}
					%> 
					<td title="Click to get details" scope="col" align="right"><%=zeroDForm.format(avg2) %></td>			 
				</tr>
				<%
				j++;
			 	}
				%>
			<!--------------------------------------------------------------------------------------------------------------->
			<!------------------------------------------ Heat CI/SGI -------------------------------------------------------->
			<%
			/* int ondate_ci=0;
			int todate_ci=0;
			int ondate_sgi=0;
			int todate_sgi=0; */
			Set<String> ondateci = new HashSet();
			Set<String> todateci = new HashSet();
			Set<String> ondatesgi = new HashSet();
			Set<String> todatesgi = new HashSet();
			
			// exec "FOUNDRYFMSHOP"."dbo"."Sel_RptGrdWiseDailyProd";1 '103', '652', '101102103', '20151106', '20151106', 'FOUNDRYERP', 'FOUNDRYFMSHOP'	
			CallableStatement cs_heat = con.prepareCall("{call Sel_RptGrdWiseDailyProd(?,?,?,?,?,?,?)}");
			cs_heat.setString(1, comp);
			cs_heat.setString(2, "652");
			cs_heat.setString(3, "101102103");
			cs_heat.setString(4, OnDateMIS);
			cs_heat.setString(5, OnDateMIS);
			cs_heat.setString(6, "FOUNDRYERP");
			cs_heat.setString(7, "FOUNDRYFMSHOP");
			ResultSet rs_heat = cs_heat.executeQuery(); 
			while(rs_heat.next()){
				if(rs_heat.getString("GRADE").equalsIgnoreCase("102")){
				//	ondate_ci++;
					ondateci.add(rs_heat.getString("TRAN_NO"));
				}
				if(rs_heat.getString("GRADE").equalsIgnoreCase("101")){
					// ondate_sgi++;
					ondatesgi.add(rs_heat.getString("TRAN_NO"));
				}
			}
			 
			
					
			CallableStatement cs_ondate = con.prepareCall("{call Sel_RptGrdWiseDailyProd(?,?,?,?,?,?,?)}");
			cs_ondate.setString(1, comp);
			cs_ondate.setString(2, "652");
			cs_ondate.setString(3, "101102103");
			cs_ondate.setString(4, from_date);
			cs_ondate.setString(5, OnDateMIS);
			cs_ondate.setString(6, "FOUNDRYERP");
			cs_ondate.setString(7, "FOUNDRYFMSHOP");
			ResultSet rs_ondate = cs_ondate.executeQuery(); 
			while(rs_ondate.next()){
				if(rs_ondate.getString("GRADE").equalsIgnoreCase("102")){
					// todate_ci++;
				todateci.add(rs_ondate.getString("TRAN_NO"));
				}
				if(rs_ondate.getString("GRADE").equalsIgnoreCase("101")){
					// todate_sgi++;
				todatesgi.add(rs_ondate.getString("TRAN_NO"));
				}
			} 
			int heatavg1 = todateci.size()/total_dd;
			int heatavg2 = todatesgi.size()/total_dd;
			int  total_ci = ondateci.size() + ondatesgi.size();
			int total_sgi = todateci.size() + todatesgi.size(); 
			int totalAverage = total_sgi/total_dd;
			%>
				<tr>
					<th scope="col" align="left"><b>HEATS</b></th>
					<td  scope="col" align="right"><b><%=ondateci.size() %></b></td>
					<td  scope="col" align="right"><b><%=ondatesgi.size() %></b></td>
					<td  scope="col" align="right"><b><%=total_ci %></b></td>
					<td  scope="col" align="right">&nbsp;</td>
					<td  scope="col" align="right"><b><%=todateci.size() %></b></td>
					<td  scope="col" align="right"><b><%=todatesgi.size() %></b></td>
					<td  scope="col" align="right"><b><%=total_sgi %></b></td>
					<td  scope="col" align="right"><b><%=totalAverage %></b></td>  
				</tr>
			<!--------------------------------------------------------------------------------------------------------------->	
			</table>  
			<!--===========================================================================================================-->
			<!--===========================================================================================================--> 
		</form>
	</div>
	
 <div style="width: 40%;float: right;">
 <span style="font-family: Arial;font-size: 10px;color: brown;"><b> ( Note : Click on record to get details &#8628; )</b> </span>
 <% 
    double sumrc = 0,sumrs=0,summix=0;
  
	CallableStatement batch = con.prepareCall("{call Sel_RptBatchProduction(?,?,?,?)}");
	batch.setString(1, comp);
	batch.setString(2, bdatefrom);
	batch.setString(3, bdateto); 
	batch.setString(4, db); 
	ResultSet rabatch = batch.executeQuery(); 
	while(rabatch.next()){
		 if(rabatch.getString("MAT_CODE").equalsIgnoreCase("1011400003")){
		 sumrc = sumrc + Double.parseDouble(rabatch.getString("QTY"));		
		 summix = summix + Double.parseDouble(rabatch.getString("TOT_MIXES"));
		 }
		 if(rabatch.getString("MAT_CODE").equalsIgnoreCase("1010403133")){ 
		 sumrs = sumrs + Double.parseDouble(rabatch.getString("QTY"));
		 }
	}
	DecimalFormat threeDForm = new DecimalFormat("0.000"); 
 %>
 <table border="1" class="tftable">
				<tr>
					<th scope="col" colspan="3">Batch Production From <%=batchonDate %> to <%=OnDate %></th>   
				</tr>
				<tr>
					<th scope="col">Item</th>
					<th scope="col">Qty</th>
					<th scope="col">Total Mixes</th>
				</tr>
				<tr>
				<td title="Click to get details"><a href="MIS_SummaryDetailsBatch_FND.jsp?comp=<%=comp %>&fromdate=<%=bdatefrom %>&todate=<%=bdateto %>&db=<%=db %>" style="text-decoration: none;">RESINE COATED SAND 3.8 %</a> </td>
				<td title="Click to get details" align="right"><a href="MIS_SummaryDetailsBatch_FND.jsp?comp=<%=comp %>&fromdate=<%=bdatefrom %>&todate=<%=bdateto %>&db=<%=db %>" style="text-decoration: none;"><%=threeDForm.format(sumrc/1000)%></a>  </td>
				<td title="Click to get details" align="right"><a href="MIS_SummaryDetailsBatch_FND.jsp?comp=<%=comp %>&fromdate=<%=bdatefrom %>&todate=<%=bdateto %>&db=<%=db %>" style="text-decoration: none;"><%=summix %></a>  </td>
				</tr>
				<tr>
				<td title="Click to get details"><a href="MIS_SummaryDetailsBatch_FND.jsp?comp=<%=comp %>&fromdate=<%=bdatefrom %>&todate=<%=bdateto %>&db=<%=db %>" style="text-decoration: none;">RAW SILICA SAND RECLAIMED</a>  </td>
				<td title="Click to get details" align="right"><a href="MIS_SummaryDetailsBatch_FND.jsp?comp=<%=comp %>&fromdate=<%=bdatefrom %>&todate=<%=bdateto %>&db=<%=db %>" style="text-decoration: none;"><%=threeDForm.format(sumrs/1000)%></a>  </td>
				<td align="right"></td>
				</tr>
 </table>
 <br>
 <table class="tftable">
			<tr>
				<th>FURNACE HEATS</th>
				<th>SHIFT 1</th>
				<th>SHIFT 2</th>
				<th>SHIFT 3</th>
				<th>TOTAL &#8659;</th>
			</tr>
			<%
			ArrayList refcode = new ArrayList();
			ArrayList refname = new ArrayList();
			
			ArrayList shift1 = new ArrayList();
			ArrayList shift2 = new ArrayList();
			ArrayList shift3 = new ArrayList();
			ArrayList total = new ArrayList();
			
			PreparedStatement ps_refCode = con.prepareStatement("SELECT * FROM MSTCOMMFURNACE ");
			ResultSet rs_refCode = ps_refCode.executeQuery();
			while(rs_refCode.next()){
				refcode.add(rs_refCode.getString("CODE"));
				refname.add(rs_refCode.getString("NAME"));
			}
			
			int fc=0;
			int shift=1;
			int qty_fc=0;
			PreparedStatement ps_fc = null;
			ResultSet rs_fc = null;
			for(int i=0;i<refcode.size();i++){
			%>
			<tr align="right">
					<td align="left"><%=refname.get(i).toString() %></td>
					<%
					ps_fc = con.prepareStatement("select COUNT(*) as count from TRNWIPMATH where TRAN_NO LIKE'%652110%' AND TRAN_DATE BETWEEN '"+OnDateMIS+"' AND '"+OnDateMIS+"' AND SHIFT='"+shift+"' AND REF_CODE='"+refcode.get(i).toString()+"'");
					rs_fc = ps_fc.executeQuery();
					while(rs_fc.next()){
						shift1.add(Integer.parseInt(rs_fc.getString("count")));
					%>
					<td><b><%=rs_fc.getString("count") %></b> </td>
					<%
					qty_fc = Integer.parseInt(rs_fc.getString("count")) ;
					}
					shift++;
					ps_fc = con.prepareStatement("select COUNT(*) as count from TRNWIPMATH where TRAN_NO LIKE'%652110%' AND TRAN_DATE BETWEEN '"+OnDateMIS+"' AND '"+OnDateMIS+"' AND SHIFT='"+shift+"' AND REF_CODE='"+refcode.get(i).toString()+"'");
					rs_fc = ps_fc.executeQuery();
					while(rs_fc.next()){
						shift2.add(Integer.parseInt(rs_fc.getString("count")));
					%>
					<td><b><%=rs_fc.getString("count") %></b> </td>
					<%
					qty_fc = Integer.parseInt(rs_fc.getString("count")) +qty_fc;
					}
					shift++;
					ps_fc = con.prepareStatement("select COUNT(*) as count from TRNWIPMATH where TRAN_NO LIKE'%652110%' AND TRAN_DATE BETWEEN '"+OnDateMIS+"' AND '"+OnDateMIS+"' AND SHIFT='"+shift+"' AND REF_CODE='"+refcode.get(i).toString()+"'");
					rs_fc = ps_fc.executeQuery();
					while(rs_fc.next()){
						shift3.add(Integer.parseInt(rs_fc.getString("count")));
					%>
					<td><b><%=rs_fc.getString("count") %></b> </td>
					<%
					qty_fc = Integer.parseInt(rs_fc.getString("count")) +qty_fc;
					}
					%> 
					<td><b><%=qty_fc %></b> </td>
					<%
					total.add(qty_fc);
					// System.out.println("qc fc = " + qty_fc);
					shift=1;
					fc=0;
					}
					%>
			</tr> 
			
				<%
				double sum1 = 0;
				double sum2 = 0;
				double sum3 = 0;
				double sum4 = 0;
				for(int i = 0; i < shift1.size(); i++){
				    sum1 += Double.parseDouble(shift1.get(i).toString());
				}
				for(int i1 = 0; i1 < shift2.size(); i1++){
					sum2 += Double.parseDouble(shift2.get(i1).toString());
				}
				for(int i2 = 0; i2 < shift3.size(); i2++){
					sum3 += Double.parseDouble(shift3.get(i2).toString());
				} 
				for(int i3 = 0; i3 < total.size(); i3++){
					sum4 += Double.parseDouble(total.get(i3).toString());
				}
				%>
			<tr align="right">
				<td style="background-color: #acc8cc;"><b>TOTAL &#8658; </b></td>
				<td><b><%=Math.round(sum1) %></b></td> 
				<td><b><%=Math.round(sum2) %></b></td> 
				<td><b><%=Math.round(sum3) %></b></td>
				<td><b><%=Math.round(sum4) %></b></td>
				
			</tr>
	</table>	 
	 
 </div>
<%
con.close();
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>