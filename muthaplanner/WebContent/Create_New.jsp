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
  <title>Register New</title>
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
  <link rel="stylesheet" href="js/jquery-ui.css"/>
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> 
  <script type="text/javascript" src="js/formden.js"></script>
  <script type="text/javascript" src="js/jquery.tokeninput.js"></script>  
  
    <script type="text/javascript">
    	$(document).ready(
  			  function () { 
  			    $( "#datePicker" ).datepicker({
  			      changeMonth: true,
  			      changeYear: true,
  			      minDate: "-0",
  			      beforeShowDay: function(date) {
  			          var day = date.getDay();
  			          return [(day != -1), ''];
  			      }
  			    });
  			  }
  	);
</script> 
<script type="text/javascript">
    function showList()
    {
        var t = $('#demo').val();
        document.getElementById("users").setAttribute('value',t);
        alert(t);
    }
    function disable_me(){
    	document.getElementById("delete_query").style.pointerEvents = "none";
    }
</script>
<script>
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
	Connection con =ConnectionModel.getConnection();
	PreparedStatement ps=null;
	ResultSet rs=null;
	String sql="";
	String username=(String)session.getAttribute("user"); 
	if(request.getParameter("avail")!=null){
		%>
		<script type="text/javascript">
		alert("Please Check Meetings Scheduled And Provide Proper Time Range...!!!");
		</script>
		<%
			}
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
      <!--  <li>
       <button type="button" class="btn btn-default">Past Events</button> |
      <button type="button" id='testbtn' class="btn btn-default">Today's Events</button> |
      <a href="#Report" class="btn btn-info" data-id="New Event" data-toggle="modal"role="button">Create new Event</a> |
      <button type="button" class="btn btn-default">Upcoming Events</button> |
      <button type="button" class="btn btn-default">My Events</button>
      </li> -->
      	 <li><a href="Create_New.jsp"><b>CREATE NEW</b></a></li>
         <li><a onclick="callstatusv('prev');" style="cursor: pointer;"><b>PREVIOUS</b></a></li>
         <li><a onclick="callstatusv('todays');" style="cursor: pointer;"><b>TODAYS</b></a></li>
         <li><a onclick="callstatusv('upcoming');" style="cursor: pointer;"><b>UPCOMING</b></a></li>
         <li><a onclick="callstatusv('myMeeting');" style="cursor: pointer;"><b>MY MEETINGS</b></a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="LogOut.jsp"><span class="glyphicon glyphicon-log-out"></span><b> <%=username%></b> Logout</a></li>
      </ul>
    </div>
  </div>
</nav>
<div id="ajaxID">
		<div class="loginmodal-container"> 
				<h1><strong><label id="lbl">New Event/Meeting</label></strong></h1>
	             <form class="form-inline" action="Event" method="post" >
	              <label>Topic / Agenda</label><br>
	              <input class="form-control" name="text" type="text" required maxlength="25"> 
	              <label>Details</label>
	              <br>
	              <textarea name="desc" rows="2" cols="30" required ></textarea>
	              <label>Meeting Date</label>
	              <br>
<input type="text"  name="date" id="datePicker" style="width: 200px;" required/>                 
	              <br>
	              <label>Start</label>
	               <select class="form-control" name="start">
	              <option value=" 7:00 am"> 7:00 am</option>
	              <option value=" 7:15 am"> 7:15 am</option>
	              <option value=" 7:30 am"> 7:30 am</option>
	              <option value=" 7:45 am"> 7:45 am</option> 
	              <option value=" 8:00 am"> 8:00 am</option>
	              <option value=" 8:15 am"> 8:15 am</option>
	              <option value=" 8:30 am"> 8:30 am</option>
	              <option value=" 8:45 am"> 8:45 am</option>
	             <option value=" 9:00 am"> 9:00 am</option>
	             <option value=" 9:15 am"> 9:15 am</option>
	             <option value=" 9:30 am"> 9:30 am</option>
	             <option value=" 9:45 am"> 9:45 am</option> 
	             <option value=" 10:00 am"> 10:00 am</option>
	             <option value=" 10:15 am"> 10:15 am</option>
	             <option value=" 10:30 am"> 10:30 am</option>
	             <option value=" 10:45 am"> 10:45 am</option>
	             <option value=" 11:00 am"> 11:00 pm</option>
	             <option value=" 11:15 am"> 11:15 pm</option>
	             <option value=" 11:30 am"> 11:30 pm</option>
	             <option value=" 11:45 am"> 11:45 pm</option>
	             <option value=" 12:00 pm"> 12:00 pm</option>
	             <option value=" 12:15 pm"> 12:15 pm</option>
	             <option value=" 12:30 pm"> 12:30 pm</option>
	             <option value=" 12:45 pm"> 13:45 pm</option>
	             <option value=" 13:00 pm"> 13:00 pm</option>
	             <option value=" 13:15 pm"> 13:15 pm</option>
	             <option value=" 13:30 pm"> 13:30 pm</option>
	             <option value=" 13:45 pm"> 13:45 pm</option>  
	             <option value=" 14:00 pm"> 14:00 pm</option>
	             <option value=" 14:15 pm"> 14:15 pm</option>
	             <option value=" 14:30 pm"> 14:30 pm</option>
	             <option value=" 14:45 pm"> 14:45 pm</option> 
	             <option value=" 15:00 pm"> 15:00 pm</option>
	             <option value=" 15:15 pm"> 15:15 pm</option>
	             <option value=" 15:30 pm"> 15:30 pm</option>
	             <option value=" 15:45 pm"> 15:45 pm</option> 
	             <option value=" 16:00 pm"> 16:00 pm</option>
	             <option value=" 16:15 pm"> 16:15 pm</option>
	             <option value=" 16:30 pm"> 16:30 pm</option>
	             <option value=" 16:45 pm"> 16:45 pm</option> 
	             <option value=" 17:00 pm"> 17:00 pm</option>
	             <option value=" 17:15 pm"> 17:15 pm</option>
	             <option value=" 17:30 pm"> 17:30 pm</option>
	             <option value=" 17:45 pm"> 17:45 pm</option> 
	             <option value=" 18:00 pm"> 18:00 pm</option>
	             <option value=" 18:15 pm"> 18:15 pm</option>
	             <option value=" 18:30 pm"> 18:30 pm</option>
	             <option value=" 18:45 pm"> 18:45 pm</option> 
	             <option value=" 19:00 pm"> 19:00 pm</option>
	             <option value=" 19:15 pm"> 19:15 pm</option>
	             <option value=" 19:30 pm"> 19:30 pm</option>
	             <option value=" 19:45 pm"> 19:45 pm</option> 
	             <option value=" 20:00 pm"> 20:00 pm</option>
	             <option value=" 20:15 pm"> 20:15 pm</option>
	             <option value=" 20:30 pm"> 20:30 pm</option>
	             <option value=" 20:45 pm"> 20:45 pm</option> 
	             <option value=" 21:00 pm"> 21:00 pm</option>
	             <option value=" 21:15 pm"> 21:15 pm</option>
	             <option value=" 21:30 pm"> 21:30 pm</option>
	             <option value=" 21:45 pm"> 21:45 pm</option> 
	             <option value=" 22:00 pm"> 22:00 pm</option>
	             <option value=" 22:15 pm"> 22:15 pm</option>
	             <option value=" 22:30 pm"> 22:30 pm</option>
	             <option value=" 22:45 pm"> 22:45 pm</option>
	             <option value=" 23:00 pm"> 23:00 pm</option>
	             <option value=" 23:15 pm"> 23:15 pm</option>
	             <option value=" 23:30 pm"> 23:30 pm</option>
	             <option value=" 23:45 pm"> 23:45 pm</option> 
	              </select>
                    <!-- <input class="form-control" id="single-input" value="" placeholder="Now">
                    <script type="text/javascript">
                     var input = $('#single-input').clockpicker({
                      placement: 'bottom',
                      align: 'left',
                        autoclose: true,
                        minTime: 'now' ,
                        'default': 'now',
                         });
                   </script>  -->
                     <label>End</label>
                 <select class="form-control" name="end">
	              <option value=" 7:00 am"> 7:00 am</option>
	              <option value=" 7:15 am"> 7:15 am</option>
	              <option value=" 7:30 am"> 7:30 am</option>
	              <option value=" 7:45 am"> 7:45 am</option> 
	              <option value=" 8:00 am"> 8:00 am</option>
	              <option value=" 8:15 am"> 8:15 am</option>
	              <option value=" 8:30 am"> 8:30 am</option>
	              <option value=" 8:45 am"> 8:45 am</option>
	             <option value=" 9:00 am"> 9:00 am</option>
	             <option value=" 9:15 am"> 9:15 am</option>
	             <option value=" 9:30 am"> 9:30 am</option>
	             <option value=" 9:45 am"> 9:45 am</option> 
	             <option value=" 10:00 am"> 10:00 am</option>
	             <option value=" 10:15 am"> 10:15 am</option>
	             <option value=" 10:30 am"> 10:30 am</option>
	             <option value=" 10:45 am"> 10:45 am</option>
	             <option value=" 11:00 am"> 11:00 pm</option>
	             <option value=" 11:15 am"> 11:15 pm</option>
	             <option value=" 11:30 am"> 11:30 pm</option>
	             <option value=" 11:45 am"> 11:45 pm</option>
	             <option value=" 12:00 pm"> 12:00 pm</option>
	             <option value=" 12:15 pm"> 12:15 pm</option>
	             <option value=" 12:30 pm"> 12:30 pm</option>
	             <option value=" 12:45 pm"> 13:45 pm</option>
	             <option value=" 13:00 pm"> 13:00 pm</option>
	             <option value=" 13:15 pm"> 13:15 pm</option>
	             <option value=" 13:30 pm"> 13:30 pm</option>
	             <option value=" 13:45 pm"> 13:45 pm</option>  
	             <option value=" 14:00 pm"> 14:00 pm</option>
	             <option value=" 14:15 pm"> 14:15 pm</option>
	             <option value=" 14:30 pm"> 14:30 pm</option>
	             <option value=" 14:45 pm"> 14:45 pm</option> 
	             <option value=" 15:00 pm"> 15:00 pm</option>
	             <option value=" 15:15 pm"> 15:15 pm</option>
	             <option value=" 15:30 pm"> 15:30 pm</option>
	             <option value=" 15:45 pm"> 15:45 pm</option> 
	             <option value=" 16:00 pm"> 16:00 pm</option>
	             <option value=" 16:15 pm"> 16:15 pm</option>
	             <option value=" 16:30 pm"> 16:30 pm</option>
	             <option value=" 16:45 pm"> 16:45 pm</option> 
	             <option value=" 17:00 pm"> 17:00 pm</option>
	             <option value=" 17:15 pm"> 17:15 pm</option>
	             <option value=" 17:30 pm"> 17:30 pm</option>
	             <option value=" 17:45 pm"> 17:45 pm</option> 
	             <option value=" 18:00 pm"> 18:00 pm</option>
	             <option value=" 18:15 pm"> 18:15 pm</option>
	             <option value=" 18:30 pm"> 18:30 pm</option>
	             <option value=" 18:45 pm"> 18:45 pm</option> 
	             <option value=" 19:00 pm"> 19:00 pm</option>
	             <option value=" 19:15 pm"> 19:15 pm</option>
	             <option value=" 19:30 pm"> 19:30 pm</option>
	             <option value=" 19:45 pm"> 19:45 pm</option> 
	             <option value=" 20:00 pm"> 20:00 pm</option>
	             <option value=" 20:15 pm"> 20:15 pm</option>
	             <option value=" 20:30 pm"> 20:30 pm</option>
	             <option value=" 20:45 pm"> 20:45 pm</option> 
	             <option value=" 21:00 pm"> 21:00 pm</option>
	             <option value=" 21:15 pm"> 21:15 pm</option>
	             <option value=" 21:30 pm"> 21:30 pm</option>
	             <option value=" 21:45 pm"> 21:45 pm</option> 
	             <option value=" 22:00 pm"> 22:00 pm</option>
	             <option value=" 22:15 pm"> 22:15 pm</option>
	             <option value=" 22:30 pm"> 22:30 pm</option>
	             <option value=" 22:45 pm"> 22:45 pm</option>
	             <option value=" 23:00 pm"> 23:00 pm</option>
	             <option value=" 23:15 pm"> 23:15 pm</option>
	             <option value=" 23:30 pm"> 23:30 pm</option>
	             <option value=" 23:45 pm"> 23:45 pm</option>
	              </select>           
                  <label>Venue</label>
	              <select class="form-control" name="venue">
	              <%
	              ps = con.prepareStatement("select * from user_tbl_company where Company_Id<=5");
	              rs = ps.executeQuery();
	              while(rs.next()){
	              %>
	              <option value="<%=rs.getString("Company_Name")%>"><%=rs.getString("Company_Name")%></option>
	              <%
	              }
	              %>
	              </select><br>
	              <label>Members</label>
	              <br>
                 <input class="form-control" id="demo" name="users" type="text" required> 
                   <script type="text/javascript">
                  $(document).ready(function() {
                  $("#demo").tokenInput([
            	<%
            	try { 
                    sql = "SELECT U_Id,U_Name,U_Email FROM user_tbl where Enable_id=1";
                    ps = con.prepareStatement(sql);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                    	%> 
                           {   
                        	   id: <%=rs.getInt("U_Id")%>,
                               "name":'<%=rs.getString("U_Name")%>',
                               "email":'<%=rs.getString("U_Email")%>' 
                           },
               <%
                    }
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
            	%>
            	
          ] , {
              propertyToSearch: "name" ,
              resultsFormatter: function(item){ return "<li>" + "<div style='display: inline-block; padding-left: 10px;'><div class='full_name'>" + item.name + " " +  "</div><div class='email'>" + item.email + "</div></div></li>" },
              tokenFormatter: function(item) { return "<li><p>" + item.name + "-"+ item.email + "</p></li>" }, 
           } );
        });
        </script> 
	              <br>
	              <input type="hidden" name="user" value="<%=username%>">
	              <input type=submit  class="btn btn-info btn-lg" type="submit" value="Create Event/Meeting"  autofocus onClick="showList()" >
	            </form> 
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