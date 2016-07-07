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

public class Purchase_Approved_statusdi extends TimerTask {

	@Override
	public void run() {
		Date d = new Date();
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday" };
		ArrayList rem = new ArrayList(); 
		if ((!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 10 && d.getMinutes() == 18)||(!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 16  && d.getMinutes() == 13)) {
		try { 
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");
			boolean sent=false;
			
			if(d.getHours() == 10 && d.getMinutes() == 18){
			cal.add(Calendar.DATE, -1);
			System.out.println("Inside last date = " + formatDate.format(cal.getTime()).toString());
			}
			if(d.getHours() == 16 && d.getMinutes() == 13){
				cal.add(Calendar.DATE, 0);
				System.out.println("Inside today date = " + formatDate.format(cal.getTime()).toString());
			}
				
			String yest_date = sdfFIrstDate.format(cal.getTime()).toString(); 
			String y_date = formatDate.format(cal.getTime()).toString();
			
			System.out.println("Yest Date = "+yest_date);
			System.out.println("Y = "+y_date);
			
			Calendar first_Datecal = Calendar.getInstance();   
			first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
			Date dddd = first_Datecal.getTime();  
			
			Date tdate = new Date(); 
			String firstDate = sdfFIrstDate.format(dddd);
			String nowDate = sdfFIrstDate.format(tdate);
			
			//System.out.println("Test = " + firstDate+"\n"+nowDate);
			
			Connection con = ConnectionUrl.getDIERPConnection();
			CallableStatement cs = con.prepareCall("{call Sel_RptPurchOrderRegister(?,?,?,?,?,?)}");
			cs.setString(1, "105");
			cs.setString(2, "0");
			cs.setString(3, "4031,4032,4037");
			cs.setString(4, firstDate);
			cs.setString(5, nowDate);
			cs.setInt(6, 0);
			ResultSet rs = cs.executeQuery();				 
		System.out.println("Email ERP Automailer.....");
		String host = "send.one.com";
		String user = "itsupports@muthagroup.com";
		String pass = "itsupports@xyz"; 
 		String from = "itsupports@muthagroup.com";
		String subject = "Purchase Approved PO from DI on  "+y_date+" !!!"; 
		boolean sessionDebug = false;
		// *********************************************************************************************
		// multiple recipients : == >
		// ********************************************************************************************* 
		String recipients[] = {"srpatekar@muthagroup.com"};
		String cc_recipients[] = {"vijaybm@muthagroup.com","internalaudit@muthagroup.com","kunalvm@muthagroup.com","adgadkari@muthagroup.com","ankatariya@muthagroup.com","kamlesh@muthagroup.com"};
		
		/*String recipients[] = {"vijaybm@muthagroup.com"};
		String cc_recipients[] = {"vijaybm@muthagroup.com"}; */
		

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
		
		InternetAddress[] addressCc = new InternetAddress[cc_recipients.length];
		for (int p = 0; p < cc_recipients.length; p++) {
			addressCc[p] = new InternetAddress(cc_recipients[p]);
		}
		  
		msg.setRecipients(Message.RecipientType.TO, addressTo);
		msg.setRecipients(Message.RecipientType.CC, addressCc);
		 
		msg.setSubject(subject);
		msg.setSentDate(new Date()); 
 		
		StringBuilder sb = new StringBuilder();
		sb.append("<b style='color: #0D265E;'>*** This is an automatically generated email for Purchase  Approved PO of DI !!! ***</b>"+
		"<table border='1' width='97%' style='font-family: Arial;'>"+
		"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
		"<th width='8%' height='25'>PO. No</th><th width='15%'>PO Date</th><th width='40%'>Supplier Name</th><th width='20%'>Created By</th> "+
		"<th width='20%'>Approved Date</th><th width='20%'>Approved By</th> "+
		"</tr>"); 
		String pono="",aprDate=""; 
		
		while (rs.next()) {
		aprDate = 	rs.getString("SYSAPR_DATETIME").substring(0, 8);
			if(!rs.getString("PO_NO").equalsIgnoreCase(pono) && aprDate.equalsIgnoreCase(yest_date)){
				sent = true;
		sb.append("<tr style='font-size: 12px;'><td style='text-align: center;'>"+rs.getString("PO_NO")+"</td>"+
		"<td style='text-align: center;'>"+rs.getString("PRN_PODATE")+"</td>"+ 
		"<td style='text-align: left;'>"+rs.getString("SUPP_NAME")+"</td>"+
		"<td style='text-align: left;'>"+rs.getString("SYSADD_LOGIN")+"</td>" +
		"<td style='text-align: center;'>"+rs.getString("SYSAPR_DATETIME").substring(6, 8) +"/"+ rs.getString("SYSAPR_DATETIME").substring(4, 6)+"/"+rs.getString("SYSAPR_DATETIME").substring(0, 4)+
		"</td><td style='text-align: left;'>"+rs.getString("SYSAPR_LOGIN")+"</td></tr>"); 
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
 
		if(sent==true){
		Transport transport = mailSession.getTransport("smtp");
		transport.connect(host, user, pass);
		transport.sendMessage(msg, msg.getAllRecipients());
		// ******************************************************************************
		transport.close();
		System.out.println("msg Sent !!!");
		} 
			con.close();
	} catch (Exception e) {
	 e.printStackTrace();
	}   
		} 
		System.out.println("Aprroved Mail 14 !!!");
		} 
}
