package com.muthagroup.automail;

import java.sql.CallableStatement;
import java.sql.Connection;
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

public class Purchase_Pending_ApprovalMFPL extends TimerTask {

	@Override
	public void run() {
		Date d = new Date();
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday" };
		ArrayList rem = new ArrayList(); 
		if ((!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 10 && d.getMinutes() == 03)||(!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 16 && d.getMinutes() == 03)) {
		try {
			
			Calendar first_Datecal = Calendar.getInstance();   
			first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
			Date dddd = first_Datecal.getTime();  
			SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");  
			Date tdate = new Date(); 
			String firstDate = sdfFIrstDate.format(dddd);
			String nowDate = sdfFIrstDate.format(tdate);
			
			// System.out.println("Test = " + firstDate+"\n"+nowDate);
			
			Connection con = ConnectionUrl.getFoundryERPNEWConnection();
			CallableStatement cs = con.prepareCall("{call Sel_RptPurchOrderRegister(?,?,?,?,?,?)}");
			cs.setString(1, "103");
			cs.setString(2, "0");
			cs.setString(3, "4031,4032,4037");
			cs.setString(4, firstDate);
			cs.setString(5, nowDate);
			cs.setInt(6, 21);
			ResultSet rs = cs.executeQuery();				
			 
			if (rs.isBeforeFirst()) {
				
		System.out.println("Automailer ERP");
		String host = "send.one.com";
		String user = "itsupports@muthagroup.com";
		String pass = "itsupports@xyz"; 
 		String from = "itsupports@muthagroup.com";
		String subject = "Purchase Pending Approvals of MFPL !!!"; 
		boolean sessionDebug = false;
		// *********************************************************************************************
		// multiple recipients : == >
		// ********************************************************************************************* 
		String recipients[] = {"ankatariya@muthagroup.com"};
		String cc_recipients[] = {"kunalvm@muthagroup.com","bhushan@muthagroup.com"};


		Properties props = System.getProperties();
		props.put("mail.host", host);
		
		/*props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", 2525);*/
		
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
		
		InternetAddress[] addressCc = new InternetAddress[cc_recipients.length];
		for (int p = 0; p < cc_recipients.length; p++) {
			addressCc[p] = new InternetAddress(cc_recipients[p]);
		}

		msg.setRecipients(Message.RecipientType.TO, addressTo);
		msg.setRecipients(Message.RecipientType.CC, addressCc);

		msg.setSubject(subject);
		msg.setSentDate(new Date()); 
 		
		StringBuilder sb = new StringBuilder();
		sb.append("<b style='color: #0D265E;'>*** This is an automatically generated email for Purchase Pending Approvals of MFPL !!! ***</b>"+
		"<table border='1' width='97%' style='font-family: Arial;'>"+
		"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
		"<th width='8%' height='25'>PO. No</th><th width='15%'>PO Date</th><th width='40%'>Supplier Name</th><th width='20%'>Created By</th> "+
		"</tr>");
		String pono=""; 
		while (rs.next()) { 
			if(!rs.getString("PO_NO").equalsIgnoreCase(pono)){
		sb.append("<tr style='font-size: 12px;'><td style='text-align: center;'>"+rs.getString("PO_NO")+"</td>"+
		"<td style='text-align: center;'>"+rs.getString("PRN_PODATE")+"</td>"+ 
		"<td style='text-align: left;'>"+rs.getString("SUPP_NAME")+"</td>"+
		"<td style='text-align: left;'>"+rs.getString("SYSADD_LOGIN")+"</td></tr>"); 
		pono = rs.getString("PO_NO");
			}
		}  
		sb.append("</table> <p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"+
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
		System.out.println("ERP MFPL Loop End");		
		}		
			con.close();
	} catch (Exception e) {
	 e.printStackTrace();
	}  
		System.out.println("ERP Mailer 3");	
		}
	}

}
