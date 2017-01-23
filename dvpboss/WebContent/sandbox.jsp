<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sandbox Page</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/tab.css" />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script>
	$(function() {
		$("#tabs").tabs();
	});
</script>
<script language="javascript" type="text/javascript">
	function clearText(field) {
		if (field.defaultValue == field.value)
			field.value = '';
		else if (field.value == '')
			field.value = field.defaultValue;
	}

	$(function() {
		$("#accordion").accordion();
	});
</script>
<script type="text/javascript">
function validatenumerics(key) {
//getting key code of pressed key
var keycode = (key.which) ? key.which : key.keyCode;
//comparing pressed keycodes
 
if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46) {
    alert("Only allow numeric Data entry");
    return false;
}else 
{
	return true;
};
}
</script>
<script type="text/javascript">
 function openPage(pageURL)
 {
 window.location.href = pageURL;
 }
</script>

<SCRIPT LANGUAGE="JavaScript">
		function addTrial(a,b) { 
         var para=a;
         var bas=b;
         if(para=='1'){
         	 window.location.href = "Get_Approval.jsp?hid="+bas;
        	 
        //	 document.myForm.Basic_Id.value = bas; 
        //	 document.myForm.submit();

        	 
         } if(para=='2') {
			window.location.href = "Add_Trials.jsp?hid="+bas;
			};
		}
	</SCRIPT>
<!-- CSS goes in the document HEAD or added to your external stylesheet -->
<style type="text/css">
table.gridtable {
	font-family: verdana, arial, sans-serif;
	font-size: 11px;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
}

table.gridtable tr {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
}

table.gridtable td {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	background-color: #ffffff;
}
</style>


</head>
<body style="background: #e3e3e3;">
	<div id="templatemo_header_wrapper">
		<!--  Free Web Templates by TemplateMo.com  -->
		<div id="templatemo_header">

			<!-- 	<div id="site_logo"></div> -->

			<div id="templatemo_menu">
				<div id="templatemo_menu_left"></div>
				<ul>
					<li><a href="Home.jsp" class="current">Home</a></li>
					<li><a href="All_DVPSheets.jsp">All DVP Sheets</a></li>
					<li><a href="NewSheet.jsp">New DVP Sheets</a></li>
					<li><a href="#">Reports</a></li>
					<li><a href="#">Search</a></li>
					<li><a href="Logout.jsp" class="last">Log Out</a></li>
				</ul>
			</div>
			<!-- end of menu -->

		</div>
		<!-- end of header -->
	</div>
	<!-- end of header wrapper -->
	<!-- ----------------------------------------------------------------------------------------------- -->
	<!-- ----------------------------Master here----------------------------------
	<ul id="globalnav">

		<li><a href="New_CostSheet.jsp" class="here">Basic</a></li>
		<li><a href="New_CostSheet_Charge.jsp">Charge</a></li>

	</ul>
	<br>
- -->


	<%
		int basic_id = 0;

		if (request.getParameter("hid") != null) {
			basic_id = Integer.parseInt(request.getParameter("hid"));
		}
	%>
	<div class="templatemo_section_1">

		<form action="Approval_Controller" class="register" method="post"
			id="myForm" name="myForm">



			<%
				try {

					Connection con = Connection_Utility.getConnection();
			%>

			<table width="95%" border="1" class="gridtable">
				<tr style="background-color: #B0C9D6">
					<th height="26" colspan="21" align="left" scope="col"><b
						style="font-size: 18px; color: #2883B8">Development Activity
							Sheet : </b></th>
				</tr>
				<tr>
					<th width="2%" scope="col"><strong>Sheet No</strong></th>
					<th width="3%" scope="col">Company</th>
					<th width="3%" scope="col">Customer</th>
					<th width="3%" scope="col">Plant Name</th>
					<th width="3%" scope="col"><strong>Part Name</strong></th>
					<th width="4%" scope="col"><strong>Part Number</strong></th>
					<th width="4%" scope="col">Project Lead</th>
					<th width="3%" scope="col">Revision Number</th>
					<th width="3%" scope="col">Revision Date</th>
					<th width="3%" scope="col">Casting From</th>
					<th width="3%" scope="col">Related Person</th>
					<th width="2%" scope="col">Planned Start Date</th>
					<th width="3%" scope="col">Planned End Date</th>
					<th width="2%" scope="col">Actual Start Date</th>
					<th width="3%" scope="col">Actual End Date</th>
					<th width="5%" scope="col">Marketing Approvals</th>
					<th width="5%" scope="col">Schedule/Month</th>
					<th width="5%" scope="col">PO No (Customer)</th>
					<th width="5%" scope="col">PO Date(Customer)</th>
					<th width="3%" scope="col">Attached PO</th>
					<th width="38%" scope="col">PO Received (Development)</th>
				</tr>
				<%
					PreparedStatement ps_getBasicInfo = con
								.prepareStatement("select * from dev_basicinfo_tbl where Basic_id="
										+ basic_id);
						ResultSet rs_getBasicInfo = ps_getBasicInfo.executeQuery();
						while (rs_getBasicInfo.next()) {
				%>
				<tr>
					<td align="center"><%=basic_id%></td>
					<%
						String Company_Name = null;
								PreparedStatement ps_getCompanyName = con
										.prepareStatement("select Company_Name from User_Tbl_Company where Company_Id="
												+ rs_getBasicInfo.getInt("Plant_Id"));
								ResultSet rs_getCompanyName = ps_getCompanyName
										.executeQuery();
								while (rs_getCompanyName.next()) {
									Company_Name = rs_getCompanyName
											.getString("Company_Name");
								}
								rs_getCompanyName.close();
								ps_getCompanyName.close();
					%>
					<td align="center"><%=Company_Name%></td>
					<%
						PreparedStatement ps_getCustName = con
										.prepareStatement("select Cust_name from customer_tbl where Cust_Id="
												+ rs_getBasicInfo.getInt("Cust_Id"));
								ResultSet rs_getCustName = ps_getCustName.executeQuery();
								while (rs_getCustName.next()) {
					%>
					<td align="center"><%=rs_getCustName.getString("Cust_Name")%></td>
					<%
						}
								rs_getCustName.close();
								ps_getCustName.close();
					%>
					<td align="center"><%=Company_Name%></td>
					<%
						PreparedStatement ps_getPartName = con
										.prepareStatement("select Part_Name from cs_part_name_tbl where PartName_Id="
												+ rs_getBasicInfo.getInt("PartName_Id"));
								ResultSet rs_getPartName = ps_getPartName.executeQuery();
								while (rs_getPartName.next()) {
					%>
					<td align="center"><%=rs_getPartName.getString("Part_Name")%></td>
					<%
						}
								rs_getPartName.close();
								ps_getPartName.close();

								PreparedStatement ps_getPartNo = con
										.prepareStatement("select Part_no from cs_part_no_tbl where PartNo_Id="
												+ rs_getBasicInfo.getInt("PartNo_Id"));
								ResultSet rs_getPartNo = ps_getPartNo.executeQuery();

								while (rs_getPartNo.next()) {
					%>
					<td align="center"><%=rs_getPartNo.getString("Part_No")%></td>
					<%
						}
								rs_getPartNo.close();
								ps_getPartNo.close();

								PreparedStatement ps_getProjectLead = con
										.prepareStatement("select U_Name from User_tbl where U_Id="
												+ rs_getBasicInfo.getInt("Project_Leader"));
								ResultSet rs_getProjectLead = ps_getProjectLead
										.executeQuery();

								while (rs_getProjectLead.next()) {
					%>

					<td align="center"><%=rs_getProjectLead.getString("U_Name")%></td>

					<%
						}
					%>

					<td align="center"><%=rs_getBasicInfo.getInt("Revision_No")%></td>
					<td align="center"><%=rs_getBasicInfo.getDate("Revision_Date")%></td>
					<%
						PreparedStatement ps_getCastingFrom = con
										.prepareStatement("Select Company_Name from User_tbl_Company where company_Id="
												+ rs_getBasicInfo.getInt("Casting_From"));
								ResultSet rs_getCastingFrom = ps_getCastingFrom
										.executeQuery();
								while (rs_getCastingFrom.next()) {
					%>
					<td align="center"><%=rs_getCastingFrom.getString("Company_Name")%></td>
					<%
						}
								PreparedStatement ps_getRelatedPerson = con
										.prepareStatement("select U_Name from USer_tbl where U_Id="
												+ rs_getBasicInfo.getInt("Related_Person"));
								ResultSet rs_getRealtedPerson = ps_getRelatedPerson
										.executeQuery();

								while (rs_getRealtedPerson.next()) {
					%>
					<td align="center"><%=rs_getRealtedPerson.getString("U_Name")%></td>
					<%
						}
								rs_getRealtedPerson.close();
								ps_getRelatedPerson.close();
					%>

					<td align="center"><%=rs_getBasicInfo.getDate("Planned_Start_Date")%></td>
					<td align="center"><%=rs_getBasicInfo.getDate("Planned_End_Date")%></td>
					<td align="center"></td>
					<td align="center"></td>
					<td align="center"><%=rs_getBasicInfo.getString("Mkt_Approval")%></td>
					<td align="center"><%=rs_getBasicInfo.getInt("Schedule_Per_Month")%></td>
					<td align="center"><%=rs_getBasicInfo.getString("PO_No_From_Cust")%></td>
					<td align="center"><%=rs_getBasicInfo.getDate("Po_Date_From_Cust")%></td>
					<%
						PreparedStatement ps_getAttachedPO = con
										.prepareStatement("select * from dev_basicinfo_po_attachment_tbl where Basic_Id="
												+ rs_getBasicInfo.getInt("Basic_Id"));
								ResultSet rs_getAttachedPO = ps_getAttachedPO
										.executeQuery();

								while (rs_getAttachedPO.next()) {
					%>
					<td align="center"><a
						href="Display_AttachedPO.jsp?field=<%=rs_getAttachedPO.getString("File_Name")%>"><%=rs_getAttachedPO.getString("File_Name")%></a></td>
					<%
						}
					%>
					<td align="center"><%=rs_getBasicInfo.getDate("PO_Rcvd_At_Dev_Date")%></td>
				</tr>

				<%
					}
						rs_getBasicInfo.close();
						ps_getBasicInfo.close();
				%>
			</table>

			</br>
			<div id="tabs">
				<ul>
					<li><a href="#tabs-1">Process Flow</a></li>
					<li><a href="#tabs-2">Machining Data</a></li>
					<li><a href="#tabs-3">Fixtures</a></li>
					<li><a href="#tabs-4">Cutting tools</a></li>
					<li><a href="#tabs-5">Gauges</a></li>
					<li><a href="#tabs-6">Others</a></li>
				</ul>
				<div id="tabs-1">

					<%
						int sr_no = 0, sr_no1 = 0, sr_no2 = 0, sr_no3 = 0, sr_no4 = 0;
							int opnno_id = 0;
							int opn_id = 0;
							System.out.println("Basic Id === " + basic_id);

							PreparedStatement ps_getOpnAndOpnnoId = con
									.prepareStatement("select * from dev_opnandopnno_basic_rel_tbl where basic_id="
											+ basic_id);
							ResultSet rs_getOpnAndOpnnoId = ps_getOpnAndOpnnoId
									.executeQuery();

							// Condition checking for Activity sheet (New operation & Operations)

							rs_getOpnAndOpnnoId.last();
							System.out.println("Get fetch size = "
									+ rs_getOpnAndOpnnoId.getRow());
							int b = rs_getOpnAndOpnnoId.getRow();
							rs_getOpnAndOpnnoId.beforeFirst();
							//*****************************************************************************************************************
							if (b > 0) {
					%>

					<table width="369" border="1" class="gridtable">

						<tr bgcolor="#CCCCCC">
							<th width="13%" height="33" scope="col">Sr. No</th>
							<th width="16%" height="33" scope="col">Op No.</th>
							<th width="37%" height="33" scope="col">Operation</th>
							<th width="14%" height="33" scope="col">Edit</th>
							<th width="20%" height="33" scope="col">Add New</th>
						</tr>

						<%
							while (rs_getOpnAndOpnnoId.next()) {
										sr_no = sr_no + 1;
						%>
						<tr>

							<td><%=sr_no%></td>
							<%
								PreparedStatement ps_getOpnIds = con
													.prepareStatement("select opnno_id,opn_id from dev_opn_opnno_rel_tbl where OpnNo_Opn_Rel_Id="
															+ rs_getOpnAndOpnnoId
																	.getInt("OpnNo_Opn_Rel_Id"));
											ResultSet rs_getOpnIds = ps_getOpnIds.executeQuery();
											while (rs_getOpnIds.next()) {
												opnno_id = rs_getOpnIds.getInt("opnno_id");
												opn_id = rs_getOpnIds.getInt("opn_id");

												PreparedStatement ps_getOpnNo = con
														.prepareStatement("select opn_no from dev_operation_no_mst_tbl where opnno_id="
																+ rs_getOpnIds.getInt("opnno_id"));
												ResultSet rs_getOpnNo = ps_getOpnNo.executeQuery();
												while (rs_getOpnNo.next()) {
							%>

							<td><%=rs_getOpnNo.getInt("Opn_no")%></td>
							<%
								}
												PreparedStatement ps_getOpn = con
														.prepareStatement("select operation from dev_operation_mst_tbl where opn_id="
																+ rs_getOpnIds.getInt("opn_id"));
												ResultSet rs_getOpn = ps_getOpn.executeQuery();
												while (rs_getOpn.next()) {
							%>


							<td><%=rs_getOpn.getString("operation")%></td>
							<%
								}
											}
							%>
							<td><input type="button" name="Submit232" value="Edit"
								onclick="openPage('Add_operation.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
							<td><input type="button" name="Submit23" value="New"
								onclick="openPage('Add_operation.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
						</tr>

						<%
							}
						%>
					</table>


					<%
						} else {
					%>
					<table width="28%" border="1" class="gridtable">
						<tr bgcolor="#CCCCCC">
							<th width="13%" height="33" scope="col">Sr. No</th>
							<th width="16%" height="33" scope="col">Op No.</th>
							<th width="37%" height="33" scope="col">Operation</th>
							<th width="14%" height="33" scope="col">Edit</th>
							<th width="20%" height="33" scope="col">Add New</th>
						</tr>

						<tr>

							<td height="42">&nbsp;</td>

							<td>&nbsp;</td>


							<td>&nbsp;</td>
							<td><input type="button" name="Submit232" value="Edit"
								onclick="openPage('Add_operation.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
							<td><input type="button" name="Submit23" value="New"
								onclick="openPage('Add_operation.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
						</tr>
					</table>
					<%
						}
					%>

				</div>


				<!-- Machining data -->
				<div id="tabs-2">
					<%
						rs_getOpnAndOpnnoId.last();
							System.out.println("Get fetch size = "
									+ rs_getOpnAndOpnnoId.getRow());
							int mb2 = rs_getOpnAndOpnnoId.getRow();
							rs_getOpnAndOpnnoId.beforeFirst();

							if (mb2 > 0) {
					%>

					<table width="953" border="1" class="gridtable">

						<tr bgcolor="#CCCCCC">
							<th width="4%" height="33" rowspan="2" scope="col">Sr. No</th>
							<th width="4%" height="33" rowspan="2" scope="col">Op No.</th>
							<th width="16%" height="33" rowspan="2" scope="col">Operation</th>

							<th height="26" colspan="8" scope="col">Machining Data</th>
						</tr>
						<tr bgcolor="#CCCCCC">
							<th width="9%" height="16" scope="col"><b>Machine Used</b></th>
							<th width="7%" scope="col"><b>CT Sec</b></th>
							<th width="9%" scope="col"><b>MC's Used</b></th>
							<th width="7%" scope="col"><b>Prod / Shift</b></th>
							<th width="12%" scope="col"><b>MC Reqd.</b></th>
							<th width="12%" scope="col"><b> <b>MC Availability</b> <br />
							</b></th>
							<th width="8%" scope="col">Edit</th>
							<th width="8%" height="16" scope="col">Add New</th>
						</tr>

						<%
							while (rs_getOpnAndOpnnoId.next()) {

										sr_no1 = sr_no1 + 1;
						%>
						<tr>

							<td><%=sr_no1%></td>
							<%
								PreparedStatement ps_getOpnIds = con
													.prepareStatement("select opnno_id,opn_id from dev_opn_opnno_rel_tbl where OpnNo_Opn_Rel_Id="
															+ rs_getOpnAndOpnnoId
																	.getInt("OpnNo_Opn_Rel_Id"));
											ResultSet rs_getOpnIds = ps_getOpnIds.executeQuery();
											while (rs_getOpnIds.next()) {
												opnno_id = rs_getOpnIds.getInt("opnno_id");
												opn_id = rs_getOpnIds.getInt("opn_id");

												PreparedStatement ps_getOpnNo = con
														.prepareStatement("select opn_no from dev_operation_no_mst_tbl where opnno_id="
																+ rs_getOpnIds.getInt("opnno_id"));
												ResultSet rs_getOpnNo = ps_getOpnNo.executeQuery();
												while (rs_getOpnNo.next()) {
							%>

							<td><%=rs_getOpnNo.getInt("Opn_no")%></td>
							<%
								}
												PreparedStatement ps_getOpn = con
														.prepareStatement("select operation from dev_operation_mst_tbl where opn_id="
																+ rs_getOpnIds.getInt("opn_id"));
												ResultSet rs_getOpn = ps_getOpn.executeQuery();
												while (rs_getOpn.next()) {
							%>


							<td><%=rs_getOpn.getString("operation")%></td>
							<%
								}
											}
							%>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td><input type="button" name="Submit24" value="Edit"
								onclick="openPage('Add_Machining.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
							<td><input type="button" name="Submit2" value="New"
								onclick="openPage('Add_Machining.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
						</tr>

						<%
							}
						%>
					</table>

					<%
						}
					%>

				</div>
				<div id="tabs-3">

					<%
						rs_getOpnAndOpnnoId.last();
							System.out.println("Get fetch size = "
									+ rs_getOpnAndOpnnoId.getRow());
							int ch = rs_getOpnAndOpnnoId.getRow();
							rs_getOpnAndOpnnoId.beforeFirst();

							if (ch > 0) {
					%>

					<table width="953" border="1" class="gridtable">

						<tr bgcolor="#CCCCCC">
							<th width="4%" height="33" rowspan="2" scope="col">Sr. No</th>
							<th width="4%" height="33" rowspan="2" scope="col">Op No.</th>
							<th width="16%" height="33" rowspan="2" scope="col">Operation</th>

							<th height="26" colspan="6" scope="col">Machining Data</th>
							<th height="26" colspan="8" scope="col">Fixture</th>
						</tr>
						<tr bgcolor="#CCCCCC">
							<th width="7%" height="16" scope="col"><b>Machine Used</b></th>
							<th width="3%" scope="col"><b>CT Sec</b></th>
							<th width="4%" scope="col"><b>MC's Used</b></th>
							<th width="5%" scope="col"><b>Prod / Shift</b></th>
							<th width="6%" scope="col"><b>MC Reqd.</b></th>
							<th width="9%" scope="col"><b><span
									style="font-size: 14px;"><b>MC Availability</b></span><br /> </b></th>
							<th width="9%" scope="col">Fixture list</th>
							<th width="6%" scope="col">Fixture No</th>
							<th width="8%" scope="col">Quotation Date</th>
							<th width="8%" scope="col">PO Date</th>
							<th width="8%" scope="col"><b>Target Receipt Date</b></th>
							<th width="7%" scope="col"><b>Actual Receipt Date</b></th>
							<th width="6%" scope="col"><b>Edit</b></th>
							<th width="6%" scope="col">New</th>
						</tr>

						<%
							while (rs_getOpnAndOpnnoId.next()) {

										sr_no2 = sr_no2 + 1;
						%>
						<tr>

							<td><%=sr_no2%></td>
							<%
								PreparedStatement ps_getOpnIds = con
													.prepareStatement("select opnno_id,opn_id from dev_opn_opnno_rel_tbl where OpnNo_Opn_Rel_Id="
															+ rs_getOpnAndOpnnoId
																	.getInt("OpnNo_Opn_Rel_Id"));
											ResultSet rs_getOpnIds = ps_getOpnIds.executeQuery();
											while (rs_getOpnIds.next()) {
												opnno_id = rs_getOpnIds.getInt("opnno_id");
												opn_id = rs_getOpnIds.getInt("opn_id");

												PreparedStatement ps_getOpnNo = con
														.prepareStatement("select opn_no from dev_operation_no_mst_tbl where opnno_id="
																+ rs_getOpnIds.getInt("opnno_id"));
												ResultSet rs_getOpnNo = ps_getOpnNo.executeQuery();
												while (rs_getOpnNo.next()) {
							%>

							<td><%=rs_getOpnNo.getInt("Opn_no")%></td>
							<%
								}
												PreparedStatement ps_getOpn = con
														.prepareStatement("select operation from dev_operation_mst_tbl where opn_id="
																+ rs_getOpnIds.getInt("opn_id"));
												ResultSet rs_getOpn = ps_getOpn.executeQuery();
												while (rs_getOpn.next()) {
							%>

							<td><%=rs_getOpn.getString("operation")%></td>

							<%
								}
											}
							%>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td><input type="button" name="Submit223" value="Edit"
								onclick="openPage('Add_Fixtures.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
							<td><input type="button" name="Submit22" value="New"
								onclick="openPage('Add_Fixtures.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
						</tr>

						<%
							}
						%>
					</table>

					<%
						}
					%>


				</div>


				<div id="tabs-4">


					<%
						rs_getOpnAndOpnnoId.last();
							System.out.println("Get fetch size = "
									+ rs_getOpnAndOpnnoId.getRow());
							int mb5 = rs_getOpnAndOpnnoId.getRow();
							rs_getOpnAndOpnnoId.beforeFirst();

							if (mb5 > 0) {
					%>

					<table width="953" border="1" class="gridtable">

						<tr bgcolor="#CCCCCC">
							<th width="4%" height="33" rowspan="2" scope="col">Sr. No</th>
							<th width="4%" height="33" rowspan="2" scope="col">Op No.</th>
							<th width="16%" height="33" rowspan="2" scope="col">Operation</th>
							<th height="30" colspan="6" scope="col">Fixture</th>
							<th height="30" colspan="12" scope="col">Cutting tools</th>
						</tr>
						<tr bgcolor="#CCCCCC">
							<th width="6%" scope="col">Fixture list</th>
							<th width="6%" scope="col">Fixture No</th>
							<th width="9%" scope="col">Quotation Date</th>
							<th width="8%" scope="col">PO Date</th>
							<th width="9%" scope="col"><b>Target Receipt Date</b></th>
							<th width="8%" scope="col"><b>Actual Receipt Date</b></th>
							<th width="5%" scope="col">Cutting Tool List</th>
							<th width="6%" scope="col"><b>Tool Qty</b></th>
							<th width="7%" scope="col"><b>PO Date</b></th>
							<th width="8%" scope="col"><b>Tool Target Date</b></th>
							<th width="8%" scope="col"><b>Tool Recpt Date</b></th>
							<th width="6%" scope="col">Edit</th>
							<th width="6%" scope="col">New</th>
						</tr>

						<%
							while (rs_getOpnAndOpnnoId.next()) {

										sr_no3 = sr_no3 + 1;
						%>
						<tr>

							<td><%=sr_no3%></td>
							<%
								PreparedStatement ps_getOpnIds = con
													.prepareStatement("select opnno_id,opn_id from dev_opn_opnno_rel_tbl where OpnNo_Opn_Rel_Id="
															+ rs_getOpnAndOpnnoId
																	.getInt("OpnNo_Opn_Rel_Id"));
											ResultSet rs_getOpnIds = ps_getOpnIds.executeQuery();
											while (rs_getOpnIds.next()) {
												opnno_id = rs_getOpnIds.getInt("opnno_id");
												opn_id = rs_getOpnIds.getInt("opn_id");

												PreparedStatement ps_getOpnNo = con
														.prepareStatement("select opn_no from dev_operation_no_mst_tbl where opnno_id="
																+ rs_getOpnIds.getInt("opnno_id"));
												ResultSet rs_getOpnNo = ps_getOpnNo.executeQuery();
												while (rs_getOpnNo.next()) {
							%>

							<td><%=rs_getOpnNo.getInt("Opn_no")%></td>
							<%
								}
												PreparedStatement ps_getOpn = con
														.prepareStatement("select operation from dev_operation_mst_tbl where opn_id="
																+ rs_getOpnIds.getInt("opn_id"));
												ResultSet rs_getOpn = ps_getOpn.executeQuery();
												while (rs_getOpn.next()) {
							%>

							<td><%=rs_getOpn.getString("operation")%></td>

							<%
								}
											}
							%>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td><input type="button" name="Submit2222" value="Edit"
								onclick="openPage('Add_Cutting_Tools.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
							<td><input type="button" name="Submit222" value="New"
								onclick="openPage('Add_Cutting_Tools.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
						</tr>

						<%
							}
						%>
					</table>

					<%
						}
					%>


				</div>
				<div id="tabs-5">


					<%
						rs_getOpnAndOpnnoId.last();
							System.out.println("Get fetch size = "
									+ rs_getOpnAndOpnnoId.getRow());
							int cn = rs_getOpnAndOpnnoId.getRow();
							rs_getOpnAndOpnnoId.beforeFirst();

							if (cn > 0) {
					%>

					<table width="953" border="1" class="gridtable">

						<tr bgcolor="#CCCCCC">
							<th width="4%" height="33" rowspan="2" scope="col">Sr. No</th>
							<th width="4%" height="33" rowspan="2" scope="col">Op No.</th>
							<th width="16%" height="33" rowspan="2" scope="col">Operation</th>
							<th height="30" colspan="5" scope="col">Cutting tools</th>
							<th height="30" colspan="12" scope="col">Gauges</th>

						</tr>
						<tr bgcolor="#CCCCCC">
							<th width="5%" scope="col">Cutting Tool List</th>
							<th width="6%" scope="col"><b>Tool Qty</b></th>
							<th width="7%" scope="col"><b>PO Date</b></th>
							<th width="8%" scope="col"><b>Tool Target Date</b></th>
							<th width="8%" scope="col"><b>Tool Recpt Date</b></th>


							<th width="6%" scope="col">Gauge No</th>
							<th width="6%" scope="col">Gauge list</th>
							<th width="9%" scope="col">Qty</th>
							<th width="8%" scope="col">Customer approval</th>
							<th width="9%" scope="col"><b>Gauges PO Date</b></th>
							<th width="8%" scope="col"><b>Gauge Tgt Date</b></th>
							<th width="8%" scope="col"><b>Gauge Recpt Date</b></th>
							<th width="6%" scope="col">Edit</th>
							<th width="6%" scope="col">New</th>
						</tr>

						<%
							while (rs_getOpnAndOpnnoId.next()) {

										sr_no4 = sr_no4 + 1;
						%>
						<tr>

							<td><%=sr_no4%></td>
							<%
								PreparedStatement ps_getOpnIds = con
													.prepareStatement("select opnno_id,opn_id from dev_opn_opnno_rel_tbl where OpnNo_Opn_Rel_Id="
															+ rs_getOpnAndOpnnoId
																	.getInt("OpnNo_Opn_Rel_Id"));
											ResultSet rs_getOpnIds = ps_getOpnIds.executeQuery();
											while (rs_getOpnIds.next()) {
												opnno_id = rs_getOpnIds.getInt("opnno_id");
												opn_id = rs_getOpnIds.getInt("opn_id");

												PreparedStatement ps_getOpnNo = con
														.prepareStatement("select opn_no from dev_operation_no_mst_tbl where opnno_id="
																+ rs_getOpnIds.getInt("opnno_id"));
												ResultSet rs_getOpnNo = ps_getOpnNo.executeQuery();
												while (rs_getOpnNo.next()) {
							%>

							<td><%=rs_getOpnNo.getInt("Opn_no")%></td>
							<%
								}
												PreparedStatement ps_getOpn = con
														.prepareStatement("select operation from dev_operation_mst_tbl where opn_id="
																+ rs_getOpnIds.getInt("opn_id"));
												ResultSet rs_getOpn = ps_getOpn.executeQuery();
												while (rs_getOpn.next()) {
							%>

							<td><%=rs_getOpn.getString("operation")%></td>

							<%
								}
											}
							%>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td><input type="button" name="Submit2222" value="Edit"
								onclick="openPage('Add_Gauges.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
							<td><input type="button" name="Submit222" value="New"
								onclick="openPage('Add_Gauges.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
						</tr>

						<%
							}
						%>
					</table>

					<%
						}
					%>


				</div>
				<div id="tabs-6">



					<%
						rs_getOpnAndOpnnoId.last();
							System.out.println("Get fetch size = "
									+ rs_getOpnAndOpnnoId.getRow());
							int mb4 = rs_getOpnAndOpnnoId.getRow();
							rs_getOpnAndOpnnoId.beforeFirst();

							if (mb4 > 0) {
								while (rs_getOpnAndOpnnoId.next()) {

									PreparedStatement ps_OpnIds = con
											.prepareStatement("select opnno_id,opn_id from dev_opn_opnno_rel_tbl where OpnNo_Opn_Rel_Id="
													+ rs_getOpnAndOpnnoId
															.getInt("OpnNo_Opn_Rel_Id"));
									ResultSet rs_OpnIds = ps_OpnIds.executeQuery();
									while (rs_OpnIds.next()) {
										opnno_id = rs_OpnIds.getInt("opnno_id");
										opn_id = rs_OpnIds.getInt("opn_id");

										PreparedStatement ps_OpnNo = con
												.prepareStatement("select opn_no from dev_operation_no_mst_tbl where opnno_id="
														+ rs_OpnIds.getInt("opnno_id"));
										ResultSet rs_OpnNo = ps_OpnNo.executeQuery();

									}
								}
					%>
					<table width="770" border="1" class="gridtable">

						<tr bgcolor="#CCCCCC">
							<th width="6%" height="33" rowspan="2" scope="col">Sr. No</th>
							<th width="6%" height="33" rowspan="2" scope="col">Op No.</th>
							<th width="16%" height="33" rowspan="2" scope="col">Operation</th>
							<th height="26" colspan="8" scope="col">Machining Data</th>
						</tr>
						<tr bgcolor="#CCCCCC">
							<th width="9%" height="16" scope="col"><b>Machine Used</b></th>
							<th width="7%" scope="col"><b>CT Sec</b></th>
							<th width="9%" scope="col"><b>MC's Used</b></th>
							<th width="7%" scope="col"><b>Prod / Shift</b></th>
							<th width="12%" scope="col"><b>MC Reqd.</b></th>
							<th width="12%" scope="col"><b> <b>MC Availability</b> <br />
							</b></th>
							<th width="8%" scope="col">Edit</th>
							<th width="8%" height="16" scope="col">Add New</th>
						</tr>

						<%
							while (rs_getOpnAndOpnnoId.next()) {

										sr_no1 = sr_no1 + 1;
						%>
						<tr>

							<td><%=sr_no1%></td>
							<%
								PreparedStatement ps_getOpnIds = con
													.prepareStatement("select opnno_id,opn_id from dev_opn_opnno_rel_tbl where OpnNo_Opn_Rel_Id="
															+ rs_getOpnAndOpnnoId
																	.getInt("OpnNo_Opn_Rel_Id"));
											ResultSet rs_getOpnIds = ps_getOpnIds.executeQuery();
											while (rs_getOpnIds.next()) {
												opnno_id = rs_getOpnIds.getInt("opnno_id");
												opn_id = rs_getOpnIds.getInt("opn_id");

												PreparedStatement ps_getOpnNo = con
														.prepareStatement("select opn_no from dev_operation_no_mst_tbl where opnno_id="
																+ rs_getOpnIds.getInt("opnno_id"));
												ResultSet rs_getOpnNo = ps_getOpnNo.executeQuery();
												while (rs_getOpnNo.next()) {
							%>

							<td><%=rs_getOpnNo.getInt("Opn_no")%></td>
							<%
								}
												PreparedStatement ps_getOpn = con
														.prepareStatement("select operation from dev_operation_mst_tbl where opn_id="
																+ rs_getOpnIds.getInt("opn_id"));
												ResultSet rs_getOpn = ps_getOpn.executeQuery();
												while (rs_getOpn.next()) {
							%>


							<td><%=rs_getOpn.getString("operation")%></td>
							<%
								}
											}
							%>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td><input type="button" name="Submit24" value="Edit"
								onclick="openPage('Add_Machining.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
							<td><input type="button" name="Submit2" value="New"
								onclick="openPage('Add_Machining.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>')" /></td>
						</tr>

						<%
							}
						%>
					</table>

					<%
						}
					%>





				</div>



			</div>




			<table width="35%">

				<tr onMouseOver="ChangeColor(this, true);"
					onmouseout="ChangeColor(this, false);" onClick="button1('');"
					style="cursor: pointer">
					<td width="22%"><input type="button" name="approval"
						value="Send it for Approval"
						onclick="addTrial('1','<%=basic_id%>');" /> <input type="hidden"
						id="Basic_Id" name="Basic_Id"></td>

					<td width="26%"><textarea name="textarea">Approval Pending</textarea></td>

					<td width="52%"><input type="button" name="Add_Trial"
						value="Add Trials" onClick="addTrial('2','<%=basic_id%>');" /></td>
				</tr>

			</table>



		</form>

		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
	</div>

	<div id="accordion" class="templatemo_section_2">
		<h3>New Sheet</h3>
		<div>
			<a href="NewSheet.jsp">New DVP Sheet</a>
		</div>
		<h3>Update Sheets</h3>
		<div>
			<a href="Activity_Sheet.jsp">Stage 1</a><br /> <a
				href="Activity_Sheet.jsp">Stage 2</a><br /> <a
				href="Activity_Sheet.jsp">Stage 3</a><br /> <a
				href="Activity_Sheet.jsp">Stage 4</a>
		</div>
	</div>




	<!-- ----------------------------------------------------------------------------------------------- -->


	<div id="templatemo_content_wrapper">
		<div id="templatemo_content">

			<div id="column_w530">



				<div class="cleaner"></div>
			</div>


			<div class="cleaner"></div>
		</div>
		<!-- end of content wrapper -->
	</div>
	<!-- end of content wrapper -->

	<div id="templatemo_footer_wrapper">

		<div id="templatemo_footer"></div>
		<!-- end of footer -->


	</div>


</body>
</html>