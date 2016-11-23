<!DOCTYPE html>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.muthagroup.controller.DailyReport"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connection.ConnectionModel"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<html lang="en">
<head>
  <title>Mutha Group Planner</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1"> 
  <link rel="stylesheet" href="css/bootstrap.min.css" >
  <link rel="stylesheet" href="css/token-input.css" type="text/css" />
  <link rel="stylesheet" href="css/token-input-facebook.css" type="text/css" />
  <link rel="stylesheet" href="css/bootstrap-iso.css" />
  <link rel="stylesheet" href="css/font-awesome.min.css" /> 
  <link rel="stylesheet" href="css/savecss.css" /> 
<link rel="stylesheet" type="text/css" href="assets/css/github.min.css"> 
<script type="text/javascript" src="assets/js/highlight.min.js"></script> 
  <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script> 
  <script type="text/javascript" src="js/formden.js"></script>
  <script type="text/javascript" src="js/jquery.tokeninput.js"></script>  
<script type="text/javascript">  
function callstatusv(str){  
		var xmlhttp;
		if (window.XMLHttpRequest) { 
			xmlhttp = new XMLHttpRequest();
		} else { 
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 
				document.getElementById("ajaxID").innerHTML = xmlhttp.responseText; 
			}
		};
		xmlhttp.open("POST", "GetPrevEvents.jsp?q=" + str, true);
		xmlhttp.send();
	}; 
	
function myFunction(divName) {
	var printContents = document.getElementById(divName).innerHTML;
    var originalContents = document.body.innerHTML;

    document.body.innerHTML = printContents;

    window.print();

    document.body.innerHTML = originalContents;
}
</script>

  <script type="text/javascript" > 
	$(document).on("click", ".modal-link", function () {
     var myBookId = $(this).data('id');
     document.getElementById('lbl').innerHTML =myBookId;
     $(".loginmodal-container #bookId").val( myBookId ); 
});
	
</script> 
  
</head>
<body>
<%
try{ 
if ((session.getAttribute("user")!=null)) 
{
	String username=(String)session.getAttribute("user"); 
%>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="mainpage.jsp"><img src="images/mutha.jpg" class="img-circle" alt="Mutha logo" width=50 height=30> </a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-center">
        <li class="active"><a href="mainpage.jsp"><b>Event Planner</b></a></li>
      	 <li><a href="Create_New.jsp"><b>CREATE NEW</b></a></li>
         <li><a onclick="callstatusv('prev');" style="cursor: pointer;"><b>PREVIOUS</b></a></li>
         <li><a onclick="callstatusv('todays');" style="cursor: pointer;"><b>TODAYS</b></a></li>
         <li><a onclick="callstatusv('upcoming');" style="cursor: pointer;"><b>UPCOMING</b></a></li>
         <li><a onclick="callstatusv('myMeeting');" style="cursor: pointer;"><b>MY MEETINGS</b></a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a  data-toggle="modal" href="#loginModal"><span class="glyphicon glyphicon-log-out"></span><b> <%=username%></b> Logout</a></li>
      </ul>
    </div>
  </div>
</nav>
  

  
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-12 text-left"> 
     <%
     /* ArrayList<String> userlist = new ArrayList<String>(); */
     Connection con =ConnectionModel.getConnection();
     String sql ="";
     java.sql.Date compareDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
     PreparedStatement ps=null,ps_des = null;;
     ResultSet rs = null,rs_des = null;
    sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,DATE_FORMAT(start_time,'%l:%i %p') as start_time, DATE_FORMAT(end_time,'%l:%i %p') as end_time,event_venue,event_desc FROM  events_units where enable_id=1  and event_date >= '"+ compareDate +"'  order by event_date";
    ps = con.prepareStatement(sql);
    rs = ps.executeQuery();
   %> 
 <div style="height: 550px;overflow: scroll;" id="ajaxID"> 
 <table class="table table-bordered">         
 <tr>
 <th>Event Date</th>
 <th>Event</th>
 <th>Details</th>
 <th>Start Time</th>
 <th>End Time</th>
 <th>Venue</th>
 <th>Participants</th>
 </tr>
 <%while (rs.next()) {%>
  <tr> 
  <td><%=rs.getString("event_date") %></td>
  <td><%=rs.getString("text") %></td>
  <td><%=rs.getString("event_desc") %></td>
  <td><%=rs.getString("start_time") %></td>
  <td><%=rs.getString("end_time") %></td>
  <td><%=rs.getString("event_venue") %></td>
  <td width="20%">
  <%
  ps_des = con.prepareStatement("select * from event_users where event_id="+rs.getInt("event_id"));
  rs_des = ps_des.executeQuery();
  while(rs_des.next()){
  %>
  <%=rs_des.getString("user_name") %>,
  <%
  }
  %>
  </td>
  </tr>
 <%
 }
 sql="";
 %> 
 </table>
      
	  </div>
    </div>
  </div>
</div>
<div class="modal fade active" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    	  <div class="modal-dialog">
				<div align="center" class="logoutmodal-container">
					<h3>Are you want to log out</h3><br>
	               <form class="form-inline" action="Logout" method="post">
	                <input  type=submit  class="btn btn-info btn-lg" type="submit" value="Log out"  autofocus >
	                 </form>      		
				</div>
			</div>
		  </div>
        
	   
<%
}
else
{
	response.sendRedirect("index.jsp"); 
} 
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>
