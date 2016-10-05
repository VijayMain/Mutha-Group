<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Type Wise Complaints</title>
</head>
<body>
<%
try{ 
	SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MM-yyyy");
	Connection con = Connection_Utility.getConnection();
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	String comp_type = request.getParameter("q");
	String comp_id = request.getParameter("r");
	// System.out.println("Company = " + comp_id + " Complaint Type = " + comp_type);
	String query="",comp_name = "ALL";
	if(comp_type.equalsIgnoreCase("all") && comp_id.equalsIgnoreCase("all") ){
		query = "select * from complaint_tbl where  Status_id!=5 order by Complaint_Date desc";
	}
	if(comp_type.equalsIgnoreCase("all") && !comp_id.equalsIgnoreCase("all") ){ 
		query = "select * from complaint_tbl where  Status_id!=5 and Company_Id="+Integer.parseInt(comp_id)+" order by Complaint_Date desc";
		
		PreparedStatement ps_compvar = con.prepareStatement("select * from user_tbl_company where Company_Id="+Integer.parseInt(comp_id) );
		ResultSet rs_compvar = ps_compvar.executeQuery();
		while (rs_compvar.next()) {
			comp_name = rs_compvar.getString("Company_Name");
		}
	}
	if(!comp_type.equalsIgnoreCase("all") && comp_id.equalsIgnoreCase("all") ){
		query = "select * from complaint_tbl where  Status_id!=5 and complaint_type='"+comp_type+"' order by Complaint_Date desc";
	}
	if(!comp_type.equalsIgnoreCase("all") && !comp_id.equalsIgnoreCase("all") ){
		query = "select * from complaint_tbl where  Status_id!=5 and complaint_type='"+comp_type+"'  and Company_Id="+Integer.parseInt(comp_id)+" order by Complaint_Date desc";
		PreparedStatement ps_compvar = con.prepareStatement("select * from user_tbl_company where Company_Id="+Integer.parseInt(comp_id) );
		ResultSet rs_compvar = ps_compvar.executeQuery();
		while (rs_compvar.next()) {
			comp_name = rs_compvar.getString("Company_Name");
		}
	} 
%>
<span id="getType_data">
							<table style="width: 100%;" class="tftable"> 
												<tr>
													<th><b>Complaint No</b></th>
													<th style="width: 60px;"><b>Type</b>
														<select name="type" id="type" style="width: 17px;" onchange="getType()">
															<option value="<%=comp_type %>"><%=comp_type %></option>
															<option value="all">All</option>
															<option value="customer">Customer</option>
															<option value="internal">Internal</option>
														</select>(<%=comp_type %>)
													</th>
													<th><b>Cust Name</b></th>
													<th><b>Company</b>
													<select name="comp_ser" id="comp_ser" style="width: 17px;" onchange="getType()">
															<option value="<%=comp_id%>"><%=comp_name %></option>
															<option value="all">All</option>
															<%
															PreparedStatement ps_compSer = con.prepareStatement("select * from user_tbl_company where Company_Id!=6" );
															ResultSet rs_compSer = ps_compSer.executeQuery();
															while (rs_compSer.next()) {
														   %>
														   <option value="<%=rs_compSer.getString("Company_Id")%>"><%=rs_compSer.getString("Company_Name")%></option>
														   <%
															}
															%>
														</select>(<%=comp_name %>) 
													</th>
													<th><b>Status</b></th>
													<th><b>Severity</b></th>
													<th><b>Item Name</b></th>
													<th><b>Defect</b></th>
													<th><b>Received By</b></th>
													<th><b>Related Dept</b></th>
													<th><b>Registered By</b></th>
													<th><b>Assigned To</b></th>
													<th><b>Category</b></th>
													<th><b>Complaint Date</b></th>
												</tr>
							<%
							PreparedStatement ps_sel = con.prepareStatement(query);
							ResultSet rs_sel = ps_sel.executeQuery(); 
							 while(rs_sel.next()){
							 %>
							 	<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" onclick="button1('<%=rs_sel.getString("complaint_no")%>');" style="cursor: pointer;">
												<td><b><%=rs_sel.getString("Complaint_No")%></b></td>
												<td><%=rs_sel.getString("complaint_type")%></td>
												<%
													PreparedStatement ps_cust = con.prepareStatement("select Cust_name from Customer_tbl where Cust_Id="+ rs_sel.getInt("Cust_Id"));
															ResultSet rs_cust = ps_cust.executeQuery();
															while (rs_cust.next()) {
												%>
												<td><%=rs_cust.getString("Cust_Name")%></td>

												<%
													}
													ps_cust.close();	
													rs_cust.close(); 
													PreparedStatement ps_comp = con.prepareStatement("select Company_Name from user_tbl_company where Company_Id="
																			+ rs_sel.getInt("Company_Id"));
															ResultSet rs_comp = ps_comp.executeQuery();
															while (rs_comp.next()) {
												%>
												<td><%=rs_comp.getString("Company_Name")%></td>
												<%
													}
															ps_comp.close();		
															rs_comp.close(); 
													PreparedStatement ps_Status = con
																	.prepareStatement("select Status from Status_tbl where Status_Id="
																			+ rs_sel.getInt("Status_id"));
															ResultSet rs_Status = ps_Status.executeQuery();
															while (rs_Status.next()) {
																if (rs_Status.getString("Status").equalsIgnoreCase("New")) {
												%>
												<td style="color: #2230C7;" class="blink"><strong>
														<%=rs_Status.getString("Status")%></strong></td>
												<%
													} else if (rs_Status.getString("Status")
																		.equalsIgnoreCase("Open")) {
												%>
												<td><%=rs_Status.getString("Status")%></td>
												<%
													} else if (rs_Status.getString("Status")
																		.equalsIgnoreCase("Resolved")) {
												%>
												<td><%=rs_Status.getString("Status")%></td>
												<%
													} else if (rs_Status.getString("Status")
																		.equalsIgnoreCase("Reopen")) {
												%>
												<td style="color: #DB2739;" class="blink"><strong>
														<%=rs_Status.getString("Status")%></strong></td>
												<%
													} else if (rs_Status.getString("Status")
																		.equalsIgnoreCase("Close")) {
												%>
												<td style="color: green;"><strong> <%=rs_Status.getString("Status")%></strong></td>
												<%
													}

															}

															PreparedStatement ps_priority = con
																	.prepareStatement("select P_Type from Severity_tbl where P_Id="
																			+ rs_sel.getInt("P_id"));
															ResultSet rs_priority = ps_priority.executeQuery();
															while (rs_priority.next()) {
																if (rs_priority.getString("P_Type").equalsIgnoreCase(
																		"Major")) {
												%>
												<td style="color: #E81A24;" class="blink"><strong>
														<%=rs_priority.getString("P_Type")%></strong></td>
												<%
													} else {
												%>
												<td><%=rs_priority.getString("P_Type")%></td>
												<%
													}
															}
															PreparedStatement ps_Item = con
																	.prepareStatement("select Item_Name from Customer_tbl_Item where Item_Id="
																			+ rs_sel.getInt("Item_id"));
															ResultSet rs_Item = ps_Item.executeQuery();
															while (rs_Item.next()) {
												%>
												<td><%=rs_Item.getString("Item_Name")%></td>
												<%
													}

															PreparedStatement ps_Defect = con
																	.prepareStatement("select Defect_Type from Defect_tbl where Defect_id="
																			+ rs_sel.getInt("Defect_Id"));
															ResultSet rs_Defect = ps_Defect.executeQuery();
															while (rs_Defect.next()) {
												%>
												<td><strong><%=rs_Defect.getString("Defect_Type")%></strong>
												</td>
												<%
													}
												%>

												<td><%=rs_sel.getString("Complaint_Received_By")%></td>

												<%
													PreparedStatement ps_related = con
																	.prepareStatement("select Department from User_tbl_Dept where Dept_id="
																			+ rs_sel
																					.getInt("Complaint_Related_To"));
															ResultSet rs_related = ps_related.executeQuery();
															while (rs_related.next()) {
												%>
												<td><%=rs_related.getString("Department")%></td>
												<%
													}
															PreparedStatement ps_registerer = con
																	.prepareStatement("select U_Name from User_tbl where U_id="
																			+ rs_sel.getInt("U_Id"));
															ResultSet rs_registerer = ps_registerer.executeQuery();
															while (rs_registerer.next()) {
												%>

												<td><%=rs_registerer.getString("U_Name")%></td>
												<%
													}

															PreparedStatement ps_assigned = con
																	.prepareStatement("select U_Name from User_tbl where U_id="
																			+ rs_sel
																					.getInt("Complaint_Assigned_To"));
															ResultSet rs_assigned = ps_assigned.executeQuery();
															while (rs_assigned.next()) {
												if(rs_sel.getInt("Complaint_Assigned_To")==uid){			
												%>
												<td style="background-color: #94c8fc"><%=rs_assigned.getString("U_Name")%></td>
												<%
													}else{
													%>
													<td><%=rs_assigned.getString("U_Name")%></td>
													<%		
													}
													}

															PreparedStatement ps_category = con
																	.prepareStatement("select Category from Category_tbl where category_id="
																			+ rs_sel.getInt("category_id"));
															ResultSet rs_category = ps_category.executeQuery();
															while (rs_category.next()) {
												%>
												<td><%=rs_category.getString("Category")%></td>
												<%
													}
												%>

												<td><%=sdf2.format(rs_sel.getDate("complaint_date"))%></td> 
											</tr>
							 <%  	
							   }
							%>
						</table>
						</span>
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>