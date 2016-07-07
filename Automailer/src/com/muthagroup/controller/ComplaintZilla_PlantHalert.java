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

public class ComplaintZilla_PlantHalert extends TimerTask {

	@Override
	public void run() {
		Date d = new Date();
		boolean flag = true;
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
		System.out.println("Overdue Complaints 14 days !!!");
		if (weekday[d.getDay()].equals("Wednesday") && d.getHours() == 10 && d.getMinutes() == 32) {
		/*if (weekday[d.getDay()].equals("Wednesday") && d.getHours() == 13 && d.getMinutes() == 48) {*/
		
		//************************************************************************************************				
		for(int loop=0;loop<5;loop++){
		try{
			Connection con = Connection_Utility.getConnection();
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat todaysDate = new SimpleDateFormat("dd/MM/yyyy"); 
			String todays_date = todaysDate.format(cal.getTime()).toString();
			
			int comp_id = 0;
			String string_Comp = "";
			int cnt = loop+1;
			PreparedStatement ps_comp = con.prepareStatement("select * from user_tbl_company where Company_Id="+cnt);
			ResultSet rs_comp = ps_comp.executeQuery();
			while (rs_comp.next()) {
				comp_id = rs_comp.getInt("Company_Id");
				string_Comp = rs_comp.getString("Company_Name");
			}
			
			SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			HashMap<String,Integer> hm=new HashMap<String,Integer>();
			
			Calendar calbackdate = new GregorianCalendar();
			calbackdate.add(Calendar.DAY_OF_MONTH, -14);
			Date sevenDaysAgo = calbackdate.getTime();
			String dateback = format2.format(calbackdate.getTime());
			
			
			String host = "send.one.com";
			String user = "itsupports@muthagroup.com";
			String pass = "itsupports@xyz";
	 		String from = "itsupports@muthagroup.com";
	 		
	 		/*list_assigned.clear();
	 		pend_closeure=0;*/
	 		
	 		int count=0;
			PreparedStatement ps_plant = con.prepareStatement("select count(*) from complaint_tbl where company_id="+comp_id+" and Status_Id<3 and Complaint_Date<'"+dateback+"'");
	 		ResultSet rs_plant = ps_plant.executeQuery();
	 		while (rs_plant.next()) {
	 			count = rs_plant.getInt("count(*)");
			}
	 		
	 		String subject = "";
	 		int srNo=1;
	 		if(count>0){
			subject = "ALERT : "+string_Comp+" Customer complaints are not closed beyond 14 days !!!";
	 		}else{
	 		subject = "ALERT : All "+string_Comp+" Customer complaints are closed !!!";	
	 		}
			
			boolean sessionDebug = false; 
			// *********************************************************************************************
			// multiple recipients : == >
			// *********************************************************************************************
			//**********************************************************************************************
			ArrayList emailList = new ArrayList();
			PreparedStatement ps_email = con.prepareStatement("select * from complaint_mailer where company_id="+comp_id);
			ResultSet rs_email	= ps_email.executeQuery();
			while (rs_email.next()) {
				emailList.add(rs_email.getString("hr_mailer_list"));
			}
			PreparedStatement ps_emailph = con.prepareStatement("select * from complaint_mailerph where company_id="+comp_id);
			ResultSet rs_emailph	= ps_emailph.executeQuery();
			while (rs_emailph.next()) {
				emailList.add(rs_emailph.getString("ph_mailer_list"));
			}
			
			emailList.add("vijaybm@muthagroup.com");
			emailList.add("vmjoshi@muthagroup.com");
			emailList.add("rhpisal@muthagroup.com");
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
			
			sb.append("<p style='font-family: Arial; font-size: 12px;'>This is to inform you that <b style='font-family: Arial; color: red;'>"+count +" customer complaints</b> are not closed beyond 14 days in"+
					"ComplaintZilla(Customer Complaint Tracking Software).</p> <p style='font-family: Arial; font-size: 12px; color: red;'>"+
					"<b>As per management decision penalty of Rs. 200 per day will be applicable to the Plant Head.</b>	</p>"+
					"<p style='font-family: Arial; font-size: 12px; color: red;'> In case of any genuine constraint to close within the specified period,"+
					"Extension to be obtained in writing from Management so that the penalty can be waived. </p> "+
					"<p style='font-family: Arial;font-size: 14px;color: green;'>IF EXTENTION APPROVAL IS GIVEN BY MANAGEMENT THEN PLEASE IGNORE THIS MAIL</p>"+
					"<p style='font-family: Arial; font-size: 12px;'> <b>Please Note: </b>"+
					"<p> In ComplaintZilla Complaints must be resolved by assigned person, Quality team must verify and close the complaints. Plant head need to monitor this flow."+
					"</p> <p> To monitor please <a href='http://192.168.0.7/ComplaintZilla/'>Click Here</a> to Login into ComplaintZilla</p>"+ 
					"<p>Use your in-house software login details to login e.g. IT Tracker.</p>Find Dashboard and check the live customer complaints status. ");
			
			sb.append("</table><p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'> IT | Software Development | Mutha Group Satara </p><hr><p>"+
					"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
					"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
					"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
					"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
					"</font></p>");
			
			if(count>0){
			msg.setContent(sb.toString(), "text/html");
			Transport transport = mailSession.getTransport("smtp");
			transport.connect(host, user, pass);
			transport.sendMessage(msg, msg.getAllRecipients());
			transport.close(); 
			}
			// *************************************************************************************************************
			
			con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
			}
		try {
	            System.out.println(new Date());
	            Thread.sleep(60 * 1000); 
	    } catch (InterruptedException e) {
	        e.printStackTrace();
	    }
		System.out.println("ComplaintZilla Automailer End !!!");
		}
	} 
}
