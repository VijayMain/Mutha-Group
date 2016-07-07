<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
<html>
<head>
<script language="JavaScript"> 
var nHist = window.history.length;
if(window.history[nHist] != window.location)
  window.history.forward(); 
</script> 
<title>Despatch Plan v/s Sales</title>
<STYLE TYPE="text/css" MEDIA=all>
.td1 { 
	font-size: 10px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
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

A:link {
	COLOR: #0000EE;
}

A:hover {
	COLOR: #0000EE;
}

A:visited {
	COLOR: #0000EE;
}

A:hover {
	COLOR: #0000EE;
}

.div_freezepanes_wrapper {
	font-size:10px;
	position: relative; 
	width: 99%;
	height: 550px;
	overflow: hidden;
	background: #fff;
	border-style: ridge;
	
}

.div_verticalscroll {
	font-size:10px;
	position: absolute;
	right: 0px;
	width: 18px;
	height: 100%;
	background: #EAEAEA;
	border: 1px solid #C0C0C0;
}

.buttonUp {
	width: 20px;
	position: absolute;
	top: 2px;
}

.buttonDn {
	width: 20px;
	position: absolute;
	bottom: 22px;
}

.div_horizontalscroll {
	font-size:10px;
	position: absolute;
	bottom: 0px;
	width: 0%;
	height: 0px;
	background: #EAEAEA;
	border: 1px solid #C0C0C0;
}

.buttonRight {
	width: 20px;
	position: absolute;
	left: 0px;
	padding-top: 2px;
}

.buttonLeft {
	width: 20px;
	position: absolute;
	right: 22px;
	padding-top: 2px;
}
</STYLE>
<script type="text/javascript">
	function getExcel_Report(comp,cust,getdate) {
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
		xmlhttp.open("POST", "DispPlanVsale_xls.jsp?comp=" + comp + "&cust=" + cust + "&getdate=" + getdate , true);
		xmlhttp.send();
	}; 
</script>
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
<%
try{	
Connection con =null; 
String comp =request.getParameter("comp");
String cust =request.getParameter("cust"); 
String getdate =request.getParameter("ondate");
 
DecimalFormat zeroDForm = new DecimalFormat("###,##0");
DecimalFormat twoDForm = new DecimalFormat("###,##0.00"); 

Connection conlocal = ConnectionUrl.getLocalDatabase();

/* System.out.println("cust = " + cust + "comp = " + comp); */
// getdate = "20141130";

String asOnDate = getdate.substring(6,8) +"/"+ getdate.substring(4,6) +"/"+ getdate.substring(0,4);

//***********************************************************************************************************************
String testDate = getdate.substring(6,8) +"-"+ getdate.substring(4,6) +"-"+ getdate.substring(0,4);
DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
Date today = formatter.parse(testDate);

/* System.out.println("Date tod Todays = " + testDate); */

Calendar calendar = Calendar.getInstance();  
calendar.setTime(today);
calendar.add(Calendar.MONTH, 1);  
calendar.set(Calendar.DAY_OF_MONTH, 1);  
calendar.add(Calendar.DATE, -1);
Date lastDayOfMonth = calendar.getTime();

int month = Integer.parseInt(getdate.substring(4,6));
SimpleDateFormat sdfparse = new SimpleDateFormat("dd/MM/yyyy"); 
Calendar calAvg = Calendar.getInstance();
//****************************************************************************************************************************************
int total_dd = 0;
int holliday = 0;
Date datesq = new Date();
int day = datesq.getDate();

PreparedStatement ps_week = conlocal.prepareStatement("select count(*) from montlyweekdays_tbl where month="+month+" and day<"+day);
ResultSet rs_week = ps_week.executeQuery();
while (rs_week.next()) {
	holliday = Integer.parseInt(rs_week.getString("count(*)"));
}

PreparedStatement ps_holli = conlocal.prepareStatement("select * from montlyweekdays_tbl where day="+day+" and month="+month);
ResultSet rs_holli = ps_holli.executeQuery();
while (rs_holli.next()) { 
	System.out.println("Its a holliday !!!");
}				

int dd =  today.getDate(); 
int tues=0;
for(int i = 1 ; i < dd ; i++)
{      
	calAvg.set(Calendar.DAY_OF_MONTH, i);
    if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY){ 
    	tues++;      
    }
}
System.out.println("month  tues "+ tues +"\t"+ dd);
int workdays = dd-tues; 

total_dd = workdays;

System.out.println("total_dd  =====================>  "+ total_dd);

total_dd = total_dd - holliday;

System.out.println("Holliday = "+holliday);
System.out.println("total_dd afer =====================>  "+ total_dd);
// ***************************************************************************************************************
int space = 0; 	
PreparedStatement ps_allHol = conlocal.prepareStatement("select count(montlyWeekdays_id) from montlyweekdays_tbl where month="+month);
ResultSet rs_allHol = ps_allHol.executeQuery();
while (rs_allHol.next()) { 
	System.out.println(rs_allHol.getString("count(montlyWeekdays_id)"));
	space = Integer.parseInt(rs_allHol.getString("count(montlyWeekdays_id)"));
}

int count_mnt = lastDayOfMonth.getDate();

int tue_month=0;
for(int i = 1 ; i < count_mnt ; i++)
{      
	calAvg.set(Calendar.DAY_OF_MONTH, i);
    if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY){ 
    	tue_month++;      
    }
}

count_mnt = count_mnt - tue_month;
System.out.println("Space = " + space);
System.out.println("Tuesday before = " + count_mnt);
count_mnt = count_mnt - space;
System.out.println("Tuesday = " + count_mnt);
// ***************************************************************************************************************
	
ArrayList itemList = new ArrayList();
ArrayList qtyDispatch = new ArrayList();
ArrayList amtDispatch = new ArrayList();
ArrayList qtySale = new ArrayList();
ArrayList amtSale = new ArrayList();
ArrayList qtyPend = new ArrayList();
ArrayList amtPend = new ArrayList();
ArrayList bsrStk = new ArrayList();
/* ArrayList netReq = new ArrayList(); */
ArrayList Req_pd = new ArrayList();
ArrayList avg_pd = new ArrayList();
ArrayList dev_rat = new ArrayList();

 



 
String CompanyName=""; 
if(comp.equalsIgnoreCase("101")){
	CompanyName = "H-21 MUTHA ENGINEERING PVT.LTD.";
	con = ConnectionUrl.getMEPLH21ERP();	
	CallableStatement callMat = con.prepareCall("{call SEL_MSTMATERIALGLSUB(?,?)}");
	callMat.setString(1, cust);
	callMat.setString(2, "101"); 
	ResultSet rsMat = callMat.executeQuery(); 
		while (rsMat.next()) {
			itemList.add(rsMat.getString("CODE"));  
		}
}
if(comp.equalsIgnoreCase("102")){
	CompanyName = "H-25 MUTHA ENGINEERING PVT.LTD.";
	con = ConnectionUrl.getMEPLH25ERP(); 
	CallableStatement callMat = con.prepareCall("{call SEL_MSTMATERIALGLSUB(?,?)}");
	callMat.setString(1, cust);
	callMat.setString(2, "101"); 
	ResultSet rsMat = callMat.executeQuery(); 
		while (rsMat.next()) {
			itemList.add(rsMat.getString("CODE")); 
		}
}
if(comp.equalsIgnoreCase("103")){ 
	CompanyName = "MUTHA FOUNDERS PVT.LTD.";
	con = ConnectionUrl.getFoundryERPNEWConnection();  
	CallableStatement callMat = con.prepareCall("{call SEL_MSTMATERIALGLSUB(?,?)}");
	callMat.setString(1, cust);
	callMat.setString(2, "101"); 
	ResultSet rsMat = callMat.executeQuery(); 
		while (rsMat.next()) {
			itemList.add(rsMat.getString("CODE"));  
		}
}if(comp.equalsIgnoreCase("105")){
	CompanyName = "DHANASHREE INDUSTRIES";
	con	= ConnectionUrl.getDIERPConnection();
	CallableStatement callMat = con.prepareCall("{call SEL_MSTMATERIALGLSUB(?,?)}");
	callMat.setString(1, cust);
	callMat.setString(2, "101"); 
	ResultSet rsMat = callMat.executeQuery(); 
		while (rsMat.next()) {
			itemList.add(rsMat.getString("CODE")); 
		}
}if(comp.equalsIgnoreCase("106")){
	CompanyName = "MUTHA ENGINEERING PVT.LTD.UNIT III";
	con	= ConnectionUrl.getK1ERPConnection();
	CallableStatement callMat = con.prepareCall("{call SEL_MSTMATERIALGLSUB(?,?)}");
	callMat.setString(1, cust);
	callMat.setString(2, "101"); 
	ResultSet rsMat = callMat.executeQuery(); 
		while (rsMat.next()) {
			itemList.add(rsMat.getString("CODE")); 
		}
}  
%> 
<strong style="color: blue;font-family: Arial;font-size: 14px;"><%=CompanyName %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Dispatch Plan v/s Sales As on &nbsp;<%=asOnDate %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>
<%
if(comp.equalsIgnoreCase("101") || comp.equalsIgnoreCase("102")){
%>
<strong style="font-family: Arial;font-size: 13px;"><a href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
<%
}else{
%>
<strong style="font-family: Arial;font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
<%	
}
%> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span style=" font-family: Arial;font-size: 11px;color: red;"><strong>Please Note :</strong>&nbsp;All Amounts in lakhs</span> 

<span id="exportId">
	<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=cust%>','<%=getdate%>')"
	style="cursor: pointer; font-family: Arial; font-size: 12px;">Generate Excel</button> <img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;" />
</span>

		<div class="div_freezepanes_wrapper">
			<div class="div_verticalscroll" onmouseover="this.style.cursor='pointer'">
				<div style="height: 50%;" onmousedown="upp();" onmouseup="upp(1);">
					<img class="buttonUp" src="images/up.png">
				</div>
				<div style="height: 50%;" onmousedown="down();" onmouseup="down(1);">
					<img class="buttonDn" src="images/down.png">
				</div>
			</div>

			<div class="div_horizontalscroll" onmouseover="this.style.cursor='pointer'">
				<div style="float: left; width: 50%; height: 100%;" onmousedown="right();" onmouseup="right(1);">
					<img class="buttonRight" src="images/left.png">
				</div>
				<div style="float: right; width: 50%; height: 100%;" onmousedown="left();" onmouseup="left(1);">
					<img class="buttonLeft" src="images/forward.png">
				</div>
			</div>		
			
			<table id="t1" class="t1" border="1" style="width:98%; border: 1px solid #000;">  
				 
				<tr align="center">
					<th class="th" rowspan="2">Sr. No</th>
					<th class="th" rowspan="2">Item Name</th> 
					<th class="th" rowspan="2" width="20px">REQ/PERDAY</th>
					<th class="th" rowspan="2" width="20px">Sale AVG/PERDAY</th>
					<th class="th" rowspan="2" width="20px">Delivery Rating %</th>
					<th class="th" colspan="2">Despatch Plan</th>
					<th class="th" colspan="2">Sales</th>
					<!-- <th class="th" rowspan="2">Delivery Rating</th> -->
					<th class="th" colspan="2">Pending</th>
					<!-- <th class="th" rowspan="2">B.S.R. Stock</th> -->
					<!-- <th class="th" rowspan="2">Net Req For Prod</th> --> 
				</tr>
				<tr align="center"  style="background-color: #BCCED4;font-family: Arial;font-size: 12px;">
					<th>Qty</th>
					<th>Amount</th> 										
					<th>Qty</th>			
					<th>Amount</th>	
					<th>Qty</th>
					<th>Amount</th> 
				</tr>
				<%
				int srNo= 1,cnt1=0;
				double rating=0,req_perdayQty=0,avg_perdayQty=0,del_rating=0;
				double dispAmt=0,saleAmt=0,pending_Amt=0;
				
				//System.out.println("Test = " + cust +"  " + matcode + "  " +getdate);
				CallableStatement callplan = con.prepareCall("{call Sel_RptDespatchPlanSale(?,?,?,?)}");
				callplan.setString(1, comp);
				callplan.setString(2, "0");
				callplan.setString(3, cust);
				callplan.setString(4, getdate);
				ResultSet rsPlan = callplan.executeQuery();
					while (rsPlan.next()) {
						// rating = (Double.parseDouble(rsPlan.getString("SALE_QTY"))*100)/Double.parseDouble(rsPlan.getString("NOS_QTY"));
				if(cnt1==0){
				%>
				<tr>
					 <td class="td1" align="left" colspan="11"><strong style="font-size: 13px;font-family: Arial;color: blue;"><%=rsPlan.getString("CUST_NAME") %>&#8658;</strong></td>
				</tr>	 
				<% 
				}
				
				req_perdayQty = Double.parseDouble(rsPlan.getString("NOS_QTY"))/count_mnt;
				avg_perdayQty = Double.parseDouble(rsPlan.getString("SALE_QTY"))/total_dd;
				del_rating = (avg_perdayQty/req_perdayQty)*100;
				
				Req_pd.add(req_perdayQty);
				avg_pd.add(avg_perdayQty);
				dev_rat.add(del_rating);
				%>
				<tr  style="font-family: Arial;font-size: 10px;">
					 <td align="center"><%=srNo %></td>
					 <td align="left"><%=rsPlan.getString("MAT_NAME") %></td> 
					 <td align="right"><%=Math.round(req_perdayQty) %></td>
					 <td align="right"><%=Math.round(avg_perdayQty) %></td>
					 <td align="right"><%=twoDForm.format(del_rating) %></td>
					 <td align="right"><%=Math.round(Double.parseDouble(rsPlan.getString("NOS_QTY"))) %></td> 	 
					 <td align="right"><%=twoDForm.format(Double.parseDouble(rsPlan.getString("SCH_AMT"))/100000) %></td>   
					 <td align="right"><%=Math.round(Double.parseDouble(rsPlan.getString("SALE_QTY"))) %></td> 
					 <td align="right"><%=twoDForm.format(Double.parseDouble(rsPlan.getString("SALE_AMT"))/100000) %></td> 
					 <%-- <td align="right"><%=Math.round(rating*100.0)/100.0%></td>  --%>				 
					 <td align="right"><%=Math.round(Double.parseDouble(rsPlan.getString("PEND_QTY"))) %></td> 
					 <td align="right"><%=twoDForm.format(Double.parseDouble(rsPlan.getString("PEND_AMT"))/100000) %></td>					  
					<%--  <td align="right"><%=twoDForm.format(Double.parseDouble(rsPlan.getString("BAL_QTY"))) %></td>  --%>
					 <%-- <td align="right"><%=twoDForm.format(Double.parseDouble(rsPlan.getString("NET_REQUIRED"))) %></td> --%> 					 
				</tr>
				<%
				qtyDispatch.add(rsPlan.getString("NOS_QTY"));	
				amtDispatch.add(rsPlan.getString("SCH_AMT"));
				qtySale.add(rsPlan.getString("SALE_QTY"));
				amtSale.add(rsPlan.getString("SALE_AMT"));
				qtyPend.add(rsPlan.getString("PEND_QTY"));
				amtPend.add(rsPlan.getString("PEND_AMT"));
				bsrStk.add(rsPlan.getString("BAL_QTY"));
				/* netReq.add(rsPlan.getString("NET_REQUIRED")); */
				srNo++;
				cnt1=1;
						}
					
					con.close();
					
					double sumqty_Disp = 0;
					for(int i = 0; i < qtyDispatch.size(); i++){
						sumqty_Disp += Double.parseDouble(qtyDispatch.get(i).toString());
					}
					double sumamt_Disp = 0;
					for(int i = 0; i < amtDispatch.size(); i++){
						sumamt_Disp += Double.parseDouble(amtDispatch.get(i).toString());
					}
					double sumsale_qty = 0;
					for(int i = 0; i < qtySale.size(); i++){
						sumsale_qty += Double.parseDouble(qtySale.get(i).toString());
					}
					double sumamtSale = 0;
					for(int i = 0; i < amtSale.size(); i++){
						sumamtSale += Double.parseDouble(amtSale.get(i).toString());
					}
					double sumqtyPend = 0;
					for(int i = 0; i < qtyPend.size(); i++){
						sumqtyPend += Double.parseDouble(qtyPend.get(i).toString());
					}
					double sumamtPend = 0;
					for(int i = 0; i < amtPend.size(); i++){
						sumamtPend += Double.parseDouble(amtPend.get(i).toString());
					}
					double sumbsrStk = 0;
					for(int i = 0; i < bsrStk.size(); i++){
						sumbsrStk += Double.parseDouble(bsrStk.get(i).toString());
					}
					/* double sumnetReq = 0;
					for(int i = 0; i < netReq.size(); i++){
						sumnetReq += Double.parseDouble(netReq.get(i).toString());
					} */
					double sumReq_pd = 0;
					for(int i = 0; i < Req_pd.size(); i++){
						sumReq_pd += Double.parseDouble(Req_pd.get(i).toString()); 
						
					}
					double sumavg_pd = 0;
					for(int i = 0; i < avg_pd.size(); i++){
						sumavg_pd += Double.parseDouble(avg_pd.get(i).toString());
					}
					/* double sumdev_rat = 0;
					for(int i = 0; i < dev_rat.size(); i++){
						sumdev_rat += Double.parseDouble(dev_rat.get(i).toString());
					} */
				%> 
				<tr style="background-color: #D8E2ED;font-size: 11px;">
					 <td class="td1" align="right" colspan="2"><strong>Customer Total :</strong> </td>
					 <td class="td1" align="right"><strong><%=Math.round(sumReq_pd) %></strong> </td>
					 <td class="td1" align="right"><strong><%=Math.round(sumavg_pd) %></strong> </td>
					 <td class="td1" align="right">&nbsp;</td>
					 <td class="td1" align="right"><strong><%=Math.round(sumqty_Disp) %></strong></td>
					 <td class="td1" align="right"><strong><%=twoDForm.format(sumamt_Disp/100000) %></strong></td>
					 <td class="td1" align="right"><strong><%=Math.round(sumsale_qty) %></strong></td>
					 <td class="td1" align="right"><strong><%=twoDForm.format(sumamtSale/100000) %></strong></td>
					 <!-- <td class="td1" align="right">&nbsp;</td> -->
					 <td class="td1" align="right"><strong><%=Math.round(sumqtyPend) %></strong></td>
					 <td class="td1" align="right"><strong><%=twoDForm.format(sumamtPend/100000) %></strong></td>
					<%--  <td class="td1" align="right"><strong><%=twoDForm.format(sumbsrStk) %></strong></td> --%>
					 <%-- <td class="td1" align="right"><strong><%=twoDForm.format(sumnetReq) %></strong></td> --%>					 
				</tr>
			</table>  			
<% 
//System.out.println("Update = " + DayWIseSum);

} catch (Exception e) {
e.printStackTrace();
e.getMessage();
}
%>
		</div>
		<br> <br> 
<script type="text/javascript">
		var freezeRow = 3; //change to row to freeze at
		var freezeCol = 12; //change to column to freeze at
		var myRow = freezeRow;
		var myCol = freezeCol;
		var speed = 130; //timeout speed for freez column
		var myTable;
		var noRows;
		var myCells, ID;

		function setUp() {
			if (!myTable) {
				myTable = document.getElementById("t1");
			}
			myCells = myTable.rows[0].cells.length;
			noRows = myTable.rows.length;

			for ( var x = 0; x < myTable.rows[0].cells.length; x++) {
				colWdth = myTable.rows[0].cells[x].offsetWidth;
				myTable.rows[0].cells[x].setAttribute("width", colWdth - 4);
			}
		}

		function right(up) {
			if (up) {
				window.clearTimeout(ID);
				return;
			}
			if (!myTable) {
				setUp();
			}

			if (myCol < (myCells)) {
				for ( var x = 0; x < noRows; x++) {
					myTable.rows[x].cells[myCol].style.display = "";
				}
				if (myCol > freezeCol) {
					myCol--;
				}
				ID = window.setTimeout('right()', speed);
			}
		}

		function left(up) {
			if (up) {
				window.clearTimeout(ID);
				return;
			}
			if (!myTable) {
				setUp();
			}

			if (myCol < (myCells - 1)) {
				for ( var x = 0; x < noRows; x++) {
					myTable.rows[x].cells[myCol].style.display = "none";
				}
				myCol++;
				ID = window.setTimeout('left()', speed);
			}
		}

		function down(up) {
			if (up) {
				window.clearTimeout(ID);
				return;
			}
			if (!myTable) {
				setUp();
			}

			if (myRow < (noRows - 1)) {
				myTable.rows[myRow].style.display = "none";
				myRow++;

				ID = window.setTimeout('down()', speed);
			}
		}

		function upp(up) {
			if (up) {
				window.clearTimeout(ID);
				return;
			}
			if (!myTable) {
				setUp();
			}
			if (myRow <= noRows) {
				myTable.rows[myRow].style.display = "";
				if (myRow > freezeRow) {
					myRow--;
				}
				ID = window.setTimeout('upp()', speed);
			}
		}
	</script>

</body>
</html>