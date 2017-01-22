package com.muthagroup.automail;

import java.sql.CallableStatement;
import java.sql.Connection;
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

public class MIS_SummaryReportK1 extends TimerTask {

	@Override
	public void run() {
		try {
			System.out.println("MIS Report 2");
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
			if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 17 && d.getMinutes() == 03) { 
			//************************************************************************************************				
				if(weekday[d.getDay()].equals("Wednesday")){
					cal.add(Calendar.DATE, -1);
					yes_date = dateFormat.format(cal.getTime()).toString(); 
					ason_date = dateFormat2.format(cal.getTime()).toString();
					System.out.println("Date logic as on date = "+yes_date+" Formatted date = " + ason_date);
					System.out.println("Date before  =  " +yes_date+"\n date before = "+ason_date);
				}
				Connection con = ConnectionUrl.getK1FMShopConnection();
				String OnDateMIS = yes_date;
				String db = "K1ERP";
				String comp = "106";
				int j=10;
				String OnDate = OnDateMIS.substring(6,8) +"/"+ OnDateMIS.substring(4,6) +"/"+ OnDateMIS.substring(0,4); 
				String batchonDate = "01"+"/"+ OnDateMIS.substring(4,6) +"/"+ OnDateMIS.substring(0,4);
				String bdateto = OnDateMIS.substring(0,4) +OnDateMIS.substring(4,6)+OnDateMIS.substring(6,8);
				String bdatefrom = OnDateMIS.substring(0,4) +OnDateMIS.substring(4,6)+"01";
				//***************************************************************************************************************
				SimpleDateFormat sdfparse = new SimpleDateFormat("dd/MM/yyyy");
				Date convertedCurrentDate = sdfparse.parse(OnDate);
				System.out.println("Date = " + convertedCurrentDate); 

				double avg2=0;
				Calendar calAvg = Calendar.getInstance(); 
				int dd = convertedCurrentDate.getDate(); 
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
				System.out.println("Work days "+ workdays);
				
				
				 DecimalFormat zeroDForm = new DecimalFormat("##0.##");
				 double total1=0,total2=0;
				  
					ArrayList cast=new ArrayList();
					ArrayList sg=new ArrayList();
					ArrayList head=new ArrayList();
					
					head.add("TOTAL MELTING , MT");
					head.add("TOTAL PROD, MT");
					head.add("YIELD, %");
					head.add("INHOUSE REJ, MT");
					head.add("GOOD PROD, MT");
					head.add("SALES, MT");
					head.add("CUSTOMER RETURNS, MT");
					head.add("INHOUSE REJ %");
					head.add("CUSTOMER RET, %");
					head.add("SALES, Rs Lacs");
					
					CallableStatement cs = con.prepareCall("{call Sel_RptMISMonthlySumm(?,?,?)}");
			 		cs.setString(1, comp);
			 		cs.setString(2, OnDateMIS);
			 		cs.setString(3, db); 
					ResultSet rs1 = cs.executeQuery(); 
					while(rs1.next()){
						if(rs1.getString("GRADE").equalsIgnoreCase("101")){
							sg.add(rs1.getString("OD_TOTAL_MELTING"));
							sg.add(rs1.getString("OD_TOTAL_PROD"));
							sg.add(rs1.getString("OD_YIELD"));
							sg.add(rs1.getString("OD_REJ_QTY"));
							sg.add(rs1.getString("OD_GOOD_PROD"));
							sg.add(rs1.getString("OD_DESP_QTY"));
							sg.add(rs1.getString("OD_CUST_RTN"));
							sg.add(rs1.getString("OD_REJ_PER"));
							sg.add(rs1.getString("OD_CUST_RTN_PER"));
							sg.add(rs1.getString("OD_DESP_AMT"));
							sg.add(rs1.getString("TD_TOTAL_MELTING"));
							sg.add(rs1.getString("TD_TOTAL_PROD"));
							sg.add(rs1.getString("TD_YIELD"));
							sg.add(rs1.getString("TD_REJ_QTY"));
							sg.add(rs1.getString("TD_GOOD_PROD"));
							sg.add(rs1.getString("TD_DESP_QTY"));
							sg.add(rs1.getString("TD_CUST_RTN"));
							sg.add(rs1.getString("TD_REJ_PER"));
							sg.add(rs1.getString("TD_CUST_RTN_PER"));
							sg.add(rs1.getString("TD_DESP_AMT"));
						} 	 	    
						if(rs1.getString("GRADE").equalsIgnoreCase("102")){
							cast.add(rs1.getString("OD_TOTAL_MELTING"));
							cast.add(rs1.getString("OD_TOTAL_PROD"));
							cast.add(rs1.getString("OD_YIELD"));
							cast.add(rs1.getString("OD_REJ_QTY"));
							cast.add(rs1.getString("OD_GOOD_PROD"));
							cast.add(rs1.getString("OD_DESP_QTY"));
							cast.add(rs1.getString("OD_CUST_RTN"));
							cast.add(rs1.getString("OD_REJ_PER"));
							cast.add(rs1.getString("OD_CUST_RTN_PER"));
							cast.add(rs1.getString("OD_DESP_AMT"));
							cast.add(rs1.getString("TD_TOTAL_MELTING"));
							cast.add(rs1.getString("TD_TOTAL_PROD"));
							cast.add(rs1.getString("TD_YIELD"));
							cast.add(rs1.getString("TD_REJ_QTY"));
							cast.add(rs1.getString("TD_GOOD_PROD"));
							cast.add(rs1.getString("TD_DESP_QTY"));
							cast.add(rs1.getString("TD_CUST_RTN"));
							cast.add(rs1.getString("TD_REJ_PER"));
							cast.add(rs1.getString("TD_CUST_RTN_PER"));
							cast.add(rs1.getString("TD_DESP_AMT"));
						}
					} 
				// ***************************************************************************************************************
				
								
				System.out.println("ERP MIS Summary Automailer Starts !!!");
				String host = "send.one.com";
				String user = "itsupports@muthagroup.com";
				String pass = "itsupports@xyz"; 
		 		String from = "itsupports@muthagroup.com";
				String subject = "MIS Summary Report("+ason_date+") of MEPL UNIT III."; 
				boolean sessionDebug = false;
				// *********************************************************************************************
				// multiple recipients : == >
				// ********************************************************************************************* 
				/*String recipients[] = {"azmutha@muthagroup.com","meghana@muthagroup.com","kunalvm@muthagroup.com","adgadkari@muthagroup.com","internalaudit@muthagroup.com","vmjoshi@muthagroup.com","vahalkar@muthagroup.com"};
				String cc_recipients[] = {"nileshss@muthagroup.com"};*/
				
				/*String recipients[] = {"vijaybm@muthagroup.com"};
				String cc_recipients[] = {"vijaybm@muthagroup.com"};*/
				
				String recipients[] = {"jangam@muthagroup.com"};
				String cc_recipients[] = {"vijaybm@muthagroup.com","nileshss@muthagroup.com"};
				
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
				
				sb.append("<b style='color: #0D265E;font-family: Arial;font-size: 11px;'>*** This is an automatically generated email of MIS Summary Report !!! ***</b> <br />"+
				"<div style='width: 65%;float: left;'><b style='font-family: Arial;font-size: 14px;'>MUTHA ENGINEERING UNIT III MIS Summary Report as on " + ason_date + "</b></div>");
				
				
				sb.append("<span style='font-family: Arial;font-size: 12px;'>Total Days : <b>"+dd +"&nbsp;&nbsp;&nbsp;</b>Total Working Days : <b>"+workdays +"</b></span>"+
						"<table border='1' style='font-size: 10px; color: #333333; width: 90%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>"+
						"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
						"<th scope='col'>&nbsp;</th><th scope='col' colspan='3'>On Date</th>"+
						"<th scope='col'>&nbsp;</th><th scope='col' colspan='3'>To Date</th><th scope='col'>&nbsp;</th></tr>"+
						"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
						"<th scope='col'>Head</th><th scope='col'>CI</th><th scope='col'>SGI</th><th scope='col'>Total</th><th scope='col'>&nbsp;</th>"+
						"<th scope='col'>CI</th><th scope='col'>SGI</th><th scope='col'>Total</th><th scope='col'>Average</th></tr>");
				
							
				for(int i=0;i<10;i++){				
					sb.append("<tr style='font-size: 10px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;'>"+ 
					"<td scope='col' align='left'>"+head.get(i).toString() +"</td>"+
					"<td title='Click to get details' scope='col' align='right'>"+cast.get(i).toString() +"</td>"+
					"<td title='Click to get details' scope='col' align='right'>"+sg.get(i).toString() +"</td>");
					
					total1 = Double.parseDouble(cast.get(i).toString()) + Double.parseDouble(sg.get(i).toString());
					sb.append("<td title='Click to get details' scope='col' align='right'>"+zeroDForm.format(total1) +"</td>"+
					"<td title='Click to get details' scope='col' align='right'>&nbsp;</td>"+
					"<td title='Click to get details' scope='col' align='right'>"+cast.get(j).toString() +"</td>"+
					"<td title='Click to get details' scope='col' align='right'>"+sg.get(j).toString() +"</td>");
					 
					total2 = Double.parseDouble(cast.get(j).toString()) + Double.parseDouble(sg.get(j).toString());
					
					sb.append("<td title='Click to get details' scope='col' align='right'>"+zeroDForm.format(total2) +"</td>");
					
					if(head.get(i).toString().equalsIgnoreCase("TOTAL MELTING , MT") || head.get(i).toString().equalsIgnoreCase("TOTAL PROD, MT") || head.get(i).toString().equalsIgnoreCase("INHOUSE REJ, MT") 
							|| head.get(i).toString().equalsIgnoreCase("GOOD PROD, MT") || head.get(i).toString().equalsIgnoreCase("SALES, Rs Lacs") || head.get(i).toString().equalsIgnoreCase("CUSTOMER RETURNS, MT")){
					avg2 = Double.parseDouble(zeroDForm.format(total2))/workdays;
					}else{
						avg2 = 0;	
					} 
				    sb.append("<td title='Click to get details' scope='col' align='right'>"+zeroDForm.format(avg2) +"</td></tr>");
					
					j++;
				}
				
				sb.append("</table>");
				
				//----------------------------------------------------------------------------------------------------------------
				
				sb.append("<p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'> IT | Software Development | Mutha Group Satara </p><hr><p>"+
						"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
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
			}	
		
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
}
