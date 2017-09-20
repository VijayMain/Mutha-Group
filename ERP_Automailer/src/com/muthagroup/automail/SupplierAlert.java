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
			System.out.println("ERP Open Indents");
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
			/*if (weekday[d.getDay()].equals("Monday") && d.getHours() == 9 && d.getMinutes() == 30) {*/
				if (weekday[d.getDay()].equals("Monday") && d.getHours() == 15 && d.getMinutes() == 7) {
			boolean flag=false;
			SimpleDateFormat formatView = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat formatsql = new SimpleDateFormat("yyyyMMdd");
	        Date date = new Date();
	        Calendar c = Calendar.getInstance();
	        c.setTime(date);
	        int i = c.get(Calendar.DAY_OF_WEEK) - c.getFirstDayOfWeek();
	        c.add(Calendar.DATE, -i - 7);
	        Date start = c.getTime();
	        c.add(Calendar.DATE, 12);
	        Date end = c.getTime();
	        System.out.println(start + " - " + end);
			 
	        String from_sqldate = formatsql.format(start);
			String to_sqldate = formatsql.format(end);
			String dateFrom = formatView.format(start);
			String dateTo = formatView.format(end);
			
			System.out.println(start + " - " + end + " - " +  from_sqldate + " - " + to_sqldate + " - " +  dateFrom + " - " + dateTo);
			
			String host = "send.one.com";
			String user = "erp@muthagroup.com";
			String pass = "erp@xyz";
	 		String from = "erp@muthagroup.com";
			String subject = "ERP Support Portal Call Transfer List From  ";
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// ********************************************************************************************* 
			ArrayList listemailTo = new ArrayList();
			/* ArrayList listemailCc = new ArrayList();  */
			String report = "ERPOpen_Indent";
			Connection con = ConnectionUrl.getLocalDatabase();
			PreparedStatement psauto = con.prepareStatement("select * from pending_approvee where report='"+report+"'");
			ResultSet rsauto = psauto.executeQuery();
			while (rsauto.next()) {
					listemailTo.add(rsauto.getString("email"));
			}
			
			String recipients[] = new String[listemailTo.size()];
			
			for(i=0;i<listemailTo.size();i++){
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
			sb.append("<b style='color: #0D265E;font-size: 10px;'>This is an automatically generated email for ERP Open Indent  dated !!!</b>");
			sb.append("<table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>"+
			"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"+
			"<th scope='col'>Indent No</th>"+
			"<th scope='col'>Indent Date</th>"+
			"<th scope='col'>Party Name</th>"+
			"<th scope='col'>Created By</th>"+ 
			"<th scope='col'>Approved By</th>"+ 
			"<th scope='col'>Approved Date</th></tr>"); 
	/*********************************************************************************************************/		
			sb.append("</table><b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
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
			
			System.out.println("ERP Indent Closed");
			con.close();
			Thread.sleep(60000);
			}
		} catch (Exception e) {
		 e.printStackTrace();
		}
	}
}
