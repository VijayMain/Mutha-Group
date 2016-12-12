package com.muthagroup.automail;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; 
import java.util.ArrayList; 
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.TimerTask; 

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.muthagroup.connectionERPUtil.ConnectionUrl;

public class Supplier_ReportFND extends TimerTask {

	@Override
	public void run() {
		try {
			System.out.println("PO Without GRN 1000 !!!");
			Date d = new Date();
			String weekday[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};

			if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 11 && d.getMinutes() == 52) {
		/*	if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 15 && d.getMinutes() == 5){*/
			    
				Connection con = ConnectionUrl.getLocalDatabase(); 
				Connection conERP = ConnectionUrl.getBWAYSERPMASTERConnection();
				String name_user = "",supp_cat="",tds_code="",supp_city="";
				boolean sent = false;

				String host = "send.one.com";
				String user = "itsupports@muthagroup.com";
				String pass = "itsupports@xyz";
				String from = "itsupports@muthagroup.com";
				String subject = "Alert: ERP New Supplier Creation Approvals are Pending !!!";
				boolean sessionDebug = false;
				// *********************************************************************************************
				// multiple recipients : == >
				// *********************************************************************************************
				ArrayList to_emails = new ArrayList();
				
				PreparedStatement  ps_rec = con.prepareStatement("select * from pending_approvee where type='to' and report='NewSuppliers_pending'");
				ResultSet rs_rec = ps_rec.executeQuery();
				while (rs_rec.next()) {
					to_emails.add(rs_rec.getString("email"));
				}
  
				Set<String> hs = new HashSet<String>();
				hs.addAll(to_emails);
				to_emails.clear();
				to_emails.addAll(hs); 
				
				
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
				msg.setRecipients(Message.RecipientType.TO, addressTo); 
				msg.setSubject(subject);
				msg.setSentDate(new Date()); 
				StringBuilder sb = new StringBuilder();
				
				sb.append("<b style='color: #0D265E;'>This is an automatically generated email for ERP Pending Approval - To add new suppliers in ERP System !!!</b>");
				sb.append("<table border='1' width='97%' style='font-family: Arial;'><tr style='font-size: 12px;background-color:#94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"
						+ "<th height='24'>Sr. No</th>"
						+ "<th>Supplier Name</th>"
						+ "<th>Purpose</th>"
						+ "<th>Request Date</th>"
						+ "<th>Request Days</th>"
						+ "<th>Logged By</th>"
						+ "<th>Approval</th>" 
						+ "</tr>"); 			
				int sr=1;
			 	PreparedStatement ps = con.prepareStatement("select DATE_FORMAT(registered_date, \"%d/%m/%Y %l:%i\") as registered_date,supp_category,tds_code,supp_city,supplier,purpose,registered_by,supp_address,supplier_phone1,supplier_phone2,pan_no,indus_type,credit_days,tan_no,code, DATEDIFF(CURDATE(), registered_date) AS DAYS from new_item_creation where enable=1 and approval_status=0");
				ResultSet rs = ps.executeQuery();
			    while(rs.next()){
			    	     PreparedStatement ps_sup = conERP.prepareStatement("select * from MSTMATCATAG where code ='"+ rs.getString("supp_category") + "'");
			    	     ResultSet rs_sup = ps_sup.executeQuery();
			    	      while(rs_sup.next()){
			    	    	  supp_cat = rs_sup.getString("NAME");  
			    	      }
			    	      
			    	      ps_sup = conERP.prepareStatement("select * from CNFRATETDS where code ='"+ rs.getString("tds_code") + "'");
			     	      rs_sup = ps_sup.executeQuery();
			     	      while(rs_sup.next()){
			     	    	  tds_code = rs_sup.getString("NAME");  
			     	      }
			     	      
			     	     ps_sup = conERP.prepareStatement("select * from MSTCOMMCITY  where CODE ='"+ rs.getString("supp_city") + "'");
			    	      rs_sup = ps_sup.executeQuery();
			    	      while(rs_sup.next()){
			    	    	  supp_city = rs_sup.getString("NAME");
			    	      } 
			    	      
			    	      sb.append("<tr><td align='center'>"+sr +"</td> <td align='left'>"
			    	      +rs.getString("supplier") +"</td> <td align='left'>"+rs.getString("purpose") +"</td> <td align='left'>"+rs.getString("registered_date") 
			    	      +"</td> <td align='left'>"+rs.getString("DAYS") +"</td> <td align='left'>"+rs.getString("registered_by") 
			    	      +"</td> <td align='left'>Pending</td></tr>");	      
			    	      
			    	      sr++; 
			    	      supp_cat=""; 
			    	      } 
 				sb.append("</table><p>"
						+ "<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"
						+ "<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"
						+ "it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"
						+ "or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"
						+ "</font></p>");
				
				msg.setContent(sb.toString(), "text/html");
				 
				Transport transport = mailSession.getTransport("smtp");
				transport.connect(host, user, pass);
				transport.sendMessage(msg, msg.getAllRecipients());
				// ******************************************************************************
				transport.close(); 
				System.out.println("MIS Summary loop End");	
				con.close();
			}
			Thread.sleep(60000);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
