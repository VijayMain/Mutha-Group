package com.muthagroup.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;
import java.util.TimerTask;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class ComplaintZilla_alertunit3 extends TimerTask {

	@Override
	public void run() {
		Date d = new Date();
		boolean flag = true;
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };  
		
		/*if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 10 && d.getMinutes() == 34) {*/
		if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 16 && d.getMinutes() == 37) {
		//************************************************************************************************				
		try{ 
			Calendar cal = Calendar.getInstance(); 
			SimpleDateFormat todaysDate = new SimpleDateFormat("dd/MM/yyyy"); 
			String todays_date = todaysDate.format(cal.getTime()).toString();
			
			int comp_id = 4;
			String string_Comp = "MEPL UNIT III";
			Connection con = Connection_Utility.getConnection();
			 
			SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			HashMap<String,Integer> hm=new HashMap<String,Integer>();  
			
			Calendar cal_last = new GregorianCalendar();
			cal_last.add(Calendar.DAY_OF_MONTH, -7);
			Date sevenDaysAgo = cal_last.getTime(); 
			String dateback = format2.format(cal_last.getTime());
			
			PreparedStatement ps_get = null,ps_user=null,ps_newget =null,ps_newuser  =null;
			ResultSet rs_get = null,rs_user=null,  rs_new_get=null,rs_new_user=null;  
			String name = "";
			ArrayList list_name = new ArrayList();
			
			PreparedStatement ps = con.prepareStatement("SELECT distinct(u_id) FROM user_tbl where dept_id=6 and company_id ="+comp_id+" and u_id in(SELECT distinct(Complaint_Assigned_To) FROM complaint_tbl where status_id<5) and enable_id=1");
			ResultSet rs = ps.executeQuery();
			
			
			while(rs.next()){
				ps_user = con.prepareStatement("select * from user_tbl where  u_id="+rs.getInt("u_id"));
				rs_user = ps_user.executeQuery();
				while(rs_user.next()){
					name = rs_user.getString("U_Name");
					list_name.add(name);
			 
			  ps_get = con.prepareStatement("select count(*) from complaint_tbl where  Company_Id="+comp_id+" and Complaint_Date<'"+dateback+"' and status_id<5");
			  rs_get = ps_get.executeQuery();
			  while(rs_get.next()){
				  hm.put(name,rs_get.getInt("count(*)"));
			  }
			}
			  name = "";
			}
			
			
			PreparedStatement ps_new = con.prepareStatement("SELECT distinct(u_id) FROM user_tbl where dept_id!=6 and company_id ="+comp_id+" and u_id in(SELECT distinct(Complaint_Assigned_To) FROM complaint_tbl where status_id<3) and enable_id=1");
			ResultSet rs_new = ps_new.executeQuery();
			
			
			while(rs_new.next()){
				ps_newuser = con.prepareStatement("select * from user_tbl where  u_id="+rs_new.getInt("u_id"));
				rs_new_user = ps_newuser.executeQuery();
				while(rs_new_user.next()){
					name = rs_new_user.getString("U_Name");
					list_name.add(name);
			 
			  ps_newget = con.prepareStatement("select count(*) from complaint_tbl where  Complaint_Assigned_To="+rs_new_user.getInt("u_id") +" and Complaint_Date<'"+dateback+"' and status_id<3");
			  rs_new_get = ps_newget.executeQuery();
			  while(rs_new_get.next()){
				  hm.put(name,rs_new_get.getInt("count(*)"));
			  }
			}
			  name = "";
			}
			
			int j=1; 
			
			System.out.println("ComplaintZilla Automailer Starts !!!");
			String host = "send.one.com";
			String user = "itsupports@muthagroup.com";
			String pass = "itsupports@xyz";
	 		String from = "itsupports@muthagroup.com";
	 		
	 		// list_name.clear();
	 		
	 		String subject = "";
	 		if(list_name.size()>0){
			subject = "ALERT : "+string_Comp+" Customer complaints are not closed beyond 7 days !!!";
	 		}else{
	 		subject = "ALERT : All "+string_Comp+" Customer complaints are closed !!!";	
	 		}
			
			boolean sessionDebug = false; 
			// *********************************************************************************************
			// multiple recipients : == >
			// *********************************************************************************************
				ArrayList emailList = new ArrayList();
			//**********************************************************************************************
			emailList.add("vijaybm@muthagroup.com");
			
			//**********************************************************************************************
			 
			
			Set<String> hs2 = new HashSet();
			hs2.addAll(emailList);
			emailList.clear();
			emailList.addAll(hs2);
			
			System.out.println("Email List =  " + emailList);
			  
			
			String[] recipients = new String[emailList.size()];
			
			for(int i=0;i<emailList.size();i++){
				recipients[i] = emailList.get(i).toString();
			}
			 
			Properties props = System.getProperties();
			props.put("mail.host", host);
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", 2525);
			Session mailSession = Session.getDefaultInstance(props, null);
			mailSession.setDebug(sessionDebug);
			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(from));
			InternetAddress[] addressTo = new InternetAddress[recipients.length];
			for (int p = 0; p < recipients.length; p++) {
				addressTo[p] = new InternetAddress(recipients[p]);
			} 
			msg.setRecipients(Message.RecipientType.TO, addressTo); 
			msg.setSubject(subject);
			msg.setSentDate(new Date()); 
			StringBuilder sb = new StringBuilder();
			
			sb.append("<b style='font-family: Arial;font-size: 11px;color: #0D265E;'>*** This is an automatically generated email from Mutha Group ComplaintZilla (Customer Complaint Tracking System) for "+string_Comp+"***</b>");
		 	//----------------------------------------------------------------------------------------------------------------
			sb.append("<p style='font-family: Arial;font-size: 12px;'> Dear HR Team, </p>");
			if(list_name.size()>0){
			sb.append("<p style='font-family: Arial;font-size: 12px;'>"+
			"This is to inform you that customer complaints are not closed beyond 7 days in ComplaintZilla(Customer Complaint Tracking Software) on "+todays_date+
			"</p> <p style='font-family: Arial;font-size: 12px;color: red;'>"+
			"<b>As per management decision penalty of Rs 100 per day will be applicable to the person responsible for closure as listed below.</b> </p>"+
		"<p style='font-family: Arial;font-size: 12px;'> <b>Please Note: </b> "+
			"If complaint assigned person is not available then Quality Team must be responsible to take action on complaints. </p>"+
			"<p style='font-family: Arial;font-size: 12px;'>"+
		"For more details please login to <b>http://192.168.0.7/ComplaintZilla/</b>  and find details in Dashboard. </p>");
			
			sb.append("<table border='1' width='70%' style='font-family: Arial;'>"+
			"<tr style='font-size: 11px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
			"<td colspan='3' height='20'><b style='font-family: Arial; font-size: 11px;'>Updated list of users responsible to close customer complaints (For those complaints which are over due beyond 7 days)</b></td>"+
			"</tr><tr align='center' style='font-size: 11px; font-family: Arial; background-color: #acc8cc;'><th style='width: 25px;'>Sr.No</th>"+
			"<th>Penalty applicable to</th><th style='width: 200px;'>No of Complaints to close</th> </tr>");
			
			
			for(int i = 0;i<list_name.size();i++){
				sb.append("<tr> <td align='center'>"+j+"</td>"+
								"<td>"+list_name.get(i).toString() +"</td>"+
								"<td align='center'>"+hm.get(list_name.get(i).toString()) +"</td> </tr>");
				j++;
			}
			}else {
			sb.append("<tr align='center' style='font-size: 11px; font-family: Arial; background-color: #acc8cc;'>"+
					"<th colspan='3'>No Pending Complaints in ComplaintZilla</th></tr> <tr>"+
					"<td colspan='3' align='center'>All Complaints are successfully closed. Please remove penalty from the users applicable to.  </td></tr>");
			}
			sb.append("</table><p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'> IT | Software Development | Mutha Group Satara </p><hr><p>"+
					"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
					"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
					"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
					"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
					"</font></p>");
			
			msg.setContent(sb.toString(), "text/html");
			Transport transport = mailSession.getTransport("smtp");
			transport.connect(host, user, pass);
			transport.sendMessage(msg, msg.getAllRecipients());
			// ******************************************************************************
			transport.close(); 
		}catch(Exception e){
			e.printStackTrace();
		}
		System.out.println("ComplaintZilla Automailer End !!!");
		}
	}

}
