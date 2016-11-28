package com.muthagroup.automail;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
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

public class TransporterWiseSaleMFPL extends TimerTask {

	@Override
	public void run() {
		/**************************************************************************************
		-- To Pay List ===>
		exec "FOUNDRYERPNEW"."dbo"."Sel_TransporterWiseSale";1 '103', '0', '101021101006101003101025101019101001101014101015101008101004101009101007101002101024101005101010101016101022101011101018101023101017101013101012101020', '20150331', '20150401', N'1'
		-- Paid ===>
		exec "FOUNDRYERPNEW"."dbo"."Sel_TransporterWiseSale";1 '103', '0', '101021101006101003101025101019101001101014101015101008101004101009101007101002101024101005101010101016101022101011101018101023101017101013101012101020', '20150331', '20150401', N'0'
		**************************************************************************************/
		DecimalFormat zeroDForm = new DecimalFormat("#####0.00");
		DecimalFormat pointForm = new DecimalFormat("#####0");
		Date d = new Date();
		String matcode="";
		double payList = 0,paidList = 0;
		double payList_wt = 0,paidList_wt = 0;
		int srno=1;
		String comp="103";
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday" };
		ArrayList rem = new ArrayList();
		if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 23 && d.getMinutes() == 47) {
		 
		try {
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
			boolean flag=false;
			Date tdate = new Date();  
			String nowDate = sdfFIrstDate.format(tdate);
			 
			
			String CurrentDate = nowDate.substring(6,8) +"/"+ nowDate.substring(4,6) +"/"+ nowDate.substring(0,4);
			
			Connection con = ConnectionUrl.getFoundryERPNEWConnection();
			
			PreparedStatement pstrname=con.prepareStatement("select * from FOUNDRYERP..MSTCOMMTRANSPORT");
			  ResultSet rstrname=pstrname.executeQuery();
			  while(rstrname.next()){
				  matcode+=rstrname.getString("CODE");
			}
			
			// System.out.println("Code = " + matcode);
			
			CallableStatement cs = con.prepareCall("{call Sel_TransporterWiseSale(?,?,?,?,?,?)}");
			cs.setString(1, "comp");
			cs.setString(2, "0");
			cs.setString(3, matcode);
			cs.setString(4, nowDate);
			cs.setString(5, nowDate);
			cs.setString(6, "0");
			ResultSet rs = cs.executeQuery();
			
			CallableStatement csPay = con.prepareCall("{call Sel_TransporterWiseSale(?,?,?,?,?,?)}");
			csPay.setString(1, "comp");
			csPay.setString(2, "0");
			csPay.setString(3, matcode);
			csPay.setString(4, nowDate);
			csPay.setString(5, nowDate);
			csPay.setString(6, "1");
			ResultSet rsPay = csPay.executeQuery();
						
		System.out.println("Email ERP Automailer.....");
		
		String host = "send.one.com";
		String user = "itsupports@muthagroup.com";
		String pass = "itsupports@xyz"; 
 		String from = "itsupports@muthagroup.com";
		String subject = "MFPL Transporter Wise Sale List of " + CurrentDate; 
		boolean sessionDebug = false;
		// *********************************************************************************************
		// multiple recipients : == >
		// ********************************************************************************************* 
		String recipients[] = {"ankatariya@muthagroup.com"};
		String cc_recipients[] = {"nileshss@muthagroup.com","internalaudit@muthagroup.com","vrkadam@muthagroup.com","bhushan@muthagroup.com","rgjadhav@muthagroup.com","nrfirodia@muthagroup.com"};
		
		/*String recipients[] = {"vijaybm@muthagroup.com"};
		String cc_recipients[] = {"vijaybm@muthagroup.com"};*/
		
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
		sb.append("<b style='color: #0D265E;'>*** This is an automatically generated email for MFPL Transporter Wise Sale List !!! ***</b>"+
				"<p><b style='color: #7A790C;'>Please Note :</b><b style='color: #78170C;'>Weight must be verified by Store & Production Dept.</b></p>"+
				
		"<table border='1' width='99%' style='font-family: Arial;'>"+
		"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
		"<th width='5%' height='20'>Sr. No</th>"+
		"<th width='15%' height='25'>Transporter Name</th><th width='12%' height='25'>Inv. No.</th>"+
		"<th width='15%'>Vehical No</th><th width='30%'>Customer Name</th><th width='12%'>Qty.</th><th width='12%'>Qty. in Kgs.</th></tr>");
		 
		if (rsPay!=null) {
		while (rsPay.next()) {
			if(srno==1){
				sb.append("<tr style='font-size: 12px;'><td style='text-align: left;color: #780B0B;background-color: #F0F0F0;' colspan='7' height='20'><b>Freight to Pay List (Sales) &#10145; </b> </td> </tr>");
			}
			
			payList = payList + Double.parseDouble(rsPay.getString("QTY")); 
			payList_wt = payList_wt + Double.parseDouble(rsPay.getString("TOTALWT"));
			
		sb.append("<tr style='font-size: 12px;'>"+
				"<td style='text-align: center;'><b>"+srno+"</b></td><td style='text-align: left;'>"+rsPay.getString("TRANSPORTER")+"</td> "+
				"<td style='text-align: right;'>"+rsPay.getString("TRAN_NO")+"</td> <td style='text-align: center;'>"+rsPay.getString("VEHICLE_NO")+"</td>"+
				"<td style='text-align: left;'>"+rsPay.getString("CUSTOMER")+"</td><td style='text-align: right;'>"+rsPay.getString("QTY")+"</td>"+
				"<td style='text-align: right;'>"+rsPay.getString("TOTALWT")+"</td></tr>");
		srno++; 
		flag=true;
		}		
		
		if(payList>0){
		sb.append("<tr style='font-size: 12px;'>"+
				"<td style='text-align: right;'  colspan='5'><b>Total &#8680;</b></td><td style='text-align: right;'>"+ pointForm.format(payList) +"</td>"+
				"<td style='text-align: right;'>"+ zeroDForm.format(payList_wt) +"</td></tr>");
		}
		payList=0;		
		paidList_wt=0;
		
		}
		srno=1;
		
		if (rs!=null) {
		while (rs.next()) {
			if(srno==1){
				sb.append("<tr style='font-size: 12px;'><td style='text-align: left;color: green;background-color: #F0F0F0;'  colspan='7' height='20'><b>Freight Paid List (Sales) &#10145; </b> </td> </tr>");
			}
			
			paidList = paidList + Double.parseDouble(rs.getString("QTY"));
			paidList_wt = paidList_wt + Double.parseDouble(rs.getString("TOTALWT"));
			
		sb.append("<tr style='font-size: 12px;'><td style='text-align: center;'><b>"+srno+"</b></td>"+
				"<td style='text-align: left;'>"+rs.getString("TRANSPORTER")+"</td> <td style='text-align: right;'>"+rs.getString("TRAN_NO")+"</td> "+
				"<td style='text-align: center;'>"+rs.getString("VEHICLE_NO")+"</td><td style='text-align: left;'>"+rs.getString("CUSTOMER")+"</td>"+
				"<td style='text-align: right;'>"+rs.getString("QTY")+"</td><td style='text-align: right;'>"+rs.getString("TOTALWT")+"</td></tr>");
		srno++;
		flag=true;
		}
		if(paidList>0){
		sb.append("<tr style='font-size: 12px;'>"+
				"<td style='text-align: right;'  colspan='5'>Total &#8680;</td><td style='text-align: right;'>"+ pointForm.format(paidList) +"</td>"+
				"<td style='text-align: right;'>"+ zeroDForm.format(paidList_wt) +"</td></tr>");
		}
		paidList=0;
		paidList_wt=0;
		}
		sb.append("</table> <p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"+
		"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
		"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
		"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
		"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
		"</font></p>");
	 
		msg.setContent(sb.toString(), "text/html"); 
		if(flag==true){
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
		System.out.println("Transport 23 !!!"); 
	}

}
