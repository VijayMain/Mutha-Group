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

public class ComplaintZilla_alert extends TimerTask {

	@Override
	public void run() {
		Date d = new Date();
		boolean flag = true;
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
		System.out.println("Overdue Complaints 7 days!!!");
		/*if (weekday[d.getDay()].equals("Wednesday") && d.getHours() == 10 && d.getMinutes() == 30) {*/
		if (weekday[d.getDay()].equals("Thursday") && d.getHours() == 11 && d.getMinutes() == 40) {
		
		//*************************************************************************************************************************************
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
			ArrayList emailList = new ArrayList();
			SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			HashMap<String,Integer> hm=new HashMap<String,Integer>();  
			
			Calendar calbackdate = new GregorianCalendar();
			calbackdate.add(Calendar.DAY_OF_MONTH, -7);
			Date sevenDaysAgo = calbackdate.getTime(); 
			String dateback = format2.format(calbackdate.getTime());
			
			String name = "";
			ArrayList list_assigned = new ArrayList();
			
			PreparedStatement ps_aasignCnt = null, ps_resolvedCnt = null,ps_user=null,ps_get=null;
			ResultSet rs_assignedCnt = null, rs_resolvedCnt = null,rs_user=null,rs_get=null;
			
			// **********************************************************************************************************************************************************
			// **********************************************************************************************************************************************************
			
			ps_aasignCnt  = con.prepareStatement("select distinct(Complaint_Assigned_To) from complaint_tbl where company_id="+comp_id+" and Status_Id<3 and complaint_type='customer' and Complaint_Date<'"+dateback+"'");
			rs_assignedCnt = ps_aasignCnt.executeQuery();
			while(rs_assignedCnt.next()){
				 ps_user = con.prepareStatement("select * from user_tbl where u_id="+rs_assignedCnt.getInt("Complaint_Assigned_To") +" and enable_id=1");
					rs_user = ps_user.executeQuery();
					while(rs_user.next()){
						name = rs_user.getString("U_Name");
						list_assigned.add(name);
						emailList.add(rs_user.getString("U_Email"));
						System.out.println("Email List = = " + emailList);
						ps_get = con.prepareStatement("select count(*) from complaint_tbl where Complaint_Assigned_To="+rs_user.getInt("u_id") +" and Complaint_Date<'"+dateback+"' and status_id<3 and complaint_type='customer'");
						  rs_get = ps_get.executeQuery();
						  while(rs_get.next()){
							  hm.put(name,rs_get.getInt("count(*)"));
						  }
						  name = "";
					}
			}
			
			System.out.println("ComplaintZilla Automailer Starts !!! " + " comp = " + comp_id);
			
			String host = "send.one.com";
			String user = "itsupports@muthagroup.com";
			String pass = "itsupports@xyz";
	 		String from = "itsupports@muthagroup.com";
	 		
	 		/*list_assigned.clear();
	 		pend_closeure=0;*/
	 		
	 		String subject = "";
	 		int srNo=1;
	 		if(list_assigned.size()>0){
			subject = "ALERT : "+string_Comp+" Customer complaints are not closed beyond 7 days !!!";
	 		}else{
	 		subject = "ALERT : All "+string_Comp+" Customer complaints are closed !!!";	
	 		}
			
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// *********************************************************************************************
			//**********************************************************************************************
			
			PreparedStatement ps_email = con.prepareStatement("select * from complaint_mailer where company_id="+comp_id);
			ResultSet rs_email	= ps_email.executeQuery();
			while (rs_email.next()) {
				emailList.add(rs_email.getString("hr_mailer_list"));
			}
			
			emailList.add("vijaybm@muthagroup.com");
			/*emailList.add("vmjoshi@muthagroup.com");
			emailList.add("rhpisal@muthagroup.com");*/
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
			if(list_assigned.size()>0){
			sb.append("<p style='font-family: Arial;font-size: 12px;'>"+
			"This is to inform you that customer complaints are not closed beyond 7 days in ComplaintZilla(Customer Complaint Tracking Software) on "+todays_date+
			"</p> <p style='font-family: Arial;font-size: 12px;color: red;'>"+
			"<b>As per management decision penalty of Rs 100 per day will be applicable to the person responsible for closure as listed below.</b>" +
			"In case of any genuine constraint to close within the specified period, Extension to be obtained in writing from Management so that the penalty can be waived. </p>"+
			"<p style='font-family: Arial;font-size: 12px;color: green;'>IF EXTENTION APPROVAL IS GIVEN BY MANAGEMENT THEN PLEASE IGNORE PERTICULAR USER</p>"+
		"<p style='font-family: Arial;font-size: 12px;'> <b>Please Note: </b> "+
			"If complaint assigned person is not available then Quality Team must be responsible to take action on complaints. </p>"+
			"<p style='font-family: Arial;font-size: 12px;'>"+
		"For more details please <a href='http://192.168.0.7/ComplaintZilla/'>Click Here</a> to Login into ComplaintZilla and find details in Dashboard. </p>");

			
			sb.append("<table border='1' width='70%' style='font-family: Arial;'>"+
			"<tr style='font-size: 11px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
			"<td colspan='3' height='20'><b style='font-family: Arial; font-size: 11px;'>Updated list of users responsible to close customer complaints (For those complaints which are over due beyond 7 days)</b></td>"+
			"</tr><tr align='center' style='font-size: 11px; font-family: Arial; background-color: #acc8cc;'><th style='width: 25px;'>Sr.No</th>"+
			"<th>Penalty applicable to</th><th style='width: 200px;'>No of Complaints to close</th> </tr>");
			
			 if(list_assigned.size()>0){
			sb.append("<tr style='font-size: 11px; font-family: Arial; background-color: #D1D1D1;'> <th colspan='3' align='left'>Complaints are assigned to and not resolved by ==></th> </tr>");
				for(int s=0;s<list_assigned.size();s++){
					
			sb.append("<tr><td align='center'>"+srNo +"</td><td>"+list_assigned.get(s).toString() +"</td><td align='center'>"+hm.get(list_assigned.get(s).toString()) +"</td></tr>");
			
			srNo = srNo++;
				}
				}
			   
			}else {
			sb.append("<tr align='center' style='font-size: 11px; font-family: Arial; background-color: #acc8cc;'>"+
					"<th colspan='3'>No Pending Complaints in ComplaintZilla</th></tr> <tr>"+
					"<td colspan='3' align='center'>All Complaints are successfully closed. Please remove penalty from the users applicable to.  " +
					"<p style='font-family: Arial;font-size: 12px;'>"+
					"For more details please <a href='http://192.168.0.7/ComplaintZilla/'>Click Here</a> to Login into ComplaintZilla and find details in Dashboard. </p>" +
					"</td></tr>");
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
			// ***********************************************************************************************************************************
			transport.close(); 
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