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

public class Valid_limitPOH25 extends TimerTask {

	@Override
	public void run() {
		try {
			System.out.println("Validity Limit PO H25 !!!");
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
			
			if(d.getHours() == 10 && d.getMinutes() == 25){
			/*	if(d.getHours() == 15 && d.getMinutes() == 4){*/
			/*if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 14 && d.getMinutes() == 42){*/
				 
				Connection con = ConnectionUrl.getLocalDatabase();
				SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
				
				Calendar cal = Calendar.getInstance();
				String sql_date = sdfFIrstDate.format(cal.getTime()).toString();
			
			boolean sent=false;
			String host = "send.one.com";
			String user = "itsupports@muthagroup.com";
			String pass = "itsupports@xyz";
	 		String from = "itsupports@muthagroup.com";
			String subject = "PO validity limit alert !!!";
			boolean sessionDebug = false;
			
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
			
			// *********************************************************************************************
			// multiple recipients : == >
			// *********************************************************************************************
			 ArrayList bcc_emails = new ArrayList();
			 ArrayList date_chk = new ArrayList();
			
			Connection conerp = null;
			int dateLimit=0;
			String report ="",company="",comp=""; 
			/******************************************************************************************************** */
			 	conerp  = ConnectionUrl.getMEPLH25ERP();
					report = "PO_ValidLimitH25";
					company = "MEPL H25";
					comp = "102"; 
			PreparedStatement ps_rec = con.prepareStatement("select * from pending_approvee where type='bcc' and report='"+report+"'");
			ResultSet rs_rec = ps_rec.executeQuery();
			while (rs_rec.next()) {
				bcc_emails.add(rs_rec.getString("email"));
				dateLimit = Integer.parseInt(rs_rec.getString("validlimit"));
			}
			
 			ArrayList codes = new ArrayList();
			 PreparedStatement ps=conerp.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='12'");
			 ResultSet rs3=ps.executeQuery();
			 while(rs3.next()){
				  codes.add(rs3.getString("SUB_GLACNO"));
			}
			int ct=0; 
			for(int i=0;i<codes.size();i++){
				PreparedStatement ps_local = null,ps_localmax = null,ps_localPrev = null;
				ResultSet rs_localmax=null,rs_localPrev=null;
			if(i==0){
			ps_local = con.prepareStatement("insert into purchase_overdues_tbl(value,enable)values(?,?)");
			ps_local.setString(1, codes.get(i).toString());
			ps_local.setInt(2, 1);
			ps_local.executeUpdate();
				}else{
					  ps_localmax = con.prepareStatement("select max(overdue_id) from purchase_overdues_tbl");
					  rs_localmax = ps_localmax.executeQuery();
					  while (rs_localmax.next()) {
						 ct = rs_localmax.getInt("max(overdue_id)");
				}
					  ps_localPrev = con.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
					  rs_localPrev=ps_localPrev.executeQuery();
					  while (rs_localPrev.next()) {
					  ps_local = con.prepareStatement("update purchase_overdues_tbl set value=? where overdue_id="+ct);
					  ps_local.setString(1, (rs_localPrev.getString("value") + codes.get(i).toString()));
					  ps_local.executeUpdate();
					  }
				  }
			  }
			
			StringBuilder sb = new StringBuilder();
			sb.append("<b style='color: #0D265E;'>This is an automatically generated email for ERP - PO Validity Limit Alert for " + company + " !!!</b>"); 
			sb.append("<table border='1' width='97%' style='font-family: Arial;'>"+
					"<tr style='font-size: 12px; background-color: #94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
					"<th height='24'>PO No</th><th>PO Date</th><th>Supplier</th><th>Material</th><th>Validity Date</th></tr>");
			
			//		exec "ENGERP"."dbo"."Sel_RptPartyWsPurchOrderRegister";1  '101', '0', '4031,4032', '20140401', '20150313', 0, '101120238'
			CallableStatement cs = conerp.prepareCall("{call  Sel_RptPartyWsPurchOrderRegister(?,?,?,?,?,?,?)}");
			cs.setString(1, comp);
			cs.setString(2, "0");
			cs.setString(3, "4031,4032");
			cs.setString(4, "20110401");
			cs.setString(5, sql_date);
			cs.setString(6, "0"); 
			
			PreparedStatement ps_insSubgl = con.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
			ResultSet rs_insSubgl = ps_insSubgl.executeQuery();
			while (rs_insSubgl.next()) {
				cs.setString(7, rs_insSubgl.getString("value"));
			}
			ResultSet rs_getapp = cs.executeQuery(); 
			date_chk.add(sql_date);
			for(int g=0;g<Integer.valueOf(dateLimit);g++){ 
				cal.add(Calendar.DATE, +1);
				sql_date = sdfFIrstDate.format(cal.getTime()).toString();
				date_chk.add(sql_date);
			} 
			while(rs_getapp.next()) { 
				if(date_chk.contains(rs_getapp.getString("VALID_DATE")) && rs_getapp.getString("STATUS_CODE").equalsIgnoreCase("0")){
				
			sb.append("<tr style='font-size: 12px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
					"<td align='right'>"+rs_getapp.getString("PO_NO")+"</td>"+
						"<td align='left'>"+rs_getapp.getString("PO_DATE").substring(6,8) +"/"+ rs_getapp.getString("PO_DATE").substring(4,6) +"/"+ rs_getapp.getString("PO_DATE").substring(0,4)+"</td>"+
						"<td align='left'>"+rs_getapp.getString("SUPP_NAME")+"</td>"+
						"<td align='left'>"+rs_getapp.getString("MAT_NAME")+"</td>"+
						"<td align='left'>"+rs_getapp.getString("VALID_DATE").substring(6,8) +"/"+ rs_getapp.getString("VALID_DATE").substring(4,6) +"/"+ rs_getapp.getString("VALID_DATE").substring(0,4)+"</td></tr>");
			sent=true;
			}
			}
		sb.append("</table><p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"+
			"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
			"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
			"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
			"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
			"</font></p>");
		 
		InternetAddress[] addressBcc = new InternetAddress[bcc_emails.size()]; 
		for (int p = 0; p < bcc_emails.size(); p++) {
			addressBcc[p] = new InternetAddress(bcc_emails.get(p).toString());
		}
		msg.setRecipients(Message.RecipientType.BCC, addressBcc);
		msg.setSubject(subject);
		msg.setSentDate(new Date());
		msg.setContent(sb.toString(), "text/html");
	 
			if(sent==true){
			Transport transport = mailSession.getTransport("smtp");
			transport.connect(host, user, pass);
			transport.sendMessage(msg, msg.getAllRecipients());
			// ******************************************************************************
			transport.close();
			System.out.println("msg Sent !!!");
			}
			 
		/******************************************************************************************************** */
			Thread.sleep(60000);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
