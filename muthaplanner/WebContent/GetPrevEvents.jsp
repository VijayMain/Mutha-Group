<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connection.ConnectionModel"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>PREV</title>
</head>
<body> 
 <div style="height: 550px;overflow: scroll;" id="ajaxID"> 
<%
try{
			String str = request.getParameter("q");
			String sql ="";
		    java.sql.Date compareDate = null; 
		    int srmodal=0;
		    if(str.equalsIgnoreCase("prev")){
		    compareDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
			sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,DATE_FORMAT(start_time,'%l:%i %p') as start_time, DATE_FORMAT(end_time,'%l:%i %p') as end_time,event_venue,event_desc FROM  events_units where enable_id=1 and event_date < '"+ compareDate +"'  order by event_date";
			}
			if(str.equalsIgnoreCase("todays")){
			    compareDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
				sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,DATE_FORMAT(start_time,'%l:%i %p') as start_time, DATE_FORMAT(end_time,'%l:%i %p') as end_time,event_venue,event_desc FROM  events_units where enable_id=1 and event_date = '"+ compareDate +"'  order by event_date";
			} 
			if(str.equalsIgnoreCase("upcoming")){
			    compareDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
				sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,DATE_FORMAT(start_time,'%l:%i %p') as start_time, DATE_FORMAT(end_time,'%l:%i %p') as end_time,event_venue,event_desc FROM  events_units where enable_id=1 and event_date > '"+ compareDate +"'  order by event_date";
			} 
			if(str.equalsIgnoreCase("myMeeting")){ 
				 int uid = Integer.parseInt(session.getAttribute("u_id").toString());
				sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,DATE_FORMAT(start_time,'%l:%i %p') as start_time, DATE_FORMAT(end_time,'%l:%i %p') as end_time,event_venue,event_desc FROM  events_units where enable_id=1 and created_by ="+ uid +"  order by event_date desc";
			} 
			
			Connection con =ConnectionModel.getConnection(); 
		    PreparedStatement ps=null,ps_des = null;;
		    ResultSet rs = null,rs_des = null;
		    ps = con.prepareStatement(sql);
		    rs = ps.executeQuery();
		   %>  
		 <table class="table table-bordered">         
		 <tr>
		 <th>Meeting Date</th>
		 <th>Topic / Agenda</th>
		 <th>Details</th>
		 <th>Start Time</th>
		 <th>End Time</th>
		 <th>Venue</th>
		 <th>Participants</th>
		 
		 <%
		 if(str.equalsIgnoreCase("myMeeting")){ 
		%>
		 <th>Delete</th>
		<%	 
		 }
		 %>
		 
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
		<%
		if(str.equalsIgnoreCase("myMeeting")){ 
		srmodal++;
		%>
		 <th> 
	    <a href="DeleteEvent.jsp?event_id=<%=rs.getInt("event_id")%>" id="delete_query" onclick="disable_me()">Delete</a> 
		<%	 
		 }
		 %> 
		  </tr>
		 <%
		 }
		 sql="";
		 %> 
		 </table>
	<%		  
}catch(Exception e){
	e.printStackTrace();
}
	%>  
</div> 
</body>
</html>