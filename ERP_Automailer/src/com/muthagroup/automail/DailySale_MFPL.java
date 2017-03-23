package com.muthagroup.automail;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DateFormat; 
import java.text.DateFormatSymbols;
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

public class DailySale_MFPL extends TimerTask {

	@Override
	public void run() {
		try {
			
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
			String yes_date = dateFormat.format(cal.getTime()).toString(); 
			String ason_date = dateFormat2.format(cal.getTime()).toString();
			if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 10 && d.getMinutes() == 10) {
			/*if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 16 && d.getMinutes() == 38){*/
			
				//************************************************************************************************
				DecimalFormat twoDForm = new DecimalFormat("#####0.00");
				DecimalFormat ZeroDForm = new DecimalFormat("#####0");
				System.out.println("Date before  =  " +yes_date+"\n date before = "+ason_date);
				if(weekday[d.getDay()].equals("Wednesday")){
					cal.add(Calendar.DATE, -1);
					yes_date = dateFormat.format(cal.getTime()).toString(); 
					ason_date = dateFormat2.format(cal.getTime()).toString();
				}
				//System.out.println("Date after =  " +yes_date+"\n date after = "+ason_date);
				int i=0;
				double lms = 0;
				double dp = 0;
				double ts = 0;
				double tms = 0;
				double ach = 0;
				double sr = 0;
				double nms = 0;
				ArrayList lms1 = new ArrayList();
				ArrayList dp1 = new ArrayList();
				ArrayList ts1 = new ArrayList();
				ArrayList tms1 = new ArrayList();
				ArrayList ach1 = new ArrayList();
				ArrayList sr1 = new ArrayList();
				ArrayList nms1 = new ArrayList();
				ArrayList lms2 = new ArrayList();
				ArrayList dp2 = new ArrayList();
				ArrayList ts2 = new ArrayList();
				ArrayList tms2 = new ArrayList();
				ArrayList ach2 = new ArrayList();
				ArrayList sr2 = new ArrayList();
				ArrayList nms2 = new ArrayList();
				ArrayList lms3 = new ArrayList();
				ArrayList dp3 = new ArrayList();
				ArrayList ts3 = new ArrayList();
				ArrayList tms3 = new ArrayList();
				ArrayList ach3 = new ArrayList();
				ArrayList sr3 = new ArrayList();
				ArrayList nms3 = new ArrayList();
				double sumach=0;
				
				Connection con = ConnectionUrl.getFoundryERPNEWConnection();
				CallableStatement cs = con.prepareCall("{call Sel_DailySale(?,?,?,?)}");
				cs.setString(1, "103");
				cs.setString(2, "0");
				cs.setString(3, yes_date);
				cs.setString(4, "1");				
				ResultSet rs = cs.executeQuery();
				
				System.out.println("ERP DailySale Automailer Starts !!!");
				String host = "send.one.com";
				String user = "itsupports@muthagroup.com";
				String pass = "itsupports@xyz"; 
		 		String from = "itsupports@muthagroup.com";
				String subject = "Daily Sale Report of MFPL !!!"; 
				boolean sessionDebug = false;
				// *********************************************************************************************
				// multiple recipients : == >
				// ********************************************************************************************* 
				String recipients[] = {"ssgare@muthagroup.com","kunalvm@muthagroup.com","internalaudit@muthagroup.com","vmjoshi@muthagroup.com","vahalkar@muthagroup.com","jbaphna@muthagroup.com","nrfirodia@muthagroup.com"};
				String cc_recipients[] = {"nileshss@muthagroup.com"};
				
				/*String recipients[] = {"vijaybm@muthagroup.com"};
				String cc_recipients[] = {"vijaybm@muthagroup.com"};*/

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
				sb.append("<b style='color: #0D265E;font-family: Arial;font-size: 11px;'>*** This is an automatically generated email of Daily Sale Report !!! ***</b> <br />"+
				"<div style='width: 65%;float: left;'><b style='font-family: Arial;font-size: 14px;'>MUTHA FOUNDERS PVT.LTD. Daily Sale Report as on "+ason_date +"</b></div>"+
				"<div style='text-align: right;font-family: Arial;font-size: 12px;float:right; width: 30%'><b>Please Note: </b>All Records is in lakhs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>"+
				
				"<table border='1' width='97%' style='font-family: Arial;'>"+
				"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
				"<th height='25'>Segment Customer Name</th><th>Last Month Sale</th><th>Despatch Plan</th><th>Todays Sales</th>"+
				"<th>Total Month of Sales</th><th>Achie. %</th><th>Sales Return</th><th>Net Month Sales</th></tr>");
				while(rs.next()){
					if(rs.getString("CUSTOMER_NAME").equalsIgnoreCase("CASH IN HAND")){
						lms=Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("LMTH_NET_SLAMT"))));
						dp=Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("DSPT_SCH_SLAMT"))));
						ts=Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("TODAY_SLAMT"))));
						tms=Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("CURR_MTH_SLAMT")))); 
						sr=Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("CM_SLRET_AMT"))));
						nms=Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("CM_NET_SLAMT"))));
						if(!twoDForm.format(Double.parseDouble(rs.getString("DSPT_SCH_SLAMT"))).equalsIgnoreCase("0")){
							ach = nms*100/dp;
							sumach = ach;
							}
						sb.append("<tr style='font-size: 11px;'><td style='text-align: left;'><b>Cash Sale<b/></td>"+
								"<td style='text-align: right;'><b>"+twoDForm.format(Double.parseDouble(rs.getString("LMTH_NET_SLAMT"))) +"</b> </td>"+
								"<td style='text-align: right;'><b>"+twoDForm.format(Double.parseDouble(rs.getString("DSPT_SCH_SLAMT"))) +"</b> </td>"+
								"<td style='text-align: right;'><b>"+twoDForm.format(Double.parseDouble(rs.getString("TODAY_SLAMT"))) +"</b> </td>"+
								"<td style='text-align: right;'><b>"+twoDForm.format(Double.parseDouble(rs.getString("CURR_MTH_SLAMT"))) +"</b> </td>"+
								"<td style='text-align: right;'><b>"+ZeroDForm.format(sumach) +"</b></td>"+
								"<td style='text-align: right;'><b>"+twoDForm.format(Double.parseDouble(rs.getString("CM_SLRET_AMT"))) +"</b> </td>"+
								"<td style='text-align: right;'><b>"+twoDForm.format(Double.parseDouble(rs.getString("CM_NET_SLAMT"))) +"</b> </td></tr>");
						
						sb.append("<tr style='font-size: 11px;background-color: #FCE6F2;'>"+
			"<td style='text-align: right;'><strong style='color: #91406A;'>Segments Total :</strong> </td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(Double.parseDouble(rs.getString("LMTH_NET_SLAMT"))) +"</b> </td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(Double.parseDouble(rs.getString("DSPT_SCH_SLAMT"))) +"</b> </td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(Double.parseDouble(rs.getString("TODAY_SLAMT"))) +"</b> </td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(Double.parseDouble(rs.getString("CURR_MTH_SLAMT"))) +"</b> </td>"+
			"<td style='text-align: right;'><b>"+ZeroDForm.format(sumach) +"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(Double.parseDouble(rs.getString("CM_SLRET_AMT"))) +"</b> </td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(Double.parseDouble(rs.getString("CM_NET_SLAMT"))) +"</b> </td></tr>");
						
						sb.append("<tr style='font-size: 11px;'><td style='text-align: left;' colspan='8'><strong style='color: blue;'>DOMESTIC &#8658;</strong></td></tr>"); 
					 }
					if(rs.getString("CAT_CODE").equalsIgnoreCase("1010001")){
						ach=0;
						lms1.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("LMTH_NET_SLAMT")))));
						dp1.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("DSPT_SCH_SLAMT")))));
						ts1.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("TODAY_SLAMT")))));
						tms1.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("CURR_MTH_SLAMT")))));
						sr1.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("CM_SLRET_AMT")))));
						nms1.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("CM_NET_SLAMT")))));
						if(!twoDForm.format(Double.parseDouble(rs.getString("DSPT_SCH_SLAMT"))).equalsIgnoreCase("0")){  
							ach = Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("CM_NET_SLAMT"))))*100/Double.parseDouble(twoDForm.format(Double.parseDouble(rs.getString("DSPT_SCH_SLAMT"))));
							ach1.add(ach);
							} 
						sb.append("<tr style='font-size: 11px;'>"+
					"<td style='text-align: left;'>"+rs.getString("CUSTOMER_NAME") +"</td>"+
					"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs.getString("LMTH_NET_SLAMT"))) +"</td>"+
			"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs.getString("DSPT_SCH_SLAMT"))) +"</td>"+
			"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs.getString("TODAY_SLAMT"))) +"</td>"+
			"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs.getString("CURR_MTH_SLAMT"))) +"</td>"+
			"<td style='text-align: right;'>"+ZeroDForm.format(ach) +"</td>"+
			"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs.getString("CM_SLRET_AMT"))) +"</td>"+
			"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs.getString("CM_NET_SLAMT"))) +"</td></tr>"); 
					} 
				} 
	rs.close();
	double sumlms1 = 0;
    for(int a1 = 0; a1 < lms1.size(); a1++)
    {
    	sumlms1 += Double.parseDouble(lms1.get(a1).toString());
    }
    double sumdp1 = 0;
    for(int a1 = 0; a1 < dp1.size(); a1++)
    {
    	sumdp1 += Double.parseDouble(dp1.get(a1).toString());
    }
    double sumts1 = 0;
    for(int a1 = 0; a1 < ts1.size(); a1++)
    {
    	sumts1 += Double.parseDouble(ts1.get(a1).toString());
    }
    double sumtms1 = 0;
    for(int a1 = 0; a1 < tms1.size(); a1++)
    {
    	sumtms1 += Double.parseDouble(tms1.get(a1).toString());
    }
    double sumsr1 = 0;
    for(int a1 = 0; a1 < sr1.size(); a1++)
    {
    	sumsr1 += Double.parseDouble(sr1.get(a1).toString());
    }
    double sumnms1 = 0;
    for(int a1 = 0; a1 < nms1.size(); a1++)
    {
    	sumnms1 += Double.parseDouble(nms1.get(a1).toString());
    }
    double sumach1 = 0;
    
    if(Double.parseDouble(twoDForm.format(sumdp1))!=0){
    sumach1 = Double.parseDouble(twoDForm.format(sumnms1))*100/Double.parseDouble(twoDForm.format(sumdp1));
    }
    sb.append("<tr style='font-size: 11px;background-color: #FCE6F2;'>"+
			"<td style='text-align: right;'><strong style='color: #91406A;'>Segments Total :</strong></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumlms1) +"</b> </td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumdp1) +"</b> </td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumts1) +"</b> </td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumtms1) +"</b> </td>"+
			"<td style='text-align: right;'><b>"+ZeroDForm.format(sumach1) +"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumsr1) +"</b> </td> "+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumnms1) +"</b> </td></tr>"); 
    
    ResultSet rs1 = cs.executeQuery();
	  
	while(rs1.next()){
		if(rs1.getString("CAT_CODE").equalsIgnoreCase("1010002")){
		if(i==0){
		sb.append("<tr style='font-size: 11px;'><td style='text-align: left;' colspan='8'><strong style='color: blue;'>EXPORT &#8658;</strong></td></tr>");	
		i++;
		}
		ach=0;
		lms2.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs1.getString("LMTH_NET_SLAMT")))));
		dp2.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs1.getString("DSPT_SCH_SLAMT")))));
		ts2.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs1.getString("TODAY_SLAMT")))));
		tms2.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs1.getString("CURR_MTH_SLAMT")))));
		sr2.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs1.getString("CM_SLRET_AMT")))));
		nms2.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs1.getString("CM_NET_SLAMT")))));
		if(!twoDForm.format(Double.parseDouble(rs1.getString("DSPT_SCH_SLAMT"))).equalsIgnoreCase("0")){  
			ach = Double.parseDouble(twoDForm.format(Double.parseDouble(rs1.getString("CM_NET_SLAMT"))))*100/Double.parseDouble(twoDForm.format(Double.parseDouble(rs1.getString("DSPT_SCH_SLAMT"))));
			ach2.add(ach);
			}
		sb.append("<tr style='font-size: 11px;'>"+
			"<td style='text-align: left;'>"+rs1.getString("CUSTOMER_NAME") +"</td>"+
			"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs1.getString("LMTH_NET_SLAMT"))) +"</td>"+
			"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs1.getString("DSPT_SCH_SLAMT"))) +"</td>"+
			"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs1.getString("TODAY_SLAMT"))) +"</td>"+
			"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs1.getString("CURR_MTH_SLAMT"))) +"</td>"+
			"<td style='text-align: right;'>"+ZeroDForm.format(ach) +"</td>"+
			"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs1.getString("CM_SLRET_AMT"))) +"</td>"+
			"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs1.getString("CM_NET_SLAMT"))) +"</td></tr>");		
		}
			}
	rs1.close();
	double sumlms2 = 0;
    for(int a1 = 0; a1 < lms2.size(); a1++)
    {
    	sumlms2 += Double.parseDouble(lms2.get(a1).toString());
    }
    double sumdp2 = 0;
    for(int a1 = 0; a1 < dp2.size(); a1++)
    {
    	sumdp2 += Double.parseDouble(dp2.get(a1).toString());
    }
    double sumts2 = 0;
    for(int a1 = 0; a1 < ts2.size(); a1++)
    {
    	sumts2 += Double.parseDouble(ts2.get(a1).toString());
    }
    double sumtms2 = 0;
    for(int a1 = 0; a1 < tms2.size(); a1++)
    {
    	sumtms2 += Double.parseDouble(tms2.get(a1).toString());
    }
    double sumsr2 = 0;
    for(int a1 = 0; a1 < sr2.size(); a1++)
    {
    	sumsr2 += Double.parseDouble(sr2.get(a1).toString());
    }
    double sumnms2 = 0;
    for(int a1 = 0; a1 < nms2.size(); a1++)
    {
    	sumnms2 += Double.parseDouble(nms2.get(a1).toString());
    }
    double segSumach = 0;
    if(Double.parseDouble(twoDForm.format(sumdp2))!=0){
    segSumach = Double.parseDouble(twoDForm.format(sumnms2))*100/Double.parseDouble(twoDForm.format(sumdp2));
    }
    if(i>0){
    	sb.append("<tr style='font-size: 11px;background-color: #FCE6F2;'>"+
			"<td style='text-align: right;'><strong style='color: #91406A;'>Segments Total :</strong></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumlms2) +"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumdp2) +"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumts2) +"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumtms2) +"</b></td>"+
			"<td style='text-align: right;'><b>"+ZeroDForm.format(segSumach) +"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumsr2) +"</b></td> "+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumnms2) +"</b></td></tr>"); 
    }
    ResultSet rs2=cs.executeQuery();
	if(rs2.isBeforeFirst()){
		i=0;
	while(rs2.next()){
		if(rs2.getString("CAT_CODE").equalsIgnoreCase("1010003")){
		if(i==0){
			sb.append("<tr style='font-size: 11px;'><td style='text-align: left;' colspan='8'><strong style='color: blue;'>SISTER COMPANY &#8658;</strong></td></tr>");
			i++;
		}	
		ach=0;
		lms3.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs2.getString("LMTH_NET_SLAMT")))));
		dp3.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs2.getString("DSPT_SCH_SLAMT")))));
		ts3.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs2.getString("TODAY_SLAMT")))));
		tms3.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs2.getString("CURR_MTH_SLAMT")))));
		sr3.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs2.getString("CM_SLRET_AMT")))));
		nms3.add(Double.parseDouble(twoDForm.format(Double.parseDouble(rs2.getString("CM_NET_SLAMT")))));
		if(!twoDForm.format(Double.parseDouble(rs2.getString("DSPT_SCH_SLAMT"))).equalsIgnoreCase("0")){  
			ach = Double.parseDouble(twoDForm.format(Double.parseDouble(rs2.getString("CM_NET_SLAMT"))))*100/Double.parseDouble(twoDForm.format(Double.parseDouble(rs2.getString("DSPT_SCH_SLAMT"))));
			ach3.add(ach);
			} 
		sb.append("<tr style='font-size: 11px;'>"+
					"<td style='text-align: left;'>"+rs2.getString("CUSTOMER_NAME") +"</td>"+
					"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs2.getString("LMTH_NET_SLAMT"))) +"</td>"+
					"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs2.getString("DSPT_SCH_SLAMT"))) +"</td>"+
					"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs2.getString("TODAY_SLAMT"))) +"</td>"+
					"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs2.getString("CURR_MTH_SLAMT"))) +"</td>"+
					"<td style='text-align: right;'>"+ZeroDForm.format(ach) +"</td>"+
					"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs2.getString("CM_SLRET_AMT"))) +"</td>"+
					"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs2.getString("CM_NET_SLAMT"))) +"</td></tr>");
		}
	}
	}   
	rs2.close();
	double sumlms3 = 0;
    for(int a1 = 0; a1 < lms3.size(); a1++)
    {
    	sumlms3 += Double.parseDouble(lms3.get(a1).toString());
    }
    double sumdp3 = 0;
    for(int a1 = 0; a1 < dp3.size(); a1++)
    {
    	sumdp3 += Double.parseDouble(dp3.get(a1).toString());
    }
    double sumts3 = 0;
    for(int a1 = 0; a1 < ts3.size(); a1++)
    {
    	sumts3 += Double.parseDouble(ts3.get(a1).toString());
    }
    double sumtms3 = 0;
    for(int a1 = 0; a1 < tms3.size(); a1++)
    {
    	sumtms3 += Double.parseDouble(tms3.get(a1).toString());
    }
    double sumsr3 = 0;
    for(int a1 = 0; a1 < sr3.size(); a1++)
    {
    	sumsr3 += Double.parseDouble(sr3.get(a1).toString());
    }
    double sumnms3 = 0;
    for(int a1 = 0; a1 < nms3.size(); a1++)
    {
    	sumnms3 += Double.parseDouble(nms3.get(a1).toString());
    }
    
    double segSumach3 = 0;
    if(Double.parseDouble(twoDForm.format(sumdp3))!=0){
    	segSumach3 = Double.parseDouble(twoDForm.format(sumnms3))*100/Double.parseDouble(twoDForm.format(sumdp3));
    }
    if(i>0){
    	sb.append("<tr style='font-size: 11px;background-color: #FCE6F2;'>"+
			"<td style='text-align: right;'><strong style='color: #91406A;'>Segments Total :</strong></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumlms3) +"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumdp3) +"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumts3) +"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumtms3) +"</b></td>"+
			"<td style='text-align: right;'><b>"+ZeroDForm.format(segSumach3) +"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumsr3) +"</b></td> "+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumnms3) +"</b></td></tr>");
    }
    double sumgrp_sumlms2 = Double.parseDouble(twoDForm.format(sumlms2))+Double.parseDouble(twoDForm.format(sumlms1))+Double.parseDouble(twoDForm.format(sumlms3));
	double sumgrp_sumdp2 = Double.parseDouble(twoDForm.format(sumdp2))+Double.parseDouble(twoDForm.format(sumdp1))+Double.parseDouble(twoDForm.format(sumdp3));
	double sumgrp_sumts2 = Double.parseDouble(twoDForm.format(sumts2))+Double.parseDouble(twoDForm.format(sumts1))+Double.parseDouble(twoDForm.format(sumts3));
	double sumgrp_sumtms2 = Double.parseDouble(twoDForm.format(sumtms2))+Double.parseDouble(twoDForm.format(sumtms1))+Double.parseDouble(twoDForm.format(sumtms3));
	double sumgrp_sumsr2 = Double.parseDouble(twoDForm.format(sumsr2))+Double.parseDouble(twoDForm.format(sumsr1))+Double.parseDouble(twoDForm.format(sumsr3));
	double sumgrp_sumnms2 = Double.parseDouble(twoDForm.format(sumnms2))+Double.parseDouble(twoDForm.format(sumnms1))+Double.parseDouble(twoDForm.format(sumnms3));
	
	double segGrpSumach = 0;
	if(Double.parseDouble(twoDForm.format(sumgrp_sumdp2))!=0){
	segGrpSumach = Double.parseDouble(twoDForm.format(sumgrp_sumnms2))*100/Double.parseDouble(twoDForm.format(sumgrp_sumdp2));
	} 
	double segGrandSumach = 0;
	if(Double.parseDouble(twoDForm.format(sumgrp_sumdp2+dp))!=0){
	segGrandSumach = Double.parseDouble(twoDForm.format(sumgrp_sumnms2+nms))*100/Double.parseDouble(twoDForm.format(sumgrp_sumdp2+dp));
	}
	
	sb.append("<tr style='font-size: 11px;background-color: #DEDEDE;'>"+
			"<td style='text-align: right;'><strong style='color: #1F1D1E;'>Grand Total :</strong></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumgrp_sumlms2+lms)+"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumgrp_sumdp2+dp)+"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumgrp_sumts2+ts)+"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumgrp_sumtms2+tms)+"</b></td>"+
			"<td style='text-align: right;'><b>"+ZeroDForm.format(segGrandSumach) +"</b></td>"+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumgrp_sumsr2+sr)+"</b></td> "+
			"<td style='text-align: right;'><b>"+twoDForm.format(sumgrp_sumnms2+nms)+"</b></td></tr></table>");
 
	sb.append("<table border='1' width='35%' style='font-family: Arial;'>"+
		"<tr><td colspan='2' style='font-family: Arial;font-size: 14px;'><b>Date from&nbsp;"+firstDate+"&nbsp;"+"to"+"&nbsp;"+nowDate +"</b></td></tr>"+
		"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
		"<th height='25'>Month</th><th>Sale</th></tr>");
    
    String[] mn = new DateFormatSymbols().getMonths(); 
	int m=0;
		CallableStatement cs_mnt = con.prepareCall("{call Sel_PreviousSale(?,?,?,?)}");
	cs_mnt.setString(1, "103");
	cs_mnt.setString(2, "0");
	cs_mnt.setString(3, yes_date);
	cs_mnt.setString(4, "1");		
	ResultSet rs_mnt = cs_mnt.executeQuery(); 
	while(rs_mnt.next()){  
		m = Integer.parseInt(rs_mnt.getString("TRAN_MONTH").substring(4));
	if(m < 13){
		sb.append("<tr style='font-size: 11px;'><td style='text-align: left;'>"+mn[m-1] +"</td>"+
		"<td style='text-align: right;'>"+twoDForm.format(Double.parseDouble(rs_mnt.getString("NET_MTH_SALE"))) +"</td></tr>");
	}else if(m==99){
		String dold= rs_mnt.getString("LST_YEARDETL");
		String d1_old = dold.substring(6, 8)+"/"+dold.substring(4, 6)+"/"+dold.substring(0, 4);
		String d2_old = dold.substring(14, 16)+"/"+dold.substring(12, 14)+"/"+dold.substring(8, 12);
		
		String dnew= rs_mnt.getString("CUR_YEARDETL");
		String d1_new = dnew.substring(6, 8)+"/"+dnew.substring(4, 6)+"/"+dnew.substring(0, 4);
		String d2_new = dnew.substring(14, 16)+"/"+dnew.substring(12, 14)+"/"+dnew.substring(8, 12);
		
	sb.append("<tr style='font-size: 13px;'>"+
		"<td style='text-align: left;' colspan='2'><b>Cumulative Totals From&nbsp;"+d1_old +"&nbsp;To&nbsp;"+d2_old +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8658;&nbsp;&nbsp;&nbsp;"+twoDForm.format(Double.parseDouble(rs_mnt.getString("TOT_PRVYEAR_SALE"))/100000) +"</b></td>"+
		"</tr><tr style='font-size: 13px;'>"+
		"<td style='text-align: left;' colspan='2'><b>Cumulative Totals From&nbsp;"+d1_new +"&nbsp;To&nbsp;"+d2_new +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8658;&nbsp;&nbsp;&nbsp;"+twoDForm.format(Double.parseDouble(rs_mnt.getString("TOT_CURYEAR_SALE"))/100000) +"</b></td></tr>");
	}	
	}
	
	sb.append("</table><p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'> IT | Software Development | Mutha Group Satara </p><hr><p>"+
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
			System.out.println("Automail loop End");		 
			
			con.close();
	
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	System.out.println("ERP Mailer 10");	
	} 
}
