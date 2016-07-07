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
<title>Add Gauge</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/tab.css" />
<link rel="stylesheet" type="text/css" href="css/tab.css" />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
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
<script>
 
	$(function() {
		//	$("#datepicker").datepicker();
		$("#gaugepodate").datepicker({
			appendText : " ( MM/DD/YYYY ) "
		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#gaugetrgdate").datepicker({
			appendText : " ( MM/DD/YYYY ) "
		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#gaugerecdate").datepicker({
			appendText : " ( MM/DD/YYYY ) "
		});
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
function editvalidateForm() {
	
	var gauge=document.getElementById("gaugelist");
	var editgauge=document.getElementById("gaugeId"); 
	
	var gaugebtn=document.getElementById("newGaugeBtn");
	var newGauge=document.getElementById("newGauge"); 
	
	
	var gaugeQty=document.getElementById("gauge_qty");
	var custAppr=document.getElementById("custAppr"); 
	var podate=document.getElementById("gaugepodate");
	var targDate=document.getElementById("gaugetrgdate"); 
	//var recdate=document.getElementById("gaugerecdate"); 
	
	
	
	if(gaugebtn.disabled==true){
		 if(newGauge.value==null || newGauge.value==""){
			alert("New Gauge Name ???");
			return false;
		 }
		}
	
	if(gauge.disabled ==false){
		 if(gauge.value==null || gauge.value==""){
			alert("Gauge Name ???");
			return false;
		 }
		} 
	 if(gauge.disabled==true){
		 if(editgauge.value==null || editgauge.value==""){
			alert("Edit Gauge Name ???");
			return false;
		 }
		}
	 
	 if(gaugeQty.value=="" || gaugeQty.value==null){
		 alert("Qty ???");
			return false;
	 }
	 if(custAppr.value=="" || custAppr.value==null){
		 alert("Customer approval ???");
			return false;
	 }
	 if(podate.value=="" || podate.value==null){
		 alert("Gauges PO Date ???");
			return false;
	 }
	 if(targDate.value=="" || targDate.value==null){
		 alert("Gauge Tgt Date ???");
			return false;
	 }
	/*  if(recdate.value=="" || recdate.value==null){
		 alert("Gauge Recpt Date ???");
			return false;
	 } */

}

</script>

<script type="text/javascript">
function validateForm() {
	var gauge=document.getElementById("gauge");
	var gaugeNew=document.getElementById("newGauge");
	
	var gaugeQty=document.getElementById("gauge_qty");
	var custApr=document.getElementById("cust_aprroval"); 
	var gaugePoDate=document.getElementById("gaugepodate");
	var gaugetargetDate=document.getElementById("gaugetrgdate"); 
	//var gaugerecDate=document.getElementById("gaugerecdate");
	
		if(gauge.disabled ==false){
		 if(gauge.value==null || gauge.value=="" || gauge.value=="null"){
			alert("Gauge list ???");
			return false;
		 }
		} 
	 if(gauge.disabled==true){
		 if(gaugeNew.value==null || gaugeNew.value==""){
			alert("Gauge list ???");
			return false;
		 }
		}
	 
	 if(gaugeQty.value=="" || gaugeQty.value==null){
		 alert("Gauge Qty ???");
			return false;
	 }
	 if(custApr.value=="" || custApr.value==null || custApr.value=="null"){
		 alert("Customer approval ???");
			return false;
	 }
	 if(gaugePoDate.value=="" || gaugePoDate.value==null){
		 alert("Gauges PO Date ???");
			return false;
	 }
	 if(gaugetargetDate.value=="" || gaugetargetDate.value==null){
		 alert("Gauge Tgt Date ???");
			return false;
	 }
	 /* if(gaugerecDate.value=="" || gaugerecDate.value==null){
		 alert("Gauge Recpt Date ???");
			return false;
	 }  */
	 return true;
}

</script>

<script type="text/javascript">
function addnewgauge(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "newGauge");
	var here = document.getElementById("newG");
	here.appendChild(element);
	
	
	var e1 = document.getElementById("newGaugeBtn");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("gaugeId");
	e.setAttribute('disabled', 'disabled');
	
	var e1 = document.getElementById("gbtn1");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("gaugelist");
	e.setAttribute('disabled', 'disabled');
	
}

function addgauge(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "newGauge");
	var here = document.getElementById("getgauge");
	here.appendChild(element);

	var e1 = document.getElementById("gauge");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("gbtn");
	e.setAttribute('disabled', 'disabled');
}
function editgaugelist(type) 
{
	document.getElementById("gaugeId").disabled=false;

	var e1 = document.getElementById("gbtn1");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("gaugelist");
	e.setAttribute('disabled', 'disabled');
}
</script>
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
<body>
	<div id="templatemo_header_wrapper">
		<!--  Free Web Templates by TemplateMo.com  -->
		<div id="templatemo_header">

			<!-- 	<div id="site_logo"></div> -->

			<div id="templatemo_menu">
				<div id="templatemo_menu_left"></div>
				<ul>
					<%
						String User_Name = null;
						int uid = Integer.parseInt(session.getAttribute("uid").toString());
						Get_UName_bo bo = new Get_UName_bo();
						User_Name = bo.get_UName(uid);
					%>
					<li><a href="Home.jsp" class="current">Home</a></li>
					<li><a href="All_DVPSheets.jsp">All DVP Sheets</a></li>
					<li><a href="EditSheet.jsp">Edit DVP Sheets</a></li>
					<li><a href="#">Reports</a></li>
					<li><a href="Search.jsp">Search</a></li>

					<li><a href="Logout.jsp" class="last"><strong>
								Log Out (<%=User_Name%>)
						</strong></a></li>
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
		try {
			int basic_id = 0;
			String action = null;
			int GD_Id = 0;
			int rel_id = 0;

			if (request.getParameter("action") != null) {
				action = request.getParameter("action");
			}
			if (request.getParameter("basic_id") != null) {
				basic_id = Integer.parseInt(request
						.getParameter("basic_id"));
			}
			Connection con = Connection_Utility.getConnection();
	%>


	<div class="templatemo_section_1">

		<%
			if (action.equalsIgnoreCase("new")) {

					if (request.getParameter("relId") != null) {
						rel_id = Integer
								.parseInt(request.getParameter("relId"));
					}
		%>
		<form action="Add_Gauge_Controller" class="register" method="post"
			id="myForm" name="myForm" onSubmit="return(validateForm());">

			<input type="hidden" name="basic_id" value="<%=basic_id%>"> <input
				type="hidden" name="rel_id" value="<%=rel_id%>">

			<table width="82%" border="1" class="gridtable">
				<tr style="background-color: #B0C9D6">
					<th height="33" colspan="8" align="left" scope="col"><span
						style="font-size: 25px; color: #2883B8">Gauges</span></th>
				</tr>
				<tr>
					<th width="5%" scope="col">Sr. No</th>

					<th width="32%" scope="col">Gauge list</th>
					<th width="5%" scope="col">Qty</th>
					<th width="13%" scope="col">Customer approval</th>
					<th width="12%" scope="col">Gauges PO Date</th>
					<th width="13%" scope="col">Gauge Tgt Date</th>
					<th width="13%" scope="col">Gauge Recpt Date</th>
				</tr>
				<%
					int sr_no = 0;
							PreparedStatement ps_getGD = con
									.prepareStatement("select * from dev_gaugedata_tbl where basic_id="
											+ basic_id);
							ResultSet rs_getGD = ps_getGD.executeQuery();
							while (rs_getGD.next()) {
								sr_no = sr_no + 1;
				%>
				<tr>
					<td><%=sr_no%></td>
					<%
						PreparedStatement ps_getGaugeName = con
											.prepareStatement("select gauge_name from dev_gauge_mst_tbl where gauge_id="
													+ rs_getGD.getInt("gauge_id"));
									ResultSet rs_getGaugeName = ps_getGaugeName
											.executeQuery();
									while (rs_getGaugeName.next()) {
					%>
					<td><%=rs_getGaugeName.getString("gauge_name")%></td>
					<%
						}
					%>

					<td><%=rs_getGD.getInt("gauge_quantity")%></td>
					<td><%=rs_getGD.getString("customer_approval")%></td>
					<td><%=rs_getGD.getDate("gauge_po_date")%></td>
					<td><%=rs_getGD.getDate("gauge_target_date")%></td>
					<td><%=rs_getGD.getDate("gauge_receipt_date")%></td>
				</tr>
				<%
					}
				%>
			</table>
			</br>
			<table width="82%">
				<tr>
					<th colspan="7" align="left" scope="col"><span
						style="font-size: 25px; color: #2883B8">Add Gauges </span></th>
				</tr>
				<tr>
					<td width="16%" height="32">Gauge list</td>
					<td width="1%">:</td>
					<td width="21%"><select name="gauge" id="gauge"
						style="cursor: pointer; max-width: 11em;">
							<option value="null">----- Select -----</option>
							<%
								PreparedStatement ps_gaugeList = con
												.prepareStatement("select gauge_name from dev_gauge_mst_tbl");
										ResultSet rs_gaugeList = ps_gaugeList.executeQuery();
										while (rs_gaugeList.next()) {
							%>
							<option value="<%=rs_gaugeList.getString("gauge_name")%>"><%=rs_gaugeList.getString("gauge_name")%></option>
							<%
								}
										rs_gaugeList.close();
										ps_gaugeList.close();
							%>

					</select></td>
					<td width="10%"><input type="button"
						onclick="addgauge('gauge')" id="gbtn" value="If other"
						style="cursor: pointer" /></td>
					<td width="19%"><span id="getgauge"></span></td>





					<td width="1%">&nbsp;</td>
					<td width="32%">&nbsp;</td>
				</tr>
				<tr>
					<td height="30">Required Qty</td>
					<td>:</td>
					<td><input type="text" name="gauge_qty" id="gauge_qty" onkeypress="return validatenumerics(event);"/></td>
					<td>&nbsp;</td>
					<td height="30">Available Qty</td>
					<td>:</td>
					<td><input type="text" name="avail_qty" id="avail_qty" onkeypress="return validatenumerics(event);"/></td>
					
					</tr>
					<tr>
					<td>Customer approval</td>
					<td>:</td>
					<td><select name="cust_aprroval" id="cust_aprroval">
							<option value="null">---- Select ----</option>
							<option value="Yes">Yes</option>
							<option value="No">No</option>
					</select></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td height="28">Gauges PO Date</td>
					<td>:</td>
					<td colspan="2"><input type="text" name="gaugepodate"
						id="gaugepodate" /></td>
					<td>Gauge Tgt Date</td>
					<td>:</td>
					<td><input type="text" name="gaugetrgdate" id="gaugetrgdate" /></td>
					
				</tr>

				<tr>
					<td>Gauge Recpt Date</td>
					<td>&nbsp;</td>
					<td colspan="2"><input type="text" name="gaugerecdate"
						id="gaugerecdate" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="4" align="center"><input type="submit"
						name="Submit" value="Add" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</form>

		<%
			} else {

					if (request.getParameter("GD_Id") != null) {
						GD_Id = Integer.parseInt(request.getParameter("GD_Id"));
					}
		%>

		<form action="Edit_Gauge_Controller" class="register" method="post"
			id="myForm" name="myForm" onSubmit="return(editvalidateForm());">

			<input type="hidden" name="basic_id" value="<%=basic_id%>"> <input
				type="hidden" name="GD_Id" value="<%=GD_Id%>">



			<table width="100%">
				<tr>
					<th colspan="10" align="left" scope="col"><span
						style="font-size: 25px; color: #2883B8">Edit Gauges </span></th>
				</tr>
				<%
					PreparedStatement ps_getGDData = con
									.prepareStatement("select * from dev_gaugedata_tbl where GD_Id="
											+ GD_Id);
							ResultSet rs_getGDData = ps_getGDData.executeQuery();
							while (rs_getGDData.next()) {
				%>
				<tr>
					<td width="1%"></td>
					<td width="19%" height="32"><strong>Change Gauge Name</strong></td>
					<td width="1%"><strong>:</strong></td>
					<td width="16%"><select name="gauge" id="gaugelist"
						style="cursor: pointer; max-width: 11em;">
							<%
								String gauge_name = null;

											PreparedStatement ps_getSelGauge = con
													.prepareStatement("select gauge_name from dev_gauge_mst_tbl where gauge_id="
															+ rs_getGDData.getInt("gauge_id"));
											ResultSet rs_getSelGauge = ps_getSelGauge
													.executeQuery();
											while (rs_getSelGauge.next()) {
												gauge_name = rs_getSelGauge.getString("gauge_name");
							%>
							<option value="<%=gauge_name%>"><%=gauge_name%></option>
							<%
								}
											rs_getSelGauge.close();
											ps_getSelGauge.close();
											PreparedStatement ps_gaugeList = con
													.prepareStatement("select gauge_name from dev_gauge_mst_tbl where gauge_id!="
															+ rs_getGDData.getInt("gauge_id"));
											ResultSet rs_gaugeList = ps_gaugeList.executeQuery();
											while (rs_gaugeList.next()) {
							%>
							<option value="<%=rs_gaugeList.getString("gauge_name")%>"><%=rs_gaugeList.getString("gauge_name")%></option>
							<%
								}
											rs_gaugeList.close();
											ps_gaugeList.close();
							%>
					</select></td>
					<td width="13%"><input type="button"
						onclick="editgaugelist('gauge')" id="gbtn1" value="to Edit"
						style="cursor: pointer" /></td>
					<td width="15%"><strong>Edit Gauge Name </strong></td>
					<td width="1%"><strong>:</strong></td>
					<td width="31%"><input type="text" value="<%=gauge_name%>"
						name="gauge" id="gaugeId" disabled="disabled" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td height="30">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><input name="button" type="button" id="newGaugeBtn"
						style="cursor: pointer" onclick="addnewgauge('new_gauge')"
						value="If other" /></td>
					<td><strong>Add New Gauge</strong></td>
					<td><strong>:</strong></td>
					<td><span id="newG"></span></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td height="30"><strong>Required Qty</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text"
						value="<%=rs_getGDData.getInt("gauge_quantity")%>"
						name="gauge_qty"  id="gauge_qty" onkeypress="return validatenumerics(event);"/></td>
					<td>&nbsp;</td>
					<td height="30"><strong>Available Qty</strong></td>
					<td>:</td>
					<td><input type="text" name="avail_qty" id="avail_qty" value="<%=rs_getGDData.getInt("avail_qty")%>" onkeypress="return validatenumerics(event);"/></td>
					</tr>
					
					<tr>
					<td>&nbsp;</td>
					<td><strong>Customer approval</strong></td>
					<td><strong>:</strong></td>
					<td><select name="cust_aprroval" id="custAppr">
							<%
								if (rs_getGDData.getString("customer_approval")
													.equalsIgnoreCase("Yes")) {
							%>
							<option value="Yes">Yes</option>
							<option value="No">No</option>
							<%
								} else {
							%>
							<option value="No">No</option>
							<option value="Yes">Yes</option>
							<%
								}
							%>

					</select></td>
					<td width="1%">&nbsp;</td>
					<td width="2%">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td height="28"><strong>Gauges PO Date</strong></td>
					<td><strong>:</strong></td>
					<td colspan="2"><input type="text"
						value="<%=rs_getGDData.getDate("gauge_po_date")%>"
						name="gaugepodate" id="gaugepodate" /></td>
					<td><strong>Gauge Tgt Date</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" name="gaugetrgdate"
						value="<%=rs_getGDData.getDate("gauge_target_date")%>"
						id="gaugetrgdate" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td><strong>Gauge Recpt Date</strong></td>
					<td><strong>:</strong></td>
					<td colspan="2">
					<%
					if(rs_getGDData.getDate("gauge_receipt_date")!=null){
					%>
					<input type="text" name="gaugerecdate"
						value="<%=rs_getGDData.getDate("gauge_receipt_date")%>"
						id="gaugerecdate" />
					<%
					}else{
					%>	
					<input type="text" name="gaugerecdate" id="gaugerecdate" />
					<%
					}
					%>
						</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="5" align="center"><input type="submit"
						name="Submit" value="Update" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
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
				</tr>
				<%
					}
				%>
			</table>

		</form>

		<%
			}
		%>

	</div>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

	<ul id="menu" class="templatemo_section_2">
		<li class="ui-state-disabled" style="color: #020303;"><strong>
				DVP BOSS</strong></li>


		<li><a href="NewSheet.jsp?action=new" style="font-size: 12px;">New
				DVP Sheet</a></li>


		<li><a href="My_Approvals.jsp" style="font-size: 12px;">My
				Approvals</a></li>

		<li><a href="Approval_Status.jsp" style="font-size: 12px;">Approval
				Status</a></li>
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