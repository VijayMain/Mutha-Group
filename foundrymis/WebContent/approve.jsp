<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Approve</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="stationary/bootstrap.min.css">
  <script src="stationary/jquery.min.js"></script>
  <script src="stationary/bootstrap.min.js"></script> 
  <script type="text/javascript">
  function myFunction(str,str1) {		
	    document.getElementById("hid_status").value = str;
  		document.getElementById("hid_mode").value = str1;
  		
  		document.getElementById("approve_btn").disabled = true;
  		document.getElementById("decline_btn").disabled = true;
  		
  		document.getElementById("myForm").submit();
  }
  </script>
</head>
<body>
<%
try{
Connection con = ConnectionUrl.getLocalDatabase();
Connection conERP = ConnectionUrl.getBWAYSERPMASTERConnection();
String name_user = "",supp_cat="",tds_code="";

if(request.getParameter("userName")!=null){
	name_user = request.getParameter("userName").toString(); 
	session.setAttribute("uname", name_user);
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
        <li class="active"><a href="approve.jsp?userName=<%=request.getParameter("userName")%>">Home <span class="sr-only">(current)</span></a></li> 
        <!-- <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Status<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">Pending Approvals</a></li>
            <li><a href="#">Approved</a></li>
            <li><a href="#">Declined</a></li>
            <li><a href="#">All </a></li>
          </ul> 
        </li>  -->
      </ul>
    <!-- <form class="navbar-form navbar-left">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="Search">
        </div>
    </form> -->
    <ul class="nav navbar-nav navbar-right">
        <li>Hi,<br> <%=name_user %></li>
    </ul>
    </div>
    </div> 
 </nav>
<table class="table table-striped" style="font-family: Arial;font-size: 12px;">
  <thead>
    <tr>
      <td align="center"><b>Sr.No</b></td>
      <td align="left"><b>Supplier Name</b></td>
      <td align="left"><b>Request Date</b></td>
      <td align="left"><b>Logged By</b></td>
      <td align="left"><b>Approval</b></td>
      <td align="left"><b>Action</b></td>
    </tr>
  </thead>
 <tbody>
  <%
  	int sr=1;
 	PreparedStatement ps = con.prepareStatement("select * from new_item_creation where enable=1 and approval_status=0");
	ResultSet rs = ps.executeQuery();
    while(rs.next()){
    	     PreparedStatement ps_sup = conERP.prepareStatement("select * from MSTMATCATAG where code ='"+ rs.getString("supp_category") + "'");
    	     ResultSet rs_sup = ps_sup.executeQuery();
    	      while(rs_sup.next()){ 
    	    	  supp_cat = rs_sup.getString("NAME");  
    	      }
    	      
    	      ps_sup = conERP.prepareStatement("select * from CNFRATETDS where code ='"+ rs.getString("tds_code") + "'");
     	      rs_sup = ps_sup.executeQuery();
     	      while(rs_sup.next()){
     	    	  tds_code = rs_sup.getString("NAME");  
     	      }
  %>
    <tr>
      <td align="center"><%=sr %></td>
      <td align="left"><%=rs.getString("supplier") %></td>
      <td align="left"><%=rs.getTimestamp("registered_date") %></td>
      <td align="left"><%=rs.getString("registered_by") %></td>
      <td align="left">Pending</td>
      <td align="left">
 	  <a class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal<%=sr%>">Action</a> 
      </td>
    </tr>

 <!-- Modal -->
<div class="modal fade" id="myModal<%=sr%>" role="dialog">
     <div class="modal-dialog modal-lg">
     <div class="modal-content">
     <div class="modal-header">
      	<button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"><%=rs.getString("supplier") %></h4>
     </div>
<div class="modal-body">
<form id="myForm" method="post" class="form-horizontal" action="Item_ApprovalController">
<input type="hidden" name="hid_status" id="hid_status">
<input type="hidden" name="hid_mode" id="hid_mode">
<div style="width: 50%;float: left;">
  <dl>
    <dt>Address</dt>
    <dd>- <%=rs.getString("supp_address") %></dd>
    <dt>Phone Number</dt>
    <dd>- <%=rs.getString("supplier_phone1") %></dd>
    <dd>- <%=rs.getString("supplier_phone2") %></dd>
     <dt>PAN Number</dt>
    <dd>- <%=rs.getString("pan_no") %></dd>
    <dt>Industry Type</dt>
    <dd>- <%=rs.getString("indus_type") %></dd>
  </dl>
  </div>
  <div style="width: 49%;float: right;">
  <dl>
    <dt>City</dt>
    <dd>- <%=rs.getString("supp_city") %></dd>
    <dt>Credit Days</dt>
    <dd>- <%=rs.getString("credit_days") %></dd>
     <dt>TAN Number</dt>
    <dd>- <%=rs.getString("tan_no") %></dd>
    <dt>Supplier Category</dt>
    <dd>- <%=supp_cat %></dd>
     <dt>TDS Code</dt>
    <dd>- <%=tds_code %></dd>
  </dl>
  </div>
  <input type="button" id="approve_btn" value="Approve"  class="btn btn-default" onclick="myFunction(1,'<%= rs.getString("code")%>')" style="background-color: #2cc543;font-weight: bold;">
  <input type="button" id="decline_btn" value="Decline"  class="btn btn-default"  onclick="myFunction(3,'<%= rs.getString("code")%>')" style="background-color: #ff2222;font-weight: bold;">
</form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
    </div>
    </div>
    </div>
</div>
     
  <%
  sr++; 
  supp_cat=""; 
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