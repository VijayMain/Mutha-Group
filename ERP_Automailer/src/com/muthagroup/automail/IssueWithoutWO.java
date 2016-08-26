package com.muthagroup.automail;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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

public class IssueWithoutWO extends TimerTask {
	@Override
	public void run() {
		try {
			System.out.println("Issue Without WO !!!");
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
			
			/*if(!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 11 && d.getMinutes() == 01){ */
			
			if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 10 && d.getMinutes() == 38){
				
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
				
			System.out.println("Email ERP Approval List.....!" + sql_date);
			String host = "send.one.com";
			String user = "itsupports@muthagroup.com";
			String pass = "itsupports@xyz"; 
	 		String from = "itsupports@muthagroup.com";
			String subject = "Issue Without Work Order List !!!"; 
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// *********************************************************************************************
			ArrayList cc_emails = new ArrayList();
			ArrayList to_emails = new ArrayList();
			ArrayList bcc_emails = new ArrayList();
			
			PreparedStatement ps_rec = con.prepareStatement("select * from pending_approvee where type='cc' and report='Issue_WithoutWO'");
			ResultSet rs_rec = ps_rec.executeQuery();
			while (rs_rec.next()) {
				cc_emails.add(rs_rec.getString("email"));
			}
			
			ps_rec = con.prepareStatement("select * from pending_approvee where type='to' and report='Issue_WithoutWO'");
			rs_rec = ps_rec.executeQuery();
			while (rs_rec.next()) {
				to_emails.add(rs_rec.getString("email"));
			}
			
			ps_rec = con.prepareStatement("select * from pending_approvee where type='bcc' and report='Issue_WithoutWO'");
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
			sb.append("<b style='color: #0D265E;'>This is an automatically generated email for ERP - Material Issued Without Work Order dated "+ simple_Date.format(date_last) +" !!!</b>");
			
			sb.append("<table border='1' width='97%' style='font-family: Arial;'><tr style='font-size: 12px;background-color:#94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
			"<th height='24'>VENDOR NAME</th>"+
			"<th>PROCESS</th>"+
			"<th>PART NAME</th>"+
			"<th>QTY</th>"+ 
			"</tr>");
			
			/*  
			 	SAMPLE SP :
			 	exec "K1ERP"."dbo"."Sel_SubContractDispt";1 '106', '0', '213', '7', '101121195101121698101120135101121306', '20160401', '20160820'
				select * from MSTACCTGLSUB where SUB_GLCODE=12
			 * 
			 * MEPL H21 Start ==================== > 
			 * 
			*/
			int testavail = 0;
			int maxCount = 0; 
			List<String> ac_Name = new ArrayList();
			
			String comp = "101";
			Connection con_21 = ConnectionUrl.getMEPLH21ERP();
			PreparedStatement ps_insSubgl = null;
			
			ps_insSubgl = con.prepareStatement("insert into issuewithoutwo(GLSUB)values(?)");
			ps_insSubgl.setString(1, "");
			int upnew = ps_insSubgl.executeUpdate();
			
			ps_insSubgl = con.prepareStatement("select max(CODE) from issuewithoutwo");
			ResultSet rs_insSubgl = ps_insSubgl.executeQuery();
			while (rs_insSubgl.next()) {
				maxCount = rs_insSubgl.getInt("max(CODE)");
			}
			
			PreparedStatement ps_getmt = con_21.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE=12");
			ResultSet rs_getmt = ps_getmt.executeQuery();
			while (rs_getmt.next()) {
				ps_insSubgl = con.prepareStatement("update issuewithoutwo set GLSUB = concat(ifnull(GLSUB,''),'"+rs_getmt.getString("SUB_GLACNO")+"') where CODE="+maxCount);
				upnew = ps_insSubgl.executeUpdate();
			}
			
			// 	exec "K1ERP"."dbo"."Sel_SubContractDispt";1 '106', '0', '213', '7', '101121195101121698101120135101121306', '20160401', '20160820'
			
			CallableStatement cs11 = con_21.prepareCall("{call Sel_SubContractDispt(?,?,?,?,?,?,?)}");
			cs11.setString(1,comp);
			cs11.setString(2,"0");
			cs11.setString(3,"213");
			cs11.setString(4,"7");
			
			ps_insSubgl = con.prepareStatement("select * from issuewithoutwo where CODE="+maxCount);
			rs_insSubgl = ps_insSubgl.executeQuery();
			while (rs_insSubgl.next()) {
				cs11.setString(5,rs_insSubgl.getString("GLSUB"));
			}
			cs11.setString(6,"20160801");
			cs11.setString(7,sql_date);
			
			ResultSet rs_getapp = cs11.executeQuery();
			while(rs_getapp.next()) {
			ac_Name.add(rs_getapp.getString("AC_NAME"));
			}
			 
			Set<String> hs = new HashSet();
			hs.addAll(ac_Name);
			ac_Name.clear();
			ac_Name.addAll(hs);
			
			
			int acn=1;
			
			for(int i=0;i<ac_Name.size();i++){
			acn=1;
			rs_getapp = cs11.executeQuery();
			while(rs_getapp.next()) {
				if(testavail==0){
					sb.append("<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;'>"+
						"<th colspan='10' style='background-color:#CCCCCC;color:#330066'>&nbsp;&nbsp;MEPL H21</th></tr>");
				}
			testavail++;
			if(ac_Name.get(i).toString().equalsIgnoreCase(rs_getapp.getString("AC_NAME"))){
			sb.append("<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;'>");
			
			if(acn==1){
				sb.append("<td align='left'>"+rs_getapp.getString("AC_NAME")+"</td>");
			}else{
				sb.append("<td align='left'></td>");
			}
			acn=0;
			sb.append("<td align='left'>"+rs_getapp.getString("PROCESS_NAME")+"</td>"+
			  "<td align='left'>"+rs_getapp.getString("NAME")+"</td>"+
			  "<td align='right'>"+rs_getapp.getString("QTY")+"</td>"+ 
			  "</tr>");
			sent = true;
			}
			}
			}
			con_21.close(); 
			/* MEPL H21 End */
			
			
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
