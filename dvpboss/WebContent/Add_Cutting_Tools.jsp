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
<title>Add Cutting Tool</title>

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
function validateForm(){
	var ctoolList =document.getElementById("cuttingtool");
	var ctoolListNew =document.getElementById("cuttingtoolNew");
	
	var ctoolQty =document.getElementById("toolqty");
	var ctoolPONo =document.getElementById("toolpono");
	var poDate =document.getElementById("podate");
	var ctooltargetDate =document.getElementById("targettooldate");
//	var ctoolrecDate =document.getElementById("toolrecptdate");
	
	
	if(ctoolList.disabled ==false){
		 if(ctoolList.value==null || ctoolList.value==""){
			alert("Cutting Tool List ???");
			return false;
		 }
		} 
	 if(ctoolList.disabled==true){
		 if(ctoolListNew.value==null || ctoolListNew.value==""){
			alert("Cutting Tool List ???");
			return false;
		 }
		}
	 
	 if(ctoolQty.value=="" || ctoolQty.value==null){
		 alert("Tool Qty ???");
			return false;
	 }
	 if(ctoolPONo.value=="" || ctoolPONo.value==null){
		 alert("Tool PO No ???");
			return false;
	 }
	 if(poDate.value=="" || poDate.value==null){
		 alert("PO Date???");
			return false;
	 }
	 if(ctooltargetDate.value=="" || ctooltargetDate.value==null){
		 alert("Tool Tgt Date ???");
			return false;
	 }
	/*
	 if(ctoolrecDate.value=="" || ctoolrecDate.value==null){
		 alert("Tool Recpt Date ???");
			return false;
	 }
	*/
}

</script>

<script type="text/javascript">
function editvalidateForm(){
	var cutTool=document.getElementById("cuttingtool");
	var editCutTool=document.getElementById("editcuttingtool");
	
	var cutToolBtn=document.getElementById("ctBtn");
	var newCutTool=document.getElementById("newCuttigTool");
	
	
	var ctQty=document.getElementById("toolqty");
	var ctPoNo=document.getElementById("toolPoNo");
	var podate=document.getElementById("podate");
	var targetDate=document.getElementById("targettooldate");
	//var recDate=document.getElementById("toolrecptdate"); 
	
	
	 	

	if(cutTool.disabled ==false){
		 if(cutTool.value==null || cutTool.value==""){
			alert("Cutting Tool ???");
			return false;
		 }
		} 
	 if(cutTool.disabled==true){
		 if(editCutTool.value==null || editCutTool.value==""){
			alert("Edit Cutting Tool ???");
			return false;
		 }
		}
	 
	 if(cutToolBtn.disabled ==true){
		 if(newCutTool.value==null || newCutTool.value=="" || newCutTool.value=="null"){
			alert("New Cutting Tool ???");
			return false;
		 }
		}
	 
	 if(ctQty.value=="" || ctQty.value==null){
		 alert("Tool Qty ???");
			return false;
	 }
	 if(ctPoNo.value=="" || ctPoNo.value==null){
		 alert("Tool PO No ???");
			return false;
	 }
	 if(podate.value=="" || podate.value==null){
		 alert("PO Date ???");
			return false;
	 }
	 if(targetDate.value=="" || targetDate.value==null){
		 alert("Tool Tgt Date ???");
			return false;
	 }
	 /*
	 if(recDate.value=="" || recDate.value==null){
		 alert("Tool Recpt Date ???");
			return false;
	 }
	 */
}
</script>

<!-- 
Date Picker======>
 -->
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script>
 
	$(function() {
		//	$("#datepicker").datepicker();
		$("#podate").datepicker({
			appendText : " ( MM/DD/YYYY ) "
		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#targettooldate").datepicker({
			appendText : " ( MM/DD/YYYY ) "
		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#toolrecptdate").datepicker({
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
function addnewCtool(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "newCuttigTool");
	var here = document.getElementById("newCT");
	here.appendChild(element);
	
	var e1 = document.getElementById("ctBtn");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("editcuttingtool");
	e.setAttribute('disabled', 'disabled');
	var e1 = document.getElementById("editbtn");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("cuttingtool");
	e.setAttribute('disabled', 'disabled');
}

function addtool(type) {
	var element = document.createElement("input");
	element.setAttribute("type", "text");
	element.setAttribute("name", type);
	element.setAttribute("id", "cuttingtoolNew");
	var here = document.getElementById("tool");
	here.appendChild(element);

	var e1 = document.getElementById("cuttingtool");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("cutbtn");
	e.setAttribute('disabled', 'disabled');
}
function edittool(type) 
{
	document.getElementById("editcuttingtool").disabled=false;

	var e1 = document.getElementById("cuttingtool");
	e1.setAttribute('disabled', 'disabled');

	var e = document.getElementById("editbtn");
	e.setAttribute('disabled', 'disabled');
}

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
	int fixture_id=0;
	int rel_id=0;
	int basic_id=0;
	String action=null;
	int ctd_id=0;
	int ctool_id=0;
	
	action=request.getParameter("action");

	if(request.getParameter("basic_id")!=null)
	{
		basic_id=Integer.parseInt(request.getParameter("basic_id"));
	}
	
	
	try
	{
		Connection con=Connection_Utility.getConnection();
	
%>


	<ul id="menu" class="templatemo_section_2">
		<li class="ui-state-disabled" style="color: #020303;"><strong> DVP BOSS</strong></li>


		<li><a href="NewSheet.jsp?action=new" style="font-size: 12px;">New DVP
				Sheet</a></li>



		<li><a href="My_Approvals.jsp" style="font-size: 12px;">My
				Approvals</a></li>

	<li><a href="Approval_Status.jsp" style="font-size: 12px;">Approval
				Status</a></li>
	</ul>


	<div class="templatemo_section_1">
		<%
			if(action.equalsIgnoreCase("new"))
			{
				
				if(request.getParameter("fixture_Id")!=null)
				{
					fixture_id=Integer.parseInt(request.getParameter("fixture_Id"));
				}
				if(request.getParameter("relId")!=null)
				{
					rel_id=Integer.parseInt(request.getParameter("relId"));
				}
				
				
				
				System.out.println("Fixture Id is...."+fixture_id);
						
		%>
		

		<form action="Add_CT_Controller" class="register" method="post" id="myForm"
			name="myForm" onSubmit="return(validateForm());">

			<input type="hidden" name="fd_id" id="fd_id" value="<%=fixture_id %>"> 
			<input type="hidden" name="rel_id" id="rel_id" value="<%=rel_id %>">
			<input type="hidden" name="basic_id" id="basic_id" value="<%=basic_id %>">
			<table width="60%" border="1" class="gridtable">
				<tr style="background-color: #B0C9D6">
					<th height="33" colspan="6" align="left" scope="col"><span
						style="font-size: 25px; color: #2883B8">Cutting Tools</span></th>
				</tr>
					
				<tr>
					<th width="8%" height="25" scope="col">Sr. No</th>
					<th width="29%" scope="col">Cutting Tool List</th>
					<th width="10%" scope="col">Tool Qty</th>
					<th width="19%" scope="col">PO Date</th>
					<th width="17%" scope="col">Tool Target Date</th>
					<th width="17%" scope="col">Tool Recpt Date</th>
				</tr>
				<%
					PreparedStatement ps_getCTData=con.prepareStatement("select * from dev_cuttingtool_data_tbl where fd_id="+fixture_id);
					ResultSet rs_getCTData=ps_getCTData.executeQuery();
					int sr_no=0;
					while(rs_getCTData.next())
					{
						sr_no=sr_no+1;
						
				%>
				<tr>
					<td height="23"><%=sr_no %></td>
					<%
						PreparedStatement ps_getCTName=con.prepareStatement("select tool_name from dev_cutting_tool_mst_tbl where ctool_Id="+rs_getCTData.getInt("ctool_id"));
						ResultSet rs_getCTName=ps_getCTName.executeQuery();
						while(rs_getCTName.next())
						{
					%>
					<td><%=rs_getCTName.getString("tool_name") %></td>
					<%
						}
					%>
					<td><%=rs_getCTData.getInt("ctool_quantity") %></td>
					<td><%=rs_getCTData.getDate("ctool_po_date") %></td>
					<td><%=rs_getCTData.getDate("ctool_target_date") %></td>
					<td><%=rs_getCTData.getDate("ctool_receipt_date") %></td>
				</tr>
				<%
					}
				%>
			</table>
			</br>
			<table width="94%">
				<tr>
					<th colspan="8" align="left" scope="col"><span style="font-size: 25px; color: #2883B8">Add Cutting Tools </span></th>
				</tr>
				<tr>
					<td width="12%" height="32">Cutting Tool List</td>
					<td width="1%">:</td>
					<td width="11%">
						<select name="cuttingtool" id="cuttingtool" style="cursor: pointer; max-width: 11em;">
							<option value="">----- Select -----</option>
							<%
								PreparedStatement ps_getToolList=con.prepareStatement("select tool_name from dev_cutting_tool_mst_tbl");
								ResultSet rs_getToolList=ps_getToolList.executeQuery();
								
								while(rs_getToolList.next())
								{
								%>
								<option value="<%=rs_getToolList.getString("tool_Name")%>"><%=rs_getToolList.getString("tool_Name")%></option>
								<%	
								}
							%>
							
						</select>
					</td>
					<td width="9%"><input type="button"
						onclick="addtool('cuttingtool')" id="cutbtn" value="If other"
						style="cursor: pointer" /></td>
					<td colspan="1" id="tool"></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					</tr>
					<tr>
					<td height="30">Required Tool Qty</td>
					<td>:</td>
					<td colspan="2"><input type="text" name="toolqty" id="toolqty" onKeyPress="return validatenumerics(event);"/></td>
					<td width="14%">&nbsp;</td>
					<td height="30">Available Tool Qty</td>
					<td>:</td>
					<td colspan="2"><input type="text" name="availtoolqty" id="availtoolqty" onKeyPress="return validatenumerics(event);"/></td>
					
				</tr>
				<tr>
					<td height="30">Tool PO No</td>
					<td>:</td>
					<td colspan="2"><input type="text" name="toolpono" id="toolpono"/></td>
					<td width="14%">&nbsp;</td>
					<td width="9%">PO Date</td>
					<td width="1%">:</td>
					<td width="43%"><input type="text" name="podate" id="podate" /></td>
				</tr>
				<tr>
					<td height="28">Tool Tgt Date</td>
					<td>:</td>
					<td colspan="3"><input type="text" name="targettooldate"
						id="targettooldate" /></td>
					<td>Tool Recpt Date</td>
					<td>:</td>
					<td><input type="text" name="toolrecptdate" id="toolrecptdate" /></td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td colspan="2">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="4" align="center"><input type="submit" name="Submit" value="Add" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td colspan="2">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</form>
		<%

			}
			else
			{
				if(request.getParameter("ctd_id")!=null)
				{
					ctd_id=Integer.parseInt(request.getParameter("ctd_id"));
				}

		%>
		
		<form action="Edit_CT_Controller" class="register" method="post" id="myForm"
			name="myForm" onSubmit="return(editvalidateForm());">

			<input type="hidden" name="ctd_id" id="ctd_id" value="<%=ctd_id %>">
			<input type="hidden" name="basic_id" id="basic_id" value="<%=basic_id %>">
			
			</br>
			<table width="94%">
				<tr>
					<th colspan="7" align="left" scope="col"><span style="font-size: 25px; color: #2883B8">Edit Cutting Tools </span></th>
				</tr>
				<tr>
					<td width="16%" height="26"><strong>Change Cutting Tool </strong></td>
					<td width="1%"><strong>:</strong></td>
					<td width="16%">
						<select name="cuttingtool" id="cuttingtool" style="cursor: pointer; max-width: 11em;">
						<%
						PreparedStatement ps_getCTData=con.prepareStatement("select * from dev_cuttingtool_data_tbl where ctd_id="+ctd_id);
						ResultSet rs_getCTData=ps_getCTData.executeQuery();
						int ct_id=0;
						String ct_name=null;
						while(rs_getCTData.next())
						{
							
							PreparedStatement ps_getSelCT=con.prepareStatement("select ctool_id,tool_name from dev_cutting_tool_mst_tbl where ctool_id="+rs_getCTData.getInt("ctool_id"));
							ResultSet rs_getSelCT=ps_getSelCT.executeQuery();
							while(rs_getSelCT.next())
							{
								ct_id=rs_getSelCT.getInt("ctool_id");
								ct_name=rs_getSelCT.getString("tool_name");
						%>
									<option value="<%=ct_name%>"><%=ct_name%></option>
						<%		
							}
						
								PreparedStatement ps_getToolList=con.prepareStatement("select tool_name from dev_cutting_tool_mst_tbl where ctool_id!="+ct_id);
								ResultSet rs_getToolList=ps_getToolList.executeQuery();
								
								while(rs_getToolList.next())
								{
								%>
								<option value="<%=rs_getToolList.getString("tool_Name")%>"><%=rs_getToolList.getString("tool_Name")%></option>
								<%	
								}
							%>
						</select>					</td>
					<td width="14%"><input type="button"
						onclick="edittool('cuttingtool')" id="editbtn" value="to Edit"
						style="cursor: pointer" /></td>
					<td height="26"><strong>Edit Cutting Tool </strong></td>
					<td><strong>:</strong></td>
					<td colspan="2"><input type="text" value="<%=ct_name %>" name="cuttingtool" id="editcuttingtool" disabled="disabled"/></td>
				</tr>
				<tr>
				  <td height="30">&nbsp;</td>
				  <td>&nbsp;</td>
				  <td>&nbsp;</td>
				  <td><input name="button" type="button" id="ctBtn"
						style="cursor: pointer"
						onclick="addnewCtool('new_cuttingtool')" value="If other" /></td>
				  <td><strong>Add New Cutting Tool </strong></td>
				  <td><strong>:</strong></td>
				  <td><span id="newCT"></span></td>
			  </tr>
				<tr>
				  <td height="30"><strong>Required Tool Qty</strong></td>
				  <td><strong>:</strong></td>
				  <td colspan="2"><input type="text" name="toolqty" id="toolqty" value="<%=rs_getCTData.getInt("ctool_quantity") %>" onKeyPress="return validatenumerics(event);"/></td>
				  
				  <td height="30"><strong>Available Tool Qty</strong></td>
				  <td>:</td>
				  <td colspan="2"><input type="text" name="availtoolqty" id="availtoolqty" value="<%=rs_getCTData.getInt("avail_qty") %>" onKeyPress="return validatenumerics(event);"/></td>
			  </tr>
				<tr>
					<td height="30"><strong>Tool PO No</strong></td>
					<td><strong>:</strong></td>
					<td colspan="2"><input type="text" id="toolPoNo" value="<%=rs_getCTData.getString("ctool_po_no") %>" name="toolpono""/></td>
					<td width="18%"><strong>PO Date</strong></td>
					<td width="1%"><strong>:</strong></td>
					<td width="34%"><input type="text" value="<%=rs_getCTData.getDate("ctool_po_date") %>" name="podate" id="podate" /></td>
				</tr>
				<tr>
					<td height="28"><strong>Tool Tgt Date</strong></td>
					<td><strong>:</strong></td>
					<td colspan="2"><input type="text" value="<%=rs_getCTData.getDate("ctool_target_date") %>" name="targettooldate"
						id="targettooldate" /></td>
					<td><strong>Tool Recpt Date</strong></td>
					<td><strong>:</strong></td>
					<td>
					<%
					if(rs_getCTData.getDate("ctool_receipt_date")!=null){
					%>
					<input type="text" name="toolrecptdate" value="<%=rs_getCTData.getDate("ctool_receipt_date")  %>" id="toolrecptdate" />
					<%
					}else{
					%>
					<input type="text" name="toolrecptdate"  id="toolrecptdate" />
					<%
					}
					%>
					</td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td colspan="2">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="4" align="center"><input type="submit" name="Submit" value="Edit" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td colspan="2">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</form>
				
		<%
			}
		
		%>
	</div>
	<%

			}
	}catch(Exception e)
	{
		e.printStackTrace();
	}
	%>
	
	
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
