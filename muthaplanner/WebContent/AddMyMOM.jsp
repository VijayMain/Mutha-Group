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
  <title>MOM Attached</title>
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

function ChangeColor(tableRow, highLight) {
	if (highLight) {
		tableRow.style.backgroundColor = '#CFCFCF';
	} else {
		tableRow.style.backgroundColor = '#FFFFFF';
	}
}

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
function disable_me(){
	document.getElementById("delete_query").style.pointerEvents = "none";
}
</script>
<script type="text/javascript">  
	// Form validation code will come here.
	function validateForm() {
	var filename = document.getElementById("filename"); 
		if (filename.value=="0" || filename.value==null || filename.value=="" || filename.value=="null") {
			alert("Please Provide MOM File !!!"); 
			document.getElementById("save").disabled = false;
			document.getElementById("waitImage").style.visibility = "hidden";
			return false;
		} 
		document.getElementById("save").disabled = true;
		document.getElementById("waitImage").style.visibility = "visible"; 
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
	if(request.getParameter("delete_str")!=null){
	%>
		<script type="text/javascript">
		alert("Deleted successfully.....!!!");
		</script>
	<%
	}
	if(request.getParameter("mom_upload")!=null){
	%>
		<script type="text/javascript">
		alert("MOM Attached successfully.....!!!");
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
      	 <li><a href="Create_New.jsp"><b>CREATE NEW</b></a></li>
         <li><a onClick="callstatusv('prev');" style="cursor: pointer;"><b>PREVIOUS</b></a></li>
         <li><a onClick="callstatusv('todays');" style="cursor: pointer;"><b>TODAYS</b></a></li>
         <li><a onClick="callstatusv('upcoming');" style="cursor: pointer;"><b>UPCOMING</b></a></li>
         <li><a onClick="callstatusv('myMeeting');" style="cursor: pointer;"><b>MY MEETINGS</b></a></li>
          <li><a onClick="callstatusv('myMOM');" style="cursor: pointer;"><b>MOM</b></a></li>
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
     int event_id = Integer.parseInt(request.getParameter("event_id"));
     int uid = Integer.parseInt(session.getAttribute("u_id").toString());
     PreparedStatement ps=null,ps_des = null, ps_act = null;
     ResultSet rs = null, rs_act = null ,rs_des = null;
      
    sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,DATE_FORMAT(start_time,'%l:%i %p') as start_time, DATE_FORMAT(end_time,'%l:%i %p') as end_time,event_venue,event_desc,created_by  FROM  events_units where event_id="+ event_id;
    ps = con.prepareStatement(sql);
    rs = ps.executeQuery();
    rs = ps.executeQuery();
%> 
<div style="height: 550px;overflow: scroll;" id="ajaxID"> 
<table class="table table-bordered">         
 <tr style="background-color: #8bcbed">
 <th>Meeting Date</th>
 <th>Topic / Agenda</th>
 <th>Details</th>
 <th>Start Time</th>
 <th>End Time</th>
 <th>Venue</th>
 <th>Participants</th>
 <th>Organizer</th>
 <th>MOM Attached</th>
 </tr>
	                <%
	                while(rs.next()){
	                %>
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
		  			 <td>
   					<%
  					ps_des = con.prepareStatement("select * from user_tbl where U_Id="+rs.getInt("created_by"));
  					rs_des = ps_des.executeQuery();
  					while(rs_des.next()){
  					%>
  					<%=rs_des.getString("u_name") %>
  					<%
  					}
  					%>
  					</td>
  					<td width="200" style="font-size: 11px;font-weight: bold;">
  					<%
  					ps_act = con.prepareStatement("select * from events_units_mom where event_id="+event_id);
  					rs_act = ps_act.executeQuery();
  					while(rs_act.next()){
  					%>
  					<span><a href="Display_AttachedMOM.jsp?field=<%=rs_act.getInt("code")%>"><%=rs_act.getString("file_name")%>,&nbsp;</a></span>
  					<%
  					}
  					%>
  					</td>				
		  			</tr>
		  			<%
	                }
	                %>
		  			</table> 
<form action="AddMy_MOM" method="post" enctype="multipart/form-data"   onSubmit="return validateForm();">
<input type="hidden" name="event_id" id="event_id" value="<%=event_id%>">  			
<table class="table table-bordered" style="width: 50%">         
 <tr style="background-color: #8bcbed">
 <th colspan="2">Attach MOM Here :</th>
 </tr>
 <tr>
    <td>Attach File<b style="color:red">*</b></td>	
    <td><input type="file" name="filename" id="filename" size="40" style="background-color: #e0e0e0"></td>
 </tr>
 <tr>
   <td>Remark(If Any)</td>
   <td><textarea name="remark" id="remark" rows="4" cols="40" style="background-color: #e0e0e0"></textarea></td>
 </tr>
 <tr>
   <td>&nbsp;</td>
   <td>
   <input type="submit" value="Save" id="save" style="width: 100px;height:25px;font-weight:bold"/>
   <span id="waitImage" style="visibility: hidden;"><strong style="color: blue;">Please Wait......</strong></span>
   </td>
 </tr>
</table>
		</form>
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
