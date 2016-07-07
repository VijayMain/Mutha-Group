<%@page import="java.text.Normalizer.Form"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
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
<title>Internal Rejection</title>
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
		xmlhttp.open("POST", "Internal_Rejection_xls.jsp?comp=" + comp +"&from="+from+"&to="+to, true);
		xmlhttp.send();
	}; 
</script>
<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = 'white';
		}
	}
</script> 
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
	<%
try{
Connection con =null;   
String comp =request.getParameter("comp");
String from =request.getParameter("from");
String to =request.getParameter("to");
String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);

DecimalFormat twoDForm = new DecimalFormat("###0.00");
 
HashMap res_hm = new HashMap();
int ct=0;
String CompanyName="",maindb="";

if(comp.equalsIgnoreCase("103")){
	con = ConnectionUrl.getFoundryFMShopConnection(); 
	maindb = "FOUNDRYERP";
	CompanyName = "MUTHA FOUNDERS";
}
if(comp.equalsIgnoreCase("105")){
	con = ConnectionUrl.getDIFMShopConnection(); 
	maindb = "DIERP";
	CompanyName = "DHANASHREE INDUSTRIES";
}
if(comp.equalsIgnoreCase("106")){
	con = ConnectionUrl.getK1FMShopConnection(); 
	maindb = "K1ERP";
	CompanyName = "MUTHA ENGINEERING UNIT III ";
}
%>
	<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName %>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong> 
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;">Internal Rejection from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %>
		<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-family: Arial;font-size: 12px;color: brown;"><b>( Note : Click on record to get details )</b></span> -->
	</strong>
	<br />
	<strong style="font-family: Arial; font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<span id="exportId">
		<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=from%>','<%=to%>')" style="cursor: pointer; font-family: Arial; font-size: 11px;height: 20px;">Generate Excel</button> <img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;" />
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
//exec "DIFMSHOP"."dbo"."Sel_RptInternalRejection_MARV";1 '105', '0', '20150701', '20150726', 'DIERP'
ArrayList reasonList = new ArrayList();
ArrayList matList = new ArrayList();
		CallableStatement cs11 = con.prepareCall("{call Sel_RptInternalRejection_MARV(?,?,?,?,?)}");
		cs11.setString(1,comp);
		cs11.setString(2,"0");
		cs11.setString(3,from);
		cs11.setString(4,to);
		cs11.setString(5,maindb);
		ResultSet rs = cs11.executeQuery();
		while(rs.next()){
			matList.add(rs.getString("MAT_NAME"));
			reasonList.add(rs.getString("REASON")); 
		}
		rs.close();
		HashSet hs_mat = new HashSet();
		hs_mat.addAll(matList);
		matList.clear();
		matList.addAll(hs_mat); 
		
		HashSet hs_res = new HashSet();
		hs_res.addAll(reasonList);
		reasonList.clear();
		reasonList.addAll(hs_res);
%>
<table id="t1" class="t1" border="1" style="width: 80%; border: 1px solid #000;">
	<tr style="font-size: 12px; font-family: Arial;">
				<th scope="col" class="th">Name of Item</th>
				<th scope="col" class="th">Casting Wt</th>
				<th scope="col" class="th">Production Qty</th>
				<th scope="col" class="th">Production Wgt</th>
				<th scope="col" class="th">Total Rej %</th> 
			<%
			for(int i=0;i<reasonList.size();i++){
			%>	
			<th scope="col" class="th"><%=reasonList.get(i).toString() %></th> 
			<%
			}
			%> 
		<th scope="col" class="th">Total No</th>
		<th scope="col" class="th">Total wgt.</th>
	</tr>
	<%
	double qty = 0,tot_no=0,perRej=0;
	String ctwt = "",prd_qty="",prd_wt="",par ="";
	
	ResultSet rs_ctwt = null,rs_temp=null;
	
	for(int j=0;j<matList.size();j++){
		rs_ctwt = cs11.executeQuery();
		while(rs_ctwt.next()){
			if(rs_ctwt.getString("MAT_NAME").equalsIgnoreCase(matList.get(j).toString())){
				ctwt = rs_ctwt.getString("CASTING_WT");
				prd_qty = rs_ctwt.getString("PRODUCT_QTY");
				prd_wt = rs_ctwt.getString("PRODUCT_WGT");
				tot_no = Double.parseDouble(rs_ctwt.getString("QTY")) + tot_no;
			}
		}
		if(prd_qty==null){
			prd_qty = "0";
		}
		if(prd_wt==null){
			prd_wt ="0";
		}
		perRej = (tot_no/ Double.parseDouble(prd_qty))*100;
	%>
	<tr style="font-family:Arial; font-size: 10px;cursor: pointer;"  onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);">
			<td align="left" width="30%"><%=matList.get(j).toString() %></td>
			<td align="right"><%=twoDForm.format(Double.parseDouble(ctwt)) %></td>
			<td align="right"><%=twoDForm.format(Double.parseDouble(prd_qty)) %></td>
			<td align="right"><%=twoDForm.format(Double.parseDouble(prd_wt)) %></td>
			<td align="right"><%=twoDForm.format(perRej) %></td>
	<%
	 	for(int i1=0;i1<reasonList.size();i1++){
			qty = 0;
			rs_temp = cs11.executeQuery();
			while(rs_temp.next()){
				if(matList.get(j).toString().equalsIgnoreCase(rs_temp.getString("MAT_NAME")) && rs_temp.getString("REASON").equalsIgnoreCase(reasonList.get(i1).toString())){
					res_hm.put(reasonList.get(i1).toString(), rs_temp.getString("QTY"));
				}
			}
			if(res_hm.get(reasonList.get(i1).toString())==null){
			%>
			 <td nowrap style="font-family: Arial;font-size: 10px;" align="right">&nbsp;</td> 
			 <%
			}else{
				par = res_hm.get(reasonList.get(i1).toString()).toString();
				qty = (Double.parseDouble(par) / Double.parseDouble(prd_qty))*100;
			%>
			 <td nowrap style="font-family: Arial;font-size: 10px;" align="right"><%=twoDForm.format(Double.parseDouble(par)) %>  <br> <%=twoDForm.format(qty) %>%</td>
			 <% 	
			 }
			 %> 
		<%
		}
		%> 	 
		<td nowrap style="font-family: Arial;font-size: 10px;" align="right"><%=twoDForm.format(tot_no)%></td>
		<td nowrap style="font-family: Arial;font-size: 10px;" align="right"><%=twoDForm.format(qty)%></td>
	</tr> 
	<% 
	par="";
	prd_qty="";
	tot_no=0;
	qty = 0;
	res_hm.clear();
	}
	%>
</table>




<%		
} catch (Exception e) {
e.printStackTrace();
e.getMessage();
}
%>
	</div>
	<br>
	<br>
	<script type="text/javascript">
		var freezeRow = 1; //change to row to freeze at
		var freezeCol = 5; //change to column to freeze at
		var myRow = freezeRow;
		var myCol = freezeCol;
		var speed = 120; //timeout speed for freez column
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