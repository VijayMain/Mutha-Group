<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.muthagroup.bo.GetUserName_BO"%> 
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script src="js/jquery-1.3.2.min.js" language="javascript"
	type="text/javascript"></script>
<script src="js/jquery-blink.js" language="javscript"
	type="text/javascript"></script>

<script type="text/javascript" language="javascript">
	$(document).ready(function() {
		$('.blink').blink();
	});
</script>


<script type="text/javascript">
	function noBack() {
		window.history.forward();
	};
	noBack();
	window.onload = noBack;
	window.onpageshow = function(evt) {
		if (evt.persisted)
			noBack();
	};
	window.onunload = function() {
		void (0);
	};
</script>
<title>Home</title>
<style type="text/css">
.tftable {
	font-size: 10px;
	color: #333333;
	width: 100%;  
}

.tftable th {
	font-size: 11px;
	background-color: #388EAB; 
	padding: 3px; 
	text-align: center;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 10px; 
	padding: 3px; 
}
</style>
<!-- Stylesheets -->
<link rel="stylesheet" href="css/style.css">

<!-- Optimize for mobile devices -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- jQuery & JS files -->

<script src="js/script.js"></script>

<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = 'white';
		}
	}

	/* function DoNav(theUrl) {
		document.location.href = theUrl;
		//	document.getElementById("frm1").submit();
	} */
	
	function getType(){
		var str = document.getElementById("type").value;
		var str1 = document.getElementById("comp_ser").value;
		//alert(str + "  =  "  + str1);
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
				document.getElementById("getType_data").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "GetTypewiseQuality.jsp?q=" + str + "&r="+str1 , true);
		xmlhttp.send(); 
	};
	
</script>


</head>
<body>

	<SCRIPT LANGUAGE="JavaScript">
		function button1(val) {
			var val1 = val; 
			document.getElementById("hid").value = val1;
			edit.submit();

		}
	</SCRIPT> 
	<%
	try {
		GetUserName_BO ubo = new GetUserName_BO();
		//PreparedStatement ps = null;
		//ResultSet rs = null;
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		//out.println("UID "+ uid);
		String U_Name = ubo.getUserName(uid); 
		//out.print("user name  :"+U_Name);
		String complaint_no = null;
		int count = 0, int_count = 0;
			SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MM-yyyy");
			Connection con = Connection_Utility.getConnection();
			session.setMaxInactiveInterval(-1);
			PreparedStatement ps = con
					.prepareStatement("select * from complaint_tbl order by complaint_date desc limit 5");
			ResultSet rs = ps.executeQuery();

			PreparedStatement ps6 = con
					.prepareStatement("select count(Status_Id) from complaint_tbl where Status_Id=1 and complaint_type='customer'");
			ResultSet rs6 = ps6.executeQuery();
			while (rs6.next()) {
				count = rs6.getInt("count(Status_Id)");
				session.setAttribute("count", count);
			}
			ps6 = con
					.prepareStatement("select count(Status_Id) from complaint_tbl where Status_Id=1 and complaint_type='internal'");
			rs6 = ps6.executeQuery();
			while (rs6.next()) {
				int_count = rs6.getInt("count(Status_Id)");
				session.setAttribute("int_count", int_count);
			}
	%>

	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width cf">

			<ul id="nav" class="fl">
				<li class="v-sep"><a href="Home.jsp"
					class="round button dark menu-user image-left">Logged in as <strong><%=U_Name%></strong></a>
				</li>

				<li><a href="All_Complaint_Others.jsp"
					class="round button dark menu-email-special image-left"
					title="New Customer Complaints"><%=count%> Customer Complaints</a></li>
				<li><a href="All_Complaint_OthersQlty.jsp"
					class="round button dark menu-email-special image-left"
					title="New Internal Complaints"><%=int_count%> Internal
						Complaints</a></li>

				<!-- 
					<li><a href="All_Complaint_Others.jsp"
					class="round button dark menu-email-special image-left"> All
						Complaints</a></li>
				 -->
				<li><a href="logout.jsp"
					class="round button dark menu-logoff image-left">Log out</a></li>
			</ul>
			<!-- end nav -->
			<!-- 	<form action="#" method="POST" id="search-form" class="fr">
				<fieldset>
					<input type="text" id="search-keyword"
						class="round button dark ic-search image-right" /> <input
						type="hidden" value="SUBMIT" />
				</fieldset>
			</form> -->

		</div>
		<!-- end full-width -->

	</div>
	<!-- end top-bar -->



	<!-- HEADER -->
	<div id="header-with-tabs">

		<div class="page-full-width cf">

			<ul id="tabs" class="fl">
				<li><a href="Home.jsp" class="active-tab dashboard-tab">Home</a></li>
				<li><a href="Report_List_Others.jsp" class="active-tab dashboard-tab">Reports</a></li>
				<li><a href="Edit_By_Search_Other.jsp" class="active-tab dashboard-tab">Search</a></li>
				<li><a href="Dashboard.jsp" class="active-tab dashboard-tab">Dashboard</a></li>

			</ul>
			<!-- end tabs -->

			<!-- Change this image to your own company's logo -->
			<!-- The logo will automatically be resized to 30px height. -->
			<a href="Home.jsp" id="company-branding-small" class="fr"><img
				src="images/company-logo.png" alt="ComplaintZilla" /></a>

		</div>
		<!-- end full-width -->

	</div>
	<!-- end header --> 

	<!-- MAIN CONTENT -->
	<div id="content">

		<!-- <div class="page-full-width cf"> --> 
		<!-- 	<div class="side-menu fl"> 
				<h3>Content</h3>
				<ul>
					<li><a href="Edit_By_Search_Other.jsp">Search Complaint</a></li>

				</ul>

			</div> -->
			<!-- end side-menu -->

			<!-- <div class="side-content fr"> -->

				<!-- <div class="content-module"> -->

					<%-- <div class="content-module-heading cf">

						<h3 class="fl">All Complaint's</h3>
						<%
							//********************************************************************************************************************

								//TO display last 3 Complaints at the marketing home page...

								//******************************************************************************************************************
						%>

					</div> --%>
					<!-- end content-module-heading -->


					<div class="content-module-main" style="overflow: scroll;height: 500px;">


						<form name="edit" action="Complaint_Action.jsp" method="post">
							<input type="hidden" name="hid" id="hid">
							<!-- Complaints Home  -->
							<span id="getType_data">
							<table style="width: 100%;" class="tftable"> 
												<tr>
													<th><b>Complaint No</b></th>
													<th style="width: 60px;"><b>Type</b>
														<select name="type" id="type" style="width: 17px;" onchange="getType()">
															<option value="all"></option>
															<option value="all">All</option> 
															<option value="customer">Customer</option>
															<option value="internal">Internal</option>
														</select>(all)
													</th>
													<th><b>Cust Name</b></th>
													<th><b>Company</b>
														<select name="comp_ser" id="comp_ser" style="width: 17px;" onchange="getType()">
															<option value="all"></option>
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
														</select>(all)
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
							String query="select * from complaint_tbl where  Status_id!=5 order by Complaint_Date desc";
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

															PreparedStatement ps_assigned = con.prepareStatement("select U_Name from User_tbl where U_id=" + rs_sel.getInt("Complaint_Assigned_To"));
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
							
						</form>
				<%
					}catch(Exception e){
						e.printStackTrace();
					}
				%>		
					</div>
					<!-- end content-module-main -->

				<!-- </div> -->
				<!-- end content-module -->

			<!-- </div> -->
			<!-- end half-size-column -->

	<!-- 	</div> -->
		<!-- end content-module-main -->

	</div>
	<!-- end content-module -->
	<!-- FOOTER -->
	<div id="footer">

		<p>
			<a href="http://www.muthagroup.com">Mutha Group of Foundries,
				Satara</a>
		</p>

	</div>
	<!-- end footer -->
</body>
</html>