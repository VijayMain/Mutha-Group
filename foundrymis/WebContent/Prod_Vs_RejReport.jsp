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
<title>Detailed MIS Founders</title>
<!-- 
<script type="text/javascript"> 
function button1(comp,fromdate,todate,db) { 
	window.location = "MIS_Details_FND.jsp?comp="+comp+"&fromdate="+fromdate+"&todate="+todate+"&db="+db; 
} 
</script>
 -->
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
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
	<% 
	try {
		 
		String final_KWH = "0";
		String final_KVH = "0";
		String initial_KWH = "0";
		String initial_KVH = "0";
		
		
		Connection con = null;
		String db = "";
		String maindb = "";
		String comp = request.getParameter("comp");
		String grade = request.getParameter("grade");
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate"); 
		String nameComp = "";
		String gradeName = "";
		if(grade.equalsIgnoreCase("101")){
			gradeName = "SG Iron";
		}
		if(grade.equalsIgnoreCase("102")){
			gradeName = "Cast Iron";
		}
		if(grade.equalsIgnoreCase("104")){
			gradeName = "Aluminium";
		}
		
		if(comp.equalsIgnoreCase("103")){
			con = ConnectionUrl.getFoundryFMShopConnection();
			db = "FOUNDRYERP";
			maindb = "FOUNDRYFMSHOP"; 
			nameComp = "MUTHA FOUNDERS PVT.LTD.";
		}
		if(comp.equalsIgnoreCase("105")){
			con = ConnectionUrl.getDIFMShopConnection();
			db = "DIERP";
			maindb = "DIFMSHOP";
			nameComp = "DHANASHREE INDUSTRIES";
		}
		if(comp.equalsIgnoreCase("106")){
			con = ConnectionUrl.getK1FMShopConnection();
			db = "K1ERP";
			maindb = "K1FMSHOP";
			nameComp = "MUTHA ENGINEERING PVT.LTD.UNIT III ";
		}
				
		String Dispdate_From = fromdate.substring(6, 8) + "/" + fromdate.substring(4, 6) + "/" + fromdate.substring(0, 4);
		String Dispdate_To = todate.substring(6, 8) + "/" + todate.substring(4, 6) + "/" + todate.substring(0, 4);
		DecimalFormat twoDForm = new DecimalFormat("0.00");  
		DecimalFormat oneDForm = new DecimalFormat("0.0");
		DecimalFormat zeroDForm = new DecimalFormat("0");
		DecimalFormat myFormatter = new DecimalFormat("###,##0");
		DecimalFormat mytotals = new DecimalFormat("###,##0.00");
 		int ct=1;
	%>
	<div> 
<strong style="color: blue;font-family: Arial;font-size: 14px;"><%=nameComp %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">Production Vs. Rejection Report of <%=gradeName %> from <%=Dispdate_From%> to <%=Dispdate_To%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<b style="color: #B09B15;font-family: Arial;font-size: 13px;">Please Note :</b><strong style="color: red;">&nbsp;&nbsp;*</strong> means Earlier day's production
<br/> 
<strong style="font-family: Arial;font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>


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
					<th class="th" rowspan="2">Invoice Weight<br/> MT. Gms</th>
					<th></th>
				</tr>
				<tr align="center"> 
					<th class="th"  style="background-color: #8D8EB3;">Box Per <br/> Kg. Gms</th> 
					<th class="th" style="background-color: #8D8EB3;">Total<br/> MT. Gms</th> 										
					<th class="th" style="background-color: #8D8EB3;">Per cast<br/> Kg. Gms</th> 
					<th class="th" style="background-color: #8D8EB3;">Total<br/> MT. Gms</th> 					
					<th class="th" style="background-color: #8D8EB3;">MT. Gms</th>					
					<th class="th" style="background-color: #8D8EB3;" colspan="2" width="10%">F.R. Qty.<hr>Fl.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S.B. </th> 
					<th class="th" style="background-color: #8D8EB3;">Weight<br/> MT. Gms</th>
					<th class="th" style="background-color: #8D8EB3;">Rej %</th>					
					<th class="th" style="background-color: #8D8EB3;">Qty.</th>
					<th class="th" style="background-color: #8D8EB3;">Weight<br/> MT. Gms</th> 
					<th></th>
				</tr>	 
				<%
				double rrWt=0,rejper=0,goodcastqty=0,goodcastWt=0;
				
				double total_pouredQty = 0;
				double total_moltenMetalQty = 0;
				double total_castingwtTotalQty = 0;
				double total_rrwtQty = 0;
				double total_flQty = 0;
				double total_sbQty = 0;
				double total_rejwtQty = 0;
			//	double total_rejpercQty = 0;
				double total_goodcastwtQty = 0;
				double total_invoiceQty = 0;
				double total_invoicewtQty = 0;
				
				double tot_unit = 0;
				double unitWithMF = 0;
				double pf=0;
				double unit_pTon=0;
				
				
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
				if(rs1.getString("GRADE").equalsIgnoreCase(grade)){
			%>
			<tr>
			<td class="td1" align="center"  width="9%"><%=ct %></td>
			<td class="td1" align="left"  width="36%"><%=rs1.getString("MAT_NAME") %> </td>
			<%
			if(!rs1.getString("QTY").equalsIgnoreCase("0.000")){
				
				if(ct==1){
					initial_KWH=rs1.getString("FROM_KWH");
					initial_KVH=rs1.getString("FROM_KVH");					
					}
				
				rrWt = Double.parseDouble(rs1.getString("TOTAL_WT")) - Double.parseDouble(rs1.getString("TOTAL_WT_WITHOUTRR"));
				
				//	Good cast qty = poured qty - ( fl qty + SB Qty )
				goodcastqty = Double.parseDouble(rs1.getString("QTY")) - (Double.parseDouble(rs1.getString("FLOOR_QTY"))+Double.parseDouble(rs1.getString("SHOTBLASTED_QTY"))); 
				//  Good cat wt weight = total wt in grm - rej weight in grms
				goodcastWt = Double.parseDouble(rs1.getString("TOTAL_WT_WITHOUTRR")) - Double.parseDouble(rs1.getString("WEIGHT"));
				
				if(Double.parseDouble(rs1.getString("QTY")) != 0.0){
					rejper = ((Double.parseDouble(rs1.getString("FLOOR_QTY")) + Double.parseDouble(rs1.getString("SHOTBLASTED_QTY")))*100)/Double.parseDouble(rs1.getString("QTY"));
					}else{
						rejper=0;
					}
								
				total_pouredQty+=Double.parseDouble(rs1.getString("QTY"));
				total_moltenMetalQty+=Double.parseDouble(rs1.getString("TOTAL_WT") );
				total_castingwtTotalQty+=Double.parseDouble(rs1.getString("TOTAL_WT_WITHOUTRR"));
				total_rrwtQty+=rrWt;
				total_flQty+=Double.parseDouble(rs1.getString("FLOOR_QTY"));
				total_sbQty+=Double.parseDouble(rs1.getString("SHOTBLASTED_QTY"));
				total_rejwtQty+=Double.parseDouble(rs1.getString("WEIGHT"));
			//	total_rejpercQty+=rejper;
				total_goodcastwtQty+=goodcastWt;
				total_invoiceQty+=Double.parseDouble(rs1.getString("INV_QTY"));
				total_invoicewtQty+=Double.parseDouble(rs1.getString("INV_WEIGHT"));
				
			%>
			<td class="td1" align="right"><%=myFormatter.format(Double.parseDouble(rs1.getString("QTY"))) %></td>
			<td class="td1" align="right"><%=mytotals.format(Double.parseDouble(rs1.getString("BOX_WT"))) %></td>
			<td class="td1" align="right"><%=twoDForm.format(Double.parseDouble(rs1.getString("TOTAL_WT"))/1000)%></td>
			<td class="td1" align="right"><%=mytotals.format(Double.parseDouble(rs1.getString("BOX_WT_WITHOUTRR"))) %></td>
			<td class="td1" align="right"><%=twoDForm.format(Double.parseDouble(rs1.getString("TOTAL_WT_WITHOUTRR"))/1000) %></td>
			<td class="td1" align="right"  width="10%"><%=twoDForm.format(rrWt/1000) %>  </td>
			<td class="td1" align="right"><%=zeroDForm.format(Double.parseDouble(rs1.getString("FLOOR_QTY"))) %></td>
			<td class="td1" align="right"><%=zeroDForm.format(Double.parseDouble(rs1.getString("SHOTBLASTED_QTY"))) %></td>
			<td class="td1" align="right"><%=twoDForm.format(Double.parseDouble(rs1.getString("WEIGHT"))/1000) %></td>
			<td class="td1" align="right"><%=twoDForm.format(rejper)%></td>
			<td class="td1" align="right"><%=myFormatter.format(goodcastqty)%></td>
			<td class="td1" align="right"><%=twoDForm.format(goodcastWt/1000)%></td>
			<td nowrap style="font-family: Arial;font-size: 10px;" class="td1" align="right" width="2%"><%=myFormatter.format(Double.parseDouble(rs1.getString("INV_QTY"))) %></td>		
			<td nowrap style="font-family: Arial;font-size: 10px;" class="td1" align="center" width="2%"><%=twoDForm.format(Double.parseDouble(rs1.getString("INV_WEIGHT"))/1000)  %></td>
			<%
			rrWt =0;
			rejper=0;
			final_KWH = rs1.getString("TO_KWH");
	 		final_KVH = rs1.getString("TO_KVH");
	 		tot_unit+=Double.parseDouble(rs1.getString("UNITKWH"));
	 		
			}else{
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			//******************************************** Pre Poured Qty *******************************************************
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				
				rrWt = Double.parseDouble(rs1.getString("PrevPouredTOTAL_WT")) - Double.parseDouble(rs1.getString("PrevPouredTOTAL_WT_WITHOUTRR"));
//				Good cast qty = poured qty - ( fl qty + SB Qty )
				goodcastqty = Double.parseDouble(rs1.getString("PrevPouredQTY")) - (Double.parseDouble(rs1.getString("FLOOR_QTY"))+Double.parseDouble(rs1.getString("SHOTBLASTED_QTY"))); 
				//  Good cat wt weight = total wt in grm - rej weight in grms
				goodcastWt = Double.parseDouble(rs1.getString("PrevPouredTOTAL_WT_WITHOUTRR")) - Double.parseDouble(rs1.getString("WEIGHT"));
			
				if(Double.parseDouble(rs1.getString("PrevPouredQTY")) != 0.0){
					rejper = ((Double.parseDouble(rs1.getString("FLOOR_QTY")) + Double.parseDouble(rs1.getString("SHOTBLASTED_QTY")))*100)/Double.parseDouble(rs1.getString("PrevPouredQTY"));
					}else{
					rejper=0;	
					}
			%> 
			<td class="td1" align="right"><strong style="color: red;">*</strong><%=myFormatter.format(Double.parseDouble(rs1.getString("PrevPouredQTY"))) %></td>
			<td class="td1" align="right"><%=mytotals.format(Double.parseDouble(rs1.getString("PrevPouredBOX_WT"))) %></td>
			<td class="td1" align="right"><%=twoDForm.format(Double.parseDouble(rs1.getString("PrevPouredTOTAL_WT"))/1000) %></td>
			<td class="td1" align="right"><%=mytotals.format(Double.parseDouble(rs1.getString("PrevPouredBOX_WT_WITHOUTRR"))) %></td>
			<td class="td1" align="right"><%=twoDForm.format(Double.parseDouble(rs1.getString("PrevPouredTOTAL_WT_WITHOUTRR"))/1000) %></td>
			<td class="td1" align="right" width="10%"><%=twoDForm.format(rrWt/1000) %>  </td>
			<td class="td1" align="right"><%=zeroDForm.format(Double.parseDouble(rs1.getString("FLOOR_QTY"))) %></td>
			<td class="td1" align="right"><%=zeroDForm.format(Double.parseDouble(rs1.getString("SHOTBLASTED_QTY"))) %></td>
			<td class="td1" align="right"><%=twoDForm.format(Double.parseDouble(rs1.getString("WEIGHT"))/1000) %></td>
			<td class="td1" align="right"><%=twoDForm.format(rejper)%></td>
			<td class="td1" align="right"><%=myFormatter.format(goodcastqty)%></td>
			<td class="td1" align="right"><%=twoDForm.format(goodcastWt/1000)%></td>
			<td nowrap style="font-family: Arial;font-size: 10px;" class="td1" align="right" width="2%"><%=myFormatter.format(Double.parseDouble(rs1.getString("INV_QTY"))) %></td>		
			<td nowrap style="font-family: Arial;font-size: 10px;" class="td1" align="center" width="2%"><%=twoDForm.format(Double.parseDouble(rs1.getString("INV_WEIGHT"))/1000)  %></td>
			<%
			rrWt =0;
			rejper=0;
			} 			 
			%>			 
			 
			</tr>
			<%	
			unitWithMF = Double.parseDouble(rs1.getString("MF_UNITKWH"));
			pf = Double.parseDouble(rs1.getString("PFACTOR"));
			unit_pTon = Double.parseDouble(rs1.getString("UNIT_PERTON"));
			ct++;
				} 
				} 	 
			%>
			<tr> 
					<td class="td1" align="right" width="20%" colspan="2"><strong>Total :</strong></td>
					<td class="td1" align="right" width="2%"><strong><%=myFormatter.format(total_pouredQty) %></strong>  </td>
					<td class="td1" align="right" width="2%">&nbsp; </td>
					<td class="td1" align="right" width="2%"><strong><%=mytotals.format(total_moltenMetalQty/1000)%></strong> </td> 
					<td class="td1" align="right" width="2%">&nbsp; </td>
					<td class="td1" align="right" width="2%"><strong><%=mytotals.format(total_castingwtTotalQty/1000) %></strong> </td> 
					<td class="td1" align="right" width="2%"><strong><%=mytotals.format(total_rrwtQty/1000) %></strong> </td> 
					<td class="td1" align="right" width="2%"><strong><%=myFormatter.format(total_flQty)%></strong> </td>
					<td class="td1" align="right" width="2%"><strong><%=myFormatter.format(total_sbQty) %></strong> </td>
					<td class="td1" align="right" width="2%"><strong><%=mytotals.format(total_rejwtQty/1000) %></strong>  </td> 
					<%
					double tot_perRej = ((total_flQty + total_sbQty)*100)/total_pouredQty;
					//System.out.println("Testing in = " + tot_perRej +"\n"+ total_flQty +"\n"+total_sbQty+"\n"+total_pouredQty);
					%>
					<td class="td1" align="right" width="2%"><strong><%=twoDForm.format(tot_perRej)%></strong> </td>
					<td class="td1" align="right" width="2%"> &nbsp;</td>
					<td class="td1" align="right" width="2%"><strong><%=mytotals.format(total_goodcastwtQty/1000) %></strong> </td> 
					<td nowrap style="font-family: Arial;font-size: 10px;" class="td1" align="right" width="2%"><strong><%=myFormatter.format(total_invoiceQty) %></strong> </td>		
					<td nowrap style="font-family: Arial;font-size: 10px;" class="td1" align="center" width="2%"><strong><%=mytotals.format(total_invoicewtQty/1000) %></strong> </td>
					<th></th>							
				</tr>
			</table>			
		</div>
		<!--
		--------------------------------------------------------------------------------------------------------------------
		-->
		 <%
		  String yld = twoDForm.format(total_castingwtTotalQty   * 100 / total_moltenMetalQty);
		  String net_yld = twoDForm.format(total_goodcastwtQty * 100 / total_moltenMetalQty);
		 %>
		  <div style="float: left; padding-left: 5px;width: 50%">
		  <table border="1" class="tftable" style="width: 100%">  	 
				<tr align="left">
					<th class="th" colspan="5">
					Yield : <strong style="color: blue;">&nbsp;<%=yld %>% </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					Net Yield :<strong style="color: blue;">&nbsp;<%=net_yld %>% </strong>	
					</th>  
				</tr>
				<tr align="center">		
					<th class="th">Molten Metal Total in MT</th>  
					<th class="th">Casting Wt. Total in MT</th>  
					<th class="th">R.R. Wt. Total in MT</th>  
					<th class="th">Rejection Quantity Wt. Total in MT</th>  
					<th class="th">Good Casting Wt. Total in MT</th>  
				</tr> 
				<tr>
					<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center; height: 5px;"><strong> <%=mytotals.format(total_moltenMetalQty/1000) %> </strong> </td>
				 	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center; height: 5px;"><strong> <%=mytotals.format(total_castingwtTotalQty/1000) %> </strong> </td>
				 	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center; height: 5px;"><strong> <%=mytotals.format(total_rrwtQty/1000) %> </strong> </td>
				 	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center; height: 5px;"><strong> <%=mytotals.format(total_rejwtQty/1000) %> </strong> </td>
				 	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center; height: 5px;"><strong> <%=mytotals.format(total_goodcastwtQty/1000) %> </strong> </td>
				</tr>				 
			</table>
		  </div>	  
		  <div style="float: left; padding-right: 5px;width: 47%">
		  <table border="1" class="tftable" style="width: 100%">  	 
				<tr>
					<th class="th" colspan="5">
					<strong>Power Consumption</strong>	 	
					</th>  
				</tr>
				<tr>
				<td>Final KWH Reading&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%= myFormatter.format(Double.parseDouble(final_KWH))%>
				</td>
				<td>Final KVH Reading&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%=myFormatter.format(Double.parseDouble(final_KVH))%> 
				</td>
				</tr>
				<tr>
				<td>Initial KWH Reading &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%= myFormatter.format(Double.parseDouble(initial_KWH))%>
				</td>
				<td>Initial KVH Reading &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%= myFormatter.format(Double.parseDouble(initial_KVH))%>
				</td>
				</tr>
				<tr>
				<%
				Double tot_unitConsum = Double.parseDouble(final_KWH) - Double.parseDouble(initial_KWH);  
				%>
				<td>Total Unit Consumption &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%=myFormatter.format(tot_unitConsum)%>
				</td>
				<td>Unit Consum With MF &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%=myFormatter.format(unitWithMF)%>
				</td>
				</tr>
				<tr>
				<td>Power Factor &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%=pf %>
				</td>
				<td>Unit Per Ton &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;
				<%=unit_pTon %>
				</td>
				</tr>
		  </table>	
		  </div>		  		
			<!-- 
			-----------------------------------------------------------------------------------------------------------------
			 -->
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