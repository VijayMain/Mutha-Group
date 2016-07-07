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
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;
import java.util.TimerTask;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.muthagroup.connectionERPUtil.ConnectionUrl;

public class SheduleEntryReminder25 extends TimerTask {

	@Override
	public void run() {
		try {
			System.out.println("Schedule Report Arial H25");
			//-------------------------------------------------------- Date Logic ---------------------------------------------------------
			Date d = new Date();
			boolean flag = true;
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };  
			DecimalFormat twoDForm = new DecimalFormat("#####0.00");			
			if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 10 && d.getMinutes() == 21) {
			/*if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 12 && d.getMinutes() == 41) {*/
			//************************************************************************************************				
				int cnt = 0;
				DecimalFormat zeroDForm = new DecimalFormat("#####0");
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.DATE, -1);
				SimpleDateFormat todaysDate = new SimpleDateFormat("dd/MM/yyyy");
				SimpleDateFormat sqlDate = new SimpleDateFormat("yyyyMMdd");
				String todays_date = todaysDate.format(cal.getTime()).toString();
				String sql_date = sqlDate.format(cal.getTime()).toString();
				// sql_date = "20141130";
				
				// **********************************************************************************************************
				Date dateLogic = todaysDate.parse(todays_date);
				if(weekday[dateLogic.getDay()].equals("Tuesday")){
					cal.add(Calendar.DATE, -1);
					todays_date = todaysDate.format(cal.getTime()).toString();
					sql_date = sqlDate.format(cal.getTime()).toString();
				}
				System.out.println("Date Updated ===============> " + todays_date + "\n" + sql_date);
				// sql_date = "20141130";
				
				// **********************************************************************************************************
				
				double req_perdayQty=0,avg_perdayQty=0,del_rating=0;
				// ***************************************************************************************************************
				// ***************************************************************************************************************
				// *************************************************** Workdays ***************************************************
				Connection conlocal = ConnectionUrl.getLocalDatabase();
				
				String testDate = sql_date.substring(6,8) +"-"+ sql_date.substring(4,6) +"-"+ sql_date.substring(0,4);
				DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
				Date today = formatter.parse(testDate);

				int month = Integer.parseInt(sql_date.substring(4,6));
				System.out.println("Date tod Todays = " + testDate);
				System.out.println("Date Month = " + month);

				Calendar calendar = Calendar.getInstance();  
				calendar.setTime(today);
				calendar.add(Calendar.MONTH, 1);  
				calendar.set(Calendar.DAY_OF_MONTH, 1);  
				calendar.add(Calendar.DATE, -1);
				Date lastDayOfMonth = calendar.getTime();


				SimpleDateFormat sdfparse = new SimpleDateFormat("dd/MM/yyyy"); 
				Calendar calAvg = Calendar.getInstance();

				//****************************************************************************************************************************************
				int total_dd = 0;
				int holliday = 0;
				Date datesq = new Date();
				int day = datesq.getDate();
				
				PreparedStatement ps_week = conlocal.prepareStatement("select count(*) from montlyweekdays_tbl where  month="+month+" and day<"+day);
				ResultSet rs_week = ps_week.executeQuery();
				while (rs_week.next()) {
					holliday = Integer.parseInt(rs_week.getString("count(*)"));
				}
				
				PreparedStatement ps_holli = conlocal.prepareStatement("select * from montlyweekdays_tbl where day="+day+" and month="+month);
				ResultSet rs_holli = ps_holli.executeQuery();
				while (rs_holli.next()) {
					flag = false;
					System.out.println("Its a holliday !!!");
				}				
				
				int dd =  today.getDate(); 
				int tues=0;
				for(int i = 1 ; i < dd ; i++)
				{      
					calAvg.set(Calendar.DAY_OF_MONTH, i);
				    if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY){ 
				    	tues++;      
				    }
				}
				System.out.println("month  tues "+ tues +"\t"+ dd);
				int workdays = dd-tues; 
				
				total_dd = workdays;
				
				System.out.println("total_dd  =====================>  "+ total_dd);
				
				total_dd = total_dd - holliday;
				
				System.out.println("Holliday = "+holliday);
				System.out.println("total_dd afer =====================>  "+ total_dd);
				// ***************************************************************************************************************// ***************************************************************************************************************
				int space = 0; 	
				PreparedStatement ps_allHol = conlocal.prepareStatement("select count(montlyWeekdays_id) from montlyweekdays_tbl where month="+month);
				ResultSet rs_allHol = ps_allHol.executeQuery();
				while (rs_allHol.next()) { 
					System.out.println(rs_allHol.getString("count(montlyWeekdays_id)"));
					space = Integer.parseInt(rs_allHol.getString("count(montlyWeekdays_id)"));
				}
				
				int count_mnt = lastDayOfMonth.getDate();
				
				int tue_month=0;
				for(int i = 1 ; i < count_mnt ; i++)
				{      
					calAvg.set(Calendar.DAY_OF_MONTH, i);
				    if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY){ 
				    	tue_month++;      
				    }
				}

				count_mnt = count_mnt - tue_month;
				System.out.println("Space = " + space);
				System.out.println("Tuesday before = " + count_mnt);
				count_mnt = count_mnt - space;
				System.out.println("Tuesday = " + count_mnt);
				// ***************************************************************************************************************
								
				System.out.println("ERP Schedule Summary Automailer Starts !!!");
				String host = "send.one.com";
				String user = "itsupports@muthagroup.com";
				String pass = "itsupports@xyz"; 
		 		String from = "itsupports@muthagroup.com";
				String subject = "Dispatch Schedule of MEPL H25 on " + todays_date; 
				boolean sessionDebug = false;
				// *********************************************************************************************
				// multiple recipients : == >
				// ********************************************************************************************* 
				
				ArrayList emailList = new ArrayList(); 
				//*************************************************************************************************************
				emailList.add("nileshss@muthagroup.com");
				emailList.add("nandkumar@muthagroup.com");
				emailList.add("h25supervisor@muthagroup.com");
				emailList.add("smsuratkar@muthagroup.com");
				emailList.add("asshete@muthagroup.com");
				emailList.add("arif@muthagroup.com");
				emailList.add("mmkulkarni@muthagroup.com");
				emailList.add("ankatariya@muthagroup.com");
				emailList.add("vmjoshi@muthagroup.com");
				emailList.add("meplunit3production@muthagroup.com");
				emailList.add("nandkumar@muthagroup.com");
				emailList.add("pdpatil@muthagroup.com");
				emailList.add("govindmb@muthagroup.com");
				emailList.add("jangam@muthagroup.com");
				emailList.add("sunilpb@muthagroup.com");
				emailList.add("takalena@muthagroup.com");
				emailList.add("nilesh@muthagroup.com");
				emailList.add("brchourasiya@muthagroup.com");
				emailList.add("anoop@muthagroup.com");
				emailList.add("vikrant@muthagroup.com");
				emailList.add("parikshitap@muthagroup.com");
				emailList.add("nrfirodia@muthagroup.com");
				emailList.add("kunalvm@muthagroup.com"); 
				emailList.add("azmutha@muthagroup.com");
				
				// emailList.add("vijaybm@muthagroup.com"); 
				//*************************************************************************************************************
				
				
				System.out.println("Before " + emailList);
				Set<String> hs2 = new HashSet();
				hs2.addAll(emailList);
				emailList.clear();
				emailList.addAll(hs2);
				
				System.out.println("After " + emailList);
				  
				
				String[] recipients = new String[emailList.size()];
				
				for(int i=0;i<emailList.size();i++){
					recipients[i] = emailList.get(i).toString(); 
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
				
				sb.append("<b  style='font-family: Arial;font-size: 10px;color: #0D265E;'>*** This is an automatically generated email from ERP System for Monthly Dispatch Schedule of  MEPL H25 !!! ***</b>");
			 	//----------------------------------------------------------------------------------------------------------------
				
				Connection con = ConnectionUrl.getMEPLH25ERP();
				
				String matcode = "";
				PreparedStatement ps_code = con.prepareStatement("select * from H25ERP..MSTACCTGLSUB where SUB_GLCODE='11'");
				ResultSet rs_code = ps_code.executeQuery();
				while (rs_code.next()) {
					matcode += rs_code.getString("SUB_GLACNO");
				}
				ArrayList condition = new ArrayList();
				CallableStatement cs = con.prepareCall("{call Sel_RptDespatchPlanSale(?,?,?,?)}");
				cs.setString(1, "102");
				cs.setString(2, "0");
				cs.setString(3, matcode);
				cs.setString(4, sql_date);
				ResultSet rs = cs.executeQuery();
				while (rs.next()) {
					condition.add(rs.getString("CUST_CODE"));
				}
				
				rs.close(); 
				Set<String> hs = new HashSet();
				hs.addAll(condition);
				condition.clear();
				condition.addAll(hs); 
			
				ResultSet rs_disp =null;
				
				if (condition.size() > 0) { 
				 
					sb.append("<p  style='font-family: Arial;font-size: 12px;'> <a href='http://192.168.0.7/foundrymis/' style='text-decoration: none; color: green;'>Click and find details from Dispatch Plan Vs Sale Report</a>"+
			"</p><table border='1' width='92%' style='font-family: Arial;'>"+
				"<tr style='font-size: 11px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
					"<td colspan='10' height='20'><b style='font-family: Arial; font-size: 11px;'>Dispatch Schedule of MEPL H25 on "+ todays_date +" (Please Note : All Amounts in lakhs) </b></td>"+
					"</tr><tr align='center' style='font-size: 11px;font-family: Arial; background-color: #acc8cc;'>"+
					"<th class='th' rowspan='2'>Item Name</th>"+ 
					"<th class='th' rowspan='2' width='20px'>REQ/DAY</th>"+
					"<th class='th' rowspan='2' width='20px'>Sale AVG/DAY</th>"+
					"<th class='th' rowspan='2' width='20px'>Delivery Rating %</th>"+
					"<th class='th' colspan='2'>Despatch Plan</th>"+
					"<th class='th' colspan='2'>Sales</th>"+
					"<th class='th' colspan='2'>Pending</th>"+ 
					"</tr> <tr align='center'  style='font-size: 11px;font-family: Arial;background-color: #BCCED4;'>"+
					"<th style='background-color: #BCCED4;'>Qty</th>"+
					"<th style='background-color: #BCCED4;'>Amount</th>"+ 										
					"<th style='background-color: #BCCED4;'>Qty</th>"+	
					"<th style='background-color: #BCCED4;'>Amount</th>"+	
					"<th style='background-color: #BCCED4;'>Qty</th>"+
					"<th style='background-color: #BCCED4;'>Amount</th></tr>");
				
				for(int i=0;i<condition.size();i++){
					rs_disp = cs.executeQuery();
					while (rs_disp.next()) {
						if(condition.get(i).toString().equals(rs_disp.getString("CUST_CODE"))){
							if(cnt==0){
							 
				sb.append("<tr align='left' style='background-color: #E3E3E3;'>"+
					"<td colspan='10' style='font-size: 12px;'><b style='color: #AD5C00;'>"+rs_disp.getString("CUST_NAME") +"&#8658;</b></td></tr>");
				
				cnt=1;
				}
							
							req_perdayQty = Double.parseDouble(rs_disp.getString("NOS_QTY"))/count_mnt;
							avg_perdayQty = Double.parseDouble(rs_disp.getString("SALE_QTY"))/total_dd;
							del_rating = (avg_perdayQty/req_perdayQty)*100;
							
							sb.append("<tr style='font-family: Arial;font-size: 10px;'><td align='left'>"+rs_disp.getString("MAT_NAME") +"</td>"+ 
								 "<td align='right'>"+Math.round(req_perdayQty) +"</td>"+
								 "<td align='right'>"+Math.round(avg_perdayQty) +"</td>"+
								 "<td align='right'>"+twoDForm.format(del_rating) +"</td>"+
								 "<td align='right'>"+Math.round(Double.parseDouble(rs_disp.getString("NOS_QTY"))) +"</td>"+ 	 
								 "<td align='right'>"+twoDForm.format(Double.parseDouble(rs_disp.getString("SCH_AMT"))/100000) +"</td>"+   
								 "<td align='right'>"+Math.round(Double.parseDouble(rs_disp.getString("SALE_QTY"))) +"</td>"+ 
								 "<td align='right'>"+twoDForm.format(Double.parseDouble(rs_disp.getString("SALE_AMT"))/100000) +"</td>"+ 
								 "<td align='right'>"+Math.round(Double.parseDouble(rs_disp.getString("PEND_QTY"))) +"</td>"+ 
								 "<td align='right'>"+twoDForm.format(Double.parseDouble(rs_disp.getString("PEND_AMT"))/100000) +"</td></tr>");			
						}
					}
						cnt=0;
					}
				
				sb.append("</table>");
				
					} else {
					 
				sb.append("<table border='1' width='80%' style='font-family: Arial;'>"+
						"<tr style='font-size: 11px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
						"<td colspan='3' height='20'><b style='font-family: Arial; font-size: 11px;'>Dispatch Schedule of  MEPL H25 on "+todays_date+"</b></td></tr>"+
						"<tr style='font-size: 11px;' align='center'><td colspan='3' style='font-size: 13px;'>"+
						"<p><b style='color: red;'>Alert &#8680; No Schedule for MEPL H21 !!!</b></p></td></tr></table>");
					}
				 		
				sb.append("<p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'> IT | Software Development | Mutha Group Satara </p><hr><p>"+
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
				// ******************************************************************************
				transport.close();
				}else {
					System.out.println("Mail Not Sent !!!!");
				}
				System.out.println("Schedule loop End");		
				conlocal.close(); 
				con.close();
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
