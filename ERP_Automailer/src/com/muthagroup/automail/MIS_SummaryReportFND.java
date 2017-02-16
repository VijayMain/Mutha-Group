package com.muthagroup.automail;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
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

public class MIS_SummaryReportFND extends TimerTask {

	@Override
	public void run() {
		try {
			System.out.println("MIS Report MF");
			//-------------------------------------------------------- Date Logic ---------------------------------------------------------
			SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("dd-MM");  
			Date tdate = new Date();
			Calendar first_Datecal = Calendar.getInstance();   
			first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
			Date dddd = first_Datecal.getTime();
			String firstDate = sdfFIrstDate.format(dddd); 			
			
			Calendar calform1 = Calendar.getInstance();
			calform1.add(Calendar.DATE, -1);
			String nowDate= sdfFIrstDate.format(calform1.getTime()).toString();
			//___________________________________________________________________________
			
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
			DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
			DateFormat dateFormat2 = new SimpleDateFormat("dd/MM/yyyy");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -1);
			
			//  yes date is todays date =======>
			String yes_date = dateFormat.format(cal.getTime()).toString();
			String ason_date = dateFormat2.format(cal.getTime()).toString();
			
			DecimalFormat twoDForm = new DecimalFormat("###,##0.##");
			/*if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 12 && d.getMinutes() == 30) {*/
			if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 11 && d.getMinutes() == 33) {
				//************************************************************************************************				
				if(weekday[d.getDay()].equals("Wednesday")){
					cal.add(Calendar.DATE, -1);
					yes_date = dateFormat.format(cal.getTime()).toString();
					ason_date = dateFormat2.format(cal.getTime()).toString();
				}
				Connection con = ConnectionUrl.getFoundryFMShopConnection();
				String OnDateMIS = yes_date;
				String db = "FOUNDRYERP";
				
				String comp = "103";
				String OnDate = OnDateMIS.substring(6,8) +"/"+ OnDateMIS.substring(4,6) +"/"+ OnDateMIS.substring(0,4);
			   String batchonDate = "01"+"/"+ OnDateMIS.substring(4,6) +"/"+ OnDateMIS.substring(0,4);
				String bdateto = OnDateMIS.substring(0,4) +OnDateMIS.substring(4,6)+OnDateMIS.substring(6,8);
				String bdatefrom = OnDateMIS.substring(0,4) +OnDateMIS.substring(4,6)+"01";
				//***************************************************************************************************************
				SimpleDateFormat sdfparse = new SimpleDateFormat("dd/MM/yyyy");
				Date convertedCurrentDate = sdfparse.parse(OnDate);
				//***************************************************************************************************************
						Date today = new Date();
				        Calendar calendar = Calendar.getInstance();  
				        calendar.setTime(today);  
				        calendar.add(Calendar.MONTH, 1);  
				        calendar.set(Calendar.DAY_OF_MONTH, 1);  
				        calendar.add(Calendar.DATE, -1); 
				        Date lastDayOfMonth = calendar.getTime(); 
				//***************************************************************************************************************
				Calendar calAvg = Calendar.getInstance();
				int total_dd = lastDayOfMonth.getDate();
				int tue_month=0;
				for(int i = 1 ; i < total_dd ; i++)
				{      
					calAvg.set(Calendar.DAY_OF_MONTH, i);
				    if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY){ 
				    	tue_month++;      
				    }
				}

				total_dd = total_dd - tue_month;

				double avg2=0; 
				/*System.out.println("Date = " + convertedCurrentDate); */
				int dd = convertedCurrentDate.getDate(); 
				int tues=0;
				for(int i = 1 ; i < dd ; i++)
				{
					calAvg.set(Calendar.DAY_OF_MONTH, i);
				 if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY){ 
				 	tues++;      
				 }
				} 
				int workdays = dd-tues; 
				//***************************************************************************************************************
				// exec "FOUNDRYFMSHOP"."dbo"."Sel_DBFoundryMIS";1 '103', '0', '20161207', 'FOUNDRYERP'
				CallableStatement cs = con.prepareCall("{call Sel_DBFoundryMIS(?,?,?,?)}");
		 		cs.setString(1, comp);
		 		cs.setString(2, "0");
		 		cs.setString(3, OnDateMIS);
		 		cs.setString(4, db);
				ResultSet rs1 = cs.executeQuery();
				
				CallableStatement cs2 = con.prepareCall("{call Sel_DBFoundryProdMIS(?,?,?,?)}");
		 		cs2.setString(1, comp);
		 		cs2.setString(2, "0");
		 		cs2.setString(3, OnDateMIS);
		 		cs2.setString(4, db);
				ResultSet rs_stk = cs2.executeQuery();
		 		//***************************************************************************************************************
				System.out.println("ERP MIS Summary Automailer Starts !!!");
				String host = "send.one.com";
				String user = "itsupports@muthagroup.com";
				String pass = "itsupports@xyz"; 
		 		String from = "itsupports@muthagroup.com";
				String subject = "MIS Summary Report ("+ason_date+") of MFPL !!!";
				boolean sessionDebug = false;
				// *********************************************************************************************
				// multiple recipients : == >
				// *********************************************************************************************
			 
				ArrayList to_emails = new ArrayList();
				String report_name = "MIS_Report_MFPL";
				Connection conLocal = ConnectionUrl.getLocalDatabase();
				PreparedStatement ps_rec = conLocal.prepareStatement("select * from pending_approvee where type='to' and report='"+report_name+"'");
				ResultSet rs_rec = ps_rec.executeQuery();
				while (rs_rec.next()) {
					to_emails.add(rs_rec.getString("email"));
				}
				
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
				
				InternetAddress[] addressTo = new InternetAddress[to_emails.size()];
				for (int p = 0; p < to_emails.size(); p++) {
					addressTo[p] = new InternetAddress(to_emails.get(p).toString());
				}
				
				
				msg.setRecipients(Message.RecipientType.TO, addressTo); 
				msg.setSubject(subject);
				msg.setSentDate(new Date()); 
				StringBuilder sb = new StringBuilder();
				
				sb.append("<b style='color: #0D265E;font-family: Arial;font-size: 11px;'>*** This is an automatically generated email of MIS Summary Report !!! ***</b> <br />"+
				"<div style='width: 65%;float: left;'><b style='font-family: Arial;font-size: 14px;'>MUTHA FOUNDERS PVT.LTD. MIS Summary Report as on "+ason_date +"</b></div>");
				
sb.append("<span style='font-family: Arial;font-size: 12px;'>Total Working Days : <b>"+total_dd +"&nbsp;&nbsp;&nbsp;</b>Working Days Over : <b>"+workdays +"</b></span>"+
"<table border='0' width='99%' style='font-family: Arial;text-align: center;'><tr><td><table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>"+
"<tr><th scope='col' colspan='4'  style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>On Date</th>"+
"</tr><tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
"<th scope='col'>Head</th><th scope='col'>CI</th><th scope='col'>SGI</th><th scope='col'>Total</th>"+
"</tr>");
while (rs1.next()) {
	sb.append("<tr><td>"+rs1.getString("HEAD")+"</td><td align='right'>"+rs1.getString("CI_QTY")+"</td><td align='right'>"+rs1.getString("SG_QTY")+"</td><td align='right'>"+rs1.getString("TOTAL")+"</td></tr>");
 }
sb.append("</table></td><td>"+
"<table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>"+
"<tr><th scope='col' colspan='5'  style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>To Date</th>"+
"</tr><tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
"<th scope='col'>Head</th><th scope='col'>CI</th><th scope='col'>SGI</th><th scope='col'>Total</th>"+
"<th scope='col'>Avg</th></tr>");
rs1.close();
if (cs.getMoreResults()) {
    rs1 = cs.getResultSet();
    while (rs1.next()) {
    	sb.append("<tr><td>"+rs1.getString("HEAD")+"</td><td align='right'>"+rs1.getString("CI_QTY")+"</td><td align='right'>"+rs1.getString("SG_QTY")+"</td><td align='right'>"+rs1.getString("TOTAL")+"</td><td align='right'>"+rs1.getString("AVG")+"</td></tr>");
     }
    rs1.close();
}
sb.append("</table></td></tr><tr><td>"+
"<table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>"+ 
"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
"<th scope='col'>Heats</th><th scope='col'>On Date</th><th scope='col'>To Date</th>"+
"<th scope='col'>Avg</th></tr>");
rs1.close();
if (cs.getMoreResults()) {
    rs1 = cs.getResultSet();
    while (rs1.next()) {
    	sb.append("<tr><td>"+rs1.getString("HEAD")+"</td><td align='right'>"+rs1.getString("ON_TOT")+"</td><td align='right'>"+rs1.getString("TO_TOT")+"</td><td align='right'>"+rs1.getString("AVG")+"</td></tr>");
     }
    rs1.close();
}
sb.append("</table></td><td>"+
"<table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>"+
"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
"<th scope='col'>Items</th><th scope='col'>On Date</th>"+
"<th scope='col'>To Date</th><th scope='col'>Avg</th></tr>"); 

rs1.close();
if (cs.getMoreResults()) {
    rs1 = cs.getResultSet();
    while (rs1.next()) {
    	sb.append("<tr><td>"+rs1.getString("HEAD")+"</td><td align='right'>"+rs1.getString("ON_TOT")+"</td><td align='right'>"+rs1.getString("TO_TOT")+"</td><td align='right'>"+rs1.getString("AVG")+"</td></tr>");
     } 
    rs1.close();
}
sb.append("</table></td></tr><tr><td colspan='2'><table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>"+
"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
"<th scope='col' colspan='2'>Shift 1</th>"+
"<th scope='col' colspan='2'>Shift 2</th><th scope='col' colspan='2'>Shift 3</th><th scope='col' colspan='2'>Total</th></tr>"+
"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
"<th scope='col'>Plan</th><th scope='col'>Act</th><th scope='col'>Plan</th><th scope='col'>Act</th>"+
"<th scope='col'>Plan</th><th scope='col'>Act</th><th scope='col'>Plan</th><th scope='col'>Act</th></tr>");
 
rs1.close();
if (cs.getMoreResults()) {
    rs1 = cs.getResultSet();
    while (rs1.next()) {
    	sb.append("<tr><td align='right'>"+rs1.getString("SHIFT1_PLAN")+"</td><td align='right'>"+rs1.getString("SHIFT1_ACT")+"</td><td align='right'>"+rs1.getString("SHIFT2_PLAN")+"</td><td align='right'>"+rs1.getString("SHIFT2_ACT")+"</td><td align='right'>"+rs1.getString("SHIFT3_PLAN")+"</td><td align='right'>"+rs1.getString("SHIFT3_ACT")+"</td><td align='right'>"+rs1.getString("TOT_PLAN")+"</td><td align='right'>"+rs1.getString("TOT_ACTPLAN")+"</td></tr>");
     } 
    rs1.close();
}
sb.append("</table><table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>"+
	 "<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'><th scope='col'>Item Name</th><th scope='col'>Schedule Qty</th><th scope='col'>Production Qty</th><th scope='col'>Dispatch Qty</th></tr>");

while(rs_stk.next()){
	//System.out.println("Date  = = " + Double.valueOf(rs1.getString("ON_PRODQTY")) + " = " +  Double.valueOf(rs1.getString("ON_DISPQTY")));
	if(Double.valueOf(rs_stk.getString("ON_PRODQTY"))==0.0 && Double.valueOf(rs_stk.getString("ON_DISPQTY"))==0.0){
	}else{
		if(!rs_stk.getString("MAT_NAME").equalsIgnoreCase("")){

sb.append("<tr><td align='left'>"+rs_stk.getString("MAT_NAME") +"</td>"+
			"<td align='right'>"+rs_stk.getString("SHEDULE_QTY") +"</td>"+
			"<td align='right'>"+rs_stk.getString("ON_PRODQTY") +"</td>"+
			"<td align='right'>"+rs_stk.getString("ON_DISPQTY") +"</td></tr>");
		}
		}
	}
	rs_stk.close();

	sb.append("</table><table border='1' style='font-size: 12px; color: #333333; width: 60%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>");
	
	if (cs2.getMoreResults()) {
	    rs_stk = cs2.getResultSet();
	 
	 sb.append("<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
			"<th scope='col'>Prod Qty MT</th>"+
			"<th scope='col'>Disp Qty MT</th>"+
			"<th scope='col'>Opening Stock MT</th>"+
			"<th scope='col'>Bal Stock MT</th>"+
			"<th scope='col'>Closing Stock MT</th></tr>");   
	 
	 while(rs_stk.next()){
		 
		 sb.append(" <tr style='font-size: 12px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
			"<td align='right'>"+rs_stk.getString("TO_PROD_MT") +"</td>"+
			"<td align='right'>"+rs_stk.getString("TO_DISP_MT") +"</td>"+
			"<td align='right'>"+rs_stk.getString("TO_OPESTOCK_MT") +"</td>"+
			"<td align='right'>"+rs_stk.getString("TO_BALSTOCK_MT") +"</td>"+
			"<td align='right'>"+rs_stk.getString("CLOSING_STKMT") +"</td></tr>");
	 }
	 rs_stk.close();
	 }
sb.append("</table></td></tr></table><p><b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
"</font></p>"); 
				msg.setContent(sb.toString(), "text/html"); 
				Transport transport = mailSession.getTransport("smtp");
				transport.connect(host, user, pass);
				transport.sendMessage(msg, msg.getAllRecipients());
				// ******************************************************************************
				transport.close();
				System.out.println("MIS Summary loop End");
				con.close();
				Thread.sleep(60000);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
	} 
} 