<%@page import="java.util.ArrayList"%>
<%@page import="com.muthagroup.bo.Get_UName_bo"%>
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
<title>My Approval Status</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/tab.css" />
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
<script>
$(function() {
$( "#menu" ).menu();
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
function ApprovalMsg(val) {	
	var remark=document.getElementById("appRemark");
	var form=document.getElementById("appaction");
	if(remark.value=="" || remark.value==null){
		alert("Remark ???");
	
	}else{	
		var val1 = val;
		//alert(val1);
		var e1 = document.getElementById("getApBtn");
		e1.setAttribute('disabled', 'disabled');
		document.getElementById("sheetNo").value = val1;
		// var loading = document.getElementById ( "imageLoading" ) ;
		// loading.style.visibility = "visible" ;
		form.submit();		
	}
}
	</SCRIPT>
<style type="text/css">
.tftable {
	font-size: 12px;
	color: #333333;
	width: 100%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
	text-align: left;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 12px;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #729ea5;
}
</style>

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

<script type="text/javascript" src="js/highslide.js"></script>
<link rel="stylesheet" type="text/css" href="css/highslide.css" />

<script type="text/javascript">
	hs.graphicsDir = 'graphics/';
	hs.outlineType = null;
	hs.wrapperClassName = 'colored-border';
</script>

</head>
<body style="background: #e3e3e3;">
	<div id="templatemo_header_wrapper">
		<!--  Free Web Templates by TemplateMo.com  -->
		<div id="templatemo_header">

			<!-- 	<div id="site_logo"></div> --> 
				<% 
				String User_Name = null;
				int uid = Integer.parseInt(session.getAttribute("uid").toString());
				Get_UName_bo bo = new Get_UName_bo();
				User_Name = bo.get_UName(uid);
				%> 
			<div id="templatemo_menu">
				<div id="templatemo_menu_left"></div>
				<ul>
					<li><a href="Home.jsp" class="current"  style="font-size: 12px;">HOME</a></li>
					<li><a href="All_DVPSheets.jsp"  style="font-size: 12px;">ALL SHEETS</a></li>
					<li><a href="EditSheet.jsp"  style="font-size: 12px;">EDIT SHEETS</a></li>
					<li><a href="Approval_Requests.jsp"  style="font-size: 12px;">REQUESTS</a></li> 
					<li><a href="MOM_Sheet.jsp" style="font-size: 12px;">DVP MOM</a></li>
					<!-- <li><a href="#"  style="font-size: 12px;">REPORTS</a></li> -->
					<li><a href="Search.jsp"  style="font-size: 12px;">SEARCH</a></li>
					<li><a href="Logout.jsp" class="last"  style="font-size: 12px;">LOG OUT (<b><%=User_Name%></b>)
					</a></li>
					<li><img alt="Mutha Group" src="images/logo.jpg" align="middle"/></li>
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
		int basic_id = 0, rows = 0, gr = 0;
		int plant_id = 0, PlantVendor = 0;
		int cast_id = 0, castVendor = 0, mcDataId = 0; 
		if (request.getParameter("hid") != null) {
			basic_id = Integer.parseInt(request.getParameter("hid"));
		}
	%>
	<div class="templatemo_section_1">

		<form action=" " class="register" method="post" id="myForm"
			name="myForm" onsubmit="return(validate());">

			<%
				try {

					Connection con = Connection_Utility.getConnection();
			%>
					<table border="1" class="tftable">
				<%
					PreparedStatement ps_getBasicInfo = con
								.prepareStatement("select * from dev_basicinfo_tbl where Basic_id="
										+ basic_id);
						ResultSet rs_getBasicInfo = ps_getBasicInfo.executeQuery();
						while (rs_getBasicInfo.next()) {
				%>
				<tr style="background-color: #CDCFC8" align="center">
					<th scope="col">S.No</th>
					<th scope="col">Customer</th>
					<th scope="col">Part Name</th>
					<th scope="col">Part No</th>
					<th scope="col">Project Lead</th>
					<th scope="col">Machining From</th>
					<th scope="col">Machining Vendor</th>
					<th scope="col">Casting From</th>
					<th scope="col">Casting Vendor</th>
					<th scope="col">Related Person</th>
					<th scope="col">Revision No</th>
					<th scope="col">Revision Date</th>
					<th scope="col">Start Date (Planned)</th>
				</tr>
				<tr>
				<tr align="center">
					<td align="center"><%=basic_id%></td>

					<%
						PreparedStatement ps_getCustName = con
										.prepareStatement("select Cust_Name from customer_tbl where Cust_Id="
												+ rs_getBasicInfo.getInt("Cust_Id"));
								ResultSet rs_getCustName = ps_getCustName.executeQuery();
								while (rs_getCustName.next()) {
					%>
					<td align="center"><%=rs_getCustName.getString("Cust_Name")%></td>
					<%
						}
								PreparedStatement ps_getPartName = con
										.prepareStatement("select Part_Name from cs_part_name_tbl where PartName_Id="
												+ rs_getBasicInfo.getInt("PartName_Id"));
								ResultSet rs_getPartName = ps_getPartName.executeQuery();
								while (rs_getPartName.next()) {
					%>
					<td align="center"><%=rs_getPartName.getString("Part_Name")%></td>
					<%
						}

								PreparedStatement ps_getPartNo = con
										.prepareStatement("select Part_no from cs_part_no_tbl where PartNo_Id="
												+ rs_getBasicInfo.getInt("PartNo_Id"));
								ResultSet rs_getPartNo = ps_getPartNo.executeQuery();

								while (rs_getPartNo.next()) {
					%>
					<td align="center"><%=rs_getPartNo.getString("Part_No")%></td>
					<%
						}
								PreparedStatement ps_getProjectLead = con
										.prepareStatement("select Project_Lead from dev_basic_projectlead_rel_tbl where basic_id="
												+ basic_id);
								ResultSet rs_getProjectLead = ps_getProjectLead
										.executeQuery();

								while (rs_getProjectLead.next()) {
									PreparedStatement ps_getUName = con
											.prepareStatement("select U_Name from User_Tbl where U_Id="
													+ rs_getProjectLead
															.getInt("Project_Lead"));
									ResultSet rs_getUName = ps_getUName.executeQuery();
									while (rs_getUName.next()) {
					%>

					<td align="center"><%=rs_getUName.getString("U_Name")%></td>

					<%
						}
								}

								PreparedStatement ps_plant = con
										.prepareStatement("select Plant_Id from  dev_basic_plant_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_plant = ps_plant.executeQuery();
								while (rs_plant.next()) {
									plant_id = rs_plant.getInt("Plant_Id");
								}

								
								if (plant_id != 0) {
					%>
					<%
						PreparedStatement ps_plantId = con
											.prepareStatement("select Company_Name from user_tbl_company where Company_Id="
													+ plant_id);
									ResultSet rs_plantId = ps_plantId.executeQuery();
									while (rs_plantId.next()) {
					%>

					<td><%=rs_plantId.getString("Company_Name")%></td>

					<%
						}
					}
					 else
					 {
					%>
					<td>&nbsp;</td>
					<%
						}
					//--------------------------------------------------------------------------------------------------------------------------------------
								PreparedStatement machinVend = con
										.prepareStatement("select * from dev_basic_plantvendor_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_machinVend = machinVend.executeQuery();
								rs_machinVend.last();
								int vd = rs_machinVend.getRow();
								rs_machinVend.beforeFirst();

								if (vd > 0) {

									while (rs_machinVend.next()) {

										PreparedStatement ps_plantvd = con
												.prepareStatement("select * from dev_plantvendor_tbl where plantvendor_id="
														+ rs_machinVend
																.getInt("plantvendor_id"));
										ResultSet rs_plantvd = ps_plantvd.executeQuery();
										while (rs_plantvd.next()) {
					%>

					<td><%=rs_plantvd
										.getString("plantvendor_name")%></td>
					<%
						}

									}
								} else {
					%>
					<td>&nbsp;</td>
					<%
						}
					%>


					<%
						//--------------------------------------------------------------------------------------------------------------------------------------
					%>
					<%
						PreparedStatement ps_cast = con
										.prepareStatement("select * from dev_basic_casting_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_cast = ps_cast.executeQuery();
								while (rs_cast.next()) 
								{
									cast_id = rs_cast.getInt("Casting_From_Id");
								}

								PreparedStatement ps_castVendor = con
										.prepareStatement("select * from dev_basic_castingvendor_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_castVendor = ps_castVendor.executeQuery();
								while (rs_castVendor.next()) 
								{
									castVendor = rs_castVendor.getInt("CastingVendor_Id");
								}
								System.out.println("casting from = " + cast_id
										+ " Casting Vendor =" + castVendor);
								if (cast_id != 0) {

									PreparedStatement ps_castingFrom = con
											.prepareStatement("select * from user_tbl_company where Company_Id="
													+ cast_id);
									ResultSet rs_castingFrom = ps_castingFrom
											.executeQuery();
									while (rs_castingFrom.next()) {
					%>
					<td><%=rs_castingFrom.getString("Company_Name")%></td>
					<%
						}
								} else {

								%>
								<td>&nbsp;</td>
								<%	

								}
					%>
					<%
						//---------------------------------------------------------------------------------------------------------------------
								PreparedStatement ps_castVend = con
										.prepareStatement("select * from dev_basic_castingvendor_rel_tbl where Basic_Id="
												+ basic_id);
								ResultSet rs_castVend = ps_castVend.executeQuery();

								rs_castVend.last();
								int ctvd = rs_castVend.getRow();
								rs_castVend.beforeFirst();

								if (ctvd > 0) {
									while (rs_castVend.next()) {

										PreparedStatement p_castVendor = con
												.prepareStatement("select * from dev_castingvendor_tbl where castingvendor_id="
														+ rs_castVend
																.getInt("castingvendor_id"));
										ResultSet r_castVendor = p_castVendor
												.executeQuery();
										while (r_castVendor.next()) {
					%>

					<td><%=r_castVendor
										.getString("castingvendor_name")%></td>
					<%
						}

									}
								} else {
					%>
					<td>&nbsp;</td>
					<%
						}
								//---------------------------------------------------------------------------------------------------------------------
					%>

										<%
						String rPer = "";
								PreparedStatement ps_getRelatedPerson = con
										.prepareStatement("select Related_Person from dev_basic_relperson_rel_tbl where basic_Id="
												+ basic_id);
								ResultSet rs_getRealtedPerson = ps_getRelatedPerson
										.executeQuery();

								rs_getRealtedPerson.last();
								int rtper = rs_getRealtedPerson.getRow();
								rs_getRealtedPerson.beforeFirst();

								while (rs_getRealtedPerson.next()) {
									System.out.println("Basic rel person = "
											+ rs_getRealtedPerson.getInt("Related_Person"));

									PreparedStatement ps_RelUName = con
											.prepareStatement("select * from user_tbl where U_Id="
													+ rs_getRealtedPerson
															.getInt("Related_Person"));
									ResultSet rs_RelUName = ps_RelUName.executeQuery();
									while (rs_RelUName.next()) {
										rPer = rs_RelUName.getString("U_Name");
									}
								}
					%>
					<td align="center"><%=rPer%></td>

					<td align="center"><%=rs_getBasicInfo.getString("Revision_No")%></td>
					<td align="center"><%=rs_getBasicInfo.getDate("Revision_Date")%></td>

					<td align="center"><%=rs_getBasicInfo.getDate("Planned_Start_Date")%></td>
				</tr>
				<tr style="background-color: #acc8cc" align="center">
					<td scope="col"><strong>End Date (Planned) </strong></td>
					<td><strong>Start Date (Actual) </strong></td>
					<td><strong>End Date (Actual) </strong></td>
					<td scope="col"><strong>Marketing<br /> Approval
					</strong></td>
					<td scope="col"><strong>Schedule/<br /> Month
					</strong></td>
					<td scope="col"><strong>PO No</strong></td>
					<td scope="col"><strong>PO Date <br />
					</strong></td>
					<td scope="col"><strong>PO Received<br />
							(Development)<br />
					</strong></td>
					<td><strong>Part Image</strong></td>
					<td scope="col"><strong>PO(Customer)</strong></td>
					<td scope="col"><strong>2d Drawing</strong></td>
					<td scope="col"><strong>3d Drawing</strong></td>
					<td scope="col"><strong>Other</strong></td>
				</tr>
				<tr align="center">
					<td align="center"><%=rs_getBasicInfo.getDate("Planned_End_Date")%></td>

					<%
						if (rs_getBasicInfo.getDate("Actual_Start_Date") == null) {
					%>
					<td colspan="1"></td>
					<%
						} else {
					%>
					<td><%=rs_getBasicInfo.getDate("Actual_Start_Date")%></td>
					<%
						}

								if (rs_getBasicInfo.getDate("Actual_End_Date") == null) {
					%>
					<td colspan="1"></td>
					<%
						} else {
					%>
					<td><%=rs_getBasicInfo.getDate("Actual_End_Date")%></td>
					<%
						}
					%>


					<td><%=rs_getBasicInfo.getString("Mkt_Approval")%></td>
					<td><%=rs_getBasicInfo.getInt("Schedule_Per_Month")%></td>
					<td><%=rs_getBasicInfo.getString("PO_No_From_Cust")%></td>
					<td><%=rs_getBasicInfo.getDate("PO_Date_From_Cust")%></td>
					<td><%=rs_getBasicInfo.getDate("PO_Rcvd_At_Dev_Date")%></td>


					<%
						PreparedStatement ps_partImage = con
										.prepareStatement("select PartNo_Id from cs_part_no_tbl where PartNo_Id="
												+ rs_getBasicInfo.getInt("PartNo_Id"));
								ResultSet rs_partImage = ps_partImage.executeQuery();
								while (rs_partImage.next()) {
									PreparedStatement ps_partImageName = con
											.prepareStatement("select * from dev_partno_photo_tbl where partno_id="
													+ rs_partImage.getInt("PartNo_Id"));
									ResultSet rs_partImageName = ps_partImageName
											.executeQuery();
					%>
					<td>
						<%
							while (rs_partImageName.next()) {
						%><img src="PartImageView.jsp?field=<%=rs_partImageName.getInt("part_photo_id")%>" alt="No Image" title="Click to enlarge" height="70" width="70" onclick="return hs.expand(this)"  style="cursor:pointer"/>
						<%
							}
						%>
					</td>
					<%
						PreparedStatement ps_AttachedPO = con
											.prepareStatement("select * from dev_basicinfo_po_attachment_tbl where Basic_Id="
													+ rs_getBasicInfo.getInt("Basic_Id"));
									ResultSet rs_AttachPO = ps_AttachedPO.executeQuery();
					%>
					<td>
						<%
							while (rs_AttachPO.next()) {
						%> <a
						href="Display_AttachedPO.jsp?field=<%=rs_AttachPO.getInt("BI_PO_Attach_Id")%>"><%=rs_AttachPO.getString("file_name")%></a>

						<%
							}
						%>
					</td>


					<%
						PreparedStatement ps_2Ddrawing = con
											.prepareStatement("select * from dev_2d_drawing_attachment where Basic_Id="
													+ rs_getBasicInfo.getInt("Basic_Id"));
									ResultSet rs_2Ddrawing = ps_2Ddrawing.executeQuery();
					%>
					<td>
						<%
							while (rs_2Ddrawing.next()) {
						%> <a
						href="Display_2Ddrawing.jsp?field=<%=rs_2Ddrawing
									.getInt("2D_drawing_attach_id")%>"><%=rs_2Ddrawing.getString("file_name")%></a>

						<%
							}
						%>
					</td>

					<%
						PreparedStatement ps_3Ddrawing = con
											.prepareStatement("select * from dev_3d_drawing_attachment_tbl where Basic_Id="
													+ rs_getBasicInfo.getInt("Basic_Id"));
									ResultSet rs_3Ddrawing = ps_3Ddrawing.executeQuery();
					%>
					<td>
						<%
							while (rs_3Ddrawing.next()) {
						%> <a
						href="Display_3Ddrawing.jsp?field=<%=rs_3Ddrawing
									.getInt("3D_drawing_attach_id")%>"><%=rs_3Ddrawing.getString("file_name")%></a>
						<%
							}
						%>
					</td>



					<%
						PreparedStatement ps_otherImages = con
											.prepareStatement("select * from dev_other_attachement where Basic_Id="
													+ rs_getBasicInfo.getInt("Basic_Id"));
									ResultSet rs_otherImages = ps_otherImages
											.executeQuery();
					%>
					<td>
						<%
							while (rs_otherImages.next()) {
						%> <a
						href="Display_othetImages.jsp?field=<%=rs_otherImages.getInt("other_attach_id")%>"><%=rs_otherImages.getString("file_name")%></a>

						<%
							}
						%>
					</td>


				</tr>
				<%
					}
						}
				%>
			</table>
			
			
			<div id="tabs">
				<ul>
					<li><a href="#tabs-1">Process Flow</a></li>
					<li><a href="#tabs-2">Machining Data</a></li>
					<li><a href="#tabs-3">Fixtures</a></li>
					<li><a href="#tabs-4">Cutting tools</a></li>
					<li><a href="#tabs-5">Gauges</a></li>
					<li><a href="#tabs-6">Others</a></li>
					<li><a href="#tabs-7">Internal Material Movement</a></li>
					<li><a href="#tabs-8">Foundry Tooling</a></li>
				</ul>
				<div id="tabs-1">

					<%
						int sr_no = 0, sr_no1 = 0, sr_no2 = 0, sr_no3 = 0, sr_no4 = 0, sr_no5 = 0, sr_no6 = 0;
							int opnno_id = 0;
							int opn_id = 0;
							System.out.println("Basic Id === " + basic_id);

							PreparedStatement ps_getOpnAndOpnnoId = con
									.prepareStatement("select omst.operation,onmst.opn_no,orel.OpnNo_Opn_Rel_Id from dev_operation_mst_tbl omst,dev_operation_no_mst_tbl onmst,dev_opn_opnno_rel_tbl orel where"
											+ " omst.opn_id=orel.opn_id and onmst.opnno_id=orel.opnno_id and orel.OpnNo_Opn_Rel_Id in(select OpnNo_Opn_Rel_Id from dev_opnandopnno_basic_rel_tbl where basic_id="
											+ basic_id + ") order by onmst.opn_no");
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
							<th width="37%" height="33" scope="col">Operation Image (If
								Any)</th>
						<!--	<th width="40%" height="33" scope="col" colspan="2">Edit /
								New</th>
							 <th width="20%" height="33" scope="col">Add New</th> -->
						</tr>

						<%
							while (rs_getOpnAndOpnnoId.next()) {
										sr_no = sr_no + 1;
						%>
						<tr align="center">

							<td><%=sr_no%></td>
							<%
								/* PreparedStatement ps_getOpnIds = con
																																																																.prepareStatement("");
																																																														ResultSet rs_getOpnIds = ps_getOpnIds.executeQuery();
																																																														while (rs_getOpnIds.next()) { */
											//opnno_id = rs_getOpnIds.getInt("opnno_id");
											//opn_id = rs_getOpnIds.getInt("opn_id");

											/* PreparedStatement ps_getOpnNo = con
													.prepareStatement("select opn_no from dev_operation_no_mst_tbl where opnno_id="
															+ rs_getOpnIds.getInt("opnno_id"));
											ResultSet rs_getOpnNo = ps_getOpnNo.executeQuery();
											while (rs_getOpnNo.next()) { */
							%>

							<td><%=rs_getOpnAndOpnnoId.getInt("Opn_no")%></td>
							<%
								/* }
																																																															PreparedStatement ps_getOpn = con
																																																																	.prepareStatement("select operation from dev_operation_mst_tbl where opn_id="
																																																																			+ rs_getOpnIds.getInt("opn_id"));
																																																															ResultSet rs_getOpn = ps_getOpn.executeQuery();
																																																															while (rs_getOpn.next()) { */
							%>


							<td><%=rs_getOpnAndOpnnoId.getString("operation")%></td>
							<%
								PreparedStatement ps_im = con
													.prepareStatement("select * from dev_opopno_attachments_tbl where Enable_Id=1 and Opn_Basic_Id=(select Opn_Basic_Id from dev_opnandopnno_basic_rel_tbl where OpnNo_Opn_Rel_Id="
															+ rs_getOpnAndOpnnoId
																	.getInt("OpnNo_Opn_Rel_Id")
															+ ")");
											ResultSet rs_im = ps_im.executeQuery();
							%>
							<td>
								<%
									while (rs_im.next()) {
								%> <a
								href="OpImageView.jsp?field=<%=rs_im.getInt("dev_opopno_attach_id")%>"
								style="cursor: pointer"><%=rs_im.getString("file_name")%></a> <%
 	}
 				/* 	} */
 %>
							</td>

							<%--
							<td><input type="button" name="Submit232" value="Edit"
								onclick="openPage('Add_operation.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>&action=<%="Edit"%>')" />

								<input type="button" name="Submit23" value="New"
								onclick="openPage('Add_operation.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
								.getInt("OpnNo_Opn_Rel_Id")%>&action=<%="new"%>')" /></td> --%>
						</tr>

						<%
							}
						%>
					</table>


					<%
						} else {
								System.out.println("In else loop");
					%>
					<table width="25%" border="1" class="gridtable">
						<tr bgcolor="#CCCCCC">
							<th width="11%" height="33" scope="col">Sr. No</th>
							<th width="11%" height="33" scope="col">Op No.</th>
							<th width="12%" height="33" scope="col">Operation</th>
							<th width="37%" height="33" scope="col">Operation Image (If
								Any)</th>
						<!--	<th width="3%" height="33" scope="col" colspan="2">Add New</th>							 
							<th width="3%" height="33" scope="col">Add New</th> -->
						</tr>

						<tr>

							<td height="42">&nbsp;</td>

							<td>&nbsp;</td>
							<td>&nbsp;</td>

							<td>&nbsp;</td>
							<%-- 	<td><input type="button" name="Submit232" value="Edit"
								onclick="openPage('Add_operation.jsp?sheet_no=<%=basic_id%>&action=<%="Edit"%>')" /></td> 
							<td colspan="2"><input type="button" name="Submit23"
								value="New"
								onclick="openPage('Add_operation.jsp?sheet_no=<%=basic_id%>&action=<%="new"%>')" /></td>--%>
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

					<table width="900" border="1" class="gridtable">

						<tr bgcolor="#CCCCCC">
							<th width="4%" height="33" rowspan="2" scope="col">Sr. No</th>
							<th width="4%" height="33" rowspan="2" scope="col">Op No.</th>
							<th width="16%" height="33" rowspan="2" scope="col">Operation</th>
							<th height="26" colspan="8" scope="col">Machining Data</th>
						</tr>
						<tr bgcolor="#CCCCCC">
							<th width="9%" height="16" scope="col"><b>Machine Used</b></th>
							<th width="9%" height="16" scope="col"><b>Machine Code</b></th>
							<th width="7%" scope="col"><b>CT Sec</b></th>
							<th width="9%" scope="col"><b>MC's Used</b></th>
							<th width="7%" scope="col"><b>Prod / Shift</b></th>
							<th width="12%" scope="col"><b>MC Reqd.</b></th>
							<th width="12%" scope="col"><b> <b>MC Allocated</b> <br />
							</b></th>
						<%--	<th width="6%" scope="col" colspan="2">Edit / New</th>
								<th width="5%" height="16" scope="col">Add New</th> --%>
						</tr>

						<%
							while (rs_getOpnAndOpnnoId.next()) {

										sr_no1 = sr_no1 + 1;
						%>
						<tr align="center">

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

												PreparedStatement ps_getMCData = con
														.prepareStatement("select * from dev_mcdata_tbl where OpnNo_Opn_Rel_Id="
																+ rs_getOpnAndOpnnoId
																		.getInt("OpnNo_Opn_Rel_Id"));

												ResultSet rs_getMCData = ps_getMCData
														.executeQuery();
												rs_getMCData.last();
												int mcData = rs_getMCData.getRow();
												rs_getMCData.beforeFirst();
												if (mcData > 0) {
													while (rs_getMCData.next()) {

														PreparedStatement ps_machin = con
																.prepareStatement("select * from dev_machinename_mst_tbl where  machineName_id="
																		+ rs_getMCData
																				.getInt("machineName_id"));
														ResultSet rs_machin = ps_machin
																.executeQuery();
														while (rs_machin.next()) {
							%>
							<td><%=rs_machin
												.getString("machine_name")%></td>
							<%
								}
							%>
							<%
								String mcCode = "";
														PreparedStatement ps_mcd = con
																.prepareStatement("select machinecode from mt_machinecode_mst_tbl where machinecode_id="
																		+ rs_getMCData
																				.getDouble("machinecode_id"));
														ResultSet rs_mcd = ps_mcd.executeQuery();
														while (rs_mcd.next()) {
															mcCode = rs_mcd
																	.getString("machinecode");
														}
														ps_mcd.close();
														rs_mcd.close();
							%>
							<td><%=mcCode%></td>
							<td><%=rs_getMCData.getDouble("CT_sec")%></td>
							<td><%=rs_getMCData.getInt("MCs_Used")%></td>
							<td><%=rs_getMCData
											.getDouble("production_per_shift")%></td>
							<td><%=rs_getMCData
											.getDouble("MC_Required")%></td>
							<td><%=rs_getMCData
											.getDouble("MC_Allocated")%></td>
						<%--	<td colspan="2"><input type="button" name="Submit24"
								value="Edit"
								onclick="openPage('Add_Machining.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
											.getInt("OpnNo_Opn_Rel_Id")%>&action=<%="Edit"%> ')" /> --%>

								<%
									}
													} else {
								%>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>

							<%--<td colspan="2"><input type="button" name="Submit2"
								value="New"
								onclick="openPage('Add_Machining.jsp?sheet_no=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
										.getInt("OpnNo_Opn_Rel_Id")%>&action=<%="new"%>')" /></td> --%>
							<%
									} 
								}
							%>
						</tr>

						<%
							}
						%>
					</table>

					<%
						}
					%>
				</div>


				<!-- Machining data ends -->
				<!-- Fixture data -->

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
							<th width="6%" height="33" rowspan="2" scope="col">Operation</th>

							<th height="26" colspan="7" scope="col">Machining Data</th>
							<th height="26" colspan="11" scope="col">Fixture</th>
						</tr>
						<tr bgcolor="#CCCCCC">
							<th width="7%" height="16" scope="col"><b>Machine Used</b></th>
							<th width="6%" scope="col"><b>Machine Code</b></th>
							<th width="3%" scope="col"><b>CT Sec</b></th>
							<th width="4%" scope="col"><b>MC's Used</b></th>
							<th width="5%" scope="col"><b>Prod / Shift</b></th>
							<th width="6%" scope="col"><b>MC Reqd.</b></th>
							<th width="9%" scope="col"><b> MC Allocated</b> <br /></th>
							<th width="9%" scope="col">Fixture list</th>
							<th width="6%" scope="col">Fixture No</th>
							<th width="8%" scope="col">Fixture Reqd Qty</th>
							<th width="8%" scope="col">Fixture Avail Qty</th>
							<th width="8%" scope="col">Quotation Date</th>
							<th width="8%" scope="col">PO Date</th>
							<th width="8%" scope="col"><b>Target Receipt Date</b></th>
							<th width="7%" scope="col"><b>Actual Receipt Date</b></th>
						<!--	<th width="4%" scope="col" colspan="2"><b>Edit / New</b></th>
							 <th width="6%" scope="col">New</th> -->
						</tr>

						<%
							while (rs_getOpnAndOpnnoId.next()) {

										sr_no2 = sr_no2 + 1;
						%>
						<tr align="center">

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
							%>

							<td>
								<%
									while (rs_getOpnNo.next()) {
								%> <%=rs_getOpnNo.getInt("Opn_no")%> <%
 	}
 %>
							</td>
							<%
								PreparedStatement ps_getOpn = con
														.prepareStatement("select operation from dev_operation_mst_tbl where opn_id="
																+ rs_getOpnIds.getInt("opn_id"));
												ResultSet rs_getOpn = ps_getOpn.executeQuery();
							%>

							<td>
								<%
									while (rs_getOpn.next()) {
								%> <%=rs_getOpn.getString("operation")%> <%
 	}
 %>
							</td>

							<%
								PreparedStatement ps_getMCData = con
														.prepareStatement("select * from dev_mcdata_tbl where OpnNo_Opn_Rel_Id="
																+ rs_getOpnAndOpnnoId
																		.getInt("OpnNo_Opn_Rel_Id"));

												ResultSet rs_getMCData = ps_getMCData
														.executeQuery();

												rs_getMCData.last();
												int mcData = rs_getMCData.getRow();
												rs_getMCData.beforeFirst();

												if (mcData > 0) {
													while (rs_getMCData.next()) {
														mcData = rs_getMCData.getInt("mcdata_id");

														System.out.println("MC DATA " + mcData);
														PreparedStatement ps_machin = con
																.prepareStatement("select * from dev_machinename_mst_tbl where  machineName_id="
																		+ rs_getMCData
																				.getInt("machineName_id"));
														ResultSet rs_machin = ps_machin
																.executeQuery();
							%>
							<td>
								<%
									while (rs_machin.next()) {
								%> <%=rs_machin
												.getString("machine_name")%> <%
 	}
 %>
							</td>

							<%
								String mcCodeNm = "";
														PreparedStatement ps_mcd = con
																.prepareStatement("select machinecode from mt_machinecode_mst_tbl where machinecode_id="
																		+ rs_getMCData
																				.getDouble("machinecode_id"));
														ResultSet rs_mcd = ps_mcd.executeQuery();
														while (rs_mcd.next()) {
															mcCodeNm = rs_mcd
																	.getString("machinecode");
														}
														ps_mcd.close();
														rs_mcd.close();
							%>
							<td><%=mcCodeNm%></td>

							<td><%=rs_getMCData.getDouble("CT_sec")%></td>
							<td><%=rs_getMCData.getInt("MCs_Used")%></td>
							<td><%=rs_getMCData
											.getDouble("production_per_shift")%></td>
							<td><%=rs_getMCData
											.getDouble("MC_Required")%></td>
							<td><%=rs_getMCData
											.getDouble("MC_Allocated")%></td>

							<%
								PreparedStatement ps_getFixtureData = con
																.prepareStatement("select * from dev_fixturedata_tbl where mcdata_id="
																		+ rs_getMCData
																				.getInt("mcdata_id"));
														ResultSet rs_getFixtureData = ps_getFixtureData
																.executeQuery();

														rs_getFixtureData.last();
														int FxData = rs_getFixtureData.getRow();
														rs_getFixtureData.beforeFirst();
														if (FxData > 0) {

															while (rs_getFixtureData.next()) {

																PreparedStatement ps_getFRelId = con
																		.prepareStatement("select fixture_id,fixtureNo_id from dev_fixture_fixtureno_rel_tbl where fixt_fixtNo_rel_Id="
																				+ rs_getFixtureData
																						.getInt("fixt_fixtNo_rel_Id"));
																ResultSet rs_getFRelId = ps_getFRelId
																		.executeQuery();
																while (rs_getFRelId.next()) {
																	PreparedStatement ps_getFName = con
																			.prepareStatement("select Fixture_Name from dev_fixture_mst_tbl where Fixture_Id="
																					+ rs_getFRelId
																							.getInt("Fixture_Id"));
																	ResultSet rs_getFName = ps_getFName
																			.executeQuery();
																	while (rs_getFName.next()) {
																		System.out
																				.println("Testing in");
							%>
							<td width="2%"><%=rs_getFName
															.getString("Fixture_Name")%></td>
							<%
								}
																	rs_getFName.close();
																	ps_getFName.close();
																	PreparedStatement ps_getFNo = con
																			.prepareStatement("select Fixture_No from dev_fixture_no_mst_tbl where FixtureNo_Id="
																					+ rs_getFRelId
																							.getInt("FixtureNo_Id"));
																	ResultSet rs_getFNo = ps_getFNo
																			.executeQuery();
																	while (rs_getFNo.next()) {
							%>
							<td width="2%"><%=rs_getFNo
															.getString("Fixture_No")%></td>

							<%
								}
							%>

							<%
								rs_getFNo.close();
																	ps_getFNo.close();
																}
																rs_getFRelId.close();
																ps_getFRelId.close();
							%>

							<td width="3%"><%=rs_getFixtureData
													.getInt("fixture_qty")%></td>
							<td width="3%"><%=rs_getFixtureData
													.getInt("avail_qty")%></td>
							<td width="3%"><%=rs_getFixtureData
													.getDate("quotation_date")%></td>
							<td width="3%"><%=rs_getFixtureData
													.getDate("fixture_po_date")%></td>
							<td width="3%"><%=rs_getFixtureData
													.getDate("target_receipt_date")%></td>
							<td width="2%"><%=rs_getFixtureData
													.getDate("actual_receipt_date")%></td>


						<%--	<td width="4%" colspan="2"><input type="button"
								name="Submit223" value="Edit"
								onclick="openPage('Add_Fixtures.jsp?hid=<%=basic_id%>&mcdata_id=<%=mcData%>&relId=<%=rs_getOpnAndOpnnoId
													.getInt("OpnNo_Opn_Rel_Id")%>&action=<%="Edit"%>')" /></td> --%>
							<%
								}

														} else {
							%>

							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						<%--	<td width="5%" colspan="2"><input type="button"
								name="Submit22" value="New"
								onclick="openPage('Add_Fixtures.jsp?hid=<%=basic_id%>&mcdata_id=<%=mcData%>&relId=<%=rs_getOpnAndOpnnoId
												.getInt("OpnNo_Opn_Rel_Id")%>&action=<%="new"%>')" /></td> --%>
							<%
								}
							%>




							<%
								}
												} else {
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
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td> 
							<%
								}
							%>

							<%
								}
							%>
						</tr>

						<%
							}
						%>
					</table>

					<%
						}
					%>


				</div>

				<!-- Fixture data Ends-->


				<!-- Cutting Tools -->
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
							<th height="33" colspan="6" scope="col">Fixture</th>
							<th height="33" colspan="9" scope="col">Cutting tools</th>
						</tr>
						<tr bgcolor="#CCCCCC">
							<th width="6%" scope="col">Fixture list</th>
							<th width="6%" scope="col">Fixture No</th>
							<th width="9%" scope="col">Quotation Date</th>
							<th width="8%" scope="col">PO Date</th>
							<th width="9%" scope="col"><b>Target Receipt Date</b></th>
							<th width="8%" scope="col"><b>Actual Receipt Date</b></th>
							<th width="5%" scope="col">Cutting Tool List</th>
							<th width="6%" scope="col"><b>Reqd Tool Qty</b></th>
							<th width="6%" scope="col"><b>Avail Tool Qty</b></th>
							<th width="7%" scope="col"><b>PO Date</b></th>
							<th width="8%" scope="col"><b>Tool Target Date</b></th>
							<th width="8%" scope="col"><b>Tool Recpt Date</b></th>
						<!--	<th width="6%" scope="col" colspan="2">Edit / New</th>
							 <th width="6%" scope="col">New</th> -->
						</tr>

						<%
							while (rs_getOpnAndOpnnoId.next()) {

										sr_no3 = sr_no3 + 1;

										PreparedStatement ps_getcountMCDATA = con
												.prepareStatement("select * from dev_mcdata_tbl where OpnNo_Opn_Rel_Id="
														+ rs_getOpnAndOpnnoId
																.getInt("OpnNo_Opn_Rel_Id"));

										ResultSet rs_getcountMCdata = ps_getcountMCDATA
												.executeQuery();

										while (rs_getcountMCdata.next()) {
											PreparedStatement ps_getcountFixData = con
													.prepareStatement("select * from dev_fixturedata_tbl where mcdata_id="
															+ rs_getcountMCdata
																	.getInt("mcdata_id"));

											ResultSet rs_getcountFixData = ps_getcountFixData
													.executeQuery();
											while (rs_getcountFixData.next()) {

												PreparedStatement ps_getcountCTData = con
														.prepareStatement("select count(fd_id) from dev_cuttingtool_data_tbl where fd_id="
																+ rs_getcountFixData
																		.getInt("fd_id"));

												ResultSet rs_getcountCTData = ps_getcountCTData
														.executeQuery();
												while (rs_getcountCTData.next()) {
													rows = rs_getcountCTData
															.getInt("count(fd_id)");
												}
											}
										}
										System.out.println("sr no " + sr_no3 + " === " + rows);
						%>
						<tr align="center">

							<td rowspan=<%=rows + 1%>><%=sr_no3%></td>
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

							<td rowspan=<%=rows + 1%>><%=rs_getOpnNo.getInt("Opn_no")%></td>
							<%
								}
												PreparedStatement ps_getOpn = con
														.prepareStatement("select operation from dev_operation_mst_tbl where opn_id="
																+ rs_getOpnIds.getInt("opn_id"));
												ResultSet rs_getOpn = ps_getOpn.executeQuery();
												while (rs_getOpn.next()) {
							%>
							<td rowspan=<%=rows + 1%>><%=rs_getOpn.getString("operation")%></td>

							<%
								}

												PreparedStatement ps_getMCData = con
														.prepareStatement("select * from dev_mcdata_tbl where OpnNo_Opn_Rel_Id="
																+ rs_getOpnAndOpnnoId
																		.getInt("OpnNo_Opn_Rel_Id"));
												ResultSet rs_getMCData = ps_getMCData
														.executeQuery();
												rs_getMCData.last();
												int mCData = rs_getMCData.getRow();
												rs_getMCData.beforeFirst();

												if (mCData > 0) {
													while (rs_getMCData.next()) {
														PreparedStatement ps_getFixtureData = con
																.prepareStatement("select * from dev_fixturedata_tbl where mcdata_id="
																		+ rs_getMCData
																				.getInt("mcdata_id"));
														ResultSet rs_getFixtureData = ps_getFixtureData
																.executeQuery();
														rs_getFixtureData.last();
														int FxData1 = rs_getFixtureData.getRow();
														rs_getFixtureData.beforeFirst();
														if (FxData1 > 0) {
															while (rs_getFixtureData.next()) {
																PreparedStatement ps_getFRelId = con
																		.prepareStatement("select fixture_id,fixtureNo_id from	dev_fixture_fixtureno_rel_tbl where fixt_fixtNo_rel_Id="
																				+ rs_getFixtureData
																						.getInt("fixt_fixtNo_rel_Id"));
																ResultSet rs_getFRelId = ps_getFRelId
																		.executeQuery();
																while (rs_getFRelId.next()) {

																	PreparedStatement ps_getFName = con
																			.prepareStatement("select Fixture_Name from dev_fixture_mst_tbl where Fixture_Id="
																					+ rs_getFRelId
																							.getInt("Fixture_Id"));
																	ResultSet rs_getFName = ps_getFName
																			.executeQuery();
																	while (rs_getFName.next()) {
																		System.out
																				.println("Testing in");
							%>
							<td width="2%" rowspan=<%=rows + 1%>><%=rs_getFName
															.getString("Fixture_Name")%></td>
							<%
								}
																	rs_getFName.close();
																	ps_getFName.close();
																	PreparedStatement ps_getFNo = con
																			.prepareStatement("select Fixture_No from dev_fixture_no_mst_tbl where FixtureNo_Id="
																					+ rs_getFRelId
																							.getInt("FixtureNo_Id"));
																	ResultSet rs_getFNo = ps_getFNo
																			.executeQuery();
																	while (rs_getFNo.next()) {
							%>
							<td width="2%" rowspan=<%=rows + 1%>><%=rs_getFNo
															.getString("Fixture_No")%></td>
							<%
								}

																}
							%>


							<td width="3%" rowspan=<%=rows + 1%>><%=rs_getFixtureData
													.getDate("quotation_date")%></td>
							<td width="3%" rowspan=<%=rows + 1%>><%=rs_getFixtureData
													.getDate("fixture_po_date")%></td>
							<td width="3%" rowspan=<%=rows + 1%>><%=rs_getFixtureData
													.getDate("target_receipt_date")%></td>
							<td width="2%" rowspan=<%=rows + 1%>><%=rs_getFixtureData
													.getDate("actual_receipt_date")%></td>




							<%
								PreparedStatement ps_getCTData = con
																		.prepareStatement("select * from dev_cuttingtool_data_tbl where fd_id="
																				+ rs_getFixtureData
																						.getInt("fd_id"));
																ResultSet rs_getCTData = ps_getCTData
																		.executeQuery();

																rs_getCTData.last();
																int ctData = rs_getCTData.getRow();
																rs_getCTData.beforeFirst();

																if (ctData < 1) {
							%>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						<%--<td colspan="2"><input type="button" name="Submit222"
								value="New"
								onclick="openPage('Add_Cutting_Tools.jsp?action=new&fixture_Id=<%=rs_getFixtureData
														.getInt("fd_id")%>&relId=<%=rs_getOpnAndOpnnoId
														.getInt("OpnNo_Opn_Rel_Id")%>&basic_id=<%=basic_id%>')" /></td> --%>	
							<%
								}

															}
														} else {
							%>
						
						<tr>
							<td> </td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td> 
							

							<%
								}

													}
												} else {
							%>
						
						<tr> 						
							<td></td>
							<td></td>
							<td> </td>
							<td></td>
							<td></td>
							<td></td> 
							<%
								}
											}
							%>
						</tr>






						<%
							//-------------------------------------------------------------------------------------------------------------

										PreparedStatement ps_getMCData = con
												.prepareStatement("select * from dev_mcdata_tbl where OpnNo_Opn_Rel_Id="
														+ rs_getOpnAndOpnnoId
																.getInt("OpnNo_Opn_Rel_Id"));
										ResultSet rs_getMCData = ps_getMCData.executeQuery();
										rs_getMCData.last();
										int mCDatanull = rs_getMCData.getRow();
										rs_getMCData.beforeFirst();
										if (mCDatanull > 0) {

											while (rs_getMCData.next()) {

												PreparedStatement ps_getFixtureData = con
														.prepareStatement("select * from dev_fixturedata_tbl where mcdata_id="
																+ rs_getMCData
																		.getInt("mcdata_id"));
												ResultSet rs_getFixtureData = ps_getFixtureData
														.executeQuery();

												rs_getFixtureData.last();
												int FxDatanull = rs_getFixtureData.getRow();
												rs_getFixtureData.beforeFirst();
												if (FxDatanull > 0) {

													while (rs_getFixtureData.next()) {

														PreparedStatement ps_getCTData = con
																.prepareStatement("select * from dev_cuttingtool_data_tbl where fd_id="
																		+ rs_getFixtureData
																				.getInt("fd_id"));
														ResultSet rs_getCTData = ps_getCTData
																.executeQuery();

														rs_getCTData.last();
														int ctData = rs_getCTData.getRow();
														rs_getCTData.beforeFirst();

														if (ctData > 0) {
															while (rs_getCTData.next()) {
						%>
						<%
							PreparedStatement ps_getTool_Name = con
																		.prepareStatement("select tool_name from dev_cutting_tool_mst_tbl where ctool_Id="
																				+ rs_getCTData
																						.getInt("ctool_id"));
																ResultSet rs_getTool_Name = ps_getTool_Name
																		.executeQuery();
																while (rs_getTool_Name.next()) {
						%>

						<tr align="center">
							<td width="3%"><%=rs_getTool_Name
															.getString("tool_name")%></td>
							<%
								}
																	rs_getTool_Name.close();
																	ps_getTool_Name.close();
							%>
							<td width="1%"><%=rs_getCTData
														.getInt("ctool_quantity")%></td>
							<td width="1%"><%=rs_getCTData
														.getInt("avail_qty")%></td>
							<td width="3%"><%=rs_getCTData
														.getDate("ctool_po_date")%></td>
							<td width="4%"><%=rs_getCTData
														.getDate("ctool_target_date")%></td>
							<td width="3%"><%=rs_getCTData
														.getDate("ctool_receipt_date")%></td>
		<%--					<td width="2%" colspan="2"><input type="button"
								name="Submit2222" value="Edit"
								onclick="openPage('Add_Cutting_Tools.jsp?action=edit&ctd_id=<%=rs_getCTData
														.getInt("ctd_id")%>&basic_id=<%=basic_id%>')" />

								<input type="button" name="Submit222" value="New"
								onclick="openPage('Add_Cutting_Tools.jsp?action=new&fixture_Id=<%=rs_getFixtureData
														.getInt("fd_id")%>&relId=<%=rs_getOpnAndOpnnoId
														.getInt("OpnNo_Opn_Rel_Id")%>&basic_id=<%=basic_id%>')" />
							</td> --%>
							<%
								}
															} 
														}
													} else {
							%>
						
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td> 

							<%
								}
												}
											} else {
							%>
						
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td> 

							<%
								}
										}
							%>
						
					</table>
					<%
						}
					%>



				</div>
				<!-- Cutting Tools End-->


				<!-- Gauges -->
				<div id="tabs-5">
					<%
						rs_getOpnAndOpnnoId.last();
							System.out.println("Get fetch size = "
									+ rs_getOpnAndOpnnoId.getRow());
							int cn1 = rs_getOpnAndOpnnoId.getRow();
							rs_getOpnAndOpnnoId.beforeFirst();

							if (cn1 > 0) {

								//--------------------------------------------------------------------------------------------------------------
					%>

					<table width="953" border="1" class="gridtable">

						<tr bgcolor="#CCCCCC">
							<th width="4%" height="33" rowspan="2" scope="col">Sr. No</th>
							<th width="4%" height="33" rowspan="2" scope="col">Op No.</th>
							<th width="16%" height="33" rowspan="2" scope="col">Operation</th>
							<th height="30" colspan="9" scope="col">Gauges</th>

						</tr>
						<tr bgcolor="#CCCCCC">

							<th width="6%" scope="col">Gauge Name</th>
							<th width="9%" scope="col">Reqd Qty</th>
							<th width="9%" scope="col">Avail Qty</th>
							<th width="8%" scope="col">Customer approval</th>
							<th width="9%" scope="col"><b>Gauges PO Date</b></th>
							<th width="8%" scope="col"><b>Gauge Tgt Date</b></th>
							<th width="8%" scope="col"><b>Gauge Recpt Date</b></th>
						<!--	<th width="6%" scope="col" colspan="2">Edit / New</th>
							 <th width="6%" scope="col">New</th> -->
						</tr>

						<%
							while (rs_getOpnAndOpnnoId.next()) {

										sr_no5 = sr_no5 + 1;

										PreparedStatement ps_gct = con
												.prepareStatement("select count(gd_id) from dev_gaugedata_tbl where basic_id="
														+ basic_id
														+ " and opnno_opn_rel_id="
														+ rs_getOpnAndOpnnoId
																.getInt("OpnNo_Opn_Rel_Id"));
										ResultSet rs_gct = ps_gct.executeQuery();
										while (rs_gct.next()) {
											gr = rs_gct.getInt("count(gd_id)");
										}
						%>
						<tr align="center">

							<td rowspan="<%=gr + 1%>"><%=sr_no5%></td>
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

							<td rowspan="<%=gr + 1%>"><%=rs_getOpnNo.getInt("Opn_no")%></td>
							<%
								}
												PreparedStatement ps_getOpn = con
														.prepareStatement("select operation from dev_operation_mst_tbl where opn_id="
																+ rs_getOpnIds.getInt("opn_id"));
												ResultSet rs_getOpn = ps_getOpn.executeQuery();
												while (rs_getOpn.next()) {
							%>

							<td rowspan="<%=gr + 1%>"><%=rs_getOpn.getString("operation")%></td>
							<%
								if (gr == 0) {
							%>
							<td rowspan="<%=gr + 1%>">&nbsp;</td>
							<td rowspan="<%=gr + 1%>">&nbsp;</td>
							<td rowspan="<%=gr + 1%>">&nbsp;</td>
							<td rowspan="<%=gr + 1%>">&nbsp;</td>
							<td rowspan="<%=gr + 1%>">&nbsp;</td>
							<td rowspan="<%=gr + 1%>">&nbsp;</td>
							<td rowspan="<%=gr + 1%>">&nbsp;</td>
						<%--	<td rowspan="<%=gr + 1%>" colspan="2"><input type="button"
								name="Submit222222" value="New"
								onclick="openPage('Add_Gauges.jsp?basic_id=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
											.getInt("OpnNo_Opn_Rel_Id")%>&action=<%="new"%>')" /></td> --%>

							<%
								}
							%>


							<%
								}
											}
							%>
						</tr>
						<%
							PreparedStatement ps_gaugedata = con
												.prepareStatement("select * from dev_gaugedata_tbl where basic_id="
														+ basic_id
														+ " and opnno_opn_rel_id="
														+ rs_getOpnAndOpnnoId
																.getInt("OpnNo_Opn_Rel_Id"));
										ResultSet rs_gaugedata = ps_gaugedata.executeQuery();
										rs_gaugedata.last();
										int gData = rs_gaugedata.getRow();
										rs_gaugedata.beforeFirst();
										if (gData > 0) {

											while (rs_gaugedata.next()) {
						%>
						<tr>
							<%
								PreparedStatement ps_gList = con
															.prepareStatement("select * from dev_gauge_mst_tbl where gauge_id="
																	+ rs_gaugedata
																			.getInt("gauge_id"));
													ResultSet rs_glist = ps_gList.executeQuery();
													while (rs_glist.next()) {
							%>
							<td><%=rs_glist.getString("gauge_name")%></td>
							<%
								}
							%>

							<td><%=rs_gaugedata.getInt("gauge_quantity")%></td>
							<td><%=rs_gaugedata.getInt("avail_qty")%></td>

							<td><%=rs_gaugedata
										.getString("customer_approval")%></td>

							<td><%=rs_gaugedata.getDate("gauge_po_date")%></td>
							<td><%=rs_gaugedata
										.getDate("gauge_target_date")%></td>
							<td><%=rs_gaugedata
										.getDate("gauge_receipt_date")%></td>

						<%--	<td colspan="2"><input type="button" name="Submit2222222"
								value="Edit"
								onclick="openPage('Add_Gauges.jsp?action=<%="Edit"%>&GD_Id=<%=rs_gaugedata.getInt("gd_id")%>&basic_id=<%=basic_id%>')" />
								<input type="button" name="Submit222222" value="New"
								onclick="openPage('Add_Gauges.jsp?basic_id=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
										.getInt("OpnNo_Opn_Rel_Id")%>&action=<%="new"%>')" />

							</td> --%>
							<%
								}
											}
											//-------------------------------------------------------------------------------------------------------------
										}
							%>
						
					</table>



					<%
						}
					%>


				</div>

				<!-- Gauges End-->

				<!-- Others -->
				<div id="tabs-6">



					<%
						rs_getOpnAndOpnnoId.last();
							System.out.println("Get fetch size = "
									+ rs_getOpnAndOpnnoId.getRow());
							int other = rs_getOpnAndOpnnoId.getRow();
							rs_getOpnAndOpnnoId.beforeFirst();

							if (other > 0) {
					%>

					<table width="600" border="1" class="gridtable">

						<tr bgcolor="#CCCCCC">
							<th width="2%" height="33" rowspan="2" scope="col">Sr. No</th>
							<th width="2%" height="33" rowspan="2" scope="col">Op No.</th>
							<th width="9%" height="33" rowspan="2" scope="col">Operation</th>
							<th width="9%" height="33" rowspan="2" scope="col">Others</th>
						</tr>
						<tr bgcolor="#CCCCCC">
						<!--	<th width="7%" height="16" scope="col"><b>Others</b></th>

							<th width="2%" scope="col" colspan="2">Edit / New</th>
							 <th width="2%" height="16" scope="col">Add New</th> -->
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
							%>
							<%
								PreparedStatement ps_other = con
														.prepareStatement("select * from dev_otherdata_tbl where basic_id="
																+ basic_id
																+ " and OpnNo_Opn_Rel_Id="
																+ rs_getOpnAndOpnnoId
																		.getInt("OpnNo_Opn_Rel_Id"));
												ResultSet rs_other = ps_other.executeQuery();
												rs_other.last();
												int otgtData = rs_other.getRow();
												rs_other.beforeFirst();

												if (otgtData > 0) {
													while (rs_other.next()) {
							%>
							<td><%=rs_other
											.getString("other_discription")%></td>
					<%--		<td colspan="2"><input type="button" name="Submit24"
								value="Edit"
								onclick="openPage('Add_Others.jsp?basic_id=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
											.getInt("OpnNo_Opn_Rel_Id")%>&action=Edit')" /></td> --%>

							<%
								}
												} else {
							%>
							<td>&nbsp;</td>

						<%--	<td colspan="2"><input type="button" name="Submit2"
								value="New"
								onclick="openPage('Add_Others.jsp?basic_id=<%=basic_id%>&relId=<%=rs_getOpnAndOpnnoId
										.getInt("OpnNo_Opn_Rel_Id")%>&action=new')" /></td> --%>
							<%
								}
							%>


							<%
								}
							%>
						</tr>

						<%
							}
						%>
					</table>

					<%
						}
					%>

				</div>
				<!-- Others End-->

				<!-- internal movement Othe -->
				<div id="tabs-7">

					<%
						rs_getOpnAndOpnnoId.last();
							System.out.println("Get fetch size = "
									+ rs_getOpnAndOpnnoId.getRow());
							int material = rs_getOpnAndOpnnoId.getRow();
							rs_getOpnAndOpnnoId.beforeFirst();

							if (material > 0) {
					%>

					<table width="529" border="1" class="gridtable">

						<tr bgcolor="#CCCCCC">
							<th height="26" colspan="5" scope="col">Internal Material
								Movement</th>
						</tr>
						<tr bgcolor="#CCCCCC" align="center">
							<th scope="col"><b> Material Type</b></th>
							<th scope="col"><b> Description</b></th>

						<!--	<th scope="col" colspan="2">Edit / New</th>
							 <th width="2%" height="16" scope="col">Add New</th> -->
						</tr>






						<%
							PreparedStatement ps_interMovement = con
											.prepareStatement("select * from dev_intmaterial_movement_tbl where basic_id="
													+ basic_id);
									ResultSet rs_intermovement = ps_interMovement
											.executeQuery();

									rs_intermovement.last();
									int interDataother = rs_intermovement.getRow();
									rs_intermovement.beforeFirst();

									if (interDataother > 0) {
										while (rs_intermovement.next()) {
						%>
						<tr align="center">
							<td><%=rs_intermovement
									.getString("material_type")%></td>
							<td><%=rs_intermovement.getString("discription")%></td>
						<%--<td colspan="2"><input type="button" name="Submit24"
								value="Edit"
								onclick="openPage('Add_internalmovement_Other.jsp?basic_id=<%=basic_id%>&action=Edit&IMM_Id=<%=rs_intermovement.getInt("mat_move_id")%>')" />
								<input type="button" name="Submit22" value="New"
								onclick="openPage('Add_internalmovement_Other.jsp?basic_id=<%=basic_id%>&action=new')" /></td> --%>	

						</tr>
						<%
							}
									} else {
						%>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						<%--	<td colspan="2" align="center"><input type="button"
								name="Submit2" value="New"
								onclick="openPage('Add_internalmovement_Other.jsp?basic_id=<%=basic_id%>&action=new')" /></td> --%>	
							<%
								}
							%>
						</tr>


					</table>

					<%
						}
					%>



				</div>
				<!-- internal movement Othe End -->

				<div id="tabs-8">


					<%
						rs_getOpnAndOpnnoId.last();
							int fm = rs_getOpnAndOpnnoId.getRow();
							rs_getOpnAndOpnnoId.beforeFirst();

							if (fm > 0) {
					%>

					<table width="529" border="1" class="gridtable">

						<tr bgcolor="#CCCCCC">
							<th height="26" align="center" colspan="7" scope="col">Foundry
								Tooling</th>
						</tr>
						<tr bgcolor="#CCCCCC" align="center">
							<th scope="col"><b> No Of Pattern Available</b></th>
							<th scope="col"><b> No Of Pattern Required</b></th>
							<th scope="col"><b> No Of Core Box Available</b></th>
							<th scope="col"><b> No Of Core Box Required</b></th>
							<th scope="col"><b> Recept Date (yyyy/mm/dd)</b></th>

						<!-- 	<th scope="col" colspan="2">Edit / New</th>
							<th width="2%" height="16" scope="col">Add New</th> -->
						</tr>

						<%
							PreparedStatement ps_ft = con
											.prepareStatement("select * from dev_foundrytoolingdata_tbl where Basic_Id="
													+ basic_id);
									ResultSet rs_ft = ps_ft.executeQuery();

									rs_ft.last();
									int fm11 = rs_ft.getRow();
									rs_ft.beforeFirst();

									if (fm11 > 0) {

										while (rs_ft.next()) {
						%>

						<tr align="center">
							<td><%=rs_ft.getInt("Pattern_Avail")%></td>
							<td><%=rs_ft.getInt("Pattern_Required")%></td>
							<td><%=rs_ft.getInt("CoreBox_Avail")%></td>
							<td><%=rs_ft.getInt("CoreBox_Required")%></td>
							<td><%=rs_ft.getDate("Recpt_Date")%></td>
						<%--<td colspan="2" align="center"><input type="button"
								name="Submit2" value="New"
								onclick="openPage('Add_Foundry_tooling.jsp?basic_id=<%=basic_id%>&action=new')" />
								<input type="button" name="Submit2" value="Edit"
								onclick="openPage('Add_Foundry_tooling.jsp?basic_id=<%=basic_id%>&ftd_Id=<%=rs_ft.getInt("FTD_Id")%>&action=edit')" />
							</td> --%>	

						</tr>
						<%
							}

									} else {
						%>
						<tr align="center">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						<%--<td colspan="2" align="center"><input type="button"
								name="Submit2" value="New"
								onclick="openPage('Add_Foundry_tooling.jsp?basic_id=<%=basic_id%>&action=new')" />
							</td> --%>	
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
			
			
			
			
			
			
			
			<%
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
				
				</form>
	<div style="float: left;width: 40%">
					<form action="Approval_Controller" method="post" name="appaction"
			id="appaction">
			<table border="0" class="tftable" width="40%" align="left">
 
				<tr style="background-color: #B0C9D6">
					<th colspan="3">Approval
						:</th>
				</tr>
				<tr> 
				<td width="30%"><strong>Approvers</strong></td>
				<td width="1">:</td> 
				<%
				ArrayList<String> list=new ArrayList<String>();
				Connection con1 = Connection_Utility.getConnection();
				PreparedStatement ps_apr=con1.prepareStatement("select * from dev_approval_tbl where Basic_Id=" + basic_id);
				ResultSet rs_apr=ps_apr.executeQuery();
				while(rs_apr.next()){
					PreparedStatement ps_user=con1.prepareStatement("select * from user_tbl where U_Id="+rs_apr.getInt("U_Id"));
					ResultSet rs_user=ps_user.executeQuery();
					while(rs_user.next()){
						list.add(rs_user.getString("U_Name"));
					}
					ps_user.close();
					rs_user.close();					
				} 
				ps_apr.close();
				rs_apr.close();
				%>
				<td width="60%"><%
						for (String approvee : list) {      
						    %>
						 <b><%=approvee%>,</b>   
						    <%
						}				
				%>
				</td>				 
			</tr>
				<tr> 
					<td width="30%"><strong>Action</strong></td>
					<td width="2%">:</td>
					<td width="60%">
						<% 
							int chr = 0;
							String remark = null;
							PreparedStatement ps_apStatus = con1
									.prepareStatement("select * from dev_approval_tbl where U_Id="
											+ uid + " and Basic_Id=" + basic_id);
							ResultSet rs_apStatus = ps_apStatus.executeQuery();
						%> <select name="approval_type">
							<%
								while (rs_apStatus.next()) {
									PreparedStatement ps_getstatus = con1
											.prepareStatement("select * from cr_tbl_approval_type where Approval_id="
													+ rs_apStatus.getInt("Approval_id"));
									ResultSet rs_getstatus = ps_getstatus.executeQuery();
									while (rs_getstatus.next()) {
										chr = rs_getstatus.getInt("Approval_id");
										remark = rs_apStatus.getString("Remark");
							%>
							<option value="<%=rs_getstatus.getInt("Approval_id")%>"><%=rs_getstatus.getString("Approval_Type")%>
							</option>
							<%
								}
								}
								PreparedStatement ps_stat = con1
										.prepareStatement("select * from cr_tbl_approval_type where Approval_id!="
												+ chr);
								ResultSet rs_stat = ps_stat.executeQuery();
								while (rs_stat.next()) {
							%>
							<option value="<%=rs_stat.getInt("Approval_id")%>"><%=rs_stat.getString("Approval_Type")%>
							</option>

							<%
								}
							%>

					</select>
					</td>
				</tr>
				<tr> 
					<td><strong>Remark</strong></td>
					<td>:</td>
					<td><textarea name="appRemark" id="appRemark" rows="5" cols="30"><%=remark%></textarea> <input
						type="hidden" name="sheetNo" id="sheetNo"></td>
				</tr>
				<tr> 
					<td colspan="3" align="left" width="60%"><input
						type="button" name="approval" value="Send it for Approval" style="width: 150px; height: 30px;"
						id="getApBtn" onclick="ApprovalMsg('<%=basic_id%>')" /> 
					<!-- 	 <img src="images/PleaseWait.gif" width="174" height="32"
						style="visibility: hidden;" id="imageLoading" /></td>
						 -->
				</tr>
			</table>
		</form>
		</div>
	</div>
<ul id="menu" class="templatemo_section_2">
		<li style="color: #020303;"><a href="Home.jsp"><img src="images/homeicon.png"><strong> DVP BOSS</strong></a></li>
		<li><a href="NewSheet.jsp?action=new" style="font-size: 12px;">New DVP Sheet </a></li> 
		<li><a href="My_Approvals.jsp" style="font-size: 12px;">My Approvals</a></li> 
		<li><a href="Approval_Status.jsp" style="font-size: 12px;">Approval Status</a></li> 
		<li><a href="Dev_Summary_Sheet.jsp" style="font-size: 12px;">DVP Summary</a></li> 
		<li><a href="MOM_Sheet.jsp" style="font-size: 12px;">MOM Summary</a><br /></li>
	</ul>
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