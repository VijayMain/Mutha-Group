<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.mysql.jdbc.ResultSetRow"%>
<%@page import="java.util.ArrayList"%>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--====================== Design Script =============================-->
<!--============================================================================-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Add Attachments</title>
<meta name="keywords"
	content="graphite theme, free templates, website templates, CSS, HTML" />
<meta name="description"
	content="Graphite Theme, Contact page, free CSS template provided by templatemo.com" />
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />

<style>
div.scroll {
	background-color: #F0EBF2;
	width: 1120px;
	height: 600px;
	overflow: scroll;
}
</style>


<script language="javascript" type="text/javascript">
	function clearText(field) {
		if (field.defaultValue == field.value)
			field.value = '';
		else if (field.value == '')
			field.value = field.defaultValue;
	}
</script>

<link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/ddsmoothmenu.js">
	/***********************************************
	 * Smooth Navigational Menu- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
	 * This notice MUST stay intact for legal use
	 * Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
	 ***********************************************/
</script>

<script type="text/javascript">
	ddsmoothmenu.init({
		mainmenuid : "templatemo_menu", //menu DIV id
		orientation : 'h', //Horizontal or vertical menu: Set to "h" or "v"
		classname : 'ddsmoothmenu', //class added to menu's outer DIV
		//customtheme: ["#1c5a80", "#18374a"],
		contentsource : "markup" //"markup" or ["container_id", "path_to_menu_file"]
	});
</script>

<!--////// CHOOSE ONE OF THE 3 PIROBOX STYLES  \\\\\\\-->
<link href="css_pirobox/white/style.css" media="screen" title="shadow"
	rel="stylesheet" type="text/css" />
<!--<link href="css_pirobox/white/style.css" media="screen" title="white" rel="stylesheet" type="text/css" />
<link href="css_pirobox/black/style.css" media="screen" title="black" rel="stylesheet" type="text/css" />-->
<!--////// END  \\\\\\\-->

<!--////// INCLUDE THE JS AND PIROBOX OPTION IN YOUR HEADER  \\\\\\\-->
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/piroBox.1_2.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$().piroBox({
			my_speed : 600, //animation speed
			bg_alpha : 0.5, //background opacity
			radius : 4, //caption rounded corner
			scrollImage : false, // true == image follows the page, false == image remains in the same open position
			pirobox_next : 'piro_next', // Nav buttons -> piro_next == inside piroBox , piro_next_out == outside piroBox
			pirobox_prev : 'piro_prev',// Nav buttons -> piro_prev == inside piroBox , piro_prev_out == outside piroBox
			close_all : '.piro_close',// add class .piro_overlay(with comma)if you want overlay click close piroBox
			slideShow : 'slideshow', // just delete slideshow between '' if you don't want it.
			slideSpeed : 4
		//slideshow duration in seconds(3 to 6 Recommended)
		});
	});
</script>

<script src="js/script.js"></script>

<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = '#EDEDED';
		}
	}

	/* function DoNav(theUrl) {
		document.location.href = theUrl;
		//	document.getElementById("frm1").submit();
	} */
</script>

<script language="javascript">
	function button1(val) {
		var val1 = val;
		//alert(val1);
		document.getElementById("hid").value = val1;
		edit.submit();
	}
</script>
<!--////// END  \\\\\\\-->
<!--============================================================================-->
<!--============================================================================-->
</head>

<%@page import="com.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>


<body id="sub_page">
	<div id="templatemo_wrapper">
		<div id="templatemo_top"></div>
		<!-- end of top -->
		<!--========================== Design Script ===============================-->
		<!--============================================================================-->
		<div id="templatemo_header1" class="ddsmoothmenu">
			<ul>
				<li><a href="Cab_Home.jsp">Home</a></li>
				<li><a href="New_Request.jsp">New Request</a></li>
				<li><a href="Cab_Edit_Request.jsp">Edit Request</a></li>
				<li><a href="Add_Action.jsp">Add Action</a></li>
				<li><a href="My_Approvals.jsp">My Approvals</a></li>
				<li><a href="Cab_Search_Request.jsp">Search Request</a></li>
				<li><a href="Reports.jsp">Reports</a></li>
				<li><a href="logout.jsp">Log Out</a></li>
			</ul>
			<br style="clear: left" />
		</div>
		<!--============================================================================-->
		<!--============================================================================-->
		<!-- end of templatemo_menu -->
		<div id="templatemo_menu">
			<div id="site_title">
				<h1 style="color: orange;">ECN</h1>
			</div>
		</div>

		<!-- end of header -->

		<div id="templatemo_main">
			<table>
				<tr>
					<td colspan="2"><h4 style="color: white; margin-bottom: 12px;">Add
							Attachments</h4></td>
				</tr>

			</table>

			<div class="col_w630 float_l">
				<div id="contact_form">

					<!-- <form method="post" name="contact" action="Edit_Request.jsp"> -->
					<form method="post" name="edit"
						action="Cab_ApproveDecline_Request.jsp" id="edit"></form>

				</div>

			</div>

			<div class="cleaner"></div>
		</div>
		<!-- end of main -->
	</div>
	<!-- end of wrapper -->

	<div id="templatemo_footer_wrapper">
		<div id="templatemo_footer">
			| Copyright 2013 <a href="http://www.muthagroup.com">Muthagroup
				Satara</a> |
			<div class="cleaner"></div>
		</div>
	</div>

</body>
<HEAD>
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
	<META HTTP-EQUIV="Expires" CONTENT="-1">
</HEAD>
</html>