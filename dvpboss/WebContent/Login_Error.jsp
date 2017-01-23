<!DOCTYPE html>
 <html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Login Form</title>
  <link rel="stylesheet" href="css/style.css">
  <!--[if lt IE 9]><script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>
<%
	String str=null;
	
	str=request.getParameter("str");
	
%>

<body>
  <section class="container">
    <div class="login">
      <h1>Login to DVP <img alt="" src="images/dvpboss2.JPG"> </h1>
      <form action="Login_Controller_Dvp" method="post">
        <p><input type="text" name="uname" value="" placeholder="Username"></p>
        <p><input type="password" name="password" value="" placeholder="Password"></p>
        <p><b style="color: red;"><%=str %></b></p>
        <p class="submit"><input type="submit" name="login" value="Login"></p>
      </form>
    </div>
 </section>

</body>
</html>
