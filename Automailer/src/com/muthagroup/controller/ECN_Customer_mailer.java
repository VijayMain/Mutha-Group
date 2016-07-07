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

public class ECN_Customer_mailer extends TimerTask {

	@Override
	public void run() {
		Date d = new Date();
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
		ArrayList rem = new ArrayList(); 
			if (weekday[d.getDay()].equals("Wednesday") && d.getHours() == 9 && d.getMinutes() == 31) {
		/*if (d.getHours() == 17 && d.getMinutes() == 00) {*/
			try {
				String pending = "Pending";
				boolean flag = false;
				String comp ="",partname ="";
				ArrayList approvers= new ArrayList();
				Calendar first_Datecal = Calendar.getInstance();   
				first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
				Date dddd = first_Datecal.getTime();  
				SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");  
				Date tdate = new Date(); 
				String firstDate = sdfFIrstDate.format(dddd);
				String nowDate = sdfFIrstDate.format(tdate);
				
				//System.out.println("Test = " + firstDate+"\n"+nowDate);
				
				Connection con = Connection_Utility.getConnection();
				
				int validcount=0;
				
				PreparedStatement ps = con.prepareStatement("select count(*) from crc_tbl_approval where CRC_Approval_Id=2"); 
				ResultSet rs = ps.executeQuery();
				
				while (rs.next()) {
				validcount = rs.getInt("count(*)");
				}
				System.out.println("count in = = " + validcount);
				if (validcount>0){

			System.out.println("ECN Customer Automailer....");
			
			String host = "send.one.com";
			String user = "ecn@muthagroup.com";
			String pass = "ecn@xyz";
	 		String from = "ecn@muthagroup.com";
			String subject = "ECN Pending Approvals Company Wise !!!";
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// *********************************************************************************************
			int ct=0;
			String[] recipients = new String[validcount];
			
			PreparedStatement psap = con.prepareStatement("select * from crc_tbl_approval where CRC_Approval_Id=2"); 
			ResultSet rsap = psap.executeQuery();
			while (rsap.next()) {
				
				PreparedStatement ps_user = con.prepareStatement("select * from user_tbl where U_Id=" + rsap.getInt("U_Id"));
				ResultSet rs_user = ps_user.executeQuery();
				while (rs_user.next()) {
					recipients[ct] = rs_user.getString("U_Email");
					System.out.println("email = = = " + rs_user.getString("U_Email"));
				}
				ct++;
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
			sb.append("<b style='color: #0D265E;'>*** This is an automatically generated email from ECN(Engineering Change Note) !!! ***</b>");
			sb.append("<p><b>Please <a href='http://192.168.0.7/ECN/'>click here</a> to Approve.</b></p>"+
					"<table border='1' width='100%' style='font-family: Arial;'>"+
		"<tr style='font-size: 12px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
			"<th width='8%' height='25' colspan='9'><b style='color: red;'>Customer Change Request Pending Approvals</b></th></tr>"+
		"<tr style='font-size: 11px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
			"<th width='5%' height='18'>ECN No.</th>"+
			"<th width='25%'>Part Name</th>"+
			"<th width='10%'>Request Date</th>"+
			"<th width='10%'>Proposed Implement Date</th>"+
			"<th width='25%'>Nature of change</th>"+
			"<th width='25%'>Reason for change</th>"+
			"<th width='8%'>Change in</th>"+
			"<th width='8%'>Company</th>"+
			"<th width='10%'>Status</th></tr>");
			
			PreparedStatement ps_ecn = null,ps_conp=null,ps_apr=null,ps_prod=null;
			ResultSet rs_ecn = null,rs_conp=null,rs_apr=null,rs_prod=null;
			
			ps_apr = con.prepareStatement("select CRC_No from crc_tbl_approval where Approval_Id=3");
			rs_apr = ps_apr.executeQuery();
			while (rs_apr.next()) { 
				approvers.add(rs_apr.getInt("CRC_No")); 
			}			
				PreparedStatement ps_data = con.prepareStatement("select * from crc_tbl order by CRC_Date");
				ResultSet rs_data = ps_data.executeQuery();
				while (rs_data.next()) {
					if(!approvers.contains(rs_data.getInt("CRC_No"))){
				ps_ecn = con.prepareStatement("select distinct(CRC_No) from crc_tbl_approval where Approval_Id=2 and CRC_No="+ rs_data.getInt("CRC_No"));
				rs_ecn = ps_ecn.executeQuery();
					while (rs_ecn.next()) {
						ps_conp = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_data.getInt("Company_Id"));
						rs_conp = ps_conp.executeQuery();
						while(rs_conp.next()){
							comp = rs_conp.getString("Company_Name");
						}
						ps_prod = con.prepareStatement("select * from customer_tbl_item where Item_Id="+rs_data.getInt("Item_Id"));
						rs_prod = ps_prod.executeQuery();
						while(rs_prod.next()){
							partname = rs_prod.getString("Item_Name");
						}
						
						flag = true;
						
			sb.append("<tr style='font-size: 9px;font-family: Arial;'>"+
					"<td style='text-align: center;'>"+rs_data.getInt("CRC_No")+"</td>"+
					"<td style='text-align: left;'>"+partname+"</td>"+
					"<td style='text-align: center;'>"+rs_data.getDate("CRC_Date")+"</td>"+
					"<td style='text-align: center;'>"+rs_data.getDate("Targated_Impl_Date")+"</td>"+
					"<td style='text-align: left;'>"+rs_data.getString("Nature_Of_Change")+"</td>"+
					"<td style='text-align: left;'>"+rs_data.getString("Reason_For_Change")+"</td>"+
					"<td style='text-align: left;'>"+rs_data.getString("Change_For")+"</td>"+
					"<td style='text-align: center;'>"+comp+"</td>"+
					"<td style='text-align: center;'><b style='color: red;'>"+pending+"</b></td></tr>"); 
				}
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
			// ************************************************************************************************************
	
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
