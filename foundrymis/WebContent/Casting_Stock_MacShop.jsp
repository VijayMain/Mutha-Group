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
<title>Casting Stock Machine Shop</title>
<STYLE TYPE="text/css" MEDIA=all>
.td1 { 
	font-size: 10px;
	border-width: 1px;
	padding: 8px;
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
	padding: 8px;
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
	function getExcel_Report(comp,from,to) { 
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
		xmlhttp.open("POST", "Casting_Stock_MacShop_xls.jsp?comp=" + comp +"&from="+from+"&to="+to, true);
		xmlhttp.send();
	};
</script>
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
<%
try{	
Connection con =null; 
String comp =request.getParameter("comp");
String from =request.getParameter("from"); 
String to =request.getParameter("to"); 
String matcode =""; 

ArrayList opQty = new ArrayList();
ArrayList perQty = new ArrayList();
ArrayList saleRet = new ArrayList();
ArrayList selQty = new ArrayList();
ArrayList purRet = new ArrayList();
ArrayList linRej = new ArrayList();
ArrayList closeBal = new ArrayList();
ArrayList minqty = new ArrayList();
ArrayList maxqty = new ArrayList();


String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);

DecimalFormat zeroDForm = new DecimalFormat("###,##0.00");


String group="";
int ct=0;
String CompanyName="";
if(comp.equalsIgnoreCase("101")){
	CompanyName = "H-21";
	con = ConnectionUrl.getMEPLH21ERP(); 
	
	  PreparedStatement ps=con.prepareStatement("select * from ENGERP..MSTMATERIALS where MATERIAL_TYPE='103'");
	  ResultSet rs=ps.executeQuery();
	  while(rs.next()){
		  matcode+=rs.getString("CODE");		  
	  }  
}else{
	CompanyName = "H-25";
	con	= ConnectionUrl.getMEPLH25ERP();
	 PreparedStatement ps=con.prepareStatement("select * from H25ERP..MSTMATERIALS where MATERIAL_TYPE='103'");
	  ResultSet rs=ps.executeQuery();
	  while(rs.next()){
		  matcode+=rs.getString("CODE");
	  }
}
%>
<strong style="color: blue;font-family: Arial;font-size: 14px;"><%=CompanyName %>&nbsp;MUTHA ENGINEERING PVT.LTD. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Casting Stock from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>

<strong style="font-family: Arial;font-size: 13px;"><a href="MachineShop_Home.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<span id="exportId"> 
<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=from%>','<%=to%>')" style="cursor: pointer;font-family: Arial;font-size: 11px;height: 20px;">Generate Excel</button>
<img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;"/>
</span> 
          
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
				<div style="float: left; width: 50%; height: 100%;" onmousedown="right();" onmouseup="right(1);">
					<img class="buttonRight" src="images/left.png">
				</div>
				<div style="float: right; width: 50%; height: 100%;" onmousedown="left();" onmouseup="left(1);">
					<img class="buttonLeft" src="images/forward.png">
				</div>
			</div>		
			
			
			<table id="t1" class="t1" border="1" style="width:98%; border: 1px solid #000;">  
				 
				<tr style="font-size: 12px;font-family: Arial;"> 
					<th scope="col" class="th">Sr.No</th>
					<th scope="col" class="th">Company Name</th>
					<th scope="col" class="th">Item Name</th>
					<th scope="col" class="th">Opening Qty</th> 
					<th scope="col" class="th">Purchase Qty</th>
					<th scope="col" class="th">Sale Return</th> 
					<th scope="col" class="th">Sale Qty</th>
					<th scope="col" class="th">Purchase Return</th>
					<th scope="col" class="th">Line Rejection</th> 
					<th scope="col" class="th">Closing Balance</th>
					<th scope="col" class="th">Min Qty</th> 
					<th scope="col" class="th">Max Qty</th> 
				</tr> 
<%

 	CallableStatement cs11 = con.prepareCall("{call Sel_MatStockStatementKranti(?,?,?,?,?)}");
	cs11.setString(1,comp);
	cs11.setString(2,"0");
	cs11.setString(3,matcode);
	cs11.setString(4,from);
	cs11.setString(5,to);
	ResultSet rs122 = cs11.executeQuery(); 
	while(rs122.next()){
 %>
			 	<tr style="font-size: 10px;"> 
					<%
					ct++;  
					opQty.add(Double.parseDouble(rs122.getString("OPENING_QTY")));  
					perQty.add(Double.parseDouble(rs122.getString("RECEIPT_QTY"))); 
					saleRet.add(Double.parseDouble(rs122.getString("SRTN_QTY"))); 
					selQty.add(Double.parseDouble(rs122.getString("ISSUE_QTY"))); 
					purRet.add(Double.parseDouble(rs122.getString("PURT_QTY"))); 
					linRej.add(Double.parseDouble(rs122.getString("REJ_QTY"))); 
					closeBal.add(Double.parseDouble(rs122.getString("CLOSING_QTY"))); 
					minqty.add(Double.parseDouble(rs122.getString("MIN_QTY")));
					maxqty.add(Double.parseDouble(rs122.getString("MAX_QTY")));
					 
					%>
					<td scope="col" align="center" width="3%"><strong><%=ct %></strong></td> 
					<td scope="col" align="left" width="25%"><%=rs122.getString("GROUP_NAME") %></td> 
					<td scope="col" align="left" width="40%"><%= rs122.getString("MAT_NAME") %></td>
					<%
					if(Double.parseDouble(rs122.getString("OPENING_QTY")) > 0){
					%> 
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("OPENING_QTY"))) %></td>
										 
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("RECEIPT_QTY"))) %></td> 
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("SRTN_QTY"))) %></td> 
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("ISSUE_QTY"))) %></td> 
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("PURT_QTY")))  %></td> 
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("REJ_QTY"))) %></td>
					<% 
					if((Double.parseDouble(rs122.getString("CLOSING_QTY")) < Double.parseDouble(rs122.getString("MIN_QTY"))) || (Double.parseDouble(rs122.getString("CLOSING_QTY")) > Double.parseDouble(rs122.getString("MAX_QTY")))){	
					%> 
					<td scope="col" align="right" style="color: #B51504"><strong><%= zeroDForm.format(Double.parseDouble(rs122.getString("CLOSING_QTY"))) %></strong></td>
					<%
					}else{
					%>
					<td scope="col" align="right"><strong><%= zeroDForm.format(Double.parseDouble(rs122.getString("CLOSING_QTY"))) %></strong></td>
					<%	
					} 
					%>
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("MIN_QTY"))) %></td>
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("MAX_QTY"))) %></td>
					<%
					}else{
					%>  
					<td scope="col" align="right" style="color: #B51504"><strong><%= zeroDForm.format(Double.parseDouble(rs122.getString("OPENING_QTY"))) %></strong></td> 
					 				 
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("RECEIPT_QTY"))) %></td> 
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("SRTN_QTY"))) %></td> 
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("ISSUE_QTY"))) %></td> 
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("PURT_QTY")))  %></td> 
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("REJ_QTY"))) %></td>
					<td scope="col" align="right"  style="color: #B51504"><strong><%= zeroDForm.format(Double.parseDouble(rs122.getString("CLOSING_QTY"))) %></strong> </td>
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("MIN_QTY"))) %></td>
					<td scope="col" align="right"><%= zeroDForm.format(Double.parseDouble(rs122.getString("MAX_QTY"))) %></td>
					<%
					}
					%> 
				</tr>
<%
	group = rs122.getString("GROUP_NAME"); 
	}
	
	double opsum = 0;
	for(int i = 1; i < opQty.size(); i++){
		opsum += Double.parseDouble(opQty.get(i).toString());
	}
	double pursum = 0;
	for(int i = 1; i < perQty.size(); i++){
		pursum += Double.parseDouble(perQty.get(i).toString());
	}
	double selrtsum = 0;
	for(int i = 1; i < saleRet.size(); i++){
		selrtsum += Double.parseDouble(saleRet.get(i).toString());
	}
	double selsum = 0;
	for(int i = 1; i < selQty.size(); i++){
		selsum += Double.parseDouble(selQty.get(i).toString());
	}
	double purRetsum = 0;
	for(int i = 1; i < purRet.size(); i++){
		purRetsum += Double.parseDouble(purRet.get(i).toString());
	}
	double linRejsum = 0;
	for(int i = 1; i < linRej.size(); i++){
		linRejsum += Double.parseDouble(linRej.get(i).toString());
	}
	double closeBalsum = 0;
	for(int i = 1; i < closeBal.size(); i++){
		closeBalsum += Double.parseDouble(closeBal.get(i).toString());
	}   
	double minsum = 0;
	for(int i = 1; i < minqty.size(); i++){
		minsum += Double.parseDouble(minqty.get(i).toString());
	}   
	double maxsum = 0;
	for(int i = 1; i < maxqty.size(); i++){
		maxsum += Double.parseDouble(maxqty.get(i).toString());
	}
%>		
		<tr>
			<td scope="col" align="right" colspan="3"><b>Total &#8658;</b></td>
			<td scope="col" align="right"><b><%=zeroDForm.format(opsum) %></b></td> 
			<td scope="col" align="right"><b><%=zeroDForm.format(pursum) %></b></td>
			<td scope="col" align="right"><b><%=zeroDForm.format(selrtsum) %></b></td>
			<td scope="col" align="right"><b><%=zeroDForm.format(selsum) %></b></td>
			<td scope="col" align="right"><b><%=zeroDForm.format(purRetsum) %></b></td>
			<td scope="col" align="right"><b><%=zeroDForm.format(linRejsum) %></b></td>
			<td scope="col" align="right"><b><%=zeroDForm.format(closeBalsum) %></b></td>
			<td scope="col" align="right"><b><%=zeroDForm.format(minsum) %></b></td> 
			<td scope="col" align="right"><b><%=zeroDForm.format(maxsum) %></b></td> 
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
<script type="text/javascript">
		var freezeRow = 1; //change to row to freeze at
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