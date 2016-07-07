<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<!--============================================================================-->
<!--====================== Design Script =============================-->
<!--============================================================================-->

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
<title>ECN Login</title>
<script language="JavaScript" src="js/gen_validatorv4.js"
	type="text/javascript" xml:space="preserve"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="description"
	content="Expand, contract, animate forms with jQuery wihtout leaving the page" />
<meta name="keywords"
	content="expand, form, css3, jquery, animate, width, height, adapt, unobtrusive javascript" />
<link rel="shortcut icon" href="../favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script src="js/cufon-yui.js" type="text/javascript"></script>
<script src="js/ChunkFive_400.font.js" type="text/javascript"></script>
<script type="text/javascript">
	Cufon.replace('h1', {
		textShadow : '1px 1px #fff'
	});
	Cufon.replace('h2', {
		textShadow : '1px 1px #fff'
	});
	Cufon.replace('h3', {
		textShadow : '1px 1px #000'
	});
	Cufon.replace('.back');
</script>
<!--============================================================================-->
<!--============================================================================-->
</head>
<body>
	<%
		String str = request.getParameter("q");
		if (str.equals("null")) {
			str = "Check your credentials...";
		}
	%>
	<div class="wrapper">
		<h1 style="text-align: center;">Engineering Change Note (ECN)</h1>
		<h2></h2>
		<div class="content">
			<div id="form_wrapper" class="form_wrapper">

				<form class="login active" action="Login_Controller" method="post"
					id="login-form">
					<h3>Login</h3>
					<div>
						<label>Username:</label> <input type="text" name="name" id="name" />
						<span class="error">This is an error</span>
					</div>
					<div>
						<label>Password: <!-- 
						<a href="forgot_password.html"
							rel="forgot_password" class="forgot linkform">Forgot your
								password?</a> -->
						</label> <input type="password" name="password" id="password" /> <label
							style="color: red;"> Login Fail !!!!!! </label> <label
							style="color: red;"><%=str%></label>
					</div>
					<div class="bottom">
						<!-- <div class="remember">
							<input type="checkbox" /><span>Keep me logged in</span>
						</div> -->
						<input type="submit" value="Login"></input>
						<div class="clear"></div>
					</div>
				</form>


				<!--  
		//********************************************************************************************************
		//Form Validation Script
-->
				<script language="JavaScript" type="text/javascript"
					xml:space="preserve">
					var frmvalidator = new Validator("login-form");

					frmvalidator.addValidation("name", "req",
							"Please enter your Login Name");

					frmvalidator.addValidation("password", "req",
							"Please enter your Login Password");
				</script>
				<!--  
		//*****************************************************************************************************
-->

<!--============================================================================-->
<!--============================================================================-->


			</div>
			<div class="clear"></div>
		</div>
		
	</div>



</body>
</html>