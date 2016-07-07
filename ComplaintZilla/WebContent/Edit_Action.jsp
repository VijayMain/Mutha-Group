<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.muthagroup.bo.Login_BO"%>
<%@page import="com.muthagroup.vo.Login_VO"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="cache-control" content="no-cache" />
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-back");
	if (session.getAttribute("uid") == null)
		response.sendRedirect("login.jsp");
%>

<html>
<head>
<title>Edit Action</title>


<!-- Stylesheets -->
<link rel="stylesheet" href="css/style.css">


<!-- Optimize for mobile devices -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- jQuery & JS files -->

<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/style1.css" />
<script src="js/script.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script src="js/jquery.autocomplete.js"></script>
</head>
<body>
	<%@ page import="com.muthagroup.bo.GetUserName_BO"%>
	<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
	<%@page import="com.muthagroup.vo.Edit_VO"%>

	<%
		Edit_VO bean = new Edit_VO();
		GetUserName_BO ubo = new GetUserName_BO();
		int count = 0;
		int action_id=0;
		
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		count = Integer.parseInt(session.getAttribute("count").toString());
		String U_Name = ubo.getUserName(uid);
		action_id=Integer.parseInt(request.getParameter("a_id"));
		try {
			Connection con = Connection_Utility.getConnection();
	%>

	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width cf">

			<ul id="nav" class="fl">

				<li class="v-sep"><a href="#"
					class="round button dark menu-user image-left">Logged in as <strong><%=U_Name%></strong></a></li>
				<li><a href="All_Complaint_Others.jsp"
					class="round button dark menu-email-special image-left"><%=count%>
						New Complaints</a></li>
				<!--<li><a href="All_Complaint_Others.jsp"
					class="round button dark menu-email-special image-left"> All
						Complaints</a></li>-->
				<li><a href="logout.jsp"
					class="round button dark menu-logoff image-left">Log out</a></li>
			</ul>
			<!-- end nav -->


			<form action="#" method="POST" id="search-form" class="fr">
				<fieldset>
					<input type="text" id="search-keyword"
						class="round button dark ic-search image-right" /> <input
						type="hidden" value="SUBMIT" />
				</fieldset>
			</form>

		</div>
		<!-- end full-width -->

	</div>
	<!-- end top-bar -->



	<!-- HEADER -->
	<div id="header-with-tabs">

		<div class="page-full-width cf">

			<ul id="tabs" class="fl">
				<li><a href="Home.jsp" class="active-tab dashboard-tab">Home</a></li>

				<li><a href="Report_List_Others.jsp"
					class="active-tab dashboard-tab">Reports</a></li>
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

		<div class="page-full-width cf">

			<div class="side-menu fl">

				<h3>Content</h3>
				<ul>
					<li><a href="Edit_By_Search_Other.jsp">Search Complaint</a></li>
				</ul>

			</div>
			<!-- end side-menu -->

			<div class="side-content fr">

				<div class="content-module">

					<div class="content-module-heading cf">

						<h3 class="fl">Action</h3>

					</div>
					<!-- end content-module-heading -->

					<div id="form_container">

						<form class="appnitro" action="Edit_Action_Controller"
							method="post">

								
									<div>


											<%
												String complaint_no=null;
												PreparedStatement PS_AP = con
																.prepareStatement("select * from complaint_tbl_action where Action_Id="
																		+ action_id);
														ResultSet rs_AP = PS_AP.executeQuery();
											%>
											
											<%
												while (rs_AP.next()) {
													complaint_no=rs_AP.getString("Complaint_No");
											%>
								</div></li>
								
								<li id="li_10"><label class="description" for="element_10">Action ID</label> 
									<input type="text" id="a_no" readonly="readonly" name="a_no" value="<%=action_id%>" />
								 </li>
								<li id="li_10"><label class="description" for="element_10">Complaint_No</label>
									<input type="text" id="c_no" readonly="readonly" name="c_no" size="45" value="<%=complaint_no%>" />		
								</li>
								<li id="li_10"><label class="description" for="element_10">Current Phase</label>
								<%
									PreparedStatement ps_phase=con.prepareStatement("select phase_name from Complaint_tbl_Phase where Phase_Id="+rs_AP.getInt("Phase_Id"));
									ResultSet rs_phase=ps_phase.executeQuery();
										while(rs_phase.next())
										{
									
								%>
									<input type="text" id="c_no" readonly="readonly" name="c_no" size="45" value="<%=rs_phase.getString("Phase_Name")%>" />		
								<%
										}
							
								%>
								</li>				
								<li id="li_10"><label class="description" for="element_10">Action
										Type</label>
									<div>
										<input type="text" id="a_type" name="a_type" size="45"
											value="<%=rs_AP.getString("Action_Type")%>" title="Maximum 45 Characters" />
									</div></li>



								<li id="li_1"><label class="description" for="element_1">Action
										Description</label>
									<div>
										<textarea id="element_1" name="action_description"
											class="element textarea medium"><%=rs_AP.getString("Action_Discription")%></textarea>
									</div></li>

								<%
												}
								%>
								<li class="buttons"><input id="saveForm"
									class="button_text" type="submit" name="submit"
									onclick="loadSubmit()" value="UPDATE" />
									<a href="Complaint_Action.jsp?hid=<%=complaint_no %>"><strong
										style="font-size: large;">Back</strong></a></li>
												</ul>
							<%
					
								} catch (Exception e) {
									e.printStackTrace();
								}
							%>
						</form>

					</div>
				</div>
				<!-- end content-module -->

			</div>
			<!-- end half-size-column -->

		</div>
		<!-- end content-module-main -->

	</div>
	<!-- end content-module -->

	<!-- FOOTER -->
	<div id="footer">

		<p>
			<a href="http://www.muthagroup.com">Mutha Group of Foundries, Satara</a>
		</p>

	</div>
	<!-- end footer -->


</body>
<script>
	jQuery(function() {
		$("#a_type").autocomplete("auto_Action.jsp");
	});
</script>
</html>