<%@page import="javax.mail.Transport"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.muthagroup.connection.ConnectionModel"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete</title>
</head>
<body>
<%
try{
	Connection con =ConnectionModel.getConnection();
	int uid = Integer.parseInt(session.getAttribute("u_id").toString());
	Timestamp timestamp = new Timestamp(System.currentTimeMillis());
	int event_id = Integer.parseInt(request.getParameter("event_id")); 
	PreparedStatement ps = con.prepareStatement("update events_units set enable_id=?,update_date=?,updated_by=? where event_id="+Integer.parseInt(request.getParameter("event_id")));
	ps.setInt(1, 0);
	ps.setTimestamp(2, timestamp);
	ps.setInt(3, uid);
	int up = ps.executeUpdate();
	
	if(up>0){
		String delete_str = "Deleted successfully.....";
		String register_user = (String) session.getAttribute("user");	
		
	/* Delete_MailNotify notify = new Delete_MailNotify(); 
	boolean update_flag = notify.mailFire(event_id,uid,register_user); */
	
	/*****************************************************************************************************/
	/* ___________________________________________________________________________________________________ */

	ArrayList to_emails = new ArrayList();
	String report = "Mutha_Planner";
	PreparedStatement ps_att = null;
	ResultSet rs_att = null;
	
	Connection con_email = ConnectionModel.getLocalDatabase(); 
	String venue = "", event_date = "", start_time = "", end_time = "", title = "", agenda = "", user_name = ""; 
	PreparedStatement ps_delmail = con.prepareStatement("SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,DATE_FORMAT(start_time,'%l:%i %p') as start_time, DATE_FORMAT(end_time,'%l:%i %p') as end_time,event_venue,event_desc FROM  events_units where event_id=" + event_id);
	ResultSet rs_delmail = ps_delmail.executeQuery();
	while (rs_delmail.next()) {

		venue = rs_delmail.getString("event_venue");
		event_date = rs_delmail.getString("event_date");
		start_time = rs_delmail.getString("start_time");
		end_time = rs_delmail.getString("end_time");
		agenda = rs_delmail.getString("text");
		title = rs_delmail.getString("event_desc");

		ps_att = con.prepareStatement("select * from user_tbl where U_Id =" + uid);
		rs_att = ps_att.executeQuery();
		while (rs_att.next()) {
			to_emails.add(rs_att.getString("U_Email"));
		}
		
		ps_att = con.prepareStatement("select * from user_tbl where U_Id in(select u_id from event_users where event_id=" + event_id +")");
		rs_att = ps_att.executeQuery();
		while (rs_att.next()) {
			to_emails.add(rs_att.getString("U_Email"));
		}

		ps_att = con.prepareStatement("select * from event_users where event_id="+ event_id);
		rs_att = ps_att.executeQuery();
		while (rs_att.next()) {
			user_name = user_name + rs_att.getString("user_name") + ",";
		}

		PreparedStatement ps_rec = con_email
				.prepareStatement("select * from pending_approvee where type='to' and report='"
						+ report + "' and validlimit='" + venue + "'");
		ResultSet rs_rec = ps_rec.executeQuery();
		while (rs_rec.next()) {
			to_emails.add(rs_rec.getString("email"));
		}

		/* System.out.println("to email list = " + to_emails
				+ " User Name = " + user_name); */

		SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		String sql_date = sdfFIrstDate.format(cal.getTime()).toString();

		String host = "send.one.com";
		String user = "itsupports@muthagroup.com";
		String pass = "itsupports@xyz";
		String from = "itsupports@muthagroup.com";
		String subject = "Meeting has been canceled at " + venue
				+ " on " + event_date + " " + start_time + " !!!";
		boolean sessionDebug = false;

		Properties props = System.getProperties();
		props.put("mail.host", host);
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", 2525);
		Session mailSession = Session.getDefaultInstance(props, null);
		mailSession.setDebug(sessionDebug);
		Message msg = new MimeMessage(mailSession);
		msg.setFrom(new InternetAddress(from));
		StringBuilder sb = new StringBuilder();

		sb.append("<b style='color: #0D265E; font-family: Arial; font-size: 11px;'>This is an automatically generated email to notify Meeting has been canceled for "
				+ venue + " at " + start_time + " !!!</b>");
		sb.append("<p><b>To Check ,</b><a href='http://192.168.0.7/muthaplanner/'>Click Here</a> </p>");
		sb.append("<table border='1' width='97%' style='font-family: Arial;'>"
				+ "<tr style='font-size: 12px; background-color: #94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"
				+ "<th>Meeting Date</th> <th>Topic / Agenda</th> <th>Details</th> <th>Start Time</th> <th>End Time</th> <th>Venue</th> <th>Participants</th> </tr> <tr>"
				+ "<td>"
				+ event_date
				+ "</td>" 
				+ "<td>"
				+  agenda
				+ "</td>"
				+ "<td>"
				+ title
				+ "</td>"
				+ "<td>"
				+ start_time
				+ "</td>"
				+ "<td>"
				+ end_time
				+ "</td>"
				+ "<td>"
				+ venue
				+ "</td>"
				+ "<td>"
				+ user_name
				+ "</td>" + "</tr>");

		sb.append("</table><p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"
				+ "<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"
				+ "<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"
				+ "it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"
				+ "or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"
				+ "</font></p>");

		InternetAddress[] addressBcc = new InternetAddress[to_emails.size()];
		for (int p = 0; p < to_emails.size(); p++) {
			addressBcc[p] = new InternetAddress(to_emails.get(p).toString());
		}

		msg.setRecipients(Message.RecipientType.TO, addressBcc);
		msg.setSubject(subject);
		msg.setSentDate(new Date());
		msg.setContent(sb.toString(), "text/html");
		Transport transport = mailSession.getTransport("smtp");
		transport.connect(host, user, pass);
		transport.sendMessage(msg, msg.getAllRecipients());
		transport.close(); 
	}
	/* ___________________________________________________________________________________________________ */
	/*****************************************************************************************************/
	
	
	
	response.sendRedirect("mainpage.jsp?delete_str="+delete_str);
	}else{
		response.sendRedirect("mainpage.jsp");
	}
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>