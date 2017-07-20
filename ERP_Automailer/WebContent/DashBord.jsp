<%@page import="jxl.write.Label"%>
<%@page import="jxl.write.WritableSheet"%>
<%@page import="jxl.format.BorderLineStyle"%>
<%@page import="jxl.format.Border"%>
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.write.WritableCellFormat"%>
<%@page import="jxl.Workbook"%>
<%@page import="jxl.write.WritableFont"%>
<%@page import="jxl.format.Colour"%>
<%@page import="jxl.write.WritableWorkbook"%>
<%@page import="java.io.File"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.muthagroup.connectionERPUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<html>
<head>
<title>Dash Board</title>
</head>
<body>
	<%
		try {
			Connection con=null; 
	 		boolean chk_flag=false,chk_grand=false;
	 		/**************************************************************************************************************/
	 	  		String CompanyName="";
	 			String comp = ""; 
	 		 	String DATE_FORMAT = "yyyyMMdd";
	 		 	ArrayList subglNo = new ArrayList();
		 		Set<String> hs = new HashSet();
	 		    SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
	 		    Calendar c1 = Calendar.getInstance(); // today
	 		   c1.add(Calendar.DATE, -1);
	 		    String DATE_FORMAT2 = "dd/MM/yyyy";
	 		    SimpleDateFormat sdf2 = new SimpleDateFormat(DATE_FORMAT2);
	 		    Calendar c2 = Calendar.getInstance(); // today
	 		   c2.add(Calendar.DATE, -1); 
	 			String datesql = sdf.format(c1.getTime());
	 			String printdate = sdf2.format(c1.getTime()); 
	 			ArrayList type = new ArrayList();
		 		type.add("101");
		 		type.add("102");
		 		type.add("103"); 
	 			// System.out.println("IN OUT Register = " + datesql + " = = " + printdate);
	%>
	 <b style='color: #0D265E;font-family: Arial;font-size: 11px;'>*** This is an automatically generated email of ERP Stock In/Out Register ***</b><table border='1' width='90%' style='font-family: Arial;text-align: center;font-family: Arial;font-size: 12px;'>
	 	<tr style='font-size: 12px; background-color: #c8e6f0; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;font-weight: bold;'>
	 	<td colspan='3'>Stock In/Out Register as on </td>
	 	</tr>
	 	<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;font-weight: bold;'>
		 <td>Part Name</td>
	 	<td>In Qty</td>
	 	<td>Out Qty</td>
	 	</tr>
	 <%  
	 
	 //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 %>
	 <tr><td colspan='3' align='left' style='background-color: #466817; color: white;font-size: 12px;'><strong>Company Name : MEPL H21 ==> </strong></td></tr>
	 <%
	 		comp = "101";
	 		CompanyName = "MEPL H-21";
	 		subglNo.clear();   
	 		hs.clear();
	 		chk_flag=false;
	 		con = ConnectionUrl.getMEPLH21ERP();
	 		CallableStatement cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
	 		cs.setString(1, comp);
	 		cs.setString(2, "0");
	 		cs.setString(3, datesql);
	 		cs.setString(4, "101102103");
	 		ResultSet rs_data = cs.executeQuery();
	 		while(rs_data.next()){
	 			subglNo.add(rs_data.getString("SUB_GLACNO"));
	 		}
	 		 
	 		hs.addAll(subglNo);
	 		subglNo.clear();
	 		subglNo.addAll(hs);
	 		
	 		ResultSet rs = null,rs_name=null;
	 		
	 		
	 		 
	 		for(int i=0;i<type.size();i++){
	 			if(i==0 && type.get(i).toString().equalsIgnoreCase("101")){
	 				
	 				%>
	 				<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>JOBWORK</strong></td></tr>
	 				<%
	 				for(int j=0;j<subglNo.size();j++){
	 				rs = cs.executeQuery();
	 				while(rs.next()){
	 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("101")){
	 						if(chk_flag==false){
	 				%>
	 				<tr><td colspan='3' align='left' style='background-color: #aeaeae;color: black;'><strong><%=rs.getString("SUBGL_LONGNAME") %></strong></td></tr>
	 				<%			
	 				chk_flag=true;
	 						}
	 				%>
	 				<tr>
	 					<td align='left'><%=rs.getString("NAME") %></td>
	 					<td align="right"><b><%=rs.getString("IN_QTY") %></b></td>
	 					<td align="right"><b><%=rs.getString("OUT_QTY") %></b></td>
	 				</tr>
	 				<%		
	 					}	 					
	 				}
	 				rs=null;
	 				chk_flag=false;
	 				}
	 			}
				if(i==1 && type.get(i).toString().equalsIgnoreCase("102")){
					%>
				 	<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>PURCHASE / SALE</strong></td></tr>
				 	<%		
				 	for(int j=0;j<subglNo.size();j++){
		 				rs = cs.executeQuery();
		 				while(rs.next()){
		 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("102")){
		 						if(chk_flag==false){
		 				%>
		 				<tr><td colspan='3' align='left' style='background-color:  #aeaeae;color: black;'><strong><%=rs.getString("SUBGL_LONGNAME") %></strong></td></tr>
		 				<%			
		 				chk_flag=true;
		 						}
		 				%>
		 				<tr>
		 				<td align='left'><%=rs.getString("NAME") %></td>
	 					<td align="right"><b><%=rs.getString("IN_QTY") %></b></td>
	 					<td align="right"><b><%=rs.getString("OUT_QTY") %></b></td>
	 					</tr>
		 				<%		
		 					}
		 					
		 				}
		 				rs=null;
		 				chk_flag=false;
		 				}
				 	
	 			}
				if(i==2 && type.get(i).toString().equalsIgnoreCase("103")){
					%>
				 	<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>SUBCONTRACT IN OUT</strong></td></tr>
				 	<%	
				 	for(int j=0;j<subglNo.size();j++){
		 				rs = cs.executeQuery();
		 				while(rs.next()){
		 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("103")){
		 						if(chk_flag==false){
		 				%>
		 				<tr><td colspan='3' align='left' style='background-color: #aeaeae;color: black;'><strong><%=rs.getString("SUBGL_LONGNAME") %></strong></td></tr>
		 				<%			
		 				chk_flag=true;
		 						}
		 				%>
		 				<tr>
		 				<td align='left'><%=rs.getString("NAME") %></td>
	 					<td align="right"><b><%=rs.getString("IN_QTY") %></b></td>
	 					<td align="right"><b><%=rs.getString("OUT_QTY") %></b></td>
						</tr>
		 				<%		
		 					}
		 				} 
		 				rs=null;
		 				chk_flag=false;
		 				}
				} 
	 		}
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	 		
%>
</table>
<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>