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
  <title>Mutha Group of Engineering Satara</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  
 <!--  <link rel="stylesheet" href="css/bootstrap.min.css" > -->
  <link rel="stylesheet" href="css/token-input.css" type="text/css" />
  <link rel="stylesheet" href="css/token-input-facebook.css" type="text/css" />
  <link rel="stylesheet" href="css/bootstrap-iso.css" />
  <link rel="stylesheet" href="css/font-awesome.min.css" />
  <!-- <link rel="stylesheet" href="css/bootstrap-datepicker3.css"/> -->
  <!--  <link rel="stylesheet" href="css/bootstrap-datetimepicker.min.css"/> -->
  
 <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
<!-- <link rel="stylesheet" type="text/css" href="dist/bootstrap-clockpicker.min.css"> -->
<link rel="stylesheet" type="text/css" href="assets/css/github.min.css">
<script type="text/javascript" src="assets/js/jquery.min.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.min.js"></script>
<!-- <script type="text/javascript" src="dist/bootstrap-clockpicker.min.js"></script> -->
<script type="text/javascript" src="assets/js/highlight.min.js"></script>
  
  <link rel="stylesheet" href="js/jquery-ui.css"/>
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> 
  
 <!--  <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script> -->
  <!-- <script type="text/javascript" src="js/bootstrap-datepicker.js" charset="UTF-8"></script> -->
  <!-- <script type="text/javascript" src="js/bootstrap-datetimepicker.js" charset="UTF-8"></script> -->
  <script type="text/javascript" src="js/formden.js"></script>
  <script type="text/javascript" src="js/jquery.tokeninput.js"></script>  
   
   
    <script type="text/javascript">
        /* $(function () {
        $('#date').datepicker({
        	format: 'dd/mm/yyyy',
			todayHighlight: 1,
			autoclose: 1});	
    }); */
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
        //INSTEAD OF: t = document.getElementById('tokenize').valueOf();
        var t = $('#demo').val();
        document.getElementById("users").setAttribute('value',t);
        alert(t);
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

/*   $(function() { // when the DOM is ready...
      //  Move the window's scrollTop to the offset position of #now
      $(window).scrollTop($('#DailyReport').offset().top);
  });
 */

/* 	$(document).ready(function(){
		var date_input1=$('input[name="date1"]'); //our date input has the name "date"
		var date_input2=$('input[name="date2"]');
		var container=$('.bootstrap-iso form').length>0 ? $('.bootstrap-iso form').parent() : "body";
		date_input1.datepicker({format: 'dd/mm/yyyy',container: container,todayHighlight: true,autoclose: true,})
		date_input2.datepicker({format: 'dd/mm/yyyy',container: container,todayHighlight: true,autoclose: true,})
	}) */
	
	$(document).on("click", ".modal-link", function () {
     var myBookId = $(this).data('id');
     document.getElementById('lbl').innerHTML =myBookId;
     $(".loginmodal-container #bookId").val( myBookId );
     // As pointed out in comments, 
     // it is superfluous to have to manually call the modal.
     // $('#addBookDialog').modal('show');
});
	
</script>

 

  <style>
  .bootstrap-iso 
.formden_header h2, 
.bootstrap-iso .formden_header p, 
.bootstrap-iso form{font-family: Arial, Helvetica, sans-serif; color: black}
.bootstrap-iso form button, 
.bootstrap-iso form button:hover{color: white !important;} 
.asteriskField{color: red;}
  
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 100%;
    }
    
    /* Set black background color, white text and some padding */
    footer {
      background-color: #555;
      color: white;
      padding: 1px;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
    @import url(http://fonts.googleapis.com/css?family=Roboto);

/****** LOGIN MODAL ******/
.loginmodal-container {
  padding: 30px;
  max-width: 600px;
  width: 100% !important;
  background-color: #F7F7F7;
  margin: 0 auto;
  border-radius: 2px;
  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
  overflow: hidden;
  font-family: roboto;
}
.logoutmodal-container {
  padding: 30px;
  max-width: 350px;
  width: 100% !important;
  background-color: #F7F7F7;
  margin: 0 auto;
  border-radius: 2px;
  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
  overflow: hidden;
  font-family: roboto;
  font-size:12;
}

.reportmodal-container {
  padding: 30px;
  max-width: 350px;
  width: 100% !important;
  background-color: #F7F7F7;
  margin: 0 auto;
  border-radius: 2px;
  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
  overflow: hidden;
  font-family: roboto;
}

.loginmodal-container h1 {
  text-align: center;
  font-size: 1.8em;
  font-family: roboto;
}

.loginmodal-container input[type=submit] {
  width: 100%;
  display: block;
  margin-bottom: 5px;
  position: relative;

}
.loginmodal-container textarea {
  width: 100%;
  height: 60px;
  display: block;
  margin-bottom: 10px;
  position: relative;

}

.loginmodal-container input[type=text], input[type=password] {
  height: 30px;
  font-size: 16px;
  width: 100%;
  margin-bottom: 10px;
  -webkit-appearance: none;
  background: #fff;
  border: 1px solid #d9d9d9;
  border-top: 1px solid #c0c0c0;
  /* border-radius: 2px; */
  padding: 0 8px;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
}

.loginmodal-container input[type=text]:hover, input[type=password]:hover {
  border: 1px solid #b9b9b9;
  border-top: 1px solid #a0a0a0;
  -moz-box-shadow: inset 0 1px 2px rgba(0,0,0,0.1);
  -webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,0.1);
  box-shadow: inset 0 1px 2px rgba(0,0,0,0.1);
}

.loginmodal {
  text-align: center;
  font-size: 14px;
  font-family: 'Arial', sans-serif;
  font-weight: 700;
  height: 36px;
  padding: 0 8px;
/* border-radius: 3px; */
/* -webkit-user-select: none;
  user-select: none; */
}

.loginmodal-submit {
  /* border: 1px solid #3079ed; */
  border: 0px;
  color: #fff;
  text-shadow: 0 1px rgba(0,0,0,0.1); 
  background-color: #4d90fe;
  padding: 17px 0px;
  font-family: roboto;
  font-size: 14px;
  /* background-image: -webkit-gradient(linear, 0 0, 0 100%,   from(#4d90fe), to(#4787ed)); */
}


.loginmodal-submit:hover {
  /* border: 1px solid #2f5bb7; */
  border: 0px;
  text-shadow: 0 1px rgba(0,0,0,0.3);
  background-color: #357ae8;
  /* background-image: -webkit-gradient(linear, 0 0, 0 100%,   from(#4d90fe), to(#357ae8)); */
}

.loginmodal-container a {
  text-decoration: none;
  color: #666;
  font-weight: 400;
  text-align: center;
  display: inline-block;
  opacity: 0.6;
  transition: opacity ease 0.5s;
} 

.reportmodal-container {
  text-align: center;
  height: 600px;
  font-size: 16px;
  max-width: 700px;
  width: 100%;
  margin-bottom: 10px;
  -webkit-appearance: none;
  background: #fff;
  border: 1px solid #d9d9d9;
  border-top: 1px solid #c0c0c0;
  /* border-radius: 2px; */
  padding: 0 8px;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
}

.login-help{
  font-size: 12px;
}
  </style>
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
      <!--  <li>
       <button type="button" class="btn btn-default">Past Events</button> |
      <button type="button" id='testbtn' class="btn btn-default">Today's Events</button> |
      <a href="#Report" class="btn btn-info" data-id="New Event" data-toggle="modal"role="button">Create new Event</a> |
      <button type="button" class="btn btn-default">Upcoming Events</button> |
      <button type="button" class="btn btn-default">My Events</button>
      </li> -->
      	 <li><a href="#Report" data-id="New Event" data-toggle="modal"><b>CREATE NEW</b></a></li>
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
   <!--  <div class="page-header" align="center">
      <h1>Welcome to Mutha Group of Industries</h1>
      <blockquote class="blockquote-reverse">
     Success is simple. Do what's right, the right way, at the right time.
      </blockquote>
      <button type="button" class="btn btn-default">Past Events</button> |
      <button type="button" id='testbtn' class="btn btn-default">Today's Events</button> |
      <a href="#Report" class="btn btn-info" data-id="New Event" data-toggle="modal"role="button">Create new Event</a> |
      <button type="button" class="btn btn-default">Upcoming Events</button> |
      <button type="button" class="btn btn-default">My Events</button>
     </div>   -->
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
        <div class="modal fade active" id="Report" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    	<div class="modal-dialog"> 
		<div class="loginmodal-container"> 
				<h1><strong><label id="lbl">New Event/Meeting</label></strong></h1><br>
	             <form class="form-inline" action="Event" method="post" >
	              <label>Event Title</label><br>
	              <input class="form-control" name="text" type="text" required maxlength="25" > 
	              <label>Event Description</label>
	              <br>
	              <textarea name="desc" rows="2" cols="30" required ></textarea>
	              <label>Event Date</label>
	              <br>
                 <!-- <input class="form-control" id="date" name="date" placeholder="DD/MM/YYYY" type="date" required /> -->
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
	              <input type=submit  class="btn btn-info btn-lg" type="submit" value="Create Event"  autofocus onClick="showList()" >
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
