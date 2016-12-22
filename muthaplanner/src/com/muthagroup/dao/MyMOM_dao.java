package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connection.ConnectionModel;
import com.muthagroup.vo.MyMOM_vo;

public class MyMOM_dao {

	public void saveMOM(HttpServletResponse response, MyMOM_vo bean,
			HttpSession session) {
		try {
			 int uid = Integer.parseInt(session.getAttribute("u_id").toString());
			 Connection con = ConnectionModel.getConnection();
			 Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			 String creater = "";
	 		PreparedStatement  ps_des = con.prepareStatement("select * from user_tbl where U_Id="+uid);
	 		ResultSet  rs_des = ps_des.executeQuery();
	 		while(rs_des.next()){
	 			creater = rs_des.getString("u_name");  
	 		}
	 		
	 		ps_des = con.prepareStatement("insert into events_units_mom(event_id,mom_attached,file_name,enable,creator,date_update,u_id)values(?,?,?,?,?,?,?)");
	 		ps_des.setInt(1, bean.getEvent_id());
	 		ps_des.setBlob(2, bean.getBlob_file());
	 		ps_des.setString(3, bean.getBlob_name());
	 		ps_des.setInt(4, 1);
	 		ps_des.setString(5, creater);
	 		ps_des.setTimestamp(6, timestamp);
	 		ps_des.setInt(7, uid);
	 		int up = ps_des.executeUpdate();
	 		
	 		if(up>0){
	 			/*___________________________________________________________________________________________________*/
	 			/*****************************************************************************************************/
	 			 ArrayList to_emails = new ArrayList();
	 			 PreparedStatement ps_umail = null,ps_agenda = null;
	 			 ResultSet rs_umail = null,rs_agenda=null;
				String event_agenda = "",eventDate = "",venue="";
				
				ps_agenda = con.prepareStatement("select DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,event_venue from events_units where event_id="+bean.getEvent_id());
				rs_agenda = ps_agenda.executeQuery();
				while (rs_agenda.next()) {
					event_agenda = rs_agenda.getString("text");
					venue = rs_agenda.getString("event_venue");
					eventDate = rs_agenda.getString("event_date");
				}
				
				PreparedStatement ps_rec = con.prepareStatement("select * from event_users where event_id="+bean.getEvent_id());
				ResultSet rs_rec = ps_rec.executeQuery();
				while (rs_rec.next()) {
					ps_umail = con.prepareStatement("select * from user_tbl where U_Id="+rs_rec.getInt("u_id"));
					rs_umail = ps_umail.executeQuery();
					while (rs_umail.next()) {
						to_emails.add(rs_umail.getString("U_Email"));
					}
				}
				
				SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
				Calendar cal = Calendar.getInstance();
				String sql_date = sdfFIrstDate.format(cal.getTime()).toString();
			
				String host = "send.one.com";
				String user = "meetings@muthagroup.com";
				String pass = "meetings@xyz";
				String from = "meetings@muthagroup.com";
				String subject = "MOM added by "+ creater + " !!!";
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
				
				sb.append("<b style='color: #0D265E; font-family: Arial; font-size: 11px;'>This is an automatically generated email to notify MOM attached !!!</b>"+
						"<p><b>To Check ,</b><a href='http://192.168.0.7/muthaplanner/'>Click Here</a></p>"+	
						"<table border='1' width='97%' style='font-family: Arial;'>"+
						"<tr style='font-size: 12px; background-color: #94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
						"<th>Meeting Agenda</th>"+
						"<th>Dated</th>"+
						"<th>Venue</th>"+
						"<th>MOM Attached By</th>"+
						"</tr>");
				
				sb.append("<tr>"+
					"<td>"+event_agenda+"</td>"+
					"<td>"+eventDate+"</td>"+
					"<td>"+venue+"</td>"+
					"<td>"+creater+"</td>"+
					"</tr>");
				
					sb.append("</table><p><b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"
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
				
			/*___________________________________________________________________________________________________*/
			/*****************************************************************************************************/
						String mom_upload = "MOM Attached successfully....";
						response.sendRedirect("AddMyMOM.jsp?mom_upload="+mom_upload+"&event_id="+bean.getEvent_id());
	 		}
	 		
	 		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
