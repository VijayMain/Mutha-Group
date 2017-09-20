package com.muthagroup.automail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.TimerTask;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import com.muthagroup.connectionERPUtil.ConnectionUrl;

public class SupplierAlert extends TimerTask {
	@Override
	public void run() {
		try {
			System.out.println("ERP Supplier Approval");
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
			/*if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 9 && d.getMinutes() == 30) {*/
				if (!weekday[d.getDay()].equals("Tuesday") && 
					((d.getHours() == 8 && d.getMinutes() == 10) || 
							(d.getHours() == 16 && d.getMinutes() == 16))) {
			boolean flag=false;
			int  app_code = 1;
			
			java.sql.Date today1 =null;
			java.sql.Date yesterday =null;
			String email_datefrom = null;
			
			if(d.getHours() == 8){
			SimpleDateFormat dateformat = new SimpleDateFormat("yyyyMMdd");
			Calendar today = Calendar.getInstance();
			SimpleDateFormat sdformat = new SimpleDateFormat("dd-MM-yyyy");
			today1 = new java.sql.Date(today.getTimeInMillis());
			today.add(Calendar.DATE, 1);
			today1 = new java.sql.Date(today.getTimeInMillis());  
			today.add(Calendar.DATE, -2);
			email_datefrom = sdformat.format(today.getTime()).toString();
			yesterday = new java.sql.Date(today.getTimeInMillis());
			}else{
				SimpleDateFormat dateformat = new SimpleDateFormat("yyyyMMdd");
				Calendar today = Calendar.getInstance();
				SimpleDateFormat sdformat = new SimpleDateFormat("dd-MM-yyyy");
				today1 = new java.sql.Date(today.getTimeInMillis());
				today.add(Calendar.DATE, 1);
				today1 = new java.sql.Date(today.getTimeInMillis());  
				today.add(Calendar.DATE, -1);
				email_datefrom = sdformat.format(today.getTime()).toString();
				yesterday = new java.sql.Date(today.getTimeInMillis());
			}
			
			// System.out.println("yes = " + yesterday + " email = " + email_datefrom + " today = " + today1);
			
			String host = "send.one.com";
			String user = "erp@muthagroup.com";
			String pass = "erp@xyz";
	 		String from = "erp@muthagroup.com";
			String subject = "List of Approved Suppliers from " + email_datefrom;
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// ********************************************************************************************* 
			ArrayList listemailTo = new ArrayList(); 
			String report = "SupplierApprovedList";
			Connection con = ConnectionUrl.getLocalDatabase();
			PreparedStatement psauto = con.prepareStatement("select * from pending_approvee where report='"+report+"'");
			ResultSet rsauto = psauto.executeQuery();
			while (rsauto.next()) {
					listemailTo.add(rsauto.getString("email"));
			}
			
			psauto = con.prepareStatement("select email_logger from new_item_creation where enable=1 and approval_status='"+app_code+"' and update_date between  '"+yesterday+"' and '"+today1+"'");
			rsauto = psauto.executeQuery();
			while (rsauto.next()) {
					listemailTo.add(rsauto.getString("email_logger"));
			}
			
			// System.out.println("Log Emails = " + listemailTo);
			
			String recipients[] = new String[listemailTo.size()];
			
			for(int i=0;i<listemailTo.size();i++){
				recipients[i] = listemailTo.get(i).toString();
			}
			
			Properties props = System.getProperties();
			props.put("mail.host", host);
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", 465);
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
			Boolean flag_avail=false;
			// Closed Indent :
			// exec "ENGERP"."dbo"."Sel_TransactionsPurchase";1 '101', '50201', 'ADMIN', '20100507', '20170517'
			sb.append("<b style='color: #0D265E;font-size: 10px;'>This is an automatically generated email from FoundryMIS Supplier Creation Portal to be added in ERP System !!!</b>");
			sb.append("<table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>"+
			"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"+
			"<th>Supplier Names</th><th>Request Date</th><th>Created By</th><th>Status</th><th>Approved Date</th></tr>");
			
			 String query = "select update_by,DATE_FORMAT(update_date, \"%d/%m/%Y %l:%i\") as update_date,DATE_FORMAT(registered_date, \"%d/%m/%Y %l:%i\") as registered_date,code,supplier,registered_by from new_item_creation where enable=1 and approval_status='"+app_code+"' and update_date between  '"+yesterday+"' and '"+today1+"' order by update_date desc";
			  
			  PreparedStatement ps = con.prepareStatement(query);
			  ResultSet rs = ps.executeQuery();
			  while(rs.next()){
			  sb.append("<tr><td align='left' style='font-family: Arial;font-size: 10px;'>"+rs.getString("supplier").toUpperCase() +"</td><td>"+rs.getString("registered_date") +"</td>"+
			  					"<td>"+rs.getString("registered_by") +"</td>"+
			  					"<td>Approved  by "+ rs.getString("update_by") + "</td><td>"+rs.getString("update_date") +"</td></tr>"); 
			  flag_avail=true;
			  }
			sb.append("</table><p><b>For more details ,</b> "+ 
			"<a href='http://192.168.0.7/foundrymis/'>Click Here</a></p>"+ 
			"<p><b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
			"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
			"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
			"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
			"</font></p>");
		 
			msg.setContent(sb.toString(), "text/html");
	 
			if(flag_avail==true){
			Transport transport = mailSession.getTransport("smtp");
			transport.connect(host, user, pass);
			transport.sendMessage(msg, msg.getAllRecipients());
			transport.close();
			}
			
			System.out.println("ERP Supplier Portal Close");
			con.close();
			Thread.sleep(60000);
			}
		} catch (Exception e) {
		 e.printStackTrace();
		}
	}
}