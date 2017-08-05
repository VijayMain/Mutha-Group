<%@page import="java.util.ArrayList"%>
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
<script type="text/javascript">
function disable_me(){
	document.getElementById("delete_query").style.pointerEvents = "none";
}
</script>
</head>
<body> 
 <div style="height: 550px;overflow: scroll;" id="ajaxID"> 
<%
try{
	
			String str = request.getParameter("q");
			String sql ="";
		    java.sql.Date compareDate = null;
		    boolean flag_prev = false;
		    //int srmodal=0;
		    PreparedStatement ps_hid=null,ps_get_att=null;
		    ResultSet rs_hid=null,rs_get_att=null;
		    int uid = Integer.parseInt(session.getAttribute("u_id").toString());
		    
		    Connection con =ConnectionModel.getConnection(); 
		    ArrayList momLisl = new ArrayList();
		    
		    if(str.equalsIgnoreCase("prev")){
		    compareDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
			sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,DATE_FORMAT(start_time,'%l:%i %p') as start_time, DATE_FORMAT(end_time,'%l:%i %p') as end_time,event_venue,event_desc,created_by FROM  events_units where enable_id=1 and event_date < '"+ compareDate +"'  order by event_date";
			}
			if(str.equalsIgnoreCase("todays")){
			    compareDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
				sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,DATE_FORMAT(start_time,'%l:%i %p') as start_time, DATE_FORMAT(end_time,'%l:%i %p') as end_time,event_venue,event_desc,created_by FROM  events_units where enable_id=1 and event_date = '"+ compareDate +"'  order by event_date";
			} 
			if(str.equalsIgnoreCase("upcoming")){
			    compareDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
				sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,DATE_FORMAT(start_time,'%l:%i %p') as start_time, DATE_FORMAT(end_time,'%l:%i %p') as end_time,event_venue,event_desc,created_by FROM  events_units where enable_id=1 and event_date > '"+ compareDate +"'  order by event_date";
			} 
			if(str.equalsIgnoreCase("myMeeting")){ 
				sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,DATE_FORMAT(start_time,'%l:%i %p') as start_time, DATE_FORMAT(end_time,'%l:%i %p') as end_time,event_venue,event_desc,created_by FROM  events_units where enable_id=1 and created_by ="+ uid +"  order by event_date desc";
			} 
			if(str.equalsIgnoreCase("myMOM")){
				PreparedStatement psList = con.prepareStatement("select * from events_units_mom");
				ResultSet rsList = psList.executeQuery();
				while(rsList.next()){
					momLisl.add(rsList.getInt("event_id"));
				}
				sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,DATE_FORMAT(start_time,'%l:%i %p') as start_time, DATE_FORMAT(end_time,'%l:%i %p') as end_time,event_venue,event_desc,created_by FROM  events_units where enable_id=1 and event_id in(SELECT event_id FROM event_users where u_id="+ uid +")  order by event_date desc";
			}
			
		    PreparedStatement ps=null,ps_des = null;
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
 		<th>Organizer</th>
		 <%
		 if(str.equalsIgnoreCase("myMeeting")){
		%>
		 <th>Delete</th>
		 <%
		 }
		 %>
		  <%
		 if(str.equalsIgnoreCase("myMOM")){
		%>
		 <th>Attached MOM</th>
		 <th>Add MOM</th>
		 <%
		 }
		 %>
		 </tr>
		 <%while (rs.next()) {%>
		 <%
		 if(str.equalsIgnoreCase("myMOM") && momLisl.contains(rs.getInt("event_id"))){
		 %>
		 <tr style="background-color: #caf9d2;cursor: pointer;" title="MOM Attached">
		 <%
		 }else{
		%>
		<tr  title="MOM Missing" style="cursor: pointer;" onclick="button1();">
		<%
		 }
		 %>
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
		  
		  
		<%
		if(str.equalsIgnoreCase("myMeeting")){
			ps_hid = con.prepareStatement("select * from events_units where event_date < CURDATE() and event_id="+rs.getInt("event_id")+" and enable_id=1 and created_by ="+ uid +"  order by event_date desc");
			rs_hid = ps_hid.executeQuery();
			while(rs_hid.next()){
				flag_prev=true;
			}
		%>
		 <td> 
		 <%
		if(flag_prev==false){
		 %>
	    <a href="DeleteEvent.jsp?event_id=<%=rs.getInt("event_id")%>" id="delete_query" onclick="disable_me()">Delete</a>
	    <%
		}else{
		%> 
	    <span style="color: green;">Done</span> 
	    <%	
		} 	 
		 }
		flag_prev=false;
		 %> 
		 </td>
		  <%
		 if(str.equalsIgnoreCase("myMOM")){
		%>
		<td width="200" style="font-size: 11px;font-weight: bold;">
		<%	 
			 ps_get_att = con.prepareStatement("select * from events_units_mom where enable=1 and event_id="+rs.getInt("event_id"));
			 rs_get_att = ps_get_att.executeQuery();
			 while(rs_get_att.next()){
		%>
		<span><a href="Display_AttachedMOM.jsp?field=<%=rs_get_att.getInt("code")%>"><%=rs_get_att.getString("file_name")%>,&nbsp;</a></span>
		<%
			 }
		%>
		</td>
		 <td align="left"><a href="AddMyMOM.jsp?event_id=<%=rs.getInt("event_id")%>"  id="delete_query" onclick="disable_me()">Add MOM</a></td>
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