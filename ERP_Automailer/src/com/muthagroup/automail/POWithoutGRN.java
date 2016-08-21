package com.muthagroup.automail;

import java.sql.CallableStatement;
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

public class POWithoutGRN extends TimerTask {

	@Override
	public void run() {
		try {
			System.out.println("ERP Pending Approval !!!");
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
			
			/*if(!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 11 && d.getMinutes() == 01){ */
			
			if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 14 && d.getMinutes() == 19){
				
				System.out.println("In Loop !!!");
				Connection con = ConnectionUrl.getLocalDatabase();
				 
				Calendar first_Datecal = Calendar.getInstance();   
				first_Datecal.add(Calendar.DATE, -1);  
				Date date_last = first_Datecal.getTime();
				SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");  
				SimpleDateFormat simple_Date = new SimpleDateFormat("dd-MM-yyyy");  
				String sql_date = sdfFIrstDate.format(date_last);
				
				
				
				if(weekday[d.getDay()].equals("Tuesday")){
					first_Datecal.add(Calendar.DATE, -1);
					sql_date = sdfFIrstDate.format(first_Datecal.getTime()).toString();  
					date_last = first_Datecal.getTime();
				}  
				
				boolean sent=false;
				
			System.out.println("Email ERP Approval List.....!");
			String host = "send.one.com";
			String user = "itsupports@muthagroup.com";
			String pass = "itsupports@xyz"; 
	 		String from = "itsupports@muthagroup.com";
			String subject = "PO Without GRN List !!!"; 
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// *********************************************************************************************
			ArrayList cc_emails = new ArrayList();
			ArrayList to_emails = new ArrayList();
			ArrayList bcc_emails = new ArrayList();
			
			PreparedStatement ps_rec = con.prepareStatement("select * from pending_approvee where type='cc' and report='REQ_PendingApproval'");
			ResultSet rs_rec = ps_rec.executeQuery();
			while (rs_rec.next()) {
				cc_emails.add(rs_rec.getString("email"));
			}
			
			ps_rec = con.prepareStatement("select * from pending_approvee where type='to' and report='REQ_PendingApproval'");
			rs_rec = ps_rec.executeQuery();
			while (rs_rec.next()) {
				to_emails.add(rs_rec.getString("email"));
			}
			
			ps_rec = con.prepareStatement("select * from pending_approvee where type='bcc' and report='REQ_PendingApproval'");
			rs_rec = ps_rec.executeQuery();
			while (rs_rec.next()) {
				bcc_emails.add(rs_rec.getString("email"));
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
			
			
			InternetAddress[] addressTo = new InternetAddress[to_emails.size()]; 
			for (int p = 0; p < to_emails.size(); p++) {
				addressTo[p] = new InternetAddress(to_emails.get(p).toString());
			}
			InternetAddress[] addressCc = new InternetAddress[cc_emails.size()]; 
			for (int p = 0; p < cc_emails.size(); p++) {
				addressCc[p] = new InternetAddress(cc_emails.get(p).toString());
			}
			InternetAddress[] addressBcc = new InternetAddress[bcc_emails.size()]; 
			for (int p = 0; p < bcc_emails.size(); p++) {
				addressBcc[p] = new InternetAddress(bcc_emails.get(p).toString());
			}
			
			
			 
			msg.setRecipients(Message.RecipientType.TO, addressTo);
			msg.setRecipients(Message.RecipientType.CC, addressCc);
			msg.setRecipients(Message.RecipientType.BCC, addressBcc);
			 
			msg.setSubject(subject);
			msg.setSentDate(new Date()); 
	 		
			StringBuilder sb = new StringBuilder();
			sb.append("<b style='color: #0D265E;'>This is an automatically generated email for ERP - PO Without GRN dated "+ simple_Date.format(date_last) +" !!!</b>");
			
			sb.append("<table border='1' width='97%' style='font-family: Arial;'><tr style='font-size: 12px;background-color:#94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
			"<th height='24'>GRN No</th>"+
			"<th>GRN DATE</th>"+
			"<th>INWARD NO</th>"+
			"<th>CHALLAN NO</th>"+
			"<th>CHALLAN DATE</th>"+
			"<th>MATERIAL</th>"+
			"<th>PARTY</th>"+
			"<th>RECD QTY</th>"+
			"<th>RATE</th>"+
			"<th>AMOUNT</th>"+
			"</tr>");
			
			/*  
			 * exec "K1ERP"."dbo"."Sel_RptGRNRegisterMutha";1 '106', '0', '2026', '20160401', '20160820', '101,103,104,105,106,107,108,109,110,111,112,113,114,116,131'
			 * 
			 * MEPL H21 Start ==================== > 
			 * 
			*/
			int testavail = 0;
			String comp = "101";
			Connection con_21 = ConnectionUrl.getMEPLH21ERP();
			
			CallableStatement cs11 = con_21.prepareCall("{call Sel_RptGRNRegisterMutha(?,?,?,?,?,?)}");
			cs11.setString(1,comp);
			cs11.setString(2,"0");
			cs11.setString(3,"2026");
			cs11.setString(4,sql_date);
			cs11.setString(5,sql_date);
			cs11.setString(6,"101,103,104,105,106,107,108,109,110,111,112,113,114,116,131");
			ResultSet rs_getapp = cs11.executeQuery();
			while(rs_getapp.next()) {
				if(testavail==0){
					sb.append("<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;'>"+
						"<th colspan='10' style='background-color:#CCCCCC;color:#330066'>&nbsp;&nbsp;MEPL H21</th></tr>");
				}
				testavail++;
			sb.append("<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;'>"+
			  "<td align='right'>"+rs_getapp.getString("GRN_NO")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("PRN_TRANDATE")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("INWNO")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("CHLNNO")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("CHLNDATE")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("MATNAME")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("AC_NAME")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("RECD_QTY")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("RATE")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("AMOUNT")+"</td>"+
			  "</tr>");
			
			sent = true;
			}
			testavail = 0;
			/* MEPL H21 End */
			
			con_21.close();
			
			/* MEPL H25 Start */
			testavail = 0;
			comp = "102";
			con_21 = ConnectionUrl.getMEPLH25ERP(); 
			
			cs11 = con_21.prepareCall("{call Sel_RptGRNRegisterMutha(?,?,?,?,?,?)}");
			cs11.setString(1,comp);
			cs11.setString(2,"0");
			cs11.setString(3,"2026");
			cs11.setString(4,sql_date);
			cs11.setString(5,sql_date);
			cs11.setString(6,"101,103,104,105,106,107,108,109,110,111,112,113,114,116,131");
			rs_getapp = cs11.executeQuery();
			while(rs_getapp.next()) {
				if(testavail==0){
					sb.append("<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;'>"+
						"<th colspan='10' style='background-color:#CCCCCC;color:#330066'>&nbsp;&nbsp;MEPL H25</th></tr>");
				}
				testavail++;
			sb.append("<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;'>"+
			  "<td align='right'>"+rs_getapp.getString("GRN_NO")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("PRN_TRANDATE")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("INWNO")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("CHLNNO")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("CHLNDATE")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("MATNAME")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("AC_NAME")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("RECD_QTY")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("RATE")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("AMOUNT")+"</td>"+
			 "</tr>");
			
			sent = true;
			}
			testavail = 0;
			/* MEPL H25 END  */
			
			
			
			
			con_21.close();
			/* MFPL Start */
			testavail = 0;
			comp = "103";
			con_21 = ConnectionUrl.getFoundryERPNEWConnection(); 
			
			cs11 = con_21.prepareCall("{call Sel_RptGRNRegisterMutha(?,?,?,?,?,?)}");
			cs11.setString(1,comp);
			cs11.setString(2,"0");
			cs11.setString(3,"2026");
			cs11.setString(4,sql_date);
			cs11.setString(5,sql_date);
			cs11.setString(6,"101,103,104,105,106,107,108,109,110,111,112,113,114,116,131");
			rs_getapp = cs11.executeQuery();
			while(rs_getapp.next()) {
				if(testavail==0){
					sb.append("<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;'>"+
						"<th colspan='10' style='background-color:#CCCCCC;color:#330066'>&nbsp;&nbsp;MFPL</th></tr>");
				}
				testavail++;
			sb.append("<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;'>"+
			  "<td align='right'>"+rs_getapp.getString("GRN_NO")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("PRN_TRANDATE")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("INWNO")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("CHLNNO")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("CHLNDATE")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("MATNAME")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("AC_NAME")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("RECD_QTY")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("RATE")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("AMOUNT")+"</td>"+
			 "</tr>");
			
			sent = true;
			}
			testavail = 0;
			/* MFPL END  */
			
			
			
			
			
			con_21.close();
			/* DI Start */
			testavail = 0;
			comp = "105";
			con_21 = ConnectionUrl.getDIERPConnection();
			
			cs11 = con_21.prepareCall("{call Sel_RptGRNRegisterMutha(?,?,?,?,?,?)}");
			cs11.setString(1,comp);
			cs11.setString(2,"0");
			cs11.setString(3,"2026");
			cs11.setString(4,sql_date);
			cs11.setString(5,sql_date);
			cs11.setString(6,"101,103,104,105,106,107,108,109,110,111,112,113,114,116,131");
			rs_getapp = cs11.executeQuery();
			while(rs_getapp.next()) {
				if(testavail==0){
					sb.append("<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;'>"+
						"<th colspan='10' style='background-color:#CCCCCC;color:#330066'>&nbsp;&nbsp;DI</th></tr>");
				}
				testavail++;
			sb.append("<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;'>"+
			  "<td align='right'>"+rs_getapp.getString("GRN_NO")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("PRN_TRANDATE")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("INWNO")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("CHLNNO")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("CHLNDATE")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("MATNAME")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("AC_NAME")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("RECD_QTY")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("RATE")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("AMOUNT")+"</td>"+
			 "</tr>");
			
			sent = true;
			}
			testavail = 0;
			/* DI END  */
			


			con_21.close();
			/* MEPL UNIT III Start */
			testavail = 0;
			comp = "106";
			con_21 = ConnectionUrl.getK1ERPConnection();
			
			cs11 = con_21.prepareCall("{call Sel_RptGRNRegisterMutha(?,?,?,?,?,?)}");
			cs11.setString(1,comp);
			cs11.setString(2,"0");
			cs11.setString(3,"2026");
			cs11.setString(4,sql_date);
			cs11.setString(5,sql_date);
			cs11.setString(6,"101,103,104,105,106,107,108,109,110,111,112,113,114,116,131");
			rs_getapp = cs11.executeQuery();
			while(rs_getapp.next()) {
				if(testavail==0){
					sb.append("<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;'>"+
						"<th colspan='10' style='background-color:#CCCCCC;color:#330066'>&nbsp;&nbsp;MEPL UNIT III</th></tr>");
				}
				testavail++;
			sb.append("<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;'>"+
			  "<td align='right'>"+rs_getapp.getString("GRN_NO")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("PRN_TRANDATE")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("INWNO")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("CHLNNO")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("CHLNDATE")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("MATNAME")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("AC_NAME")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("RECD_QTY")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("RATE")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("AMOUNT")+"</td>"+
			 "</tr>");
			
			sent = true;
			}
			testavail = 0;
			/* MEPL UNIT III END  */
			
			
			
			
			
			
			
			
            sb.append("</table><p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"+
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
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
	} 
}