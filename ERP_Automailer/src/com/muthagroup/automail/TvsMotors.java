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

public class TvsMotors extends TimerTask {

	@Override
	public void run() {
		try {
		Date d = new Date();
		System.out.println("ERP TVS Loop");	
		if (d.getHours() == 22 && d.getMinutes() == 12) {
		boolean flag=false;
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd"); 
		Date tdate = new Date(); 
		String nowDate = sdfFIrstDate.format(tdate); 
		DecimalFormat twoDForm = new DecimalFormat("###,##0.00");
		
		String CurrentDate = nowDate.substring(6,8) +"/"+ nowDate.substring(4,6) +"/"+ nowDate.substring(0,4);
		
		String host = "send.one.com";
		String user = "erp@muthagroup.com";
		String pass = "erp@xyz";
 		String from = "erp@muthagroup.com";
		String subject = "Mutha Group TVS Dispatch Report  dated "+CurrentDate; 
		boolean sessionDebug = false;
		// *********************************************************************************************
		// multiple recipients : == >
		// ********************************************************************************************* 
		ArrayList listemailTo = new ArrayList();
		/*ArrayList listemailCc = new ArrayList();*/
		String report = "TVS_DispatchReport";
		Connection con = ConnectionUrl.getLocalDatabase();
		PreparedStatement psauto = con.prepareStatement("select * from pending_approvee where report='"+report+"'");
		ResultSet rsauto = psauto.executeQuery();
		while (rsauto.next()) {
				listemailTo.add(rsauto.getString("email"));
		}
		
		String recipients[] = new String[listemailTo.size()];
		
		for(int i=0;i<listemailTo.size();i++){
			recipients[i] = listemailTo.get(i).toString();
		}
		
		Properties props = System.getProperties();
		props.put("mail.host", host);
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
		msg.setRecipients(Message.RecipientType.TO, addressTo); 
		msg.setSubject(subject);
		msg.setSentDate(new Date());  
		StringBuilder sb = new StringBuilder();
		
		
		// System.out.println("Sql Date = " + nowDate); 
		Boolean flag_avail=false;
		String comp = "103";
		int cnt=1;
		double tot_wt =0;
		// exec "FOUNDRYERP"."dbo"."Sel_CustomerwiseDespatchmutha";1 '103', '0', '20170402', '20170405', '101110048', '115'
		// MFPL 
		sb.append("<b style='color: #0D265E;font-size: 10px;'>This is an automatically generated email for TVS Dispatch Report  dated "+CurrentDate+" !!!</b>");
		
sb.append("<table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>"+
		"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"+
		"<th scope='col'>S.No</th>"+
		"<th scope='col'>Invoice No</th>"+
		"<th scope='col'>Invoice Date</th>"+
		"<th scope='col'>Part Name & Part Code</th>"+
		"<th scope='col'>Sale Rate</th>"+
		"<th scope='col'>Qty</th>"+
		"<th scope='col'>Packets</th>"+
		"<th scope='col'>Weight</th>"+
		"<th scope='col'>Total Weight</th>"+
		"<th scope='col'>Basic Amount</th>"+
		"<th scope='col'>Total Amount</th>"+
		"<th scope='col'>Transporter Name</th>"+ 
		"<th scope='col'>Vehicle No</th></tr>");

Connection con_erp = ConnectionUrl.getFoundryERPNEWConnection();
CallableStatement cs = con_erp.prepareCall("{call Sel_CustomerwiseDespatchmutha(?,?,?,?,?,?)}");
cs.setString(1, "103");
cs.setString(2, "0");
cs.setString(3, nowDate);
cs.setString(4, nowDate);
cs.setString(5, "101110048");
cs.setString(6, "115");
ResultSet rs = cs.executeQuery();

while(rs.next()){
	if(cnt==1){
		sb.append("<tr style='font-size: 12px; background-color: #ecee8a; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 22px;'>"+
				"<th scope='col' colspan='13'> Mutha Founders Sale</th></tr>");
	}
	tot_wt =  Double.parseDouble(rs.getString("WEIGHT")) * Double.parseDouble(rs.getString("QTY"));
sb.append("<tr><td align='right'>"+cnt +"</td>"+
	"<td>"+rs.getString("INV_NO") +"</td>"+
	"<td>"+rs.getString("PRN_TRANDATE") +"</td>"+
	"<td>"+rs.getString("MAT_NAME") +"</td>"+
	"<td align='right'>"+rs.getString("RATE") +"</td>"+
	"<td align='right'>"+rs.getString("QTY") +"</td>"+
	"<td align='right'>"+rs.getString("TOTAL_BOXES") +"</td>"+
	"<td align='right'>"+rs.getString("WEIGHT") +"</td>"+ 
	"<td align='right'>"+twoDForm.format(tot_wt) +"</td>"+
	"<td align='right'>"+rs.getString("ITEM_AMOUNT") +"</td>"+
	"<td align='right'>"+rs.getString("INV_AMOUNT") +"</td>"+
	"<td>"+rs.getString("TRANPORTER_NAME") +"</td>"+ 
	"<td>"+rs.getString("VEHICLE_NO") +"</td></tr>");
flag_avail=true;
cnt++;
	}

	// DI 
	cnt=1;
	tot_wt=0;
	con_erp = ConnectionUrl.getDIERPConnection();
	cs = con_erp.prepareCall("{call Sel_CustomerwiseDespatchmutha(?,?,?,?,?,?)}");
	cs.setString(1, "105");
	cs.setString(2, "0");
	cs.setString(3, nowDate); 
	cs.setString(4, nowDate);
	cs.setString(5, "101110048");
	cs.setString(6, "115");
	rs = cs.executeQuery();
	while(rs.next()){
		if(cnt==1){
			sb.append("<tr style='font-size: 12px; background-color: #ecee8a; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 22px;'>"+
					"<th scope='col' colspan='13'> Dhanashree Industries Sale</th></tr>");
		}
		tot_wt =  Double.parseDouble(rs.getString("WEIGHT")) * Double.parseDouble(rs.getString("QTY")); 
			sb.append("<tr><td align='right'>"+cnt +"</td>"+
				"<td>"+rs.getString("INV_NO") +"</td>"+
				"<td>"+rs.getString("PRN_TRANDATE") +"</td>"+
				"<td>"+rs.getString("MAT_NAME") +"</td>"+
				"<td align='right'>"+rs.getString("RATE") +"</td>"+
				"<td align='right'>"+rs.getString("QTY") +"</td>"+
				"<td align='right'>"+rs.getString("TOTAL_BOXES") +"</td>"+
				"<td align='right'>"+rs.getString("WEIGHT") +"</td>"+
				"<td align='right'>"+twoDForm.format(tot_wt) +"</td>"+
				"<td align='right'>"+rs.getString("ITEM_AMOUNT") +"</td>"+
				"<td align='right'>"+rs.getString("INV_AMOUNT") +"</td>"+
				"<td>"+rs.getString("TRANPORTER_NAME") +"</td>"+ 
				"<td>"+rs.getString("VEHICLE_NO") +"</td></tr>");
			flag_avail=true;
			cnt++;		
	}
	// H21
			cnt=1;
			tot_wt=0;
			con_erp = ConnectionUrl.getMEPLH21ERP();
			cs = con_erp.prepareCall("{call Sel_CustomerwiseDespatchmutha(?,?,?,?,?,?)}");
			cs.setString(1, "101");
			cs.setString(2, "0");
			cs.setString(3, nowDate); 
			cs.setString(4, nowDate);
			cs.setString(5, "101110048");
			cs.setString(6, "115");
			rs = cs.executeQuery();
			while(rs.next()){
				
				if(cnt==1){
					sb.append("<tr style='font-size: 12px; background-color: #ecee8a; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 22px;'>"+
							"<th scope='col' colspan='13'> MEPL H21 Sale </th></tr>");
				}
				
				tot_wt =  Double.parseDouble(rs.getString("WEIGHT")) * Double.parseDouble(rs.getString("QTY"));
				sb.append("<tr><td align='right'>"+cnt +"</td>"+
						"<td>"+rs.getString("INV_NO") +"</td>"+
						"<td>"+rs.getString("PRN_TRANDATE")+"</td>"+
						"<td>"+rs.getString("MAT_NAME")+"</td>"+
						"<td align='right'>"+rs.getString("RATE") +"</td>"+
						"<td align='right'>"+rs.getString("QTY") +"</td>"+
						"<td align='right'>"+rs.getString("TOTAL_BOXES") +"</td>"+
						"<td align='right'>"+rs.getString("WEIGHT") +"</td>"+
						"<td align='right'>"+twoDForm.format(tot_wt) +"</td>"+
						"<td align='right'>"+rs.getString("ITEM_AMOUNT") +"</td>"+
						"<td align='right'>"+rs.getString("INV_AMOUNT") +"</td>"+
						"<td>"+rs.getString("TRANPORTER_NAME") +"</td>"+ 
						"<td>"+rs.getString("VEHICLE_NO") +"</td></tr>"); 
					flag_avail=true;
					cnt++;
			}
			
			// H25
			cnt=1;
			tot_wt=0;
			con_erp = ConnectionUrl.getMEPLH25ERP();
			cs = con_erp.prepareCall("{call Sel_CustomerwiseDespatchmutha(?,?,?,?,?,?)}");
			cs.setString(1, "102");
			cs.setString(2, "0");
			cs.setString(3, nowDate); 
			cs.setString(4, nowDate);
			cs.setString(5, "101110048");
			cs.setString(6, "115");
			rs = cs.executeQuery();
			while(rs.next()){
				if(cnt==1){
					sb.append("<tr style='font-size: 12px; background-color: #ecee8a; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 22px;'>"+
							"<th scope='col' colspan='13'> MEPL H25 Sale </th></tr>");
				}
			tot_wt =  Double.parseDouble(rs.getString("WEIGHT")) * Double.parseDouble(rs.getString("QTY"));
					sb.append("<tr><td align='right'>"+cnt +"</td>"+
						"<td>"+rs.getString("INV_NO") +"</td>"+
						"<td>"+rs.getString("PRN_TRANDATE") +"</td>"+
						"<td>"+rs.getString("MAT_NAME") +"</td>"+
						"<td align='right'>"+rs.getString("RATE") +"</td>"+
						"<td align='right'>"+rs.getString("QTY") +"</td>"+
						"<td align='right'>"+rs.getString("TOTAL_BOXES") +"</td>"+
						"<td align='right'>"+rs.getString("WEIGHT") +"</td>"+
						"<td align='right'>"+twoDForm.format(tot_wt) +"</td>"+
						"<td align='right'>"+rs.getString("ITEM_AMOUNT") +"</td>"+
						"<td align='right'>"+rs.getString("INV_AMOUNT") +"</td>"+
						"<td>"+rs.getString("TRANPORTER_NAME") +"</td>"+ 
						"<td>"+rs.getString("VEHICLE_NO") +"</td></tr>");
			flag_avail=true;
			cnt++;		
			}
			
			// MEPL UIII
			cnt=1;
			tot_wt=0;
			con_erp = ConnectionUrl.getK1ERPConnection();
			cs = con_erp.prepareCall("{call Sel_CustomerwiseDespatchmutha(?,?,?,?,?,?)}");
			cs.setString(1, "106");
			cs.setString(2, "0");
			cs.setString(3, nowDate); 
			cs.setString(4, nowDate);
			cs.setString(5, "101110048");
			cs.setString(6, "115");
			rs = cs.executeQuery();
			while(rs.next()){
				if(cnt==1){
					sb.append("<tr style='font-size: 12px; background-color: #ecee8a; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 22px;'>"+
							"<th scope='col' colspan='13'> MEPL UNIT III Sale </th></tr>");
				}
				tot_wt =  Double.parseDouble(rs.getString("WEIGHT")) * Double.parseDouble(rs.getString("QTY"));
				   sb.append("<tr><td align='right'>"+cnt +"</td>"+
						"<td>"+rs.getString("INV_NO") +"</td>"+
						"<td>"+rs.getString("PRN_TRANDATE") +"</td>"+
						"<td>"+rs.getString("MAT_NAME") +"</td>"+
						"<td align='right'>"+rs.getString("RATE") +"</td>"+
						"<td align='right'>"+rs.getString("QTY") +"</td>"+
						"<td align='right'>"+rs.getString("TOTAL_BOXES") +"</td>"+
						"<td align='right'>"+rs.getString("WEIGHT") +"</td>"+
						"<td align='right'>"+twoDForm.format(tot_wt) +"</td>"+
						"<td align='right'>"+rs.getString("ITEM_AMOUNT") +"</td>"+
						"<td align='right'>"+rs.getString("INV_AMOUNT") +"</td>"+
						"<td>"+rs.getString("TRANPORTER_NAME") +"</td>"+ 
						"<td>"+rs.getString("VEHICLE_NO") +"</td></tr>"); 
					flag_avail=true;
					cnt++;
			}  
		
		
		
		
		
		
		
		
		
		
		sb.append("</table> <p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>Mutha Group Satara </p><hr><p>"+
		"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
		"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
		"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
		"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
		"</font></p>");
	 
		msg.setContent(sb.toString(), "text/html");
 
		if(flag_avail==true){
		Transport transport = mailSession.getTransport("smtp");
		transport.connect(host, user, pass);
		transport.sendMessage(msg, msg.getAllRecipients());
		transport.close();
		}
		
		System.out.println("ERP TVS Loop End");
		con.close();
		Thread.sleep(60000);
		}
	} catch (Exception e) {
	 e.printStackTrace();
	}
	}
}
