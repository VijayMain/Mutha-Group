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
<title>Monthly Dispatch</title>
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
	width: 98%;
	height: 18px;
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
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
<%
/*
System.out.println("This is data");
System.out.println(request.getParameter("comp"));
System.out.println(request.getParameter("month"));
System.out.println(request.getParameter("db"));
System.out.println(request.getParameter("monthname"));
*/
try {
	Connection con=null;
	String CompanyName="";
	String comp =request.getParameter("comp");
	String month =request.getParameter("month"); 
	String monthName =request.getParameter("monthname");
	
	DecimalFormat zeroDForm = new DecimalFormat("###,##0");
  
	if(comp.equalsIgnoreCase("101")){
		CompanyName = "H-21";
		con = ConnectionUrl.getMEPLH21ERP();
	}else{
		CompanyName = "H-25";
		con	= ConnectionUrl.getMEPLH25ERP();
	}
%>
<div> 
<strong style="color: blue;font-family: Arial;font-size: 13px;"><%=CompanyName %>&nbsp;MUTHA ENGINEERING PVT.LTD. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 13px;">Monthly Dispatch of&nbsp;<%=monthName%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>
<strong style="font-family: Arial;font-size: 13px;"><a href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>

		<div class="div_freezepanes_wrapper"> 
			<div class="div_verticalscroll"
				onmouseover="this.style.cursor='pointer'">
				<div style="height: 50%;" onmousedown="upp();" onmouseup="upp(1);">
					<img class="buttonUp" src="images/up.png">
				</div>
				<div style="height: 50%;" onmousedown="down();" onmouseup="down(1);">
					<img class="buttonDn" src="images/down.png">
				</div>
			</div>

			<div class="div_horizontalscroll" onmouseover="this.style.cursor='pointer'">
				<div style="float: left; width: 50%; height: 100%;"
					onmousedown="right();" onmouseup="right(1);">
					<img class="buttonRight" src="images/left.png">
				</div>
				<div style="float: right; width: 50%; height: 100%;"
					onmousedown="left();" onmouseup="left(1);">
					<img class="buttonLeft" src="images/forward.png">
				</div>
			</div>
<% 
	
	String ct=""; 
	int srno=1; 
	double sum = 0;
	ArrayList dates = new ArrayList(); 
	ArrayList DayWIseSum = new ArrayList(); 
	double finalsum=0;
	 
	CallableStatement cs = con.prepareCall("{call Sel_RptMonthlyDespatch(?,?)}");
	cs.setString(1, comp);
	cs.setString(2, month); 
	ResultSet rs1 = cs.executeQuery();
	 while(rs1.next()){
		 dates.add(rs1.getString("DAYS")); 
	 } 
 // *********************************************************************************************************
HashSet hs = new HashSet();
hs.addAll(dates);
dates.clear();
dates.addAll(hs);
Collections.sort(dates); 
ArrayList dayUpdate = new ArrayList();
ArrayList dayUpdate1 = new ArrayList();
//***********************************************************************************************************
	// System.out.println("All  = " + dayUpdate); 
%> 
			<table id="t1" border="1" cellpadding=2 style="border: 1px solid #000;"> 
				<tr align="center">
					<th class="th">Sr. No</th>
					<th class="th">Item Name</th>
					<th class="th">Scheduled Qty</th>    
					<th class="th">Avg Qty</th>    
					<th class="th">Per Day Qty</th>    
					<th class="th">Total Qty</th> 
				  <%
					for (int index = 0; index < dates.size(); index++) {
				  %>
				  <th class="th">&nbsp;<%= dates.get(index).toString() %></th>
				  <%
						 }
				  %>
				</tr> 
				<%  
				
				 for(int j=0;j<(dates.size());j++){
					 dayUpdate.add("-");
				}
				
				 for(int j=0;j<(dates.size());j++){
					 dayUpdate1.add("-");
				}
				
				 for(int j=0;j<(dates.size());j++){
					 DayWIseSum.add("-");
				} 
				  
				CallableStatement cs11 = con.prepareCall("{call Sel_RptMonthlyDespatch(?,?)}");
				cs11.setString(1, comp);
				cs11.setString(2, month); 
				ResultSet rs122 = cs11.executeQuery(); 
				while (rs122.next()) { 
					if(ct==""){
				%>
				<tr>
					<td class="td1" align="center"><%=srno++ %> </td>
					<td class="td1" align="left"><%=rs122.getString("NAME") %></td> 
					<td class="td1" align="right"><%=rs122.getString("SCH_QTY") %> </td>
					<td class="td1" align="right"><%=rs122.getString("AVG_QTY") %> </td> 
					<td class="td1" align="right"><%=rs122.getString("PER_QTY")  %> </td>
					
				<% 
				CallableStatement callsp1 = con.prepareCall("{call Sel_RptMonthlyDespatch(?,?)}");
				callsp1.setString(1, comp);
				callsp1.setString(2, month); 
				
					ResultSet ressp1 = callsp1.executeQuery(); 
					while (ressp1.next()) {
						if(ressp1.getString("NAME").equalsIgnoreCase(rs122.getString("NAME"))){
						//	dayUpdate.add(Integer.parseInt(ressp1.getString("DAYS"))-1, ressp1.getString("DC_QTY")); 
							for(int j=0;j<(dates.size());j++){
								if(ressp1.getString("DAYS").equalsIgnoreCase(dates.get(j).toString())){
									dayUpdate.set(j, ressp1.getString("DC_QTY"));
								}						 
							}							
						}
					}
					// Horrizontal Sum Logic ====== > 
					
					for(int i2=0;i2<(dates.size());i2++){
						if(!dayUpdate.get(i2).toString().equalsIgnoreCase("-")){
						sum = sum +Double.parseDouble(dayUpdate.get(i2).toString());
					//	System.out.println("System Sum Patch = " + sum);
						}						
					}					
					%>
					<td class="td1" align="right"><%=String.valueOf(sum).replaceAll("\\.0*$", "") %> </td>
					<%
					sum = 0;				
					for(int prd=0;prd<(dates.size());prd++){
					%>
					<td nowrap style="font-family: Arial;font-size: 10px;" align="right">&nbsp;<%=dayUpdate.get(prd).toString().replaceAll("\\.0*$", "") %></td>
					<%	
					} 	
					
					//DayWIseSum.addAll(dayUpdate);
					for(int j=0;j<(dates.size());j++){
						DayWIseSum.set(j,dayUpdate.get(j).toString());
					}
					dayUpdate.clear();
					for(int j=0;j<(dates.size());j++){
						dayUpdate.add("-");
					}
				  %>					 
				</tr>  
				<%	
					}else if(!rs122.getString("NAME").equalsIgnoreCase(ct)){  
				%>
				<tr>
					<td class="td1" align="center"><%=srno++ %> </td> 
					<td class="td1" align="left" width="40%"><%=rs122.getString("NAME") %></td> 
					<td class="td1" align="right"><%=rs122.getString("SCH_QTY") %> </td>
					<td class="td1" align="right"><%=rs122.getString("AVG_QTY") %> </td> 
					<td class="td1" align="right"><%=rs122.getString("PER_QTY")  %> </td>
					
				  <% 
				  CallableStatement callsp = con.prepareCall("{call Sel_RptMonthlyDespatch(?,?)}");
				  callsp.setString(1, comp);
				  callsp.setString(2, month); 
					
					ResultSet ressp = callsp.executeQuery(); 
					while (ressp.next()) {
						if(ressp.getString("NAME").equalsIgnoreCase(rs122.getString("NAME"))){
							//dayUpdate1.add(Integer.parseInt(ressp.getString("DAYS")), ressp.getString("DC_QTY"));							
							for(int j=0;j<(dates.size());j++){
								if(ressp.getString("DAYS").equalsIgnoreCase(dates.get(j).toString())){
									dayUpdate1.set(j, ressp.getString("DC_QTY"));
								}						 
							}
						}
					}
					
					// Horrizontal Sum Logic ====== > 
					
					for(int i2=0;i2<(dates.size());i2++){
						if(!dayUpdate1.get(i2).toString().equalsIgnoreCase("-")){
						sum = sum +Double.parseDouble(dayUpdate1.get(i2).toString());
						//System.out.println("System Sum Patch = " + sum);
						}						
					}
					
					for(int f=0;f<dates.size();f++){
						if(DayWIseSum.get(f).toString().equalsIgnoreCase("-")){
							DayWIseSum.set(f, 0); 
						}
					}
					for(int i1=0;i1<dates.size();i1++){
						if(!dayUpdate1.get(i1).toString().equalsIgnoreCase("-")){							
							DayWIseSum.set(i1,(Double.parseDouble(DayWIseSum.get(i1).toString()) + Double.parseDouble(dayUpdate1.get(i1).toString())));
							//DayWIseSum.remove(i1+1);
						}else{							
							DayWIseSum.set(i1,DayWIseSum.get(i1).toString());
							//DayWIseSum.remove(i1+1);
						}
					}
					%>
					<td class="td1" align="right"><%=zeroDForm.format(Double.parseDouble(String.valueOf(sum))) %> </td>
					<%
					sum=0;
					for(int prd1=0;prd1<(dates.size());prd1++){
						%>
						<td nowrap style="font-family: Arial;font-size: 10px;" align="right">&nbsp;<%=dayUpdate1.get(prd1).toString().replaceAll("\\.0*$", "") %></td>
						<%	
						}
					//System.out.println("Date size ="+dayUpdate1.size() + " update = " + dayUpdate1);
					dayUpdate1.clear();
					for(int j=0;j<(dates.size());j++){
						 dayUpdate1.add("-");
					}
				  %>				   					 
				</tr>   
				<%
					} 
					ct = rs122.getString("NAME");
				}
			  ct="";
				%>
				 <tr style="font-family: Arial;font-size: 14px;">
					<td class="td1" align="right">&nbsp;</td>
					<td class="td1" align="left">&nbsp;</td>
					<td class="td1" align="right">&nbsp;</td>
					<td class="td1" align="right">&nbsp;</td>
					<td class="td1" align="right">&nbsp;</td> 
					<td class="td1" align="right"><strong>Total &#8658;</strong></td>
					 <%
					for (int index = 0; index < dates.size(); index++) {
					 %>
						<td nowrap style="font-family: Arial;font-size: 10px;" align="right">&nbsp;<%=zeroDForm.format(Double.parseDouble(DayWIseSum.get(index).toString())) %></td>
					 <%
						}
					 %>				   					 
				</tr> 
			</table>
<%
//System.out.println("Update = " + DayWIseSum);
con.close();
} catch (Exception e) {
e.printStackTrace();
e.getMessage();
}
%>
		</div>
		<br> <br>
	</div>
<script type="text/javascript">
		var freezeRow = 1; //change to row to freeze at
		var freezeCol = 6; //change to column to freeze at
		var myRow = freezeRow;
		var myCol = freezeCol;
		var speed = 100; //timeout speed for freez column
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