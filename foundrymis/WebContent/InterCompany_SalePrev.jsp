<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.NumberFormat"%>
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
<title>Ajax for inter comp sale prev</title>
</head>
<body style="font-family: Arial;">
<span id="lastyear_sale">
<br/>
<%    
try{
String from_date = request.getParameter("FromDate_ICS");
String to_date = request.getParameter("ToDate_ICS");
int unitConvert = Integer.parseInt(request.getParameter("unitConvert"));

String rec="";
if(unitConvert==1){
	rec = "Rupees";
}else{
	rec = "Lakhs";
}
//System.out.println("test = " + to_date);
//System.out.println("Testing = " + from_date + "\n" + to_date);
/* DecimalFormat mytotals = new DecimalFormat("0.00");  */

NumberFormat mytotals = NumberFormat.getInstance();
mytotals.setMaximumFractionDigits(2);

String dateFrom =  from_date.substring(8,10)+"/"+ from_date.substring(5,7) +"/"+ from_date.substring(0,4);

String dateTo =  to_date.substring(8,10)+"/"+ to_date.substring(5,7) +"/"+ to_date.substring(0,4);
//System.out.println("test = " + dateTo);

from_date = from_date.substring(0,4) + from_date.substring(5,7) + from_date.substring(8,10);
to_date = to_date.substring(0,4) + to_date.substring(5,7) + to_date.substring(8,10); 



%> 
<table width="86%"  border="1" class="tftable"> 
			<tr>
				<td align="center" scope="col" colspan="9"><strong style="font-size: 14px;">Sister Company Sale From <%=dateFrom %> to <%=dateTo %></strong>&nbsp;<strong style="color: green;font-size: 10px;">all in <%=rec %></strong> </td> 
			</tr>
			<tr>
				<th align="left" scope="col" width="12%">
				<strong>CUSTOMERS&#8658; </strong><hr/>
				<strong>COMPANY&#8659;</strong>				</th>
				<th align="center" scope="col" width="9%">Total Gross  Sale</th>
				<th align="center" scope="col" width="10%"><strong>MEPL H21</strong></th>
				<th align="center" scope="col" width="12%"><strong>MEPL H25</strong></th>
				<th align="center" scope="col" width="13%"><strong>MFPL</strong></th>
				<th align="center" scope="col" width="12%"><strong>DI</strong></th>
				<th align="center" scope="col" width="11%"><strong>MEPL Unit III</strong></th>
			  <th width="11%" align="center" scope="col"><strong>Subtotal of Inter Company Sale</strong></th>
			  <th width="10%" align="center" scope="col">Net Total Outside Sale</th>
			</tr>
			
				<%
				double sumH21_ToH25 = 0;
				double sumH21_Total = 0;
				ArrayList listH21_ToH25 = new ArrayList();
				//H21 to H25 exec "ENGERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '101', '0', '101110205', '20141201', '20141231'
				Connection con_H21_toH25 = ConnectionUrl.getMEPLH21ERP();
				CallableStatement H21_toH25 = con_H21_toH25.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H21_toH25.setString(1, "101");
				H21_toH25.setString(2, "0");
				H21_toH25.setString(3, "101110205");
				H21_toH25.setString(4, from_date);
				H21_toH25.setString(5, to_date);
				ResultSet rs_H21_toH25 = H21_toH25.executeQuery();
				 while(rs_H21_toH25.next()){ 
					 listH21_ToH25.add(Double.parseDouble(rs_H21_toH25.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH21_ToH25.size(); i++)
				  {
					 sumH21_ToH25 += (Double.parseDouble(listH21_ToH25.get(i).toString())/unitConvert);
				  } 
				%>
			<tr>
				<th  align="left"><strong>MEPL H21</strong></th> 
				
				<%
				double h21=0,h25=0,mf=0,di=0,k1=0;
				/* --------------------------------------------------------------------------------------------------- */
				String h21_totgross = "";
				ArrayList listH21_gross = new ArrayList();
				double sum_gross = 0;
				PreparedStatement ps_subgl = con_H21_toH25.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE=11");
				ResultSet rs_subgl = ps_subgl.executeQuery();
				while(rs_subgl.next()){
					h21_totgross  = h21_totgross + rs_subgl.getString("SUB_GLACNO");
				}
				H21_toH25 = con_H21_toH25.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H21_toH25.setString(1, "101");
				H21_toH25.setString(2, "0");
				H21_toH25.setString(3, h21_totgross);
				H21_toH25.setString(4, from_date);
				H21_toH25.setString(5, to_date);
				rs_H21_toH25 = H21_toH25.executeQuery();
				while(rs_H21_toH25.next()){
					 listH21_gross.add(Double.parseDouble(rs_H21_toH25.getString("SALES_AMOUNT"))); 
				 }
				 for(int i = 0; i < listH21_gross.size(); i++)
				  {
					 sum_gross += (Double.parseDouble(listH21_gross.get(i).toString())/100000);
				  }
				 /* --------------------------------------------------------------------------------------------------- */
				 h21 = sum_gross;
				%>
				<td align="right"><b><%=mytotals.format(sum_gross) %></b></td>
				<td align="right" style="background-color: #ED723E;"></td>
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=101&reportof=H21_toH25&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumH21_ToH25) %></strong> </a> </td>
				<%
				double sumH21_Tomfpl = 0; 
				ArrayList listH21_Tomfpl = new ArrayList();
				//H21 to mfpl exec "ENGERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '101', '0', '101110070101110032101110060101110100', '20141201', '20141231'
				
				CallableStatement H21_tomfpl = con_H21_toH25.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H21_tomfpl.setString(1, "101");
				H21_tomfpl.setString(2, "0");
				H21_tomfpl.setString(3, "101110070101110032101110060101110100");
				H21_tomfpl.setString(4, from_date);
				H21_tomfpl.setString(5, to_date);
				ResultSet rs_H21_tomfpl = H21_tomfpl.executeQuery();
				 while(rs_H21_tomfpl.next()){ 
					 listH21_Tomfpl.add(Double.parseDouble(rs_H21_tomfpl.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH21_Tomfpl.size(); i++)
				  {
					 sumH21_Tomfpl += (Double.parseDouble(listH21_Tomfpl.get(i).toString())/unitConvert);
				  } 
				%>
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=101&reportof=H21_tomfpl&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumH21_Tomfpl) %></strong> </a> </td>
				<%  
				double sumH21_Todi = 0; 
				ArrayList listH21_Todi = new ArrayList();
				//H21 to di exec "ENGERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '101', '0', '101110012101110084', '20141201', '20141231'
				
				CallableStatement H21_todi = con_H21_toH25.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H21_todi.setString(1, "101");
				H21_todi.setString(2, "0");
				H21_todi.setString(3, "101110012101110084");
				H21_todi.setString(4, from_date);
				H21_todi.setString(5, to_date);
				ResultSet rs_H21_todi = H21_todi.executeQuery();
				 while(rs_H21_todi.next()){ 
					 listH21_Todi.add(Double.parseDouble(rs_H21_todi.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH21_Todi.size(); i++)
				  {
					 sumH21_Todi += (Double.parseDouble(listH21_Todi.get(i).toString())/unitConvert);
				  } 
				 %>
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=101&reportof=H21_todi&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumH21_Todi) %></strong> </a> </td>
				<%
				double sumH21_TounitIII = 0; 
				ArrayList listH21_TounitIII = new ArrayList();
				//H21 to unitIII exec "ENGERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '101', '0', '101110347', '20141201', '20141231'
				
				CallableStatement H21_tounitIII = con_H21_toH25.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H21_tounitIII.setString(1, "101");
				H21_tounitIII.setString(2, "0");
				H21_tounitIII.setString(3, "101110347");
				H21_tounitIII.setString(4, from_date);
				H21_tounitIII.setString(5, to_date);
				ResultSet rs_H21_tounitIII = H21_tounitIII.executeQuery();
				 while(rs_H21_tounitIII.next()){ 
					 listH21_TounitIII.add(Double.parseDouble(rs_H21_tounitIII.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH21_TounitIII.size(); i++)
				  {
					 sumH21_TounitIII += (Double.parseDouble(listH21_TounitIII.get(i).toString())/unitConvert);
				  } 
				 %>  
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=101&reportof=H21_tounitIII&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumH21_TounitIII) %></strong> </a> </td>
				<%		
				/* sumH21_ToH25 = Double.parseDouble(mytotals.format(sumH21_ToH25));
				sumH21_Tomfpl = Double.parseDouble(mytotals.format(sumH21_Tomfpl));
				sumH21_Todi = Double.parseDouble(mytotals.format(sumH21_Todi));
				sumH21_TounitIII = Double.parseDouble(mytotals.format(sumH21_TounitIII)); */
				
				sumH21_Total = sumH21_ToH25 + sumH21_Tomfpl + sumH21_Todi + sumH21_TounitIII;
				
				//sumH21_Total = Double.parseDouble(mytotals.format(sumH21_Total));
				
				%>

                <td align="right">
                <strong><%=mytotals.format(sumH21_Total) %></strong></td>
                <%
				double h21_sumgross = h21-sumH21_Total; 
				%>
                <td align="right"><strong><%=mytotals.format(h21_sumgross) %></strong></td>
			</tr>
			<tr>
				<th  align="left"><strong>MEPL H25</strong></th>
				<%
				double sumH25_ToH21 = 0;
				double sumH25_Total = 0;
				ArrayList listH25_toH21 = new ArrayList();
				//H25 to H21 exec "H25ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '102', '0', '101110054101110233101110100101110069', '20141201', '20141231' 
				Connection con_H25_toH21 = ConnectionUrl.getMEPLH25ERP();
				CallableStatement H25_toH21 = con_H25_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H25_toH21.setString(1, "102");
				H25_toH21.setString(2, "0");
				H25_toH21.setString(3, "101110054101110233101110100101110069");
				H25_toH21.setString(4, from_date);
				H25_toH21.setString(5, to_date);
				ResultSet rs_H25_toH21 = H25_toH21.executeQuery();
				 while(rs_H25_toH21.next()){
					 listH25_toH21.add(Double.parseDouble(rs_H25_toH21.getString("SALES_AMOUNT"))); 
				 }
				 for(int i = 0; i < listH25_toH21.size(); i++)
				 {
					 sumH25_ToH21 += (Double.parseDouble(listH25_toH21.get(i).toString())/unitConvert);
				 } 
				%>
				<%
				h21_totgross = "";
				listH21_gross.clear();
				sum_gross = 0;
				ps_subgl = con_H25_toH21.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE=11");
				rs_subgl = ps_subgl.executeQuery();
				while(rs_subgl.next()){
					h21_totgross  = h21_totgross + rs_subgl.getString("SUB_GLACNO");
				}
				H21_toH25 = con_H25_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H21_toH25.setString(1, "102");
				H21_toH25.setString(2, "0");
				H21_toH25.setString(3, h21_totgross);
				H21_toH25.setString(4, from_date);
				H21_toH25.setString(5, to_date);
				rs_H21_toH25 = H21_toH25.executeQuery();
				while(rs_H21_toH25.next()){
					 listH21_gross.add(Double.parseDouble(rs_H21_toH25.getString("SALES_AMOUNT"))); 
				 }
				 for(int i = 0; i < listH21_gross.size(); i++)
				  {
					 sum_gross += (Double.parseDouble(listH21_gross.get(i).toString())/100000);
				  }
				 /* --------------------------------------------------------------------------------------------------- */
				 h25 = sum_gross;
				%>
				<td align="right"><b><%=mytotals.format(sum_gross) %></b></td>
                <td align="right">
                <a href="InterCompany_SaleDetails.jsp?comp=102&reportof=H25_toH21&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumH25_ToH21) %></strong> </a> </td>
				<td align="right" style="background-color: #ED723E;"></td>
				<%
				double sumH25_Tomfpl = 0; 
				ArrayList listH25_tomfpl = new ArrayList();
				//H25 to mfpl exec "H25ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '102', '0', '101110070101110032101110060101110100', '20141201', '20141231' 
				
				CallableStatement H25_tomfpl = con_H25_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H25_tomfpl.setString(1, "102");
				H25_tomfpl.setString(2, "0");
				H25_tomfpl.setString(3, "101110070101110032101110060101110100");
				H25_tomfpl.setString(4, from_date);
				H25_tomfpl.setString(5, to_date);
				ResultSet rs_H25_tomfpl = H25_tomfpl.executeQuery();
				 while(rs_H25_tomfpl.next()){ 
					 listH25_tomfpl.add(Double.parseDouble(rs_H25_tomfpl.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH25_tomfpl.size(); i++)
				  {
					 sumH25_Tomfpl += (Double.parseDouble(listH25_tomfpl.get(i).toString())/unitConvert);
				  } 
				%>
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=102&reportof=H25_tomfpl&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumH25_Tomfpl) %></strong> </a> </td>
				<%
				double sumH25_Todi = 0; 
				ArrayList listH25_todi = new ArrayList();
				//H25 to di exec "H25ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '102', '0', '101110012101110084', '20141201', '20141231' 
				CallableStatement H25_todi = con_H25_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H25_todi.setString(1, "102");
				H25_todi.setString(2, "0");
				H25_todi.setString(3, "101110012101110084");
				H25_todi.setString(4, from_date);
				H25_todi.setString(5, to_date);
				ResultSet rs_H25_todi = H25_todi.executeQuery();
				 while(rs_H25_todi.next()){ 
					 listH25_todi.add(Double.parseDouble(rs_H25_todi.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH25_todi.size(); i++)
				  {
					 sumH25_Todi += (Double.parseDouble(listH25_todi.get(i).toString())/unitConvert);
				  }
				%> 
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=102&reportof=H25_todi&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumH25_Todi) %></strong> </a> </td>
				<%
				double sumH25_Tok1 = 0; 
				ArrayList listH25_tok1 = new ArrayList();
				//H25 to k1 exec "H25ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '102', '0', '101110347', '20141201', '20141231' 
				CallableStatement H25_tok1 = con_H25_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H25_tok1.setString(1, "102");
				H25_tok1.setString(2, "0");
				H25_tok1.setString(3, "101110347");
				H25_tok1.setString(4, from_date);
				H25_tok1.setString(5, to_date);
				ResultSet rs_H25_tok1 = H25_tok1.executeQuery();
				 while(rs_H25_tok1.next()){ 
					 listH25_tok1.add(Double.parseDouble(rs_H25_tok1.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listH25_tok1.size(); i++)
				  {
					 sumH25_Tok1 += (Double.parseDouble(listH25_tok1.get(i).toString())/unitConvert);
				  } 
				%>
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=102&reportof=H25_tok1&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumH25_Tok1) %></strong> </a> </td>
				<%
				/* sumH25_ToH21 = Double.parseDouble(mytotals.format(sumH25_ToH21));
				sumH25_Tomfpl = Double.parseDouble(mytotals.format(sumH25_Tomfpl));
				sumH25_Todi = Double.parseDouble(mytotals.format(sumH25_Todi));
				sumH25_Tok1 = Double.parseDouble(mytotals.format(sumH25_Tok1)); */
				
				sumH25_Total = sumH25_ToH21 + sumH25_Tomfpl + sumH25_Todi  +  sumH25_Tok1;
				
				//sumH25_Total = Double.parseDouble(mytotals.format(sumH25_Total));
				%>

                <td align="right"><strong><%=mytotals.format(sumH25_Total) %></strong></td>
				<%
				double h25_sumgross = h25-sumH25_Total; 
				%>
                <td align="right"><strong><%=mytotals.format(h25_sumgross) %></strong></td>
			</tr>
			<tr>
				<th  align="left"><strong>MFPL</strong></th>
				<%
				double summfpl_ToH21 = 0;
				double summfpl_Total = 0;
				ArrayList listmfpl_toH21 = new ArrayList();
				//K1 to H21 exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110070101110032101110060101110100', '20141001', '20141231'
				Connection con_mfpl_toH21 = ConnectionUrl.getFoundryERPNEWConnection();
				CallableStatement mfpl_toH21 = con_mfpl_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				mfpl_toH21.setString(1, "103");
				mfpl_toH21.setString(2, "0");
				mfpl_toH21.setString(3, "101110070101110032101110060101110100");
				mfpl_toH21.setString(4, from_date);
				mfpl_toH21.setString(5, to_date);
				ResultSet rs_mfpl_toH21 = mfpl_toH21.executeQuery();
				 while(rs_mfpl_toH21.next()){ 
					 listmfpl_toH21.add(Double.parseDouble(rs_mfpl_toH21.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listmfpl_toH21.size(); i++)
				  {
					 summfpl_ToH21 += (Double.parseDouble(listmfpl_toH21.get(i).toString())/unitConvert);
				  } 
				%>
				<%
				h21_totgross = "";
				listH21_gross.clear();
				sum_gross = 0;
				ps_subgl = con_mfpl_toH21.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE=11");
				rs_subgl = ps_subgl.executeQuery();
				while(rs_subgl.next()){
					h21_totgross  = h21_totgross + rs_subgl.getString("SUB_GLACNO");
				}
				H21_toH25 = con_mfpl_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H21_toH25.setString(1, "103");
				H21_toH25.setString(2, "0");
				H21_toH25.setString(3, h21_totgross);
				H21_toH25.setString(4, from_date);
				H21_toH25.setString(5, to_date);
				rs_H21_toH25 = H21_toH25.executeQuery();
				while(rs_H21_toH25.next()){
					 listH21_gross.add(Double.parseDouble(rs_H21_toH25.getString("SALES_AMOUNT"))); 
				 }
				 for(int i = 0; i < listH21_gross.size(); i++)
				  {
					 sum_gross += (Double.parseDouble(listH21_gross.get(i).toString())/100000);
				  }
				 /* --------------------------------------------------------------------------------------------------- */
				 mf = sum_gross;
				%>
				<td align="right"><b><%=mytotals.format(sum_gross) %></b></td>
                <td align="right">
                <a href="InterCompany_SaleDetails.jsp?comp=103&reportof=mfpl_toH21&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(summfpl_ToH21) %></strong> </a> </td>
				<%
				double summfpl_ToH25 = 0; 
				ArrayList listmfpl_toH25 = new ArrayList();
				//K1 to H25 exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110205', '20141001', '20141231' 
				CallableStatement mfpl_toH25 = con_mfpl_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				mfpl_toH25.setString(1, "103");
				mfpl_toH25.setString(2, "0");
				mfpl_toH25.setString(3, "101110205");
				mfpl_toH25.setString(4, from_date);
				mfpl_toH25.setString(5, to_date);
				ResultSet rs_mfpl_toH25 = mfpl_toH25.executeQuery();
				 while(rs_mfpl_toH25.next()){ 
					 listmfpl_toH25.add(Double.parseDouble(rs_mfpl_toH25.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listmfpl_toH25.size(); i++)
				  {
					 summfpl_ToH25 += (Double.parseDouble(listmfpl_toH25.get(i).toString())/unitConvert);
				  }  
				%>
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=103&reportof=mfpl_toH25&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(summfpl_ToH25) %></strong> </a> </td>
				<td align="right" style="background-color: #ED723E;"></td>
				<%
				double summfpl_Todi = 0; 
				ArrayList listmfpl_todi = new ArrayList();
				//K1 to di exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110012101110084', '20141001', '20141231' 
				CallableStatement mfpl_todi = con_mfpl_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				mfpl_todi.setString(1, "103");
				mfpl_todi.setString(2, "0");
				mfpl_todi.setString(3, "101110012101110084");
				mfpl_todi.setString(4, from_date);
				mfpl_todi.setString(5, to_date);
				ResultSet rs_mfpl_todi = mfpl_todi.executeQuery();
				 while(rs_mfpl_todi.next()){ 
					 listmfpl_todi.add(Double.parseDouble(rs_mfpl_todi.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listmfpl_todi.size(); i++)
				  {
					 summfpl_Todi += (Double.parseDouble(listmfpl_todi.get(i).toString())/unitConvert);
				  } 
				%>
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=103&reportof=mfpl_todi&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(summfpl_Todi) %></strong> </a> </td>
				<%
				double summfpl_TounitIII = 0; 
				ArrayList listmfpl_tounitIII = new ArrayList();
				//K1 to unitIII exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110347', '20141001', '20141231' 
				CallableStatement mfpl_tounitIII = con_mfpl_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				mfpl_tounitIII.setString(1, "103");
				mfpl_tounitIII.setString(2, "0");
				mfpl_tounitIII.setString(3, "101110347");
				mfpl_tounitIII.setString(4, from_date);
				mfpl_tounitIII.setString(5, to_date);
				ResultSet rs_mfpl_tounitIII = mfpl_tounitIII.executeQuery();
				 while(rs_mfpl_tounitIII.next()){ 
					 listmfpl_tounitIII.add(Double.parseDouble(rs_mfpl_tounitIII.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listmfpl_tounitIII.size(); i++)
				  {
					 summfpl_TounitIII += (Double.parseDouble(listmfpl_tounitIII.get(i).toString())/unitConvert);
				  } 
				 
				 /* summfpl_ToH21 = Double.parseDouble(mytotals.format(summfpl_ToH21));
				 summfpl_ToH25 = Double.parseDouble(mytotals.format(summfpl_ToH25));
				 summfpl_Todi = Double.parseDouble(mytotals.format(summfpl_Todi));
				 summfpl_TounitIII = Double.parseDouble(mytotals.format(summfpl_TounitIII)); */
				 
				 summfpl_Total = summfpl_ToH21 + summfpl_ToH25 + summfpl_Todi + summfpl_TounitIII;
				 
				// summfpl_Total = Double.parseDouble(mytotals.format(summfpl_Total));
				%>
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=103&reportof=mfpl_tounitIII&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(summfpl_TounitIII) %></strong> </a> </td>
				<td align="right">
                <strong><%=mytotals.format(summfpl_Total) %></strong></td> 
				<%
				double mf_sumgross = mf-summfpl_Total; 
				%>
                <td align="right"><strong><%=mytotals.format(mf_sumgross) %></strong></td>
			</tr>
			
			<tr>
				<th  align="left"><strong>DI</strong></th>
				<%
				double sumdi_toH21 = 0;
				double sumdi_Total = 0;
				ArrayList listdi_toH21 = new ArrayList();
				//DI to H21 exec "DIERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '105', '0', '101110054101110233101110100101110069', '20141001', '20141231'
				Connection con_di_toH21 = ConnectionUrl.getDIERPConnection();
				CallableStatement di_toH21 = con_di_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				di_toH21.setString(1, "105");
				di_toH21.setString(2, "0");
				di_toH21.setString(3, "101110054101110233101110100101110069");
				di_toH21.setString(4, from_date);
				di_toH21.setString(5, to_date);
				ResultSet rs_di_toH21 = di_toH21.executeQuery();
				 while(rs_di_toH21.next()){ 
					 listdi_toH21.add(Double.parseDouble(rs_di_toH21.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listdi_toH21.size(); i++)
				  {
					 sumdi_toH21 += (Double.parseDouble(listdi_toH21.get(i).toString())/unitConvert);
				  } 
				%>
				<%
				h21_totgross = "";
				listH21_gross.clear();
				sum_gross = 0;
				ps_subgl = con_di_toH21.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE=11");
				rs_subgl = ps_subgl.executeQuery();
				while(rs_subgl.next()){
					h21_totgross  = h21_totgross + rs_subgl.getString("SUB_GLACNO");
				}
				H21_toH25 = con_di_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H21_toH25.setString(1, "105");
				H21_toH25.setString(2, "0");
				H21_toH25.setString(3, h21_totgross);
				H21_toH25.setString(4, from_date);
				H21_toH25.setString(5, to_date);
				rs_H21_toH25 = H21_toH25.executeQuery();
				while(rs_H21_toH25.next()){
					 listH21_gross.add(Double.parseDouble(rs_H21_toH25.getString("SALES_AMOUNT"))); 
				 }
				 for(int i = 0; i < listH21_gross.size(); i++)
				  {
					 sum_gross += (Double.parseDouble(listH21_gross.get(i).toString())/100000);
				  }
				 /* --------------------------------------------------------------------------------------------------- */
				 di = sum_gross;
				%>
				<td align="right"><b><%=mytotals.format(sum_gross) %></b></td>
                <td align="right">
                <a href="InterCompany_SaleDetails.jsp?comp=105&reportof=di_toH21&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumdi_toH21) %></strong> </a> </td>
				<%
				double sumdi_toH25 = 0; 
				ArrayList listdi_toH25 = new ArrayList();
				//DI to H25 exec "DIERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '105', '0', '101110205', '20141001', '20141231' 
				CallableStatement di_toH25 = con_di_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				di_toH25.setString(1, "105");
				di_toH25.setString(2, "0");
				di_toH25.setString(3, "101110205");
				di_toH25.setString(4, from_date);
				di_toH25.setString(5, to_date);
				ResultSet rs_di_toH25 = di_toH25.executeQuery();
				 while(rs_di_toH25.next()){ 
					 listdi_toH25.add(Double.parseDouble(rs_di_toH25.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listdi_toH25.size(); i++)
				  {
					 sumdi_toH25 += (Double.parseDouble(listdi_toH25.get(i).toString())/unitConvert);
				  } 
				%>
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=105&reportof=di_toH25&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumdi_toH25) %></strong> </a> </td>
				<%
				double sumdi_tomfpl = 0; 
				ArrayList listdi_tomfpl = new ArrayList();
				//DI to mfpl exec "DIERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '105', '0', '101110070101110032101110060101110100', '20141001', '20141231' 
				CallableStatement di_tomfpl = con_di_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				di_tomfpl.setString(1, "105");
				di_tomfpl.setString(2, "0");
				di_tomfpl.setString(3, "101110070101110032101110060101110100");
				di_tomfpl.setString(4, from_date);
				di_tomfpl.setString(5, to_date);
				ResultSet rs_di_tomfpl = di_tomfpl.executeQuery();
				 while(rs_di_tomfpl.next()){ 
					 listdi_tomfpl.add(Double.parseDouble(rs_di_tomfpl.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listdi_tomfpl.size(); i++)
				  {
					 sumdi_tomfpl += (Double.parseDouble(listdi_tomfpl.get(i).toString())/unitConvert);
				  } 
				%>
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=105&reportof=di_tomfpl&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumdi_tomfpl) %></strong> </a> </td>
				<td align="right" style="background-color: #ED723E;"></td>
				<%
				double sumdi_tounitIII = 0; 
				ArrayList listdi_tounitIII = new ArrayList();
				//DI to unitIII exec "DIERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '105', '0', '101110347', '20141001', '20141231' 
				CallableStatement di_tounitIII = con_di_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				di_tounitIII.setString(1, "105");
				di_tounitIII.setString(2, "0");
				di_tounitIII.setString(3, "101110347");
				di_tounitIII.setString(4, from_date);
				di_tounitIII.setString(5, to_date);
				ResultSet rs_di_tounitIII = di_tounitIII.executeQuery();
				 while(rs_di_tounitIII.next()){ 
					 listdi_tounitIII.add(Double.parseDouble(rs_di_tounitIII.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listdi_tounitIII.size(); i++)
				  {
					 sumdi_tounitIII += (Double.parseDouble(listdi_tounitIII.get(i).toString())/unitConvert);
				  } 
				 
				/*  sumdi_toH21 = Double.parseDouble(mytotals.format(sumdi_toH21));
				 sumdi_toH25 = Double.parseDouble(mytotals.format(sumdi_toH25));
				 sumdi_tomfpl = Double.parseDouble(mytotals.format(sumdi_tomfpl));
				 sumdi_tounitIII = Double.parseDouble(mytotals.format(sumdi_tounitIII)); */
				 
				 sumdi_Total = sumdi_toH21 + sumdi_toH25 + sumdi_tomfpl + sumdi_tounitIII;
				 
				 //sumdi_Total = Double.parseDouble(mytotals.format(sumdi_Total));
				%>
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=105&reportof=di_tounitIII&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumdi_tounitIII) %></strong> </a> </td>
				<td align="right">
                <strong><%=mytotals.format(sumdi_Total) %></strong> </td> 
                <%
				double di_sumgross = di-sumdi_Total; 
				%>
                <td align="right"><strong><%=mytotals.format(di_sumgross) %></strong></td>
			</tr>
			
			<tr>
				<th  align="left"><strong>MEPL Unit III</strong></th>
				<%
				double sumk1_ToH21 = 0;
				double sumk1_Total = 0;
				ArrayList listk1_ToH21 = new ArrayList();
				//K1 to H21 exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110054101110233101110100101110069', '20141001', '20141231'
				Connection con_k1_toH21 = ConnectionUrl.getK1ERPConnection();
				CallableStatement k1_toH21 = con_k1_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				k1_toH21.setString(1, "106");
				k1_toH21.setString(2, "0");
				k1_toH21.setString(3, "101110054101110233101110100101110069");
				k1_toH21.setString(4, from_date);
				k1_toH21.setString(5, to_date);
				ResultSet rs_k1_toH21 = k1_toH21.executeQuery();
				 while(rs_k1_toH21.next()){ 
					 listk1_ToH21.add(Double.parseDouble(rs_k1_toH21.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listk1_ToH21.size(); i++)
				  {
				 	sumk1_ToH21 += (Double.parseDouble(listk1_ToH21.get(i).toString())/unitConvert);
				  } 
				%>
				<%
				h21_totgross = "";
				listH21_gross.clear();
				sum_gross = 0;
				ps_subgl = con_k1_toH21.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE=11");
				rs_subgl = ps_subgl.executeQuery();
				while(rs_subgl.next()){
					h21_totgross  = h21_totgross + rs_subgl.getString("SUB_GLACNO");
				}
				H21_toH25 = con_k1_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				H21_toH25.setString(1, "106");
				H21_toH25.setString(2, "0");
				H21_toH25.setString(3, h21_totgross);
				H21_toH25.setString(4, from_date);
				H21_toH25.setString(5, to_date);
				rs_H21_toH25 = H21_toH25.executeQuery();
				while(rs_H21_toH25.next()){
					 listH21_gross.add(Double.parseDouble(rs_H21_toH25.getString("SALES_AMOUNT"))); 
				 }
				 for(int i = 0; i < listH21_gross.size(); i++)
				  {
					 sum_gross += (Double.parseDouble(listH21_gross.get(i).toString())/100000);
				  }
				 /* --------------------------------------------------------------------------------------------------- */
				 k1 = sum_gross;
				%>
				<td align="right"><b><%=mytotals.format(sum_gross) %></b></td>
                <td align="right">
                <a href="InterCompany_SaleDetails.jsp?comp=106&reportof=k1_toH21&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumk1_ToH21) %></strong> </a> </td>
				<% 
				double sumk1_ToH25 = 0;	 
				ArrayList listk1_ToH25 = new ArrayList();
				//K1 to H25 exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110205', '20141001', '20141231'
				CallableStatement k1_toH25 = con_k1_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				k1_toH25.setString(1, "106");
				k1_toH25.setString(2, "0");
				k1_toH25.setString(3, "101110205");
				k1_toH25.setString(4, from_date);
				k1_toH25.setString(5, to_date);
				ResultSet rs_k1_toH25 = k1_toH25.executeQuery();
				 while(rs_k1_toH25.next()){ 
					 listk1_ToH25.add(Double.parseDouble(rs_k1_toH25.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listk1_ToH25.size(); i++)
				  {
				 	sumk1_ToH25 += (Double.parseDouble(listk1_ToH25.get(i).toString())/unitConvert);
				  }
				 
				%>
 				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=106&reportof=k1_toH25&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumk1_ToH25) %></strong> </a> </td>
				<% 
				double sumk1_Tomfpl = 0;	  
				ArrayList listk1_Tomfpl = new ArrayList();
				//K1 to mfpl exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110070101110032101110060101110100', '20141001', '20141231'
				CallableStatement k1_tomfpl = con_k1_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				k1_tomfpl.setString(1, "106");
				k1_tomfpl.setString(2, "0");
				k1_tomfpl.setString(3, "101110070101110032101110060101110100");
				k1_tomfpl.setString(4, from_date);
				k1_tomfpl.setString(5, to_date);
				ResultSet rs_k1_tomfpl = k1_tomfpl.executeQuery();
				 while(rs_k1_tomfpl.next()){ 
					 listk1_Tomfpl.add(Double.parseDouble(rs_k1_tomfpl.getString("SALES_AMOUNT"))); 
					} 				
				 for(int i = 0; i < listk1_Tomfpl.size(); i++)
				  {
				 	sumk1_Tomfpl += (Double.parseDouble(listk1_Tomfpl.get(i).toString())/unitConvert);
				  }
				  
				%>
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=106&reportof=k1_tomfpl&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumk1_Tomfpl) %></strong> </a> </td>
				<% 
				double sumk1_Todi = 0;	  
				ArrayList listk1_Todi = new ArrayList();
				//K1 to di exec "K1ERP"."dbo"."Sel_RptCustomerWsSaleSummary";1 '106', '0', '101110012101110084', '20141001', '20141231'
				CallableStatement k1_todi = con_k1_toH21.prepareCall("{call Sel_RptCustomerWsSaleSummary(?,?,?,?,?)}");
				k1_todi.setString(1, "106");
				k1_todi.setString(2, "0");
				k1_todi.setString(3, "101110012101110084");
				k1_todi.setString(4, from_date);
				k1_todi.setString(5, to_date);
				ResultSet rs_k1_todi = k1_todi.executeQuery();
				 while(rs_k1_todi.next()){ 
					 listk1_Todi.add(Double.parseDouble(rs_k1_todi.getString("SALES_AMOUNT"))); 
				 } 				
				 for(int i = 0; i < listk1_Todi.size(); i++)
				  {
				 	sumk1_Todi += (Double.parseDouble(listk1_Todi.get(i).toString())/unitConvert);
				  }
				 
				/*  sumk1_ToH21 = Double.parseDouble(mytotals.format(sumk1_ToH21));
				 sumk1_ToH25 = Double.parseDouble(mytotals.format(sumk1_ToH25));
				 sumk1_Tomfpl = Double.parseDouble(mytotals.format(sumk1_Tomfpl));
				 sumk1_Todi = Double.parseDouble(mytotals.format(sumk1_Todi)); */
				 
				 sumk1_Total = sumk1_ToH21 + sumk1_ToH25 + sumk1_Tomfpl + sumk1_Todi;
				 
				// sumk1_Total = Double.parseDouble(mytotals.format(sumk1_Total));
				%>
				<td align="right"><a href="InterCompany_SaleDetails.jsp?comp=106&reportof=k1_todi&fromDate=<%=from_date %>&toDate=<%=to_date %>" style="color: black;" title="Click to get Details"><strong><%=mytotals.format(sumk1_Todi) %></strong> </a> </td>
				<td align="right" style="background-color: #ED723E;"></td>
				<td align="right"><strong><%=mytotals.format(sumk1_Total) %></strong></td> 
                <%
				double k1_sumgross = k1-sumk1_Total; 
				%>
                <td align="right"><strong><%=mytotals.format(k1_sumgross) %></strong></td>
			</tr>
			
			<tr>
			<th  align="left"><strong>TOTAL &#8658;</strong></th>
			<%
			String h21sum = "0.00";
			double totalH21 =  sumH25_ToH21  +  summfpl_ToH21  +  sumdi_toH21  + sumk1_ToH21; 
			if(totalH21==.00){
				totalH21 = 0;
			}else{
				h21sum = mytotals.format(totalH21);
			}
			double all_gross =  h21 + h25 + mf + di + k1; 
			String str_gross = mytotals.format(all_gross);
			%>
			<td align="right"><strong><%=str_gross%></strong></td>
            <td align="right">
            <strong><%=h21sum %></strong></td>
			<%
			String h25sum = "0.00";
			double totalH25 =  sumH21_ToH25 +  summfpl_ToH25  +   sumdi_toH25 +  sumk1_ToH25;
			if(totalH25==.00){
				totalH25 = 0;
			}else{
				h25sum = mytotals.format(totalH25);
			}
			%>
			<td align="right"><strong><%=h25sum %></strong> </td>
			<%
			String mfplsum = "0.00";
			double totalmfpl =  sumH21_Tomfpl +  sumH25_Tomfpl  +   sumdi_tomfpl +  sumk1_Tomfpl;
		 
			if(totalmfpl==.00){
				totalmfpl = 0;
			}else{
				mfplsum = mytotals.format(totalmfpl);
			}
			%>
			<td align="right"><strong> <%=mfplsum %></strong> </td>
			<%
			String disum = "0.00";
			double totaldi =  sumH21_Todi +  sumH25_Todi  +   summfpl_Todi +  sumk1_Todi;
			if(totaldi==.00){
				totaldi = 0;
			}else{
				disum = mytotals.format(totaldi);
			}
			%>
			<td align="right"><strong><%=disum %> </strong></td>
			<%
			String k1sum = "0.00";
			double totalk1 =  sumH21_TounitIII +  sumH25_Tok1  +   summfpl_TounitIII +  sumdi_tounitIII;
			if(totalk1==.00){
				totalk1 = 0;
			}else{
				k1sum = mytotals.format(totalk1);
			}
			%> 
			<td align="right"><strong><%=k1sum %></strong></td>
			<%
			String allsum = "0.00";
			double totalall =  sumH21_Total  +  sumH25_Total  + summfpl_Total  +  sumdi_Total  +  sumk1_Total;
			if(totalall==.00){
				totalall = 0;
			}else{
				allsum = mytotals.format(totalall);
			}
			%>
			<td  align="right"><strong><%=allsum %></strong></td>		
            <%
				double allinone_sumgross = all_gross - totalall; 
			%>
            <td align="right"><strong><%=mytotals.format(allinone_sumgross) %></strong></td>
			</tr>
</table>
<% 
con_H21_toH25.close();    
con_mfpl_toH21.close();   
con_di_toH21.close();   
con_k1_toH21.close();   
}catch(Exception e){
e.printStackTrace();
}
%>		
</span>
</body>
</html>