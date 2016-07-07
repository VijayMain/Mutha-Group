package com.muthagroup.controller;

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

public class ECN_CheckAction_mailer extends TimerTask {

	@Override
	public void run() {

		Date d = new Date();
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
		ArrayList rem = new ArrayList();
		 if (weekday[d.getDay()].equals("Wednesday") && d.getHours() == 9 && d.getMinutes() == 34) {
		/*if (d.getHours() == 17 && d.getMinutes() == 16) {*/
			try {
				String pending = "Pending";
				boolean flag = false;
				String comp ="",partname ="";
				ArrayList approvers= new ArrayList();
				Calendar first_Datecal = Calendar.getInstance();   
				first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
				Date dddd = first_Datecal.getTime();  
				SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy/MM/dd");  
				Date tdate = new Date();
				String firstDate = sdfFIrstDate.format(dddd);
				String nowDate = sdfFIrstDate.format(tdate);
				
				//System.out.println("Test = " + firstDate+"\n"+nowDate);
				
				Connection con = Connection_Utility.getConnection();
				
				ArrayList countEmail = new ArrayList(); 
				 
				
				
				PreparedStatement ps_appId = null,ps_ap=null,ps_user=null;
				ResultSet rs_appId = null,rs_ap=null,rs_user=null;
				
				PreparedStatement psap = con.prepareStatement("select distinct(CR_No),u_id from cr_tbl_action where Action_Date between '"+firstDate+"' and '"+nowDate+"'"); 
				ResultSet rsap = psap.executeQuery();
				while (rsap.next()) {
					
					ps_ap = con.prepareStatement("select * from cr_tbl_approval where Approval_Id=1 and CR_No="+ rsap.getInt("CR_No"));
					rs_ap = ps_ap.executeQuery();
						while (rs_ap.next()) {			
					ps_user = con.prepareStatement("select * from user_tbl where U_Id=" + rsap.getInt("U_Id"));
					rs_user = ps_user.executeQuery();
					while (rs_user.next()) {
						countEmail.add(rs_user.getString("U_Email")); 
						System.out.println("Emails List = " + rs_user.getString("U_Email") + " Cr No = " + rsap.getInt("CR_No"));
						}
							} 
				}	
				
				
				
				System.out.println("list size = " + countEmail.size());
				int ct=0;
				
				if (countEmail.size()>0){
				
					countEmail.add("govindmb@muthagroup.com");
					
					ct = countEmail.size(); 
					String[] recipients = new String[ct];
					
					
					for(int e=0;e<countEmail.size();e++){
						recipients[e]=countEmail.get(e).toString();
						System.out.println("filler  = " + recipients[e].toString() + " e = "+e);
					}
					
					System.out.println("list size = " + recipients.length);

		System.out.println("ECN Automailer....");
			
			String host = "send.one.com";
			String user = "ecn@muthagroup.com";
			String pass = "ecn@xyz";
	 		String from = "ecn@muthagroup.com";
			String subject = "Please Check the Actions Performed on ECN";
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// *********************************************************************************************
			 
			
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
			sb.append("<table border='1' width='100%' style='font-family: Arial;'>"+
					"<tr style='font-size: 12px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
					"<th width='8%' height='25' colspan='8'><b>Please <a href='http://192.168.0.7/ECN/'>click here</a> and Verify the Actions on following ECN(Internal Change Note)</b></th>"+
					"</tr>"+
						"<tr style='font-size: 11px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
						"<th width='5%' height='18'>ECN No.</th>"+
						"<th width='20%'>Part Name</th>"+
						"<th width='10%'>Request Date</th>"+
						"<th width='10%'>Proposed Implement Date</th>"+
						"<th width='21%'>Present System</th>"+
						"<th width='21%'>Proposed System</th>"+
						"<th width='21%'>Objective</th>"+
						"<th width='8%'>Company</th></tr>");
			
			PreparedStatement ps_ecn = null,ps_conp=null,ps_apr=null,ps_prod=null,ps_rd=null;
			ResultSet rs_ecn = null,rs_conp=null,rs_apr=null,rs_prod=null,rs_rd=null;
			
			ps_apr = con.prepareStatement("select distinct(CR_No) from cr_tbl_action where Action_Date between '"+firstDate+"' and '"+nowDate+"'");
			rs_apr = ps_apr.executeQuery();
			while (rs_apr.next()) {
				approvers.add(rs_apr.getInt("CR_No"));
			}
			
			System.out.println("Approvers 1 1 1 " + approvers);
			
			for(int c=0;c<approvers.size();c++){
						System.out.println("Approvers = = " + approvers.get(c).toString()); 
						ps_rd = con.prepareStatement("select * from cr_tbl where CR_No="+Integer.parseInt(approvers.get(c).toString()));
						rs_rd = ps_rd.executeQuery();
						while (rs_rd.next()) {
						ps_conp = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_rd.getInt("Company_Id"));
						rs_conp = ps_conp.executeQuery();
						while(rs_conp.next()){
							comp = rs_conp.getString("Company_Name"); 
						}
						
						ps_prod = con.prepareStatement("select * from customer_tbl_item where Item_Id="+rs_rd.getInt("Item_Id"));
						rs_prod = ps_prod.executeQuery();
						while(rs_prod.next()){
							partname = rs_prod.getString("Item_Name"); 
						}
						
						
			sb.append("<tr style='font-size: 9px;font-family: Arial;'>"+
					"<td style='text-align: center;'>"+rs_rd.getInt("CR_No")+"</td>"+
					"<td style='text-align: left;'>"+partname+"</td>"+
					"<td style='text-align: center;'>"+rs_rd.getDate("CR_Date")+"</td>"+
					"<td style='text-align: center;'>"+rs_rd.getDate("Proposed_Impl_Date")+"</td>"+
					"<td style='text-align: left;'>"+rs_rd.getString("Present_System")+"</td>"+
					"<td style='text-align: left;'>"+rs_rd.getString("Proposed_System")+"</td>"+
					"<td style='text-align: left;'>"+rs_rd.getString("Objective")+"</td>"+
					"<td style='text-align: center;'>"+comp+"</td></tr>"); 
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
