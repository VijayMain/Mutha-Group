package com.muthagroup.automail;
 
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

public class OpenIndent extends TimerTask {

	@Override
	public void run() {
		try {
		System.out.println("ERP Open Indents");
		Date d = new Date();
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
		
		/*if (weekday[d.getDay()].equals("Monday") && d.getHours() == 9 && d.getMinutes() == 30) {*/
			if (weekday[d.getDay()].equals("Monday") && d.getHours() == 15 && d.getMinutes() == 7) {
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
		String subject = "ERP Open Indent dated "+CurrentDate;
		boolean sessionDebug = false;
		// *********************************************************************************************
		// multiple recipients : == >
		// ********************************************************************************************* 
		ArrayList listemailTo = new ArrayList();
		/* ArrayList listemailCc = new ArrayList();  */
		String report = "ERPOpen_Indent";
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
		Boolean flag_avail=false;
		// Closed Indent : 
		// exec "ENGERP"."dbo"."Sel_TransactionsPurchase";1 '101', '50201', 'ADMIN', '20100507', '20170517' 
		sb.append("<b style='color: #0D265E;font-size: 10px;'>This is an automatically generated email for ERP Open Indent  dated "+CurrentDate+" !!!</b>");
		sb.append("<table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>"+
		"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"+
		"<th scope='col'>Indent No</th>"+
		"<th scope='col'>Indent Date</th>"+
		"<th scope='col'>Party Name</th>"+
		"<th scope='col'>Created By</th>"+ 
		"<th scope='col'>Approved By</th>"+ 
		"<th scope='col'>Approved Date</th></tr>");


/*********************************************************************************************************/		
sb.append("<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"
		+ "<td colspan='6'><b>MEPL H21</b></td>"
		+ "</tr>");
Connection con_erp = ConnectionUrl.getMEPLH21ERP(); 
//exec "ENGERP"."dbo"."Sel_TransactionsPurchase";1 '101', '50201', 'ADMIN', '20100507', '20170517' 
PreparedStatement cs = con_erp.prepareCall("{call Sel_TransactionsPurchase(?,?,?,?,?)}");
cs.setString(1, "101");
cs.setString(2, "50201");
cs.setString(3, "ADMIN");
cs.setString(4, "20100507");
cs.setString(5, nowDate);
ResultSet rs = cs.executeQuery();

while(rs.next()){
if(rs.getString("STATUS_CODE").equalsIgnoreCase("0")){
sb.append("<tr><td align='right'>"+rs.getString("STRAN_NO") +"</td>"+
"<td>"+rs.getString("PRN_TRANDATE") +"</td>"+
"<td>"+rs.getString("AC_NAME") +"</td>"+
"<td>"+rs.getString("CREATED_BY") +"</td>"+
"<td>"+rs.getString("APPROVED_BY") +"</td>"+
"<td align='right'>"+rs.getString("APPROVED_ON") +"</td></tr>");
//System.out.println("Approval Status = " + rs.getString("STATUS_CODE"));
flag_avail=true;

//System.out.println("status code = " + rs.getString("STATUS_CODE"));
}
}
/*********************************************************************************************************/

/*********************************************************************************************************/		
sb.append("<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"
		+ "<td colspan='6'><b>MEPL H25</b></td>"
		+ "</tr>");
con_erp = ConnectionUrl.getMEPLH25ERP(); 
//exec "ENGERP"."dbo"."Sel_TransactionsPurchase";1 '101', '50201', 'ADMIN', '20100507', '20170517' 
cs = con_erp.prepareCall("{call Sel_TransactionsPurchase(?,?,?,?,?)}");
cs.setString(1, "102");
cs.setString(2, "50201");
cs.setString(3, "ADMIN");
cs.setString(4, "20100507");
cs.setString(5, nowDate);
rs = cs.executeQuery();

while(rs.next()){
if(rs.getString("STATUS_CODE").equalsIgnoreCase("0")){
sb.append("<tr><td align='right'>"+rs.getString("STRAN_NO") +"</td>"+
"<td>"+rs.getString("PRN_TRANDATE") +"</td>"+
"<td>"+rs.getString("AC_NAME") +"</td>"+
"<td>"+rs.getString("CREATED_BY") +"</td>"+
"<td>"+rs.getString("APPROVED_BY") +"</td>"+
"<td align='right'>"+rs.getString("APPROVED_ON") +"</td></tr>");
//System.out.println("Approval Status = " + rs.getString("STATUS_CODE"));
flag_avail=true;

//System.out.println("status code = " + rs.getString("STATUS_CODE"));
}
}
/*********************************************************************************************************/

/*********************************************************************************************************/		
sb.append("<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"
	+ "<td colspan='6'><b>MFPL</b></td>"
	+ "</tr>");
con_erp = ConnectionUrl.getFoundryERPNEWConnection();
//exec "ENGERP"."dbo"."Sel_TransactionsPurchase";1 '101', '50201', 'ADMIN', '20100507', '20170517'
cs = con_erp.prepareCall("{call Sel_TransactionsPurchase(?,?,?,?,?)}");
cs.setString(1, "103");
cs.setString(2, "50201");
cs.setString(3, "ADMIN");
cs.setString(4, "20100507");
cs.setString(5, nowDate); 
rs = cs.executeQuery();

while(rs.next()){
if(rs.getString("STATUS_CODE").equalsIgnoreCase("0")){
sb.append("<tr><td align='right'>"+rs.getString("STRAN_NO") +"</td>"+
"<td>"+rs.getString("PRN_TRANDATE") +"</td>"+
"<td>"+rs.getString("AC_NAME") +"</td>"+
"<td>"+rs.getString("CREATED_BY") +"</td>"+
"<td>"+rs.getString("APPROVED_BY") +"</td>"+
"<td align='right'>"+rs.getString("APPROVED_ON") +"</td></tr>");
//System.out.println("Approval Status = " + rs.getString("STATUS_CODE"));
flag_avail=true;

//System.out.println("status code = " + rs.getString("STATUS_CODE"));

}
}
/*********************************************************************************************************/


/*********************************************************************************************************/		
sb.append("<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"
		+ "<td colspan='6'><b>DI</b></td>"
		+ "</tr>");
con_erp = ConnectionUrl.getDIERPConnection(); 
//exec "ENGERP"."dbo"."Sel_TransactionsPurchase";1 '101', '50201', 'ADMIN', '20100507', '20170517' 
cs = con_erp.prepareCall("{call Sel_TransactionsPurchase(?,?,?,?,?)}");
cs.setString(1, "105");
cs.setString(2, "50201");
cs.setString(3, "ADMIN");
cs.setString(4, "20100507");
cs.setString(5, nowDate);
rs = cs.executeQuery();

while(rs.next()){
if(rs.getString("STATUS_CODE").equalsIgnoreCase("0")){
sb.append("<tr><td align='right'>"+rs.getString("STRAN_NO") +"</td>"+
"<td>"+rs.getString("PRN_TRANDATE") +"</td>"+
"<td>"+rs.getString("AC_NAME") +"</td>"+
"<td>"+rs.getString("CREATED_BY") +"</td>"+
"<td>"+rs.getString("APPROVED_BY") +"</td>"+
"<td align='right'>"+rs.getString("APPROVED_ON") +"</td></tr>");
//System.out.println("Approval Status = " + rs.getString("STATUS_CODE"));
flag_avail=true;

//System.out.println("status code = " + rs.getString("STATUS_CODE"));
}
}
/*********************************************************************************************************/

/*********************************************************************************************************/		
sb.append("<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"
		+ "<td colspan='6'><b>MEPL UNIT III</b></td>"
		+ "</tr>");
con_erp = ConnectionUrl.getK1ERPConnection(); 
//exec "ENGERP"."dbo"."Sel_TransactionsPurchase";1 '101', '50201', 'ADMIN', '20100507', '20170517' 
cs = con_erp.prepareCall("{call Sel_TransactionsPurchase(?,?,?,?,?)}");
cs.setString(1, "106");
cs.setString(2, "50201");
cs.setString(3, "ADMIN");
cs.setString(4, "20100507");
cs.setString(5, nowDate);
rs = cs.executeQuery();

while(rs.next()){
if(rs.getString("STATUS_CODE").equalsIgnoreCase("0")){
sb.append("<tr><td align='right'>"+rs.getString("STRAN_NO") +"</td>"+
"<td>"+rs.getString("PRN_TRANDATE") +"</td>"+
"<td>"+rs.getString("AC_NAME") +"</td>"+
"<td>"+rs.getString("CREATED_BY") +"</td>"+
"<td>"+rs.getString("APPROVED_BY") +"</td>"+
"<td align='right'>"+rs.getString("APPROVED_ON") +"</td></tr>");
//System.out.println("Approval Status = " + rs.getString("STATUS_CODE"));
flag_avail=true;

//System.out.println("status code = " + rs.getString("STATUS_CODE"));
}
}
/*********************************************************************************************************/



		sb.append("</table><b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
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
		
		System.out.println("ERP Indent Closed");
		con.close();
		Thread.sleep(60000);
		}
	} catch (Exception e) {
	 e.printStackTrace();
	}
  }
}