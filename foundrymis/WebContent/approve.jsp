<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Approve</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="stationary/bootstrap.min.css">
  <script src="stationary/jquery.min.js"></script>
  <script src="stationary/bootstrap.min.js"></script>
</head>
<body> 
<%
try{
Connection con = ConnectionUrl.getLocalDatabase();
String name_user = "";
if(request.getParameter("userName")!=null){
	name_user = request.getParameter("userName").toString(); 
}
%>
<nav class="navbar navbar-default">
  <div class="container-fluid"> 
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <img src="images/MUTHA LOGO.JPG" class="navbar-brand"/>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Home <span class="sr-only">(current)</span></a></li> 
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Status<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">Pending Approvals</a></li>
            <li><a href="#">Approved Items</a></li>
            <li><a href="#">All </a></li> 
          </ul> 
        </li> 
      </ul>
      <form class="navbar-form navbar-left">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="Search">
        </div>
      </form>
      <ul class="nav navbar-nav navbar-right">
        <li>Hi, <%=name_user %></li>
      </ul>
      
    </div> 
 </nav>




<table class="table table-striped">
  <thead>
    <tr>
      <td align="center"><b>Sr.No</b></td>
      <td align="left"><b>Supplier Name</b></td>
      <td align="left"><b>Request Date</b></td>
      <td align="left"><b>Logged By</b></td>
      <td align="left"><b>Approval</b></td>
    </tr>
  </thead>
  <tbody>
  <%
  	int sr=1; 		
 	PreparedStatement ps = con.prepareStatement("select * from new_item_creation where enable=1 and approval_status=0");
	ResultSet rs = ps.executeQuery();
    while(rs.next()){ 
  %>
    <tr>
      <td align="center"><%=sr %></td>
      <td align="left"><%=rs.getString("supplier") %></td>
      <td align="left"><%=rs.getTimestamp("registered_date") %></td>
      <td align="left"><%=rs.getString("registered_by") %></td>
      <td align="left">Pending</td>
    </tr> 
  <%
  sr++;
    }
  %>  
  </tbody>
</table>


<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>