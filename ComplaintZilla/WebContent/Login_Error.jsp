<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>

<script language="JavaScript" src="gen_validatorv4.js"
	type="text/javascript" xml:space="preserve"></script>

<script type="text/javascript">
	function showState(str) {
		var xmlhttp;
		//var str=document.getElementById("fname");

		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var a = null;
				document.getElementById("dept").innerHTML = xmlhttp.responseText;
				//document.getElementById("approvers").innerHTML = xmlhttp.responseText;

			}
		};
		xmlhttp.open("POST", "Dept_Name.jsp?q=" + str, true);
		xmlhttp.send();
	};
</script>


<script type="text/javascript">
	function navigateTo(target, newWindow) {
		var url = 'http://192.168.0.6/companyunits.htm';
		if (newWindow) {
			window.open(url, target, '--- attributes here, see below ---');
		} else {
			window[target].location.href = url;
		}
	}
</script>
<script type="text/javascript">
	function navigateToMiki(target, newWindow) {
		var url = 'http://192.168.0.7:8080';
		if (newWindow) {
			window.open(url, target, '--- attributes here, see below ---');
		} else {
			window[target].location.href = url;
		}
	}
</script>
<script type="text/javascript">
	function navigateToCAB(target, newWindow) {
		var url = 'http://192.168.0.7/ECN';
		if (newWindow) {
			window.open(url, target, '--- attributes here, see below ---');
		} else {
			window[target].location.href = url;
		}
	}
</script>
<script type="text/javascript">
	function navigateToittracker(target, newWindow) {
		var url = 'http://192.168.0.7/ittracker';
		if (newWindow) {
			window.open(url, target, '--- attributes here, see below ---');
		} else {
			window[target].location.href = url;
		}
	}
</script>

<script type="text/javascript">
	function navigateTodvpboss(target, newWindow) {
		var url = 'http://192.168.0.7/dvpboss/';
		if (newWindow) {
			window.open(url, target, '--- attributes here, see below ---');
		} else {
			window[target].location.href = url;
		}
	}
</script>

<script type="text/javascript">
	function navigateTofiqurnot(target, newWindow) {
		var url = 'http://192.168.0.7/fiqurnot/';
		if (newWindow) {
			window.open(url, target, '--- attributes here, see below ---');
		} else {
			window[target].location.href = url;
		}
	}
</script>

<link rel="stylesheet" href="css/style.css">

<!-- Optimize for mobile devices -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

</head>
<body>

	<!-- TOP BAR -->
	<div id="top-bar">

		<div class="page-full-width">

			<input type="button"
				class="round button dark ic-left-arrow image-left"
				value="MIKI Login" onclick="navigateToMiki('window', false);">

			<input type="button"
				class="round button dark ic-left-arrow image-left" value="ERP Login"
				onclick="navigateTo('window', false);"> 
				
				<input type="button"
				class="round button dark ic-left-arrow image-left" value="ECN Login"
				onclick="navigateToCAB('window', false);"> 
				
				<input
				type="button" class="round button dark ic-left-arrow image-left"
				value="ITTracker Login"
				onclick="navigateToittracker('window', false);">
				
				<!-- New Links -->
				<input
				type="button" class="round button dark ic-left-arrow image-left"
				value="DVPBOSS Login"
				onclick="navigateTodvpboss('window', false);">
				
				<input
				type="button" class="round button dark ic-left-arrow image-left"
				value="fiqurnot Login"
				onclick="navigateTofiqurnot('window', false);">
				<!-- End -->
				
		</div>
		<!-- end full-width -->

	</div>
	<!-- end top-bar -->



	<!-- HEADER -->
	<div id="header">

		<div class="page-full-width cf">

			<div id="login-intro" class="fl">

				<h1>Login to ComplaintZilla</h1>
				<h5>Enter your credentials below</h5>

			</div>
			<!-- login-intro -->

			<!-- Change this image to your own company's logo -->
			<!-- The logo will automatically be resized to 39px height. -->
			<a href="login.jsp" id="company-branding" class="fr"><img
				src="images/company-logo.png" alt="ComplaintZilla" /></a>

		</div>
		<!-- end full-width -->

	</div>
	<!-- end header -->
	<%
		String str = request.getParameter("q");

		if (str.equals("null")) {
			str = "Please Enter the Correct Credentials . . . !";
		}
	%>


	<!-- MAIN CONTENT -->
	<div id="content">

		<form action="Login_Controller" method="post" id="login-form"
			name="login-form">

			<fieldset>

				<p>

					<label for="login-username">username</label> <input type="text"
						id="login-username" onchange="showState(this.value)"
						class="round full-width-input" name="Login_Name" />
				</p>

				<p>
					<label for="login-password">password</label> <input type="password"
						id="login-password" class="round full-width-input"
						name="Login_Password" />
				</p>

				<div id="dept">
					<p>

						<label for="login-department">Department</label> <input
							type="text" name="U_Dept" id="dept"
							onchange="showState(this.value)" class="round full-width-input">

					</p>
				</div>


				<p>

					<label for="login-username"><b style="color: red;"><%=str%></b></label>
				</p>

				<input type="submit"
					class="button round blue image-right ic-right-arrow" name="LOGIN"
					value="LOG IN">
			</fieldset>

			<br />


		</form>
		<!--  
		//********************************************************************************************************
		//Form Validation Script
-->
		<script language="JavaScript" type="text/javascript"
			xml:space="preserve">
			var frmvalidator = new Validator("login-form");

			frmvalidator.addValidation("Login_Name", "req",
					"Please enter your First Name");
			frmvalidator.addValidation("Login_Name", "maxlen=20",
					"Max length for FirstName is 20");

			frmvalidator.addValidation("Login_Password", "req",
					"Please enter Password");
			frmvalidator.addValidation("Login_Password", "maxlen=20",
					"Max length is 20");

			frmvalidator.addValidation("U_Dept", "req",
					"Please select your Department");
			frmvalidator.addValidation("U_Dept",
					"Please Select Your Department");
		</script>
		<!--  
		//*****************************************************************************************************
-->

	</div>
	<!-- end content -->



	<!-- FOOTER -->
	<div id="footer">

		<p>
			<a href="http://www.muthagroup.com">Mutha Group of Foundries, Satara</a>
		</p>

	</div>
	<!-- end footer -->

</body>
</head>
<body>

</body>
</html>