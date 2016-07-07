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
<title>Detailed MIS GradeWise K-1</title>
<style type="text/css">
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
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
<%  
try{
	Connection con = ConnectionUrl.getK1FMShopConnection();
	String comp =request.getParameter("comp");
	String OnDateMIS =request.getParameter("ondate"); 
	String db =request.getParameter("db"); 
	String grade =request.getParameter("grade"); 
	int j=1;
	String OnDate = OnDateMIS.substring(6,8) +"/"+ OnDateMIS.substring(4,6) +"/"+ OnDateMIS.substring(0,4);  
	%> 
 <strong style="color: blue;font-family: Arial;font-size: 14px;">MUTHA ENGINEERING PVT.LTD.UNIT III&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">MIS Summary Report for <%=grade %> (&nbsp;<%= OnDate%>&nbsp;)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong><br/>
<br/> 
<strong style="font-family: Arial;font-size: 13px;"><a href="MIS_SummaryDetails_K1.jsp?comp=<%=comp %>&ondate=<%= OnDateMIS%>&db=<%=db %>" style="text-decoration: none;">&lArr;BACK</a>
</strong>
<br/> 
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
			
			<table id="t1" border="1" cellpadding=2 style="width:90%; border: 1px solid #000;">  
				 
				<tr style="font-family: Arial;font-size: 12px;">
					<th scope="col" class="th">Sr. No</th>
					<th scope="col" class="th">Item Name</th>
					<th scope="col" class="th">PatternBox Wt.</th>
					<th scope="col" class="th">Casting Wt.</th> 
					<th scope="col" class="th">Finish Wt.</th>
					<th scope="col" class="th">OP Stock</th>
					<th scope="col" class="th">Rate</th>
					<th scope="col" class="th">RS kg.</th>
					<th scope="col" class="th">Disp. Mt</th> 
					<th scope="col" class="th">Prod. Plan</th> 
					<th scope="col" class="th">Prod. Mt</th> 
					<th scope="col" class="th">Sales lacs.</th> 
				</tr> 
				<%  
				CallableStatement cs = con.prepareCall("{call Sel_RptMISMonthlyGradeSummery(?,?,?)}");
		 		cs.setString(1, comp);
		 		cs.setString(2, OnDateMIS);
		 		cs.setString(3, db); 
				ResultSet rs1 = cs.executeQuery(); 
				while(rs1.next()){
					if(rs1.getString("GRADE").equalsIgnoreCase(grade)){
				%> 
			 	<tr style="font-family: Arial;font-size: 10px;">
			 		<td scope="col" align="center"><a href="MIS_SummaryDetails_MatNameK1.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&matcode=<%=rs1.getString("MAT_CODE")%>&grade=<%=grade %>" style="text-decoration: none;color: black;"><%=j%></a> </td>	
					<td scope="col" align="left"><a href="MIS_SummaryDetails_MatNameK1.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&matcode=<%=rs1.getString("MAT_CODE")%>&grade=<%=grade %>" style="text-decoration: none;color: black;"><%=rs1.getString("MAT_NAME") %></a> </td>
					<td scope="col" align="right"><a href="MIS_SummaryDetails_MatNameK1.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&matcode=<%=rs1.getString("MAT_CODE")%>&grade=<%=grade %>" style="text-decoration: none;color: black;"><%=rs1.getString("PATBOX_WT") %></a> </td>
					<td scope="col" align="right"><a href="MIS_SummaryDetails_MatNameK1.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&matcode=<%=rs1.getString("MAT_CODE")%>&grade=<%=grade %>" style="text-decoration: none;color: black;"><%=rs1.getString("CASTING_WT") %></a> </td> 
					<td scope="col" align="right"><a href="MIS_SummaryDetails_MatNameK1.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&matcode=<%=rs1.getString("MAT_CODE")%>&grade=<%=grade %>" style="text-decoration: none;color: black;"><%=rs1.getString("FINISH_WT") %></a> </td>
					<td scope="col" align="right"><a href="MIS_SummaryDetails_MatNameK1.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&matcode=<%=rs1.getString("MAT_CODE")%>&grade=<%=grade %>" style="text-decoration: none;color: black;"><%=rs1.getString("OP_STOCK") %></a> </td> 
					<td scope="col" align="right"><a href="MIS_SummaryDetails_MatNameK1.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&matcode=<%=rs1.getString("MAT_CODE")%>&grade=<%=grade %>" style="text-decoration: none;color: black;"><%=rs1.getString("RATE") %></a> </td>
					<td scope="col" align="right"><a href="MIS_SummaryDetails_MatNameK1.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&matcode=<%=rs1.getString("MAT_CODE")%>&grade=<%=grade %>" style="text-decoration: none;color: black;"><%=rs1.getString("RS_KG") %></a> </td>
					<td scope="col" align="right"><a href="MIS_SummaryDetails_MatNameK1.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&matcode=<%=rs1.getString("MAT_CODE")%>&grade=<%=grade %>" style="text-decoration: none;color: black;"><%=rs1.getString("DISP_MT") %></a> </td> 
					<td scope="col" align="right"><a href="MIS_SummaryDetails_MatNameK1.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&matcode=<%=rs1.getString("MAT_CODE")%>&grade=<%=grade %>" style="text-decoration: none;color: black;"><%=rs1.getString("PROD_PLAN") %></a> </td>
					<td scope="col" align="right"><a href="MIS_SummaryDetails_MatNameK1.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&matcode=<%=rs1.getString("MAT_CODE")%>&grade=<%=grade %>" style="text-decoration: none;color: black;"><%=rs1.getString("PROD_MT") %></a> </td> 
					<td scope="col" align="right"><a href="MIS_SummaryDetails_MatNameK1.jsp?comp=<%=comp %>&ondate=<%=OnDateMIS %>&db=<%=db %>&matcode=<%=rs1.getString("MAT_CODE")%>&grade=<%=grade %>" style="text-decoration: none;color: black;"><%=rs1.getString("SALES_LACS") %></a> </td> 
				</tr>
				<%
				j++;
					}
				}
				%> 
			 	
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