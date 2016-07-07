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
<title>WO ws Exp Boring Details</title>
<STYLE TYPE="text/css" MEDIA=all>
.td1 {
	font-size: 10px;
	border-width: 1px;
	border-style: solid;
	border-color: #729ea5;
}

.tftable tr {
	background-color: white; 
}

.th {
	font-size: 12px;
	font-family: Arial;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5; 
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
	font-size: 10px;
	position: relative;
	width: 99%;
	height: 550px;
	overflow: hidden;
	background: #fff;
	border-style: ridge;
}

.div_verticalscroll {
	font-size: 10px;
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
	font-size: 10px;
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
	function getExcel_Report(comp,from,to,partyCode) {
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
		xmlhttp.open("POST", "WO_ws_ExpBoringDetails_xls.jsp?comp=" + comp + "&from=" + from + "&to=" + to + "&partyCode="+partyCode, true);
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
String partyCode =request.getParameter("party");
String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);

DecimalFormat twoDForm = new DecimalFormat("###0.00"); 
 
int ct=0;
String CompanyName="";  
double expected_Boring=0,recovery=0,openingwt=0;
if(comp.equalsIgnoreCase("103")){
	CompanyName = "MUTHA FOUNDERS PVT. LTD.";
	con = ConnectionUrl.getFoundryERPNEWConnection();   
} 
String partName=""; 
 
CallableStatement cs11 = con.prepareCall("{call Sel_RptWOWiseBoringDetail(?,?,?,?)}");
cs11.setString(1,comp);
cs11.setString(2,"0");
cs11.setString(3,from);
cs11.setString(4,to); 
ResultSet rs12 = cs11.executeQuery(); 
while(rs12.next()){
	if(rs12.getString("SUB_GLACNO").equalsIgnoreCase(partyCode)){
		partName = rs12.getString("PARTY_NAME"); 
	}
}
%>
	<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName %>&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;</strong> 
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;">Work Order Wise Expected Boring Details of&nbsp;<%=partName %>&nbsp;from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</strong><br />

	<strong style="font-family: Arial; font-size: 13px;">
	<a href="WO_ws_Expected_Boring.jsp?comp=<%=comp %>&from=<%=from %>&to=<%=to %>" style="text-decoration: none;">&lArr;BACK</a> 
		</strong>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	<span id="exportId">
		<button id="filebutton"
			onclick="getExcel_Report('<%=comp%>','<%=from%>','<%=to%>','<%=partyCode%>')"
			style="cursor: pointer; font-family: Arial; font-size: 12px;">Generate
			Excel</button> <img alt="#" src="images/fileload.gif" id="fileloading"
		style="visibility: hidden;" />
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
		<div class="div_horizontalscroll"
			onmouseover="this.style.cursor='pointer'">
			<div style="float: left; width: 50%; height: 100%;"
				onmousedown="right();" onmouseup="right(1);">
				<img class="buttonRight" src="images/left.png">
			</div>
			<div style="float: right; width: 50%; height: 100%;"
				onmousedown="left();" onmouseup="left(1);">
				<img class="buttonLeft" src="images/forward.png">
			</div>
		</div>
		<table id="t1" class="t1" border="1" style="width: 95%; border: 1px solid #000;">  
		<tr>
		<th scope="col" class="th" colspan="10" align="left">PARTY NAME &nbsp;&nbsp;&#8658;&nbsp;&nbsp; <b style="color: #FFFFFF"><%=partName %></b></th>
		</tr>
    <tr>
    	<th scope="col" class="th">W.O. No.</th>
        <th scope="col" class="th">W.O. date <br></th>
        <th scope="col" class="th">Process Type <br></th>
        <th scope="col" class="th">Item Description <br></th>
        <th scope="col" class="th">Opening Bal. <br></th>
        <th scope="col" class="th">Return boring. <br></th>
        <th scope="col" class="th">Std.boring wt. <br></th>
        <th scope="col" class="th">Inward qty</th>
        <th scope="col" class="th">Expected boring</th>
        <th scope="col" class="th">Recovery bal <br></th> 
    </tr>
    <%
    double opBal=0,retBor=0,stdBore=0,inward=0,exp=0,reco=0;
    ResultSet rs = cs11.executeQuery();
    while(rs.next()){
    	if(rs.getString("SUB_GLACNO").equalsIgnoreCase(partyCode)){
    		if(rs.getString("MAT_CODE").equalsIgnoreCase("0")){
    			openingwt = Double.parseDouble(rs.getString("OPENING_WT"));
    			opBal = opBal + openingwt;
    			retBor = retBor + Double.parseDouble(rs.getString("RETURN_BORING"));
    %>
    <tr style="font-family: Arial;font-size: 12px;"> 
        <td colspan="4"><b><%=partName %></b></td>
        <td align="right"><%=twoDForm.format(Double.parseDouble(rs.getString("OPENING_WT"))) %></td>
        <td align="right"><%=twoDForm.format(Double.parseDouble(rs.getString("RETURN_BORING"))) %></td> 
        <td>&nbsp;</td> 
        <td>&nbsp;</td> 
        <td>&nbsp;</td> 
        <td>&nbsp;</td>   
    </tr>
    <%
    	}
	if(!rs.getString("MAT_CODE").equalsIgnoreCase("0")){
		recovery=0;
		expected_Boring=0;
		if(rs.getString("EXPECTED_BORING")!=null && Double.parseDouble(rs.getString("EXPECTED_BORING"))!=0.000000){
			 expected_Boring = Double.parseDouble(rs.getString("EXPECTED_BORING")); 
		 }else{
			 expected_Boring = 0;
		 } 
		recovery = openingwt + expected_Boring - Double.parseDouble(rs.getString("RETURN_BORING"));
		stdBore = Double.parseDouble(rs.getString("BORI_WEIGHT")) + stdBore ;
		inward = inward + Double.parseDouble(rs.getString("RECEIVED_QTY"));
		exp = exp + expected_Boring;
		reco = reco + recovery;
    %>
    <tr style="font-family: Arial;font-size: 12px;"> 
        <td width="8%" align="right"><%=rs.getString("WO_DOCNO")%></td>
        <td width="7%" align="right"><%=rs.getString("PRN_TRANDATE")%></td>
        <td width="20%" align="left"><%=rs.getString("NAME")%></td>
        <td width="25%" align="left"><%=rs.getString("MAT_NAME")%></td>
        <td colspan="2">&nbsp;</td> 
        <td align="right"><%=twoDForm.format(Double.parseDouble(rs.getString("BORI_WEIGHT")))%></td> 
        <td align="right"><%=twoDForm.format(Double.parseDouble(rs.getString("RECEIVED_QTY")))%>
        <td align="right"><%=twoDForm.format(expected_Boring) %></td>
        <td align="right"><%=twoDForm.format(recovery) %></td>
    </tr>
    		<%
    		
    		}
    	}
    }
    %>
    <tr style="font-family: Arial;font-size: 12px;"> 
        <td colspan="4" align="right"><b>Total &#8658; </b></td>
        <td align="right"><%=twoDForm.format(opBal) %></td>
        <td align="right"><%=twoDForm.format(retBor) %></td> 
        <td align="right"><%=twoDForm.format(stdBore) %></td>
        <td align="right"><%=twoDForm.format(inward) %></td> 
        <td align="right"><%=twoDForm.format(exp) %></td> 
        <td align="right"><%=twoDForm.format(reco) %></td>     
    </tr>
</table>
		<%
	// System.out.println("Update = " + DayWIseSum);
con.close();
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
		var freezeCol = 7; //change to column to freeze at
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