package com.muthagroup.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Properties;
import java.util.TimerTask;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class ECN_NoAction_Custmailer extends TimerTask {

	@Override
	public void run() {
		Date d = new Date();
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
		ArrayList rem = new ArrayList(); 
			if (weekday[d.getDay()].equals("Wednesday") && d.getHours() == 9 && d.getMinutes() == 33) {
		/*if (d.getHours() == 17 && d.getMinutes() == 8) {*/
			try {
				
				ArrayList approvers = new ArrayList();
				ArrayList app_rem = new ArrayList();
				
				boolean flag = false;
				
				String comp="",partname="";
				String pending = "Pending";
				Connection con = Connection_Utility.getConnection();
				PreparedStatement ps_ecn = null, ps_apr = null, ps_cr = null,ps_conp=null,ps_prod=null;
				ResultSet rs_ecn = null, rs_apr = null, rs_cr = null,rs_conp=null,rs_prod=null;

				ps_apr = con.prepareStatement("select * from crc_tbl");
				rs_apr = ps_apr.executeQuery();
				while (rs_apr.next()) {
					approvers.add(rs_apr.getInt("CRC_No"));
				}
				
				if(approvers.size()>0){
				// System.out.println("Before = " + approvers);

				ps_cr = con.prepareStatement("select * from crc_tbl_approval where Approval_Id in(2,3)");
				rs_cr = ps_cr.executeQuery();
				while (rs_cr.next()) {
					if (approvers.contains(rs_cr.getInt("CRC_No"))) {
						app_rem.add(rs_cr.getInt("CRC_No"));
					}
				}

				HashSet hs = new HashSet();
				hs.addAll(app_rem);
				app_rem.clear();
				app_rem.addAll(hs);

				approvers.removeAll(app_rem); 
				
				// System.out.println("After = " + approvers);

				PreparedStatement ps_pr = null;
				ResultSet rs_pr = null;
				
			System.out.println("ECN Approved Automailer....");
			String host = "send.one.com";
			String user = "ecn@muthagroup.com";
			String pass = "ecn@xyz";
	 		String from = "ecn@muthagroup.com";
			String subject = "No Action Registered on Approved ECN(Customer Change Requests)";
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// *********************************************************************************************
			String[] recipients = new String[approvers.size()+1];
			 PreparedStatement ps_recipients = null;
			 ResultSet rs_recipients = null;
			 
			 int ct=0;
			 
			for(int c=0;c<approvers.size();c++){
				
			PreparedStatement psap = con.prepareStatement("select * from crc_tbl where CRC_No="+Integer.parseInt(approvers.get(c).toString())); 
			ResultSet rsap = psap.executeQuery();
			while (rsap.next()) {
				PreparedStatement ps_user = con.prepareStatement("select * from user_tbl where U_Id=" + rsap.getInt("U_Id"));
				ResultSet rs_user = ps_user.executeQuery();
				while (rs_user.next()) {
					recipients[ct] = rs_user.getString("U_Email");
					ct++;
					}
				}
			}			
			
			
		//	recipients[ct] = "govindmb@muthagroup.com";
			
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
			sb.append("<b style='color: #0D265E;'>*** This is an automatically generated email from ECN(Engineering Change Note) !!! ***</b>");
			sb.append("<p><b>Please <a href='http://192.168.0.7/ECN/'>click here</a> to Approve.</b></p>"+
					"<table border='1' width='100%' style='font-family: Arial;'>"+
					"<tr style='font-size: 12px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
					"<th width='8%' height='25' colspan='9'><b style='color: red;'>No Action Taken on Approved ECN(Customer Change Requests)</b></th></tr>"+
					"<tr style='font-size: 11px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
					"<th width='5%' height='18'>ECN No.</th>"+
					"<th width='25%'>Part Name</th>"+
					"<th width='10%'>Request Date</th>"+
					"<th width='10%'>Proposed Implement Date</th>"+
					"<th width='25%'>Nature of change</th>"+
					"<th width='25%'>Reason for change</th>"+
					"<th width='8%'>Change in</th>"+
					"<th width='8%'>Company</th>"+
					"<th width='10%'>Action</th></tr>");			
			
			for (int i = 0; i < approvers.size(); i++) {
				ps_pr = con.prepareStatement("select * from crc_tbl where CRC_No=" + Integer.parseInt(approvers.get(i).toString()));
				rs_pr = ps_pr.executeQuery();
				while(rs_pr.next()){
					
					ps_conp = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_pr.getInt("Company_Id"));
					rs_conp = ps_conp.executeQuery();
					while(rs_conp.next()){
						comp = rs_conp.getString("Company_Name"); 
					}
					
					ps_prod = con.prepareStatement("select * from customer_tbl_item where Item_Id="+rs_pr.getInt("Item_Id"));
					rs_prod = ps_prod.executeQuery();
					while(rs_prod.next()){
						partname = rs_prod.getString("Item_Name"); 
					}
			
					sb.append("<tr style='font-size: 9px;font-family: Arial;'>"+
							"<td style='text-align: center;'>"+rs_pr.getInt("CRC_No")+"</td>"+
							"<td style='text-align: left;'>"+partname+"</td>"+
							"<td style='text-align: center;'>"+rs_pr.getDate("CRC_Date")+"</td>"+
							"<td style='text-align: center;'>"+rs_pr.getDate("Targated_Impl_Date")+"</td>"+
							"<td style='text-align: left;'>"+rs_pr.getString("Nature_Of_Change")+"</td>"+
							"<td style='text-align: left;'>"+rs_pr.getString("Reason_For_Change")+"</td>"+
							"<td style='text-align: left;'>"+rs_pr.getString("Change_For")+"</td>"+
							"<td style='text-align: center;'>"+comp+"</td>"+
							"<td style='text-align: center;'><b style='color: red;'>"+pending+"</b></td></tr>"); 	
					flag = true;
				}
			}
						
			sb.append("</table> <p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"+
					"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
					"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
					"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
					"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
					"</font></p>");
		 
			if(flag==true){
			msg.setContent(sb.toString(), "text/html");	 
			Transport transport = mailSession.getTransport("smtp");
			transport.connect(host, user, pass);
			transport.sendMessage(msg, msg.getAllRecipients());
			transport.close(); 
			}
			}		
				con.close();
		} catch (Exception e) {
		 e.printStackTrace();
		}
	}else {
		System.out.println("Testing in.........");
		}
		System.out.println("Automailer ECN Loop End");		
	}
}
