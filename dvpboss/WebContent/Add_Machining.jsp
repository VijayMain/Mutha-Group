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
<title>Add Machining Data</title>

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

<script type="text/javascript">
function validateForm() {
	var machine=document.getElementById("machine_name");
	var newMachine=document.getElementById("newMachine");
	
	var ctSec=document.getElementById("ct_sec");
	var noOfMcUsed=document.getElementById("mcs_used");
	var MCReqd=document.getElementById("mc_reqd");
	var prodShift=document.getElementById("prod_per_shift");
	var mcAvailability=document.getElementById("mc_availability"); 
	
	if(machine.disabled ==false){
		 if(machine.value=="null" || machine.value==null || machine.value==""){
			alert("Machine Used ???");
			return false;
		 }
		} 
	 if(machine.disabled==true){
		 if(newMachine.value==null || newMachine.value==""){
			alert("Machine Used ???");
			return false;
		 }
		}
	 
	 if(ctSec.value=="" || ctSec.value==null){
		 alert("CT Sec ???");
			return false;
	 }
	 
	 if(noOfMcUsed.value=="" || noOfMcUsed.value==null){
		 alert("No of MC's Used ???");
			return false;
	 }
	 if(MCReqd.value=="" || MCReqd.value==null){
		 alert("MC Reqd ???");
			return false;
	 }
	 if(prodShift.value=="" || prodShift.value==null){
		 alert("Prod/ Shift ???");
			return false;
	 }
	 if(mcAvailability.value=="null" || mcAvailability.value==null || mcAvailability.value==""){
		 alert("MC Availability ???");
			return false;
	 }
}

</script>

<script type="text/javascript">
function editvalidateForm() {
	 
	var machine=document.getElementById("machine_name");
	var editMachine=document.getElementById("machineId");
	
	var mcBtn=document.getElementById("newMachinBtn");
	var newMachine=document.getElementById("newMachineAdd");
	
	if(machine.disabled ==false){
		 if(machine.value=="null" || machine.value==null || machine.value==""){
			alert("Machine Used ???");
			return false;
		 }
		}
	if(machine.disabled ==true){
		 if(editMachine.value=="null" || editMachine.value==null || editMachine.value==""){
			alert("Edit Machine Used ???");
			return false;
		 }
		}
	
	if(mcBtn.disabled ==true){
		 if(newMachine.value==null || newMachine.value==""){
			alert("New Machine ???");
			return false;
		 }
		}
	
	
	
}
</script>

<script type="text/javascript">
function  addnewmachine(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "newMachineAdd");
	var here = document.getElementById("newMachine");
	here.appendChild(element);
	
	var e1 = document.getElementById("newMachinBtn");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("machineId");
	e.setAttribute('disabled', 'disabled');
	
	var e1 = document.getElementById("mcbtn");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("machine_name");
	e.setAttribute('disabled', 'disabled');

}

function addmachine(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "newMachine");
	var here = document.getElementById("getmachine");
	here.appendChild(element);

	var e1 = document.getElementById("machine_name");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("mcbtn");
	e.setAttribute('disabled', 'disabled');
}
function editmachine(type) 
{
	document.getElementById("machineId").disabled=false;

	var e1 = document.getElementById("machine_name");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("mcbtn");
	e.setAttribute('disabled', 'disabled');
}
</script>
<script type="text/javascript">
function validatenumerics(key) {
//getting key code of pressed key
var keycode = (key.which) ? key.which : key.keyCode;
//comparing pressed keycodes
 
if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46) 
{
    alert("Only allow numeric Data entry");
    return false;
}else 
{
	return true;
};
}
</script>

<script type="text/javascript">
	function prod_per_shift1() 
	{
		var a = document.getElementById('ct_sec');
		
		//alert(a);
		var b = document.getElementById('mcs_used');

		if (a.value == "") 
		{
			a.value = 0;
		}

		if (b.value == "") 
		{
			b.value = 0;
		}
		var j=(((parseFloat(b.value)*420)/((parseFloat(a.value)/60)))*0.9);
		
		document.getElementById('prod_per_shift').value = j.toFixed(2);
	}
</script>

<script type="text/javascript">
	function machine_reqd1() 
	{
		var a = document.getElementById('prod_per_shift');
		
		//alert(a);
		var b = document.getElementById('schedule_per_month');

		if (a.value == "") 
		{
			a.value = 0;
		}

		if (b.value == "") 
		{
			b.value = 0;
		}
		var j=(parseFloat(b.value)/parseFloat(a.value))/75;
		
		document.getElementById('mc_reqd').value = j.toFixed(2);
	}
</script>

<script type="text/javascript">
	function getMCode(str) {
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
				document.getElementById("mcode").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "MachineCode.jsp?q=" + str, true);
		xmlhttp.send();
	};
</script>


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
					<li><a href="#">Search</a></li>
					<li><a href="Logout.jsp" class="last"><strong> Log Out (<%=User_Name %>)</strong></a>
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
			int rel_id = 0;
			String action = null;

			if (request.getParameter("sheet_no") != null) {
				basic_id = Integer.parseInt(request
						.getParameter("sheet_no"));
				System.out.println("Sheet no...." + basic_id);
			}

			if (request.getParameter("relId") != null) {
				rel_id = Integer.parseInt(request.getParameter("relId"));
				System.out.println("relation id...." + rel_id);
			}

			if (request.getParameter("action") != null) {
				action = request.getParameter("action");
				System.out.println("Basic == " + action);
			}

			Connection con = Connection_Utility.getConnection();

			PreparedStatement ps_getSchedulePM = con
					.prepareStatement("select Schedule_Per_Month from dev_basicinfo_tbl where basic_id="
							+ basic_id);

			ResultSet rs_getSchedulePM = ps_getSchedulePM.executeQuery();

			while (rs_getSchedulePM.next()) {
	%>
	<input type="hidden" name="schedule_per_month" id="schedule_per_month"
		value="<%=rs_getSchedulePM.getInt("Schedule_Per_Month")%>">
	<%
		}
			rs_getSchedulePM.close();
			ps_getSchedulePM.close();
	%>

	<div class="templatemo_section_1">

		<%
			if (action.equalsIgnoreCase("New")) {
		%>


		<form action="Add_Machining_Controller" class="register" method="post"
			id="myForm" name="myForm" onSubmit="return(validateForm());">

			<input type="hidden" name="OpnNo_Opn_Rel_Id" value="<%=rel_id%>">
			<input type="hidden" name="basic_id" value="<%=basic_id%>">

			<table width="70%" border="1" class="gridtable">
				<tr style="background-color: #B0C9D6">
					<th height="33" colspan="7" align="left" scope="col"><span
						style="font-size: 25px; color: #2883B8">Machining Data</span></th>
				</tr>

				<tr>
					<th width="7%" scope="col">Sr. No</th>
					<th width="25%" scope="col">Machine Used</th>
					<th width="10%" scope="col">CT Sec</th>
					<th width="18%" scope="col">MC's Used</th>
					<th width="11%" scope="col">Prod / Shift</th>
					<th width="16%" scope="col">Machine Reqd.</th>
					<th width="13%" scope="col">MC Allocated</th>
				</tr>
				<%
					int sr_no = 0;
							PreparedStatement ps_getPreviousData = con
									.prepareStatement("select * from dev_mcdata_tbl where basic_id="
											+ basic_id);
							ResultSet rs_getPreviousData = ps_getPreviousData
									.executeQuery();

							while (rs_getPreviousData.next()) {
								sr_no = sr_no + 1;
				%>
				<tr>
					<td><%=sr_no%></td>
					<%
						PreparedStatement ps_getMachineName = con
											.prepareStatement("select machine_name from dev_machinename_mst_tbl where machineName_id="
													+ rs_getPreviousData
															.getInt("machinename_id"));
									ResultSet rs_getMachineName = ps_getMachineName
											.executeQuery();

									while (rs_getMachineName.next()) {
					%>
					<td><%=rs_getMachineName
									.getString("machine_Name")%></td>
					<%
						}
									rs_getMachineName.close();
									ps_getMachineName.close();
					%>

					<td><%=rs_getPreviousData.getDouble("CT_sec")%></td>
					<td><%=rs_getPreviousData.getInt("MCs_Used")%></td>
					<td><%=rs_getPreviousData
								.getDouble("production_per_shift")%></td>
					<td><%=rs_getPreviousData.getDouble("MC_Required")%></td>
					<td><%=rs_getPreviousData
								.getString("MC_Allocated")%></td>
				</tr>
				<%
					}
							rs_getPreviousData.close();
							ps_getPreviousData.close();
				%>
			</table>
			</br>
			<table width="71%">
				<tr>
					<th colspan="6" align="left" scope="col"><span
						style="font-size: 25px; color: #2883B8">Add Machining Data
					</span></th>
				</tr>
				<tr>
					<td width="17%">Machine Used</td>
					<td width="1%">:</td>
					<td width="21%"><select name="machine_name" id="machine_name" onChange="getMCode(this.value)"
						style="cursor: pointer; max-width: 11em;">
							<option value="null">----- Select -----</option>
							<%
								PreparedStatement ps_getMachineNames = con
												.prepareStatement("select machine_name from dev_machinename_mst_tbl");
										ResultSet rs_getMachineNames = ps_getMachineNames
												.executeQuery();
										while (rs_getMachineNames.next()) {
							%>
							<option value="<%=rs_getMachineNames.getString("machine_name")%>"><%=rs_getMachineNames.getString("machine_name")%></option>
							<%
								}
							%>
					</select></td>
					<td width="13%">Machine Code</td>
					<td width="1%">:</td>
					<td width="47%" id="mcode"><select name="machine_code"
						id="machine_code">
							<option value="0">- - - - - Select - - - - -</option>
					</select></td>
				</tr>
				<tr>
					<td>CT Sec</td>
					<td>:</td>
					<td><input type="text" name="ct_sec" id="ct_sec"
						onkeypress="return validatenumerics(event);"
						onkeyup="prod_per_shift1()" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>No of MC's Used</td>
					<td>:</td>
					<td><input type="text" name="mcs_used" id="mcs_used"
						onkeypress="return validatenumerics(event);"
						onkeyup="prod_per_shift1()" onChange="machine_reqd1()"></td>
					<td>Prod/ Shift</td>
					<td>:</td>
					<td><input type="text" readonly="readonly"
						name="prod_per_shift" id="prod_per_shift" /></td>
				</tr>
				<tr>
					<td>MC Reqd</td>
					<td>:</td>
					<td><input type="text" readonly="readonly" name="mc_reqd"
						id="mc_reqd" /></td>
					<td>MC Allocated</td>
					<td>:</td>
					<td><input type="text" name="mc_availability" id="mc_availability" style="cursor: pointer; max-width: 11em;">
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="4" align="center"><input type="submit"
						name="Submit" value="Add" /></td>
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
				</tr>
			</table>
		</form>

		<%
			} else {
		%>

		<form action="Edit_Machining_Controller" class="register" method="post"
			id="myForm1" name="myForm" onSubmit="return(editvalidateForm());">
			
			
			<input type="hidden" name="OpnNo_Opn_Rel_Id" value="<%=rel_id%>">
			<input type="hidden" name="basic_id" value="<%=basic_id%>">
			
			
			<table width="97%">
				<tr>
					<th colspan="11" align="left" scope="col"><span
						style="font-size: 25px; color: #2883B8">Edit Machining Data
					</span></th>
				</tr>
				<tr>
				  <td width="1%">     			  </td>
					<td width="20%"><strong>Change Machine Used</strong></td>
					<td width="1%"><strong>:</strong></td>
					<td width="19%">
					
					<select name="machine_name" id="machine_name" onChange="getMCode(this.value)"
						style="cursor: pointer; max-width: 11em;">
						
					<% 
						PreparedStatement ps_getSelMachineData=con.prepareStatement("select * from dev_mcdata_tbl where basic_id="+basic_id+" and OpnNo_Opn_Rel_Id="+rel_id);
						ResultSet rs_getSelMachineData=ps_getSelMachineData.executeQuery();
						int machineName_id=0;
						String machineName=null;
						while(rs_getSelMachineData.next())
						{
							machineName_id=rs_getSelMachineData.getInt("machinename_id");
							PreparedStatement ps_getSelMachineName=con.prepareStatement("select machine_name from dev_machinename_mst_tbl where machinename_id="+machineName_id);
							ResultSet rs_getSelMachineName=ps_getSelMachineName.executeQuery();
							while(rs_getSelMachineName.next())
							{
								machineName=rs_getSelMachineName.getString("machine_name");
								%>
					<option value="<%=machineName %>"><%=machineName %></option>			
								<%
							}
							rs_getSelMachineName.close();
							ps_getSelMachineName.close();
						
					
						PreparedStatement ps_getMachineNames=con.prepareStatement("select machine_name from dev_machinename_mst_tbl where machinename_id!="+machineName_id);
						ResultSet rs_getMachineNames=ps_getMachineNames.executeQuery();
						while(rs_getMachineNames.next())
						{
					%>
					<option value="<%=rs_getMachineNames.getString("machine_name") %>"><%=rs_getMachineNames.getString("machine_name") %></option>
					<%		
						}
					%>
				  </select>					
				  </td>
				  <td width="13%">Machine Code</td>
					<td width="1%">:</td>
					<td width="47%" id="mcode"><select name="machine_code"
						id="machine_code">
						<%
							PreparedStatement ps_getmcCode=con.prepareStatement("select machinecode_id,machinecode from mt_machinecode_mst_tbl where machinecode_id="+rs_getSelMachineData.getInt("machinecode_id"));
							ResultSet rs_getmcCode=ps_getmcCode.executeQuery();
							while(rs_getmcCode.next())
							{
								
						
						%>
							<option value="<%=rs_getmcCode.getInt("machinecode_id")%>"><%=rs_getmcCode.getString("machinecode") %></option>
						<%

							}
						%>
					</select></td></tr>
				<tr>
				  <td>&nbsp;</td>
				  <td>&nbsp;</td>
				  <td>&nbsp;</td>
				  <td>&nbsp;</td>
				  <td>
				  <!-- <input name="button" type="button" id="newMachinBtn"
						style="cursor: pointer"
						onclick="addnewmachine('new_machine_name')" value="If other" />
						 -->
						</td>
				  <td>&nbsp;</td>
				  <td><!-- <strong>Add New Machine </strong> --></td>
				  <td><!-- <strong>:</strong> --></td>
				  <td><!-- <span id="newMachine"></span> --></td>
				  <td>&nbsp;</td>
				  <td>&nbsp;</td>
			  </tr>
				<tr>
				  <td>&nbsp;</td>
					<td><strong>CT Sec</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" value="<%=rs_getSelMachineData.getDouble("CT_sec") %>" name="ct_sec" id="ct_sec" onKeyPress="return validatenumerics(event);" onKeyUp="prod_per_shift1()"/></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="1%">&nbsp;</td>
				</tr>
				<tr>
				  <td>&nbsp;</td>
					<td><strong>No of MC's Used</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" value="<%=rs_getSelMachineData.getInt("MCs_Used") %>"  name="mcs_used" id="mcs_used" onKeyPress="return validatenumerics(event);"  onkeyup="prod_per_shift1()"  onchange="machine_reqd1()"  ></td>
					<td><strong>Prod/ Shift</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" value="<%=rs_getSelMachineData.getDouble("production_per_shift") %>" readonly="readonly" name="prod_per_shift" id="prod_per_shift" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
				  <td>&nbsp;</td>
					<td><strong>MC Reqd</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" value="<%=rs_getSelMachineData.getDouble("MC_Required") %>" readonly="readonly" name="mc_reqd" id="mc_reqd" /></td>
					<td><strong>MC Allocated</strong></td>
					<td><strong>:</strong></td>
					<td><input type="text" name="mc_availability" id="select" value="<%=rs_getSelMachineData.getDouble("MC_Allocated") %>" style="cursor: pointer; max-width: 11em;"></td>
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
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="5" align="center"><input type="submit" name="Submit" value="Edit" />  </td>
					<td>&nbsp;</td>
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
					<td>&nbsp;</td>
				</tr>
</table>
			
			
	  </form>
			
		<%
						}
						rs_getSelMachineData.close();
						rs_getSelMachineData.close();
			}
		%>


	</div>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
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