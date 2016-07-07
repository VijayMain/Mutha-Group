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
<title>Detailed MIS Founders</title>
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
		String comp = request.getParameter("comp");
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		String db = request.getParameter("db"); 
		String maindb = "FOUNDRYFMSHOP"; 
		String Dispdate_From = fromdate.substring(6, 8) + "/" + fromdate.substring(4, 6) + "/" + fromdate.substring(0, 4);
		String Dispdate_To = todate.substring(6, 8) + "/" + todate.substring(4, 6) + "/" + todate.substring(0, 4);
		DecimalFormat threeDForm = new DecimalFormat("0.00"); 
		DecimalFormat fourDForm = new DecimalFormat("0.0000");
		DecimalFormat oneDForm = new DecimalFormat("0.0");
		DecimalFormat zeroDForm = new DecimalFormat("0");
		
		int ct=1;
	%>
	<div>
<strong style="font-family: Arial;font-size: 14px;">MUTHA FOUNDERS PVT.LTD. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Detailed MIS from <%=Dispdate_From%> to <%=Dispdate_To%></strong> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span style="font-family: Arial;font-size: 13px;">Please Note :<strong style="color: brown;">&nbsp;&nbsp;*</strong> means Earlier day's production</span>

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
			<%
				try {
					Connection con = ConnectionUrl.getFoundryFMShopConnection();
					String final_KWH = "";
					String final_KVH = "";
					String initial_KWH = "";
					String initial_KVH = ""; 
					ArrayList tot_unit = new ArrayList();
					ArrayList unitWithMF = new ArrayList();
			%>
			<table id="t1" border="1" cellpadding=2 style="border: 1px solid #000;">
				<tr align="center">
					<th class="th" rowspan="2">Sr. No</th>
					<th class="th" rowspan="2">Item Name</th>
					<th class="th" rowspan="2">Poured Qty.</th>
					<th class="th" colspan="2">Molten Metal</th>
					<th class="th" colspan="2">Casting Wt.</th>
					<th class="th">R.R. Wt.</th>
					<th class="th" colspan="4">Rejection Quantity</th>
					<th class="th" colspan="2">Good Casting</th>
					<th class="th" rowspan="2">Invoice Qty</th>
					<th class="th" rowspan="2">Invoice Weight<br/> Kg. Gms</th>
					<th></th>
				</tr>
				<tr align="center"> 
					<th class="tp"  style="background-color: #8D8EB3;">Box Per <br/> Kg. Gms</th> 
					<th class="tp" style="background-color: #8D8EB3;">Total<br/> Kg. Gms</th> 										
					<th class="tp" style="background-color: #8D8EB3;">Per cast<br/> Kg. Gms</th> 
					<th class="tp" style="background-color: #8D8EB3;">Total<br/> Kg. Gms</th> 					
					<th class="tp" style="background-color: #8D8EB3;">Kg. Gms</th>					
					<th class="tp" style="background-color: #8D8EB3;" colspan="2" width="10%">F.R. Qty.<hr>&nbsp;Fl. Qty. &nbsp;&nbsp; S.B. Qty.</th> 
					<th class="tp" style="background-color: #8D8EB3;">Weight<br/> Kg. Gms</th>
					<th class="tp" style="background-color: #8D8EB3;">Rej %</th>					
					<th class="tp" style="background-color: #8D8EB3;">Qty.</th>
					<th class="tp" style="background-color: #8D8EB3;">Weight<br/> Kg. Gms</th> 
					<th></th>
				</tr>	 
				<%
				double rrWt=0,rejper=0,goodcastqty=0,goodcastWt=0;				
				CallableStatement cs = con.prepareCall("{call Sel_RptProdAndRej(?,?,?,?,?,?,?)}");
		 		cs.setString(1, comp);
		 		cs.setString(2, "652");
		 		cs.setString(3, "101102103104"); 
		 		cs.setString(4, fromdate);
		 		cs.setString(5, todate);
		 		cs.setString(6, db); 
		 		cs.setString(7, maindb); 
				ResultSet rs1 = cs.executeQuery(); 
				while(rs1.next()){ 				
				if(!rs1.getString("QTY").equalsIgnoreCase("0.000")){ 
					rrWt = Double.parseDouble(rs1.getString("TOTAL_WT")) - Double.parseDouble(rs1.getString("TOTAL_WT_WITHOUTRR")); 
					//	(( fl qty + SB Qty ) * 100 ) / Poured Qty = Rej%
					if(Double.parseDouble(rs1.getString("QTY")) != 0.0){
					rejper = ((Double.parseDouble(rs1.getString("FLOOR_QTY")) + Double.parseDouble(rs1.getString("SHOTBLASTED_QTY")))*100)/Double.parseDouble(rs1.getString("QTY"));
					}else{
						rejper = 0;	
					}
					//	Good cast qty = poured qty - ( fl qty + SB Qty )
					goodcastqty = Double.parseDouble(rs1.getString("QTY")) - (Double.parseDouble(rs1.getString("FLOOR_QTY"))+Double.parseDouble(rs1.getString("SHOTBLASTED_QTY"))); 
					//  Good cat wt weight = total wt in grm - rej weight in grms
					goodcastWt = Double.parseDouble(rs1.getString("TOTAL_WT_WITHOUTRR")) - Double.parseDouble(rs1.getString("WEIGHT"));
				%> 
				<tr  onmouseover="this.style.background='#EEEEEE';" onmouseout="this.style.background='';">
					<td class="td1" align="center" width="1%"><%=ct %></td>
					<%
					if(ct==1){
					initial_KWH=rs1.getString("FROM_KWH");
					initial_KVH=rs1.getString("FROM_KVH");					
					}
					%>
					<td class="td1" align="left" width="20%"><%= rs1.getString("MAT_NAME") %></td>
					<td class="td1" align="right" width="2%"><%=oneDForm.format(Double.parseDouble(rs1.getString("QTY"))) %></td>
					<td class="td1" align="right" width="2%"><%=fourDForm.format(Double.parseDouble(rs1.getString("BOX_WT")))  %></td>
					<td class="td1" align="right" width="2%"><%=threeDForm.format(Double.parseDouble(rs1.getString("TOTAL_WT")))  %></td>
					<td class="td1" align="right" width="2%"><%=threeDForm.format(Double.parseDouble(rs1.getString("BOX_WT_WITHOUTRR")))  %></td>
					<td class="td1" align="right" width="2%"><%=threeDForm.format(Double.parseDouble(rs1.getString("TOTAL_WT_WITHOUTRR")))  %></td>
					<td class="td1" align="right" width="2%"><%=threeDForm.format(rrWt) %></td>
					<td class="td1" align="right" width="2%"><%=zeroDForm.format(Double.parseDouble(rs1.getString("FLOOR_QTY")))  %></td>
					<td class="td1" align="right" width="2%"><%=zeroDForm.format(Double.parseDouble(rs1.getString("SHOTBLASTED_QTY")))%></td>
					<td class="td1" align="right" width="2%"><%=threeDForm.format(Double.parseDouble(rs1.getString("WEIGHT")))  %></td>
					<td class="td1" align="right" width="2%"><%=threeDForm.format(rejper) %></td>
					<td class="td1" align="right" width="2%"><%= zeroDForm.format(goodcastqty) %></td>
					<td class="td1" align="right" width="2%"><%=threeDForm.format(goodcastWt) %></td>	
					<td nowrap style="font-family: Arial;font-size: 10px;" class="td1" align="right" width="2%"><%=zeroDForm.format(Double.parseDouble(rs1.getString("INV_QTY"))) %></td>		
					<td nowrap style="font-family: Arial;font-size: 10px;" class="td1" align="center" width="2%"><%=fourDForm.format(Double.parseDouble(rs1.getString("INV_WEIGHT")))  %></td>
					<th></th>							
				</tr>
			<% 
			final_KWH = rs1.getString("TO_KWH");
	 		final_KVH = rs1.getString("TO_KVH");
	 		tot_unit.add(rs1.getString("UNITKWH"));
	 		unitWithMF.add(rs1.getString("MF_UNITKWH"));
				}else{
					rrWt = Double.parseDouble(rs1.getString("PrevPouredTOTAL_WT")) - Double.parseDouble(rs1.getString("PrevPouredTOTAL_WT_WITHOUTRR")); 
					//	(( fl qty + SB Qty ) * 100 ) / Poured Qty = Rej%
					if(Double.parseDouble(rs1.getString("PrevPouredQTY")) != 0.0){	
					rejper = ((Double.parseDouble(rs1.getString("FLOOR_QTY")) + Double.parseDouble(rs1.getString("SHOTBLASTED_QTY")))*100)/Double.parseDouble(rs1.getString("PrevPouredQTY"));
					}else{
					rejper = 0;	
					}
					//	Good cast qty = poured qty - ( fl qty + SB Qty )
					goodcastqty = Double.parseDouble(rs1.getString("PrevPouredQTY")) - (Double.parseDouble(rs1.getString("FLOOR_QTY"))+Double.parseDouble(rs1.getString("SHOTBLASTED_QTY"))); 
					//  Good cat wt weight = total wt in grm - rej weight in grms
					goodcastWt = Double.parseDouble(rs1.getString("PrevPouredTOTAL_WT_WITHOUTRR")) - Double.parseDouble(rs1.getString("WEIGHT"));
			%>
				<tr  onmouseover="this.style.background='#EEEEEE';" onmouseout="this.style.background='';">
					<td class="td1" align="center" width="1%"><%=ct %></td>
					<td class="td1" align="left" width="20%"><%= rs1.getString("MAT_NAME") %></td>
					<td class="td1" align="right" width="2%"><b style="color: brown;">*</b> <%=oneDForm.format(Double.parseDouble(rs1.getString("PrevPouredQTY"))) %></td>
					<td class="td1" align="right" width="2%"><%=fourDForm.format(Double.parseDouble(rs1.getString("PrevPouredBOX_WT")))  %></td>
					<td class="td1" align="right" width="2%"><%=threeDForm.format(Double.parseDouble(rs1.getString("PrevPouredTOTAL_WT")))  %></td>
					<td class="td1" align="right" width="2%"><%=threeDForm.format(Double.parseDouble(rs1.getString("PrevPouredBOX_WT_WITHOUTRR")))  %></td>
					<td class="td1" align="right" width="2%"><%=threeDForm.format(Double.parseDouble(rs1.getString("PrevPouredTOTAL_WT_WITHOUTRR")))  %></td>
					<td class="td1" align="right" width="2%"><%=threeDForm.format(rrWt) %></td>
 					<td class="td1" align="right" width="2%"><%=zeroDForm.format(Double.parseDouble(rs1.getString("FLOOR_QTY")))  %></td>
					<td class="td1" align="right" width="2%"><%=zeroDForm.format(Double.parseDouble(rs1.getString("SHOTBLASTED_QTY")))%></td>
					<td class="td1" align="right" width="2%"><%=threeDForm.format(Double.parseDouble(rs1.getString("WEIGHT")))  %></td>
					<td class="td1" align="right" width="2%"><%=threeDForm.format(rejper) %></td>
					<td class="td1" align="right" width="2%"><%= zeroDForm.format(goodcastqty) %></td>	 
					<td class="td1" align="right" width="2%"><%=threeDForm.format(goodcastWt) %></td>	
					<td nowrap style="font-family: Arial;font-size: 10px;" class="td1" align="right" width="2%"><%=zeroDForm.format(Double.parseDouble(rs1.getString("INV_QTY"))) %></td>		
					<td nowrap style="font-family: Arial;font-size: 10px;" class="td1" align="center" width="2%"><%=fourDForm.format(Double.parseDouble(rs1.getString("INV_WEIGHT")))  %></td>
					<th></th>								
				</tr>
			<%		
			final_KWH = rs1.getString("TO_KWH");
	 		final_KVH = rs1.getString("TO_KVH");
	 		tot_unit.add(rs1.getString("UNITKWH"));
	 		unitWithMF.add(rs1.getString("MF_UNITKWH"));
				}
				ct++;
				}
			%>
			</table>
			<%
			 double sumtot_unit = 0;	
			 double sumunitWithMF = 0; 
			 
			 	for(int i = 0; i < tot_unit.size(); i++)
			    {
			 		sumtot_unit += Double.parseDouble(tot_unit.get(i).toString());
			    }
			 	for(int i = 0; i < unitWithMF.size(); i++)
			    {
			 		sumunitWithMF += Double.parseDouble(unitWithMF.get(i).toString());
			    }
			 	
				
			%>
		</div> 
		<div style="float: left; padding-right: 5px;width: 60%">
		  <table border="1" class="tftable" style="width: 100%">  	 
				<tr>
					<th class="th" colspan="5">
					<strong>Power Consumption</strong>	 	
					</th>  
				</tr>
				<tr>
				<td>Final KWH Reading&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%= final_KWH%>
				</td>
				<td>Final KVH Reading&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%= final_KVH%> 
				</td>
				</tr>
				<tr>
				<td>Initial KWH Reading &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%= initial_KWH%>
				</td>
				<td>Initial KVH Reading &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%= initial_KVH%>
				</td>
				</tr>
				<tr>
				<td>Total Unit Consumption &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%=sumtot_unit %>
				</td>
				<td>Unit Consum With MF &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%=sumunitWithMF %>
				</td>
				</tr>
				<tr>
				<td>Power Factor &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				</td>
				<td>Unit Per Ton &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				</td>
				</tr>
		  </table>	
		  </div>
		  <br> <br>
		  <%
		  con.close();
				} catch (Exception e) {
					e.printStackTrace();
					e.getMessage();
				}
		  %>
	</div>
	<script type="text/javascript">
		var freezeRow = 2; //change to row to freeze at
		var freezeCol = 14; //change to column to freeze at
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