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
<title>Development Summary</title>

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
<style type="text/css">
#templatemo_menu {
	float: left;
	width: 100%;
	height: 48px;
	background: url(images/templatemo_menu_bg.jpg);
	padding: 5px 0 0 0;
}
</style>
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
 function openPage(pageURL)
 {
	 window.location.href = pageURL;
 }
</script>
<script>
$(function() {
$( "#menu" ).menu();
});
</script>
<style>
.ui-menu {
	width: 150px;
}
</style>
<!-- CSS goes in the document HEAD or added to your external stylesheet -->
<style type="text/css">
.tftable {
	font-size: 12px;
	color: #333333;
	width: 80%;
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
	text-align: center;
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

<script type="text/javascript">
	function ChangeColor(tableRow, highLight) 
	{
		if (highLight) 
		{
			tableRow.style.backgroundColor = '#CFCFCF';
		} 
		else 
		{
			tableRow.style.backgroundColor = '#EDEDED';
		}
	}
</script>

<script language="javascript">
	function button1(val) 
	{
		var val1 = val;
		//alert(val1);
		document.getElementById("hid").value = val1;
		myForm.submit();
	}
</script>
<script type="text/javascript">

function getSummary(){
	var custId = document.getElementById("cust").value;
	var U_Id = document.getElementById("plead").value;
	window.location.href="Dev_Summary_Sheet.jsp?custid="+custId+"&plead="+U_Id;
}
</script>

</head>
<%
	int uid = 0;
	int plant_id = 0, PlantVendor = 0;
	int cast_id = 0, castVendor = 0;
	String User_Name = null;

	uid = Integer.parseInt(session.getAttribute("uid").toString());

	Get_UName_bo bo = new Get_UName_bo();

	User_Name = bo.get_UName(uid);

	try {
		Connection con = Connection_Utility.getConnection();
%>
<body>
	<div id="templatemo_header_wrapper">
		<!--  Free Web Templates by TemplateMo.com  -->
		<div id="templatemo_header">

			<!-- 	<div id="site_logo"></div> -->

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



	<div style="width: 100%;float: left;">

		<form action="DVP_SheetView.jsp" class="register" method="post"
			id="myForm" name="myForm" onsubmit="return(validate());">
 <input type="hidden" name="hid" id="hid">
 
 <table class="tftable" width="40%" border="0">
				<tr align="center">
				<th colspan="3" align="center">Select Filter</th> 
				</tr> 
				<tr align="center">
				<td><strong>Select Customer :</strong> <select name="cust" id="cust">
				<option value="0">- - - - Select - - - -</option>
				<%
				PreparedStatement ps_cust1=con.prepareStatement("select * from customer_tbl");
				ResultSet rs_cust1=ps_cust1.executeQuery();
				while(rs_cust1.next()){
				%>
				<option value="<%= rs_cust1.getInt("Cust_Id")%>"><%=rs_cust1.getString("Cust_Name") %></option>
				<%
				}
				%> 
				</select> </td>
				<td>
				<strong>Select Project Lead :</strong> <select name="plead" id="plead">
				<option value="0">- - - - Select - - - -</option>
				
				<%  
					PreparedStatement ps_us1=con.prepareStatement("select * from user_tbl where dept_id=7");
					ResultSet rs_us1=ps_us1.executeQuery();
					while(rs_us1.next()){
				%>
				<option value="<%=rs_us1.getInt("U_Id")%>"><%=rs_us1.getString("U_Name") %></option> 
				<%
					} 
				%> 
				
				</select> 
				</td>
				<td><input type="button" onclick="getSummary()" value="Get Summary"> </td>  
				</tr> 
 </table>
 
 <%
 int cust=0,plead=0;
 if(request.getParameter("custid")!=null){ 
cust = Integer.parseInt(request.getParameter("custid"));
System.out.print("Customer " + cust);
 }
if(request.getParameter("plead")!=null){
plead = Integer.parseInt(request.getParameter("plead"));
System.out.print("Plead " + plead);
 }

 


 
 %>
  
			<table border="1" class="tftable" width="100%">
				<tr align="center">
					<th rowspan="2">Sheet No</th>
					<th rowspan="2">Customer</th>
					<th rowspan="2">Part Name</th>
					<th rowspan="2">Part Image</th>
					<th rowspan="2">Part No.</th>
					<th rowspan="2">Project Lead</th> 
					<th rowspan="2">Start Date (yyyy/mm/dd)</th>
					<th rowspan="2">Target PPAP Date (yyyy/mm/dd)</th>
					<th colspan="3">Foundry Tooling</th>
					<th colspan="3">Fixtures</th>
					<th colspan="3">Cutting Tooling's</th>
					<th colspan="3">Gauges</th>
					<th colspan="3">Documents</th>
					<th rowspan="2">Remark</th>
				</tr>
				<tr>
					<th>Reqd</th>
					<th>Avail</th>
					<th>Recpt Date (yyyy/mm/dd)</th>
					<th>Reqd</th>
					<th>Avail</th>
					<th>Recpt Date (yyyy/mm/dd)</th>
					<th>Reqd</th>
					<th>Avail</th>
					<th>Recpt Date (yyyy/mm/dd)</th>
					<th>Reqd</th>
					<th>Avail</th>
					<th>Recpt Date (yyyy/mm/dd)</th>
					
					<th>APQP</th>
					<th>Process Sheet</th>
					<th>Final PPAP</th>
				</tr>
				
				<% 
				int basic_id=0,fxCount=0,fxAvailCt=0,ctl=0,ctl_avil=0,gct=0,gctl_avail=0,ftct=0,ftctavl=0;
				ResultSet rs_devBase=null;
				PreparedStatement ps_devBase=null;
				String fxrecptDate="",ctrecptDate="",gaugeRecptDate="";
				//---------------------------------->>>
				if(cust>0 && plead==0)
				{
					System.out.println("customer name is found..");
				ps_devBase=con.prepareStatement("select * from dev_basicinfo_tbl where Cust_Id in("+cust+")");
				rs_devBase=ps_devBase.executeQuery();
				}
				else if(plead>0 && cust==0)
				{
					System.out.println("project lead is found..");
					ps_devBase=con.prepareStatement("select * from dev_basicinfo_tbl where basic_id in(select basic_id from dev_basic_projectlead_rel_tbl where Project_Lead="+plead+")");
					rs_devBase=ps_devBase.executeQuery();
				}
				else if(plead>0 && cust>0)
				{
					System.out.println("customer and project lead both are found..");
					ps_devBase=con.prepareStatement("select * from dev_basicinfo_tbl where Cust_Id="+cust+" and basic_id in(select basic_id from dev_basic_projectlead_rel_tbl where Project_Lead= "+plead+")");
					rs_devBase=ps_devBase.executeQuery();
				}
				else
				{
					System.out.println("BOth are not found....");
					ps_devBase=con.prepareStatement("select * from dev_basicinfo_tbl order by cust_id");
					rs_devBase=ps_devBase.executeQuery();	
				}
				
				while(rs_devBase.next())
				{
					basic_id=rs_devBase.getInt("Basic_Id");
				%>

				<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" onclick="button1('<%=basic_id%>');" align="center">				



					<td><%=rs_devBase.getInt("Basic_Id") %></td>
					<%
					PreparedStatement ps_cust=con.prepareStatement("select Cust_Name from customer_tbl where Cust_Id="+rs_devBase.getInt("Cust_Id") + " order by Cust_Name");
					ResultSet rs_cust = ps_cust.executeQuery();
					while(rs_cust.next()){
					%>
					<td><%=rs_cust.getString("Cust_Name") %></td> 
					<%
					}
					ps_cust.close();
					rs_cust.close();
					
					PreparedStatement ps_part=con.prepareStatement("select Part_Name from cs_part_name_tbl where PartName_Id="+rs_devBase.getInt("PartName_Id"));
					ResultSet rs_part=ps_part.executeQuery();
					while(rs_part.next()){
					%>
					<td><%=rs_part.getString("Part_Name") %></td>
					<%
					}
					ps_part.close();
					rs_part.close();
					%>
					
						<%
						PreparedStatement ps_partImage = con
										.prepareStatement("select PartNo_Id from cs_part_no_tbl where PartNo_Id="
												+ rs_devBase.getInt("PartNo_Id"));
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
						%>
						<img alt="No Image" src="PartImageView.jsp?field=<%=rs_partImageName.getInt("part_photo_id")%>" height="100" width="100" >
						
						 
						<%
							}
						}
						%>
					</td>
					
					
					<%
					
					PreparedStatement ps_partNo=con.prepareStatement("select Part_No from cs_part_no_tbl where PartNo_Id="+rs_devBase.getInt("PartNo_Id"));
					ResultSet rs_partNo=ps_partNo.executeQuery();
					while(rs_partNo.next()){
					%>
					<td><%=rs_partNo.getString("Part_No") %></td>
					<%
					}
					%>
					
					<%
					PreparedStatement ps_Plead=con.prepareStatement("select * from dev_basic_projectlead_rel_tbl where Basic_Id="+basic_id);
					ResultSet rs_Plead=ps_Plead.executeQuery(); 
					%>
					<td>
					<%
					while(rs_Plead.next()){
						PreparedStatement ps_us=con.prepareStatement("select * from user_tbl where U_Id="+rs_Plead.getInt("Project_Lead"));
						ResultSet rs_us=ps_us.executeQuery();
						while(rs_us.next()){
					%>
					<%=rs_us.getString("U_Name") %>
					<%
						}
					}
					%>
					</td>
					
					
					<td><%=rs_devBase.getDate("Actual_Start_Date") %></td>
					<td><%=rs_devBase.getDate("Actual_End_Date") %></td>
					<%
					PreparedStatement ps_ft=con.prepareStatement("select * from dev_foundrytoolingdata_tbl where basic_id="+ basic_id);
					ResultSet rs_ft=ps_ft.executeQuery();
					while(rs_ft.next()){
						System.out.print("ftct" +  rs_ft.getInt("Pattern_Avail"));
						ftct = ftct + rs_ft.getInt("Pattern_Avail") + rs_ft.getInt("CoreBox_Avail"); 
						ftctavl = ftctavl + rs_ft.getInt("Pattern_Required") + rs_ft.getInt("CoreBox_Required");
					}
					%>
					<td><%=ftct %></td>
					<%
					ftct=0;
					%> 
					<td><%=ftctavl %></td>
					<% ftctavl=0;%>
					
					<%
					PreparedStatement ps_ft_recpt=con.prepareStatement("select max(Recpt_Date) from dev_foundrytoolingdata_tbl where Basic_Id="+basic_id);
					ResultSet rs_ft_recpt=ps_ft_recpt.executeQuery();
					
					rs_ft_recpt.last();
					int recptData = rs_ft_recpt.getRow();
					rs_ft_recpt.beforeFirst();
					
					if (recptData > 0) {
					while(rs_ft_recpt.next()){
					%>
					<td><%=rs_ft_recpt.getString("max(Recpt_Date)") %></td>
					<%
					}
					}else{
						%>
						<td></td>
						<% 
					}
					%>
					 
						<%						
					PreparedStatement ps_oprelId=con.prepareStatement("select * from dev_opnandopnno_basic_rel_tbl where basic_id="+ basic_id);
					ResultSet rs_oprelId=ps_oprelId.executeQuery();
					while(rs_oprelId.next()){
					
						PreparedStatement ps_fxct=con.prepareStatement("select * from dev_fixturedata_tbl where opnno_opn_rel_id="+rs_oprelId.getInt("opnno_opn_rel_id"));
						ResultSet rs_fxct = ps_fxct.executeQuery();
						while(rs_fxct.next()){
							fxCount= fxCount + rs_fxct.getInt("fixture_qty");
							fxAvailCt= fxAvailCt + rs_fxct.getInt("avail_qty");
							//System.out.println("Fixture Qty = "+basic_id+"\n" + rs_fxct.getInt("fixture_qty") + "\n add" + fxCount);
						}
						
						PreparedStatement ps_fx_recpt=con.prepareStatement("select max(actual_receipt_date) from dev_fixturedata_tbl where opnno_opn_rel_id="+rs_oprelId.getInt("opnno_opn_rel_id"));
						ResultSet rs_fx_recpt=ps_fx_recpt.executeQuery();
						while(rs_fx_recpt.next()){
							fxrecptDate = rs_fx_recpt.getString("max(actual_receipt_date)");
						}
						
						
						PreparedStatement ps_ctool=con.prepareStatement("select * from dev_cuttingtool_data_tbl where opnno_opn_rel_id="+rs_oprelId.getInt("opnno_opn_rel_id"));
						ResultSet rs_ctool = ps_ctool.executeQuery();
						while(rs_ctool.next()){
							ctl= ctl + rs_ctool.getInt("ctool_quantity");
							ctl_avil= ctl_avil + rs_ctool.getInt("avail_qty");
							
							//System.out.println("ctool Qty = "+basic_id+"\n" + rs_ctool.getInt("ctool_quantity") + "\n add" + ctl);
						}
						
						
						PreparedStatement ps_ct_recpt=con.prepareStatement("select max(ctool_receipt_date) from dev_cuttingtool_data_tbl where opnno_opn_rel_id="+rs_oprelId.getInt("opnno_opn_rel_id"));
						ResultSet rs_ct_recpt=ps_ct_recpt.executeQuery();
						while(rs_ct_recpt.next()){
							ctrecptDate = rs_ct_recpt.getString("max(ctool_receipt_date)");
						}
						
						
						PreparedStatement ps_gauges=con.prepareStatement("select * from dev_gaugedata_tbl where opnno_opn_rel_id="+rs_oprelId.getInt("opnno_opn_rel_id"));
						ResultSet rs_gauges = ps_gauges.executeQuery();
						while(rs_gauges.next()){
							gct= gct + rs_gauges.getInt("gauge_quantity");
							gctl_avail= gctl_avail + rs_gauges.getInt("avail_qty");
						//	System.out.println("gauges Qty = "+basic_id+"\n" + rs_gauges.getInt("gauge_quantity") + "\n add" + gct);
						} 						
						
						PreparedStatement ps_gauge_recpt=con.prepareStatement("select max(gauge_receipt_date) from dev_gaugedata_tbl where basic_id="+basic_id);
						ResultSet rs_gauge_recpt=ps_gauge_recpt.executeQuery();
						while(rs_gauge_recpt.next()){
							gaugeRecptDate = rs_gauge_recpt.getString("max(gauge_receipt_date)");
						}
						
						
					}
					ps_oprelId.close();
					rs_oprelId.close();
					%>
					<td><%=fxCount %></td>
					<%
					fxCount=0;
					%>
					<td><%=fxAvailCt %></td>
					<%fxAvailCt=0; %> 
					
					<td><%=fxrecptDate %></td>
					
					<td><%=ctl %></td>
					<%
					ctl=0;
					%>
					<td><%=ctl_avil %></td>
					<%ctl_avil=0; %>
					<td><%=ctrecptDate %></td>
					
					<td><%=gct %></td>
					<%
					gct=0;
					%>
					<td><%=gctl_avail %></td>
					<%gctl_avail=0; %>
					<td><%=gaugeRecptDate %></td>
					
					
					<%
					PreparedStatement ps_doc=con.prepareStatement("select * from dev_document_tbl where basic_id="+basic_id);
					ResultSet rs_doc=ps_doc.executeQuery();
					
					rs_doc.last();
					int docData = rs_doc.getRow();
					rs_doc.beforeFirst();
					
					if (docData > 0) {
							while(rs_doc.next()){
					%>
					<td><%=rs_doc.getString("apqp_doc") %></td>
					<td><%=rs_doc.getString("process_sheet") %></td>
					<td><%=rs_doc.getString("final_ppap") %></td>
					<%
							}
							}else{
								%>
					<td></td>
					<td></td>
					<td></td>
								<%
							}
					%>
					<td></td>
				</tr>
				<%
				
				}
				rs_devBase.close();
				ps_devBase.close();
				%>
				
			</table>




		</form>
		<%
		con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
	</div>
	<!-- 	<div id="accordion" class="templatemo_section_2">
		<h3>New Sheet</h3>
		<div>
			<a href="NewSheet.jsp" style="font-size: 12px;">New DVP Sheet</a><br />
			<a href="My_Approvals.jsp" style="font-size: 12px;">My Approvals</a><br />
		</div>
		 
	</div> -->

	<!-- <ul id="menu" class="templatemo_section_2">
		<li class="ui-state-disabled" style="color: #020303;"><strong>
				DVP BOSS</strong></li>


		<li><a href="NewSheet.jsp?action=new" style="font-size: 12px;">New
				DVP Sheet</a></li>

		<li><a href="My_Approvals.jsp" style="font-size: 12px;">My
				Approvals</a></li>


		<li><a href="Approval_Status.jsp" style="font-size: 12px;">Approval
				Status</a></li>

		<li><a href="Dev_Summary_Sheet.jsp" style="font-size: 12px;">Development
				Summary</a><br /></li>


	</ul> -->
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