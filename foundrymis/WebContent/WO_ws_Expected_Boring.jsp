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
<title>WO ws Expected Boring</title>
<STYLE TYPE="text/css" MEDIA=all>
.td1 {
	font-size: 10px;
	border-width: 1px;
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
		xmlhttp.open("POST", "WO_ws_ExpectedBoring_xls.jsp?comp=" + comp +"&from="+from+"&to="+to, true);
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
<script type="text/javascript">
		function button1(v1,v2,v3,v4) {
			var v1 = v1;
			var v2 = v2;
			var v3 = v3;
			var v4 = v4; 
			 window.location = "WO_ws_Expected_BoringDetails.jsp?comp="+v1+"&from="+v2+"&to="+v3+"&party="+v4; 
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
 
int ct=0;
String CompanyName="";  
if(comp.equalsIgnoreCase("103")){
	CompanyName = "MUTHA FOUNDERS PVT. LTD.";
	con = ConnectionUrl.getFoundryERPNEWConnection();   
} 
%>
	<strong style="color: blue; font-family: Arial; font-size: 14px;"><%=CompanyName %>&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong> 
	<strong style="color: #1B5869; font-family: Arial; font-size: 14px;">Work Order Wise Expected Boring Summary from &nbsp;<%=fromDate %>&nbsp; to &nbsp;<%=toDate %>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-family: Arial;font-size: 10px;color: brown;"><b>( Note : Click on record to get details )</b></span>
	</strong>
	
	<br />

	<strong style="font-family: Arial; font-size: 13px;"><a
		href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	<span id="exportId">
		<button id="filebutton"
			onclick="getExcel_Report('<%=comp%>','<%=from%>','<%=to%>')"
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
		<table id="t1" class="t1" border="1" style="width: 80%; border: 1px solid #000;">
			<tr style="font-size: 12px; font-family: Arial;"> 
				<th scope="col" class="th" width="5%">Sr.No.</th>
				<th scope="col" class="th">Party Name</th>
				<th scope="col" class="th">Opening Bal</th>
				<th scope="col" class="th">Return Boring</th>
				<th scope="col" class="th">Expected Boring</th>
				<th scope="col" class="th">Recovery Bal.</th> 
			</tr>
			<%	
			//  exec "FOUNDRYERP"."dbo"."Sel_RptWOWiseBoringDetail";1 '103', '0', '20150301', '20150314'
	int cnt=1;
	double recovery=0;
	ArrayList party=new ArrayList();
	ArrayList OP_Qty=new ArrayList();
	ArrayList ret_bore=new ArrayList();
	ArrayList exp_bore=new ArrayList();
	ArrayList Rec_bal=new ArrayList();
	ArrayList Subglcode=new ArrayList();
	ArrayList  partyNames = new ArrayList();
	
	HashMap pN = new HashMap();
	HashMap pName = new HashMap();
	
	
	double expected_Boring=0;
	
	
 	CallableStatement cs11 = con.prepareCall("{call Sel_RptWOWiseBoringDetail(?,?,?,?)}");
	cs11.setString(1,comp);
	cs11.setString(2,"0");
	cs11.setString(3,from);
	cs11.setString(4,to); 
	ResultSet rs1 = cs11.executeQuery(); 
	while(rs1.next()){
		recovery =0;
		 party.add(rs1.getString("SUB_GLACNO"));
		 OP_Qty.add(rs1.getString("OPENING_WT"));
		 ret_bore.add(rs1.getString("RETURN_BORING"));
		 pN.put(rs1.getString("SUB_GLACNO"),rs1.getString("PARTY_NAME"));
		 Subglcode.add(rs1.getString("SUB_GLACNO"));
		 if(rs1.getString("EXPECTED_BORING")!=null && Double.parseDouble(rs1.getString("EXPECTED_BORING"))!=0.000000){
			 expected_Boring = Double.parseDouble(rs1.getString("EXPECTED_BORING")); 
		 }else{
			 expected_Boring = 0;
		 }
		 exp_bore.add(expected_Boring);
		 recovery = Double.parseDouble(rs1.getString("OPENING_WT")) + expected_Boring - Double.parseDouble(rs1.getString("RETURN_BORING"));
		 Rec_bal.add(recovery);
	}	 
	HashSet hs = new HashSet();
	hs.addAll(party);
	party.clear();
	party.addAll(hs);
	Collections.sort(party);	
	 
	for(int s=0;s<Subglcode.size();s++){
		 pName.put(Subglcode.get(s).toString(), pN.get(Subglcode.get(s).toString()));
	}
	
	//System.out.println("Pname = " + pName.get("101120421"));
	
	double op=0,rt=0,exp=0,rec=0;
	String data = "";
	ArrayList allData=new ArrayList();  
	for(int i=0;i<party.size();i++){
		op=0;  
		rt=0;  
		exp=0;   
		rec=0;
		for(int j=0;j<Subglcode.size();j++){
				if(party.get(i).toString().equalsIgnoreCase(Subglcode.get(j).toString())){
				op += Double.parseDouble(OP_Qty.get(j).toString());
				rt += Double.parseDouble(ret_bore.get(j).toString());
				exp += Double.parseDouble(exp_bore.get(j).toString());
				rec += Double.parseDouble(Rec_bal.get(j).toString());  
				}
			}
		data = party.get(i).toString()+"$"+String.valueOf(op)+"$"+String.valueOf(rt)+"$"+String.valueOf(exp)+"$"+String.valueOf(rec);
		allData.add(data);  
		}  
	String dataname = "";
	String[] parts = null;
	int sr=1;
	for(int m=0;m<allData.size();m++){
	 dataname = allData.get(m).toString();
	 parts = dataname.split("\\$");
	/* System.out.println("one  = " + pName.get(parts[0].toString()));
	System.out.println("two  = " + parts[1].toString());
	System.out.println("three  = " + parts[2].toString());
	System.out.println("four  = " + parts[3].toString());
	System.out.println("five  = " + parts[4].toString());
	System.out.println("********************************************************************"); */
	%>
		<tr style="font-family:Arial; font-size: 10px;cursor: pointer;"  title="Click to get details...."
		    onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" 
		    onclick="button1('<%=comp%>','<%=from%>','<%=to%>','<%=parts[0].toString()%>');">
			<td align="center"><%=sr %></td>
			<td><b><%=pName.get(parts[0].toString()) %></b></td>
			<td align="right"><%=twoDForm.format(Double.parseDouble(parts[1].toString())) %></td>
			<td align="right"><%=twoDForm.format(Double.parseDouble(parts[2].toString())) %></td>
			<td align="right"><%=twoDForm.format(Double.parseDouble(parts[3].toString())) %></td>
			<td align="right"><%=twoDForm.format(Double.parseDouble(parts[4].toString())) %></td> 
		</tr> 
	<%
	sr++;
	}
	%>
		
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