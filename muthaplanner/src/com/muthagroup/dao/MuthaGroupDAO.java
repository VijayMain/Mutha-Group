package com.muthagroup.dao;

import com.muthagroup.connection.ConnectionModel;
import com.muthagroup.vo.MuthaGroupVO; 

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
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

public class MuthaGroupDAO {
    public ArrayList<ArrayList<String>> getReport(MuthaGroupVO vo) {
        ArrayList<ArrayList<String>> allList = new ArrayList<ArrayList<String>>();
        try {
            Connection con = ConnectionModel.getConnection();
            String sql = new String();
            PreparedStatement ps = null;
            ResultSet rs = null;
            int event_id = 0;
            //String event_creator="";
           
            sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \"),text,DATE_FORMAT(start_time,'%l:%i %p'), DATE_FORMAT(end_time,'%l:%i %p'),event_venue,event_desc FROM events_units";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                ArrayList<String> list = new ArrayList<String>();
                event_id=rs.getInt("event_id");
                int i = 1;
                while (i <= 7) {
                    list.add(rs.getString(i));
                    ++i;
                }
              /*  sql = "SELECT event_creator FROM event_creator where event_id="+event_id+"";
                PreparedStatement ps1 = con.prepareStatement(sql);
                ResultSet rs1 = ps1.executeQuery();
                if(rs1.next())
                {
                	event_creator=rs1.getString("event_creator");
                	
                }
                list.add(event_creator);*/
                allList.add(list);
            }
            return allList;
        }
        catch (Exception e) {
            e.printStackTrace();
            return allList;
        }
    }

    public void saveEvent(ArrayList<String> list, int uid, HttpServletResponse response) {
        try {
        	Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            String date = list.get(0);
            String start = list.get(2);
            String end = list.get(3);
     //    String strDate =  date.substring(6,10) + "-" + date.substring(3, 5) + "-" + date.substring(0, 2);
            String strDate = date;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date dateMy = sdf.parse(strDate); 
            java.sql.Date sqlDate = new java.sql.Date(dateMy.getTime()); 
            SimpleDateFormat time = new SimpleDateFormat("HH:mm a");
            Date utilTime1=time.parse(start);
            Date utilTime2=time.parse(end);
            Time sqltime1=new Time(utilTime1.getTime());
            Time sqltime2=new Time(utilTime2.getTime());
            Connection con = ConnectionModel.getConnection();
            String sql = new String();
            ResultSet rs = null;
            PreparedStatement ps = null;
            int event_id =0;
            boolean flag_avail=false;
            PreparedStatement ps_chk = con.prepareStatement("SELECT * FROM events_units where event_date='"+sqlDate+"' and event_venue='"+list.get(4).toString()+"' and enable_id=1 and  CAST(start_time as time) >= '"+sqltime1+"' AND CAST(end_time as time) <'"+sqltime2+"'");
            ResultSet rs_chk = ps_chk.executeQuery();
            while (rs_chk.next()) {
				flag_avail=true;
			}
            if(flag_avail==true || start.equalsIgnoreCase(end)){
            	System.out.println("Already Available");
            	String avail = "Please select proper date range...!";
            	response.sendRedirect("Create_New.jsp?avail="+avail);
            	
            }else{
            	
            sql = "insert into events_units(event_date,text,start_time,end_time,event_venue,event_desc,enable_id,created_by,created_date) values(?,?,?,?,?,?,?,?,?)";
            ps = con.prepareStatement(sql);
            ps.setDate(1, sqlDate);//date
            ps.setString(2, list.get(1));//text
            ps.setTime(3, sqltime1);//strat
            ps.setTime(4, sqltime2);//end
            ps.setString(5, list.get(4));//venue
            ps.setString(6, list.get(5));//details
            ps.setInt(7, 1);
            ps.setInt(8, uid);
            ps.setTimestamp(9, timestamp);
            ps.executeUpdate();
            
            sql = "select max(event_id) as code FROM events_units";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
        	   event_id=rs.getInt("code");
           }
        	boolean sent = false;
        	ArrayList to_emails = new ArrayList(); 
            String users=list.get(5);//users list
            String[] userlist ;
            userlist = users.split(",");
            String creator= list.get(6);//creator
            String name_users = "";
            String user_id = "",user_name="";
            String[] user_saparate = creator.split(",");             
 			for (int p = 0; p < user_saparate.length; p++) {
 				user_id = user_saparate[p].toString(); 
 				if(user_id!=""){
 				ps = con.prepareStatement("select * from user_tbl where U_Id="+Integer.parseInt(user_id));
 				rs = ps.executeQuery();
 				while (rs.next()) {
 					to_emails.add(rs.getString("U_Email"));
 					
 					user_name = rs.getString("U_Name");
 					
 					name_users = name_users + user_name +","; 
 					sent=true;
				}
 				sql = "insert into event_users(event_id,u_id,user_name) values(?,?,?)";
 	            ps = con.prepareStatement(sql);
 	            ps.setInt(1, event_id);
 	            ps.setInt(2, Integer.parseInt(user_id));
 	            ps.setString(3, user_name);
 	            ps.executeUpdate(); 				
 				user_id="";
 				user_name="";
 				}
 			}
 			/*___________________________________________________________________________________________________*/
 			/*****************************************************************************************************/
 			
			String report = "Mutha_Planner";
			
			Connection con_email = ConnectionModel.getLocalDatabase();
			PreparedStatement ps_rec = con_email.prepareStatement("select * from pending_approvee where type='to' and report='"+ report + "' and validlimit='" + list.get(4).toString() + "'");
			ResultSet rs_rec = ps_rec.executeQuery();
			while (rs_rec.next()) {
				to_emails.add(rs_rec.getString("email")); 
			} 
			SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			String sql_date = sdfFIrstDate.format(cal.getTime()).toString();
		
			String host = "send.one.com";
			String user = "itsupports@muthagroup.com";
			String pass = "itsupports@xyz";
			String from = "itsupports@muthagroup.com";
			String subject = "Meeting Scheduled at "+ list.get(4).toString()+" on " + date + " " + start + " !!!";
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
			
			sb.append("<b style='color: #0D265E; font-family: Arial; font-size: 11px;'>This is an automatically generated email to attend a meeting in "+list.get(4).toString()+"!!!</b>");
			sb.append("<p><b>To Check ,</b><a href='http://192.168.0.7/muthaplanner/'>Click Here</a> </p>");
			sb.append("<table border='1' width='97%' style='font-family: Arial;'>"+
						"<tr style='font-size: 12px; background-color: #94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
						"<th>Meeting Date</th> <th>Topic / Agenda</th> <th>Details</th> <th>Start Time</th> <th>End Time</th> <th>Venue</th> <th>Participants</th> </tr> <tr>"+
						"<td>"+date+"</td>"+
						"<td>"+list.get(5).toString()+"</td>"+
						"<td>"+list.get(1).toString()+"</td>"+
						"<td>"+start+"</td>"+
						"<td>"+end+"</td>"+
						"<td>"+list.get(4).toString()+"</td>"+
						"<td>"+name_users+"</td>"+
						"</tr>");
	 		sb.append("</table><p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"
						+ "<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"
						+ "<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"
						+ "it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"
						+ "or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"
						+ "</font></p>");

	 		
	 		InternetAddress[] addressBcc = new InternetAddress[1];
			for (int p = 0; p < to_emails.size(); p++) {
				addressBcc[0] = new InternetAddress(to_emails.get(p).toString());
				
				msg.setRecipients(Message.RecipientType.TO, addressBcc);
				msg.setSubject(subject);
				msg.setSentDate(new Date());
				msg.setContent(sb.toString(), "text/html");
				if (sent == true) {
					Transport transport = mailSession.getTransport("smtp");
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients());
					transport.close();
				} 
			}
		/*___________________________________________________________________________________________________*/
		/*****************************************************************************************************/
        }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

	public ArrayList<ArrayList<String>> getTodayReport(MuthaGroupVO vo) {
		 ArrayList<ArrayList<String>> allList = new ArrayList<ArrayList<String>>();
	        try {
	            Connection con = ConnectionModel.getConnection();
	            String sql = new String();
	            PreparedStatement ps = null;
	            ResultSet rs = null;
	            int event_id = 0;
	          //  String event_creator="";
	            Date utiltoday = new Date();
	            String today= new SimpleDateFormat("yyyy-MM-dd").format(utiltoday);
	            
	            sql = "SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \"),text,DATE_FORMAT(start_time,'%l:%i %p'), DATE_FORMAT(end_time,'%l:%i %p'),event_venue,event_desc FROM events_units where event_date="+today+"";
	            ps = con.prepareStatement(sql);
	            rs = ps.executeQuery();
	            while (rs.next()) {
	                ArrayList<String> list = new ArrayList<String>();
	                event_id=rs.getInt("event_id");
	                int i = 1;
	                while (i <= 7) {
	                    list.add(rs.getString(i));
	                    ++i;
	                }
	               /* sql = "SELECT event_creator FROM event_creator where event_id="+event_id+"";
	                PreparedStatement ps1 = con.prepareStatement(sql);
	                ResultSet rs1 = ps1.executeQuery();
	                if(rs1.next())
	                {
	                	event_creator=rs1.getString("event_creator");
	                	
	                }
	                list.add(event_creator);*/
	                allList.add(list);
	            }
	            return allList;
	        }
	        catch (Exception e) {
	            e.printStackTrace();
	            return allList;
	        }
	}
}
