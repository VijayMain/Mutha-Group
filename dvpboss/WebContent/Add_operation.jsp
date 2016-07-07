<%@page import="com.muthagroup.bo.Get_UName_bo"%>
<%@page import="java.util.ArrayList"%>
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
<title>DVP Boss Operations</title>

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
<script type="text/javascript" src="js/highslide.js"></script>
<link rel="stylesheet" type="text/css" href="css/highslide.css" />

<script type="text/javascript">
    hs.graphicsDir = 'graphics/';
    hs.outlineType = null;
    hs.wrapperClassName = 'colored-border';
</script>
<style type="text/css">
.tftable {
	font-size: 12px;
	color: #333333;
	width: 80%;
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc;
	padding: 8px;
	text-align: left;
}

.tftable td {
	font-size: 12px;
	padding: 8px;
}
</style>

<script type="text/javascript">
function validateForm() {
	
	var opNo=document.getElementById("opno");
	var newOpNo=document.getElementById("opnoNew");
	var operation=document.getElementById("operation");
	var operationNew=document.getElementById("operationNew");
	
 
	
	if(opNo.disabled ==false){
		 if(opNo.value=="null" || opNo.value==null || opNo.value==""){
			alert("Operation Number ???");
			return false;
		 }
		}
	 if(opNo.disabled==true){
		 if(newOpNo.value==null || newOpNo.value==""){
			alert("Operation Number ???");
			return false;
		 }
		}
	  	 
		if(operation.disabled ==false){
			 if(operation.value=="null" || operation.value==null || operation.value==""){
				alert("Operation ???");
				return false;
			 }
			} 
		 if(operation.disabled==true){
			 if(operationNew.value==null || operationNew.value==""){
				alert("Operation ???");
				return false;
			 }
			}
		 
	 
	 
	 
	return true;
}

</script>
<script type="text/javascript">
function editValidateForm() {
	var opNo=document.getElementById("opno");
	var opnoNew=document.getElementById("opno1");
	
	var opNoBtn=document.getElementById("newBtn");
	var opNoNew=document.getElementById("newOpNo");
	
 
	var oprtNew=document.getElementById("editOpr");
	var opBtn=document.getElementById("operation");
	
	var oprtBtn=document.getElementById("addNewOpBtn");
	var newOperation=document.getElementById("newOperation");
	 
	if(opNo.disabled ==false){
		 if(opNo.value=="" || opNo.value==null){
			alert("Operation No ???");
			return false;
		 }
		} 
	 if(opNo.disabled==true){
		 if(opnoNew.value==null || opnoNew.value==""){
			alert("Operation No ???");
			return false;
		 }
		}
	 if(opNoBtn.disabled==true){
		 if(opNoNew.value==null || opNoNew.value==""){
			alert("New Operation No ???");
			return false;
		 }
		}
	 
		if(opBtn.disabled==false){
			 if(opBtn.value== "" || opBtn.value==null){
				alert("Operation ???");
				return false;
			 }
			} 
		 if(opBtn.disabled==true){
			 if(oprtNew.value==null || oprtNew.value==""){
				alert("Operation ???");
				return false;
			 }
			}
		 
		 if(oprtBtn.disabled==true){
			 if(newOperation.value==null || newOperation.value==""){
				alert("New Operation ???");
				return false;
			 }
			}
		 
		 return true;
}
</script>

<script type="text/javascript">

function addnewOper(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "newOperation");	
	var here = document.getElementById("addNewOpr");
	here.appendChild(element);
	
	
	var e1 = document.getElementById("addNewOpBtn");
	e1.setAttribute('disabled', 'disabled');

	var e2 = document.getElementById("editOpr");
	e2.setAttribute('disabled', 'disabled');
	
	var e1 = document.getElementById("opbtn1");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("operation");
	e.setAttribute('disabled', 'disabled');
	
}


function addnewOpNo(type) {

	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "newOpNo");
	var here = document.getElementById("newON");
	here.appendChild(element);
	
	var e1 = document.getElementById("opno1");
	e1.setAttribute('disabled', 'disabled');

	var e2 = document.getElementById("opnobtn1");
	e2.setAttribute('disabled', 'disabled');
	
	var e1 = document.getElementById("opno");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("newBtn");
	e.setAttribute('disabled', 'disabled');
}


function addopno(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "opnoNew");
	var here = document.getElementById("opr");
	here.appendChild(element);

	var e1 = document.getElementById("opno");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("opnobtn");
	e.setAttribute('disabled', 'disabled');
}
function addoperation(type) {
	
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "operationNew");
	var here = document.getElementById("getop");
	here.appendChild(element);

	var e = document.getElementById("opbtn");
	e.setAttribute('disabled', 'disabled');
	
	var e = document.getElementById("operation");
	e.setAttribute('disabled', 'disabled');
	
}


function changeOpno(type) 
{
	document.getElementById("opno1").disabled=false;

	var e1 = document.getElementById("opno");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("opnobtn1");
	e.setAttribute('disabled', 'disabled');
}

function editoperation(type) 
{
	document.getElementById("editOpr").disabled=false;

	var e1 = document.getElementById("operation");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("opbtn1");
	e.setAttribute('disabled', 'disabled');
}



</script>




<script type="text/javascript">
function getOpn_Names(str) {
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
			document.getElementById("opn_names").innerHTML = xmlhttp.responseText;
		}
	};
	xmlhttp.open("POST", "getOpn_Names.jsp?opn_no=" + str, true);
	xmlhttp.send();
};
</script>


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
					<li><a href="#">All DVP Sheets</a></li>
				<li><a href="EditSheet.jsp">Edit DVP Sheets</a></li>
					<li><a href="Approval_Requests.jsp">Approvals Requests</a></li>
					<li><a href="#">Reports</a></li>
					<li><a href="Search.jsp">Search</a></li>
				<li><a href="Logout.jsp" class="last"><strong> Log Out (<%=User_Name %>)</strong></a></li>
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
			String sheet_no_str = null;
			String action = null;
			action = request.getParameter("action");
			System.out.println("you hav to take " + action + " Action ");
			int sheet_no = 0;
			sheet_no_str = request.getParameter("sheet_no");

			Connection con = Connection_Utility.getConnection();

			if (sheet_no_str != null) {
				sheet_no = Integer.parseInt(sheet_no_str);
			}
	%>

	<div class="templatemo_section_1">
		<%
			if (action.equals("new")) {
		%>
		<form action="Add_Operation" class="register" method="post" enctype="multipart/form-data"
			id="myForm" name="myForm" onSubmit="return(validateForm());">

			<table width="57%">
				<tr>
					<th colspan="26" align="left" scope="col"
						style="font-size: 25px; color: #2883B8">Add Operation</th>
				</tr>
				<tr>
					<td width="20%">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="24%">&nbsp;</td>
					<td width="10%">&nbsp;</td>
					<td width="45%">&nbsp;</td>
				</tr>
				<tr>
					<td>Sheet Number</td>
					<td>:</td>
					<td><strong><%=sheet_no%></strong></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<input type="hidden" name="hid_sheet_no" value="<%=sheet_no%>">
				</tr>

				<tr>
					<td>Operation No</td>
					<td>:</td>
					<%
						PreparedStatement ps_getOpnNos = con
										.prepareStatement("select Opn_No from dev_operation_no_mst_tbl");
								ResultSet rs_getOpnNos = ps_getOpnNos.executeQuery();
					%>
					<td><select name="opno" id="opno"
						onchange="getOpn_Names(this.value)"
						style="cursor: pointer; max-width: 11em;">
							<option value="null">----- Select -----</option>
							<%
								while (rs_getOpnNos.next()) {
							%>
							<option value="<%=rs_getOpnNos.getString("Opn_No")%>"><%=rs_getOpnNos.getString("Opn_No")%></option>
							<%
								}
							%>

					</select></td>

					<td><input type="button" onClick="addopno('opno')"
						id="opnobtn" value="If other" style="cursor: pointer" /></td>
					<td><span id="opr"></span></td>
				</tr>
				<tr>

					<td>Operation</td>
					<td>:</td>
					<td>
						<div id="opn_names">
							<select name="operation" id="operation"
								style="cursor: pointer; max-width: 11em;">
								<option value="null">----- Select -----</option>
							</select>
						</div>
					</td>

					<td><input type="button" onClick="addoperation('operation')"
						id="opbtn" value="If other" style="cursor: pointer" /></td>
					<td><span id="getop"></span></td>
				</tr>
				
				<tr>
					<td>Operation Image( If Any )</td>
					<td>:</td>
					<td colspan="3"><input type="file" name="op_image" id="op_image" size="40"></td> 
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><input type="submit" name="Submit" value="Add Operation" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>

		</form>
		<%
			} else {
		%>
		<form action="Edit_Operation" class="register" method="post" enctype="multipart/form-data"
			id="myForm1" name="myForm1" onSubmit="return(editValidateForm());">

			<b>
				<table width="87%" height="163" border="0" class="tftable">
					<tr>
						<td colspan="10"><span
							style="font-size: 25px; color: #2883B8">Edit Operation</span></td>
					</tr>
					<tr>
						<td width="23">&nbsp;</td>
						<td width="147" style="font-size: 20px">Sheet No</td>
						<td width="18">:</td>
						<td width="78" style="font-size: 20px"><%=sheet_no%></td>
						<td width="72">&nbsp;</td>
						<td width="143">&nbsp;</td>
						<td width="18">&nbsp;</td>
						<td width="158">&nbsp;</td>
						<td width="31">&nbsp;</td>
						<td width="31">&nbsp;</td>
					</tr>
					<tr>
					<td></td>
					<td><strong>Change Operation No</strong></td>
					<td>:</td>
					<%
						int rel_id = 0;
								int opn_no_id = 0;
								int opn_id = 0;

								rel_id = Integer.parseInt(request.getParameter("relId"));

								PreparedStatement ps_getOpnAndOpnNo = con
										.prepareStatement("select opnno_id,opn_id from dev_opn_opnno_rel_tbl where opnno_opn_rel_id="
												+ rel_id);
								ResultSet rs_getOpnAndOpnNo = ps_getOpnAndOpnNo
										.executeQuery();
								while (rs_getOpnAndOpnNo.next()) {
									opn_id = rs_getOpnAndOpnNo.getInt("opn_id");
									opn_no_id = rs_getOpnAndOpnNo.getInt("opnno_id");
								}
								rs_getOpnAndOpnNo.close();
								ps_getOpnAndOpnNo.close();
					%>
					<td><select name="opno" id="opno"
						onchange="getOpn_Names(this.value)"
						style="cursor: pointer; max-width: 11em;">
							<%
								String selOpnNo = null;
										PreparedStatement ps_selOpnNo = con
												.prepareStatement("select Opn_No from dev_operation_no_mst_tbl where opnno_id="
														+ opn_no_id);
										ResultSet rs_selOpnNo = ps_selOpnNo.executeQuery();
										while (rs_selOpnNo.next()) {
											selOpnNo = rs_selOpnNo.getString("Opn_No");
							%>
							<option value="<%=rs_selOpnNo.getString("Opn_No")%>"><%=rs_selOpnNo.getString("Opn_No")%></option>
							<%
								}
										rs_selOpnNo.close();
										ps_selOpnNo.close();

										PreparedStatement ps_getOpnNos = con
												.prepareStatement("select Opn_No from dev_operation_no_mst_tbl where opnno_id!="
														+ opn_no_id);
										ResultSet rs_getOpnNos = ps_getOpnNos.executeQuery();
										while (rs_getOpnNos.next()) {
							%>
							<option value="<%=rs_getOpnNos.getString("Opn_No")%>"><%=rs_getOpnNos.getString("Opn_No")%></option>
							<%
								}
										rs_getOpnNos.close();
										ps_getOpnNos.close();
							%>

					</select></td>
					<td><input type="button" onClick="changeOpno('opno')"
						id="opnobtn1" value="to Edit" style="cursor: pointer" /></td>

					<td>Edit Operation No&nbsp;</td>
					<td>:</td>
					<td><input type="text" name="opno" id="opno1"
						value="<%=selOpnNo%>" disabled="disabled"></td>
					</tr>
					<tr>
					  <td></td>
					  <td>&nbsp;</td>
					  <td>&nbsp;</td>
					  <td>&nbsp;</td>
					  <td><input name="button" type="button"
						id="newBtn" style="cursor: pointer" onClick="addnewOpNo('new_opno')" value="If other" /></td>
					  <td>Add New Operation No :</td>
					  <td>:</td>
					  <td><span id="newON"></span></td>
					  <td>&nbsp;</td>
					  <td>&nbsp;</td>
					  <td width="31">&nbsp;</td>
					  <td width="31">&nbsp;</td>
				  </tr>
					<tr>
						<td></td>
						<td>Change Operation</td>
						<td>:</td>
						<td><div id="opn_names">
								<select name="operation" id="operation"
									style="cursor: pointer; max-width: 11em;">
									<%
										String op = null;
												PreparedStatement ps_getSelOpn = con
														.prepareStatement("select operation from dev_operation_mst_tbl where opn_id="
																+ opn_id);
												ResultSet rs_getSelOpn = ps_getSelOpn.executeQuery();
												while (rs_getSelOpn.next()) {
													op = rs_getSelOpn.getString("operation");
									%>
									<option value="<%=rs_getSelOpn.getString("operation")%>"><%=rs_getSelOpn.getString("operation")%></option>
									<%
										}
												rs_getSelOpn.close();
												ps_getSelOpn.close();
									%>
								</select>
							</div></td>
						<td><input type="button" onClick="editoperation('opno')"
							id="opbtn1" value="to Edit" style="cursor: pointer" /></td>


						<td>Edit Operation</td>
						<td>:</td>
						<td><input type="text" id="editOpr" name="operation"
							value="<%=op%>" disabled="disabled" /></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
					  <td height="37" colspan="4">&nbsp;</td>
					  <td><input name="button2" type="button"
						id="addNewOpBtn" style="cursor: pointer" onClick="addnewOper('new_operation')" value="If other" /></td>
					  <td>Add New Operation  </td>
					  <td>:</td>
					  <td><span id="addNewOpr"></span></td>
					  <td>&nbsp;</td>
					  <td>&nbsp;</td>
				  </tr>
				  <tr>
						<td width="23">&nbsp;</td>
						<td width="147">Operation Image</td>
						<td width="18">:</td>
						<%
								PreparedStatement ps_im = con
													.prepareStatement("select * from dev_opopno_attachments_tbl where Enable_Id=1 and Opn_Basic_Id=(select Opn_Basic_Id from dev_opnandopnno_basic_rel_tbl where OpnNo_Opn_Rel_Id="
															+rel_id
															+ ")");
											ResultSet rs_im = ps_im.executeQuery();
							%>
							<td width="80">
								<%
									while (rs_im.next()) {
								%>
								  
<a href="OpImageView.jsp?field=<%=rs_im.getInt("dev_opopno_attach_id")%>" style="cursor:pointer"><%=rs_im.getString("file_name") %></a>
								<%
 								}
 								%>
							</td>
						<td width="72">&nbsp;</td>
						<td width="143">&nbsp;</td>
						<td width="18">&nbsp;</td>
						<td width="158">&nbsp;</td>
						<td width="31">&nbsp;</td>
						<td width="31">&nbsp;</td>
					</tr>
					 <tr>
						<td width="23">&nbsp;</td>
						<td width="147">Change Operation Image</td>
						<td width="18">:</td>
						<td width="78" colspan="4"><input type="file" name="upOp_image" id="upOp_image" size="40"> </td>
						<td width="158">&nbsp;</td>
						<td width="31">&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><input type="hidden" name="rel_id" value="<%=rel_id%>">
						<input type="hidden" name="basic_id"
							value="<%=sheet_no%>">
							<input type="hidden" name="avail_opn_id"
							value="<%=opn_id%>">
							<input type="hidden" name="avail_opn_no_id"
							value="<%=opn_no_id%>">
						</td>
						<td height="37" colspan="4"><input
							name="Submit" type="submit" value="Edit Operation" style="width: 150px; height: 30px; border-style: outset; color: #08403C;"  /></td> 
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</b>
		</form>


		<%
			}
		%>
	</div>
	<ul id="menu" class="templatemo_section_2">
		<li class="ui-state-disabled" style="color: #020303;"><strong> DVP BOSS</strong></li>

	<li><a href="NewSheet.jsp?action=new" style="font-size: 12px;">New DVP
				Sheet</a></li>


		<li><a href="My_Approvals.jsp" style="font-size: 12px;">My
				Approvals</a> </li>
	<li><a href="Approval_Status.jsp" style="font-size: 12px;">Approval
				Status</a> </li>

	</ul>
	<!-- ----------------------------------------------------------------------------------------------- -->
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

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