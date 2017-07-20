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
import java.util.Properties;
import java.util.Set;
import java.util.TimerTask; 

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage; 

import com.muthagroup.connectionERPUtil.ConnectionUrl;

public class InOut_Register extends TimerTask {
	@Override
	public void run() {
		try {
			System.out.println("ERP IN OUT Approval !!!");
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
			
			if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 10 && d.getMinutes() == 35){
			/*if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 16 && d.getMinutes() == 41){*/
			
			Connection conlocal = ConnectionUrl.getLocalDatabase();
				 
			String host = "send.one.com";
			String user = "itsupports@muthagroup.com";
			String pass = "itsupports@xyz";
	 		String from = "itsupports@muthagroup.com";
			String subject = "ERP Stock In/Out Register";
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			/* exec "ENGERP"."dbo"."Sel_RptStockInoutStatus";1 '101', '0', '20170122', '101102103'*/ 
			// *********************************************************************************************
		 	ArrayList to_emails = new ArrayList();
			String report_up = "InOutRegister";
			PreparedStatement ps_rec = conlocal.prepareStatement("select * from pending_approvee where type='to' and report='"+report_up+"'");
			ResultSet rs_rec = ps_rec.executeQuery();
			while (rs_rec.next()) {
				to_emails.add(rs_rec.getString("email"));
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
			
			InternetAddress[] addressTo = new InternetAddress[to_emails.size()];
			for (int p = 0; p < to_emails.size(); p++) {
				addressTo[p] = new InternetAddress(to_emails.get(p).toString());
			}
			msg.setRecipients(Message.RecipientType.TO, addressTo);
			msg.setSubject(subject);
			msg.setSentDate(new Date());
	 		StringBuilder sb = new StringBuilder();
			
	 		
	 		Connection con=null; 
	 		boolean chk_flag=false,flagMail=false;
	 		/**************************************************************************************************************/
	 		String CompanyName="";
 			String comp = ""; 
 		 	String DATE_FORMAT = "yyyyMMdd";
 		 	ArrayList subglNo = new ArrayList();
	 		Set<String> hs = new HashSet();
 		    SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
 		    Calendar c1 = Calendar.getInstance(); // today
 		   c1.add(Calendar.DATE, -1);
 		    String DATE_FORMAT2 = "dd/MM/yyyy";
 		    SimpleDateFormat sdf2 = new SimpleDateFormat(DATE_FORMAT2);
 		    Calendar c2 = Calendar.getInstance(); // today
 		   c2.add(Calendar.DATE, -1); 
 			String datesql = sdf.format(c1.getTime());
 			String printdate = sdf2.format(c1.getTime()); 
 			ArrayList type = new ArrayList();
	 		type.add("101");
	 		type.add("102");
	 		type.add("103"); 
 			// System.out.println("IN OUT Register = " + datesql + " = = " + printdate);
sb.append("<b style='color: #0D265E;font-family: Arial;font-size: 11px;'>*** This is an automatically generated email of ERP Stock In/Out Register ***</b><table border='1' width='90%' style='font-family: Arial;text-align: center;font-family: Arial;font-size: 12px;'>"+
 	"<tr style='font-size: 12px; background-color: #c8e6f0; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;font-weight: bold;'>"+
 	"<td colspan='3'>Stock In/Out Register as on </td></tr>"+
 	"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;font-weight: bold;'>"+
	 "<td>Part Name</td>"+
 	"<td>In Qty</td>"+
 	"<td>Out Qty</td>"+
 	"</tr>");
 

/******************************************************* MEPL H21 *******************************************/

sb.append("<tr><td colspan='3' align='left' style='background-color: #466817; color: white;font-size: 12px;'><strong>Company Name : MEPL H21 ==> </strong></td></tr>");
 		comp = "101";
 		CompanyName = "MEPL H-21";
 		subglNo.clear();   
 		hs.clear();
 		chk_flag=false;
 		con = ConnectionUrl.getMEPLH21ERP();
 		CallableStatement cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
 		cs.setString(1, comp);
 		cs.setString(2, "0");
 		cs.setString(3, datesql);
 		cs.setString(4, "101102103");
 		ResultSet rs_data = cs.executeQuery();
 		while(rs_data.next()){
 			subglNo.add(rs_data.getString("SUB_GLACNO"));
 		}
 		hs.addAll(subglNo);
 		subglNo.clear();
 		subglNo.addAll(hs);
 		 ResultSet rs = null,rs_name=null;
 		for(int i=0;i<type.size();i++){
 			if(i==0 && type.get(i).toString().equalsIgnoreCase("101")){ 
 			sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>JOBWORK</strong></td></tr>");
 				for(int j=0;j<subglNo.size();j++){
 				rs = cs.executeQuery();
 				while(rs.next()){
 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("101")){
 						if(chk_flag==false){
 			sb.append("<tr><td colspan='3' align='left' style='background-color: #aeaeae;color: black;'><strong>"+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
 				chk_flag=true;
 						}
 			sb.append("<tr><td align='left'>"+rs.getString("NAME")+"</td><td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
 			flagMail=true;
 					}	 					
 				}
 				rs=null;
 				chk_flag=false;
 				}
 			}
			if(i==1 && type.get(i).toString().equalsIgnoreCase("102")){ 
			 	sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>PURCHASE / SALE</strong></td></tr>");
			 	for(int j=0;j<subglNo.size();j++){
	 				rs = cs.executeQuery();
	 				while(rs.next()){
	 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("102")){
	 						if(chk_flag==false){ 
	 			 sb.append("<tr><td colspan='3' align='left' style='background-color:  #aeaeae;color: black;'><strong>"+ rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>"); 
	 				chk_flag=true;
	 						} 
	 				sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td>"+
 					"<td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
	 				flagMail=true;
	 					} 
	 				}
	 				rs=null;
	 				chk_flag=false;
	 				}
			 	
 			}
			if(i==2 && type.get(i).toString().equalsIgnoreCase("103")){
				sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>SUBCONTRACT IN OUT</strong></td></tr>");
			 	for(int j=0;j<subglNo.size();j++){
	 				rs = cs.executeQuery();
	 				while(rs.next()){
	 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("103")){
	 						if(chk_flag==false){
	 						sb.append("<tr><td colspan='3' align='left' style='background-color: #aeaeae;color: black;'><strong>"+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
	 				chk_flag=true;
	 						}
	 			sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td>"+
 					"<td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
	 			flagMail=true;
	 					}
	 				}
	 				rs=null;
	 				chk_flag=false;
	 				}
			}
 		}
 		/*******************************************************************************************************************/
	 	/******************************************************* MEPL H25 *******************************************/
 			sb.append("<tr><td colspan='3' align='left' style='background-color: #466817; color: white;font-size: 12px;'><strong>Company Name : MEPL H25 ==> </strong></td></tr>");
 		 		comp = "102";
 		 		CompanyName = "MEPL H-25";
 		 		subglNo.clear();
 		 		hs.clear();
 		 		chk_flag=false;
 		 		con = ConnectionUrl.getMEPLH25ERP();
 		 		cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
 		 		cs.setString(1, comp);
 		 		cs.setString(2, "0");
 		 		cs.setString(3, datesql);
 		 		cs.setString(4, "101102103");
 		 		rs_data = cs.executeQuery();
 		 		while(rs_data.next()){
 		 			subglNo.add(rs_data.getString("SUB_GLACNO"));
 		 		}
 		 		hs.addAll(subglNo);
 		 		subglNo.clear();
 		 		subglNo.addAll(hs);
 		 		rs = null;
 		 		rs_name=null;
 		 		for(int i=0;i<type.size();i++){
 		 			if(i==0 && type.get(i).toString().equalsIgnoreCase("101")){ 
 		 			sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>JOBWORK</strong></td></tr>");
 		 				for(int j=0;j<subglNo.size();j++){
 		 				rs = cs.executeQuery();
 		 				while(rs.next()){
 		 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("101")){
 		 						if(chk_flag==false){
 		 			sb.append("<tr><td colspan='3' align='left' style='background-color: #aeaeae;color: black;'><strong>"+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
 		 				chk_flag=true;
 		 						}
 		 			sb.append("<tr><td align='left'>"+rs.getString("NAME")+"</td><td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 		 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
 		 			flagMail=true;
 		 					}	 					
 		 				}
 		 				rs=null;
 		 				chk_flag=false;
 		 				}
 		 			}
 					if(i==1 && type.get(i).toString().equalsIgnoreCase("102")){ 
 					 	sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>PURCHASE / SALE</strong></td></tr>");
 					 	for(int j=0;j<subglNo.size();j++){
 			 				rs = cs.executeQuery();
 			 				while(rs.next()){
 			 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("102")){
 			 						if(chk_flag==false){ 
 			 			 sb.append("<tr><td colspan='3' align='left' style='background-color:  #aeaeae;color: black;'><strong>"+ rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>"); 
 			 				chk_flag=true;
 			 						} 
 			 				sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td>"+
 		 					"<td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 		 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
 			 				flagMail=true;
 			 					} 
 			 				}
 			 				rs=null;
 			 				chk_flag=false;
 			 				}
 					 	
 		 			}
 					if(i==2 && type.get(i).toString().equalsIgnoreCase("103")){
 						sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>SUBCONTRACT IN OUT</strong></td></tr>");
 					 	for(int j=0;j<subglNo.size();j++){
 			 				rs = cs.executeQuery();
 			 				while(rs.next()){
 			 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("103")){
 			 						if(chk_flag==false){
 			 						sb.append("<tr><td colspan='3' align='left' style='background-color: #aeaeae;color: black;'><strong>"+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
 			 				chk_flag=true;
 			 						}
 			 			sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td>"+
 		 					"<td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 		 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
 			 			flagMail=true;
 			 					}
 			 				}
 			 				rs=null;
 			 				chk_flag=false;
 			 				}
 					}
 		 		}
 		 		/*******************************************************************************************************************/
 		 		/******************************************************* DI *******************************************/
 	 			sb.append("<tr><td colspan='3' align='left' style='background-color: #466817; color: white;font-size: 12px;'><strong>Company Name : DI ==> </strong></td></tr>");
 	 		 		comp = "105";
 	 		 		CompanyName = "DI";
 	 		 		subglNo.clear();
 	 		 		hs.clear();
 	 		 		chk_flag=false;
 	 		 		con = ConnectionUrl.getDIERPConnection();
 	 		 		cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
 	 		 		cs.setString(1, comp);
 	 		 		cs.setString(2, "0");
 	 		 		cs.setString(3, datesql);
 	 		 		cs.setString(4, "101102103");
 	 		 		rs_data = cs.executeQuery();
 	 		 		while(rs_data.next()){
 	 		 			subglNo.add(rs_data.getString("SUB_GLACNO"));
 	 		 		}
 	 		 		hs.addAll(subglNo);
 	 		 		subglNo.clear();
 	 		 		subglNo.addAll(hs);
 	 		 		rs = null;
 	 		 		rs_name=null;
 	 		 		for(int i=0;i<type.size();i++){
 	 		 			if(i==0 && type.get(i).toString().equalsIgnoreCase("101")){ 
 	 		 			sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>JOBWORK</strong></td></tr>");
 	 		 				for(int j=0;j<subglNo.size();j++){
 	 		 				rs = cs.executeQuery();
 	 		 				while(rs.next()){
 	 		 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("101")){
 	 		 						if(chk_flag==false){
 	 		 			sb.append("<tr><td colspan='3' align='left' style='background-color: #aeaeae;color: black;'><strong>"+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
 	 		 				chk_flag=true;
 	 		 						}
 	 		 			sb.append("<tr><td align='left'>"+rs.getString("NAME")+"</td><td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 	 		 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
 	 		 			flagMail=true;
 	 		 					}	 					
 	 		 				}
 	 		 				rs=null;
 	 		 				chk_flag=false;
 	 		 				}
 	 		 			}
 	 					if(i==1 && type.get(i).toString().equalsIgnoreCase("102")){ 
 	 					 	sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>PURCHASE / SALE</strong></td></tr>");
 	 					 	for(int j=0;j<subglNo.size();j++){
 	 			 				rs = cs.executeQuery();
 	 			 				while(rs.next()){
 	 			 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("102")){
 	 			 						if(chk_flag==false){ 
 	 			 			 sb.append("<tr><td colspan='3' align='left' style='background-color:  #aeaeae;color: black;'><strong>"+ rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>"); 
 	 			 				chk_flag=true;
 	 			 						} 
 	 			 				sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td>"+
 	 		 					"<td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 	 		 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
 	 			 				flagMail=true;
 	 			 					} 
 	 			 				}
 	 			 				rs=null;
 	 			 				chk_flag=false;
 	 			 				}
 	 					 	
 	 		 			}
 	 					if(i==2 && type.get(i).toString().equalsIgnoreCase("103")){
 	 						sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>SUBCONTRACT IN OUT</strong></td></tr>");
 	 					 	for(int j=0;j<subglNo.size();j++){
 	 			 				rs = cs.executeQuery();
 	 			 				while(rs.next()){
 	 			 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("103")){
 	 			 						if(chk_flag==false){
 	 			 						sb.append("<tr><td colspan='3' align='left' style='background-color: #aeaeae;color: black;'><strong>"+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
 	 			 				chk_flag=true;
 	 			 						}
 	 			 			sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td>"+
 	 		 					"<td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 	 		 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
 	 			 			flagMail=true;
 	 			 					}
 	 			 				}
 	 			 				rs=null;
 	 			 				chk_flag=false;
 	 			 				}
 	 					}
 	 		 		}
 	 		 		/*******************************************************************************************************************/
 	 		 		/******************************************************* MEPL UNIT III *******************************************/
 	 	 			sb.append("<tr><td colspan='3' align='left' style='background-color: #466817; color: white;font-size: 12px;'><strong>Company Name : MEPL UNIT III ==> </strong></td></tr>");
 	 	 		 		comp = "106";
 	 	 		 		CompanyName = "MEPL UNIT III";
 	 	 		 		subglNo.clear();
 	 	 		 		hs.clear();
 	 	 		 		chk_flag=false;
 	 	 		 		con = ConnectionUrl.getK1ERPConnection();
 	 	 		 		cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
 	 	 		 		cs.setString(1, comp);
 	 	 		 		cs.setString(2, "0");
 	 	 		 		cs.setString(3, datesql);
 	 	 		 		cs.setString(4, "101102103");
 	 	 		 		rs_data = cs.executeQuery();
 	 	 		 		while(rs_data.next()){
 	 	 		 			subglNo.add(rs_data.getString("SUB_GLACNO"));
 	 	 		 		}
 	 	 		 		hs.addAll(subglNo);
 	 	 		 		subglNo.clear();
 	 	 		 		subglNo.addAll(hs);
 	 	 		 		rs = null;
 	 	 		 		rs_name=null;
 	 	 		 		for(int i=0;i<type.size();i++){
 	 	 		 			if(i==0 && type.get(i).toString().equalsIgnoreCase("101")){ 
 	 	 		 			sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>JOBWORK</strong></td></tr>");
 	 	 		 				for(int j=0;j<subglNo.size();j++){
 	 	 		 				rs = cs.executeQuery();
 	 	 		 				while(rs.next()){
 	 	 		 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("101")){
 	 	 		 						if(chk_flag==false){
 	 	 		 			sb.append("<tr><td colspan='3' align='left' style='background-color: #aeaeae;color: black;'><strong>"+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
 	 	 		 				chk_flag=true;
 	 	 		 						}
 	 	 		 			sb.append("<tr><td align='left'>"+rs.getString("NAME")+"</td><td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 	 	 		 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
 	 	 		 			flagMail=true;
 	 	 		 					}	 					
 	 	 		 				}
 	 	 		 				rs=null;
 	 	 		 				chk_flag=false;
 	 	 		 				}
 	 	 		 			}
 	 	 					if(i==1 && type.get(i).toString().equalsIgnoreCase("102")){ 
 	 	 					 	sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>PURCHASE / SALE</strong></td></tr>");
 	 	 					 	for(int j=0;j<subglNo.size();j++){
 	 	 			 				rs = cs.executeQuery();
 	 	 			 				while(rs.next()){
 	 	 			 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("102")){
 	 	 			 						if(chk_flag==false){ 
 	 	 			 			 sb.append("<tr><td colspan='3' align='left' style='background-color:  #aeaeae;color: black;'><strong>"+ rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>"); 
 	 	 			 				chk_flag=true;
 	 	 			 						} 
 	 	 			 				sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td>"+
 	 	 		 					"<td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 	 	 		 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
 	 	 			 				flagMail=true;
 	 	 			 					} 
 	 	 			 				}
 	 	 			 				rs=null;
 	 	 			 				chk_flag=false;
 	 	 			 				}
 	 	 					 	
 	 	 		 			}
 	 	 					if(i==2 && type.get(i).toString().equalsIgnoreCase("103")){
 	 	 						sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>SUBCONTRACT IN OUT</strong></td></tr>");
 	 	 					 	for(int j=0;j<subglNo.size();j++){
 	 	 			 				rs = cs.executeQuery();
 	 	 			 				while(rs.next()){
 	 	 			 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("103")){
 	 	 			 						if(chk_flag==false){
 	 	 			 						sb.append("<tr><td colspan='3' align='left' style='background-color: #aeaeae;color: black;'><strong>"+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
 	 	 			 				chk_flag=true;
 	 	 			 						}
 	 	 			 			sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td>"+
 	 	 		 					"<td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 	 	 		 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
 	 	 			 			flagMail=true;
 	 	 			 					}
 	 	 			 				}
 	 	 			 				rs=null;
 	 	 			 				chk_flag=false;
 	 	 			 				}
 	 	 					}
 	 	 		 		}
 	 	 		 		/*******************************************************************************************************************/
 	 			 		
 	 	 		 		/******************************************************* MFPL *******************************************/
 	 	 	 			sb.append("<tr><td colspan='3' align='left' style='background-color: #466817; color: white;font-size: 12px;'><strong>Company Name : MFPL ==> </strong></td></tr>");
 	 	 	 		 		comp = "103";
 	 	 	 		 		CompanyName = "MFPL";
 	 	 	 		 		subglNo.clear();
 	 	 	 		 		hs.clear();
 	 	 	 		 		chk_flag=false;
 	 	 	 		 		con = ConnectionUrl.getFoundryERPNEWConnection();
 	 	 	 		 		cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
 	 	 	 		 		cs.setString(1, comp);
 	 	 	 		 		cs.setString(2, "0");
 	 	 	 		 		cs.setString(3, datesql);
 	 	 	 		 		cs.setString(4, "101102103");
 	 	 	 		 		rs_data = cs.executeQuery();
 	 	 	 		 		while(rs_data.next()){
 	 	 	 		 			subglNo.add(rs_data.getString("SUB_GLACNO"));
 	 	 	 		 		}
 	 	 	 		 		hs.addAll(subglNo);
 	 	 	 		 		subglNo.clear();
 	 	 	 		 		subglNo.addAll(hs);
 	 	 	 		 		rs = null;
 	 	 	 		 		rs_name=null;
 	 	 	 		 		for(int i=0;i<type.size();i++){
 	 	 	 		 			if(i==0 && type.get(i).toString().equalsIgnoreCase("101")){ 
 	 	 	 		 			sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>JOBWORK</strong></td></tr>");
 	 	 	 		 				for(int j=0;j<subglNo.size();j++){
 	 	 	 		 				rs = cs.executeQuery();
 	 	 	 		 				while(rs.next()){
 	 	 	 		 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("101")){
 	 	 	 		 						if(chk_flag==false){
 	 	 	 		 			sb.append("<tr><td colspan='3' align='left' style='background-color: #aeaeae;color: black;'><strong>"+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
 	 	 	 		 				chk_flag=true;
 	 	 	 		 						}
 	 	 	 		 			sb.append("<tr><td align='left'>"+rs.getString("NAME")+"</td><td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 	 	 	 		 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
 	 	 	 		 			flagMail=true;
 	 	 	 		 					}	 					
 	 	 	 		 				}
 	 	 	 		 				rs=null;
 	 	 	 		 				chk_flag=false;
 	 	 	 		 				}
 	 	 	 		 			}
 	 	 	 					if(i==1 && type.get(i).toString().equalsIgnoreCase("102")){ 
 	 	 	 					 	sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>PURCHASE / SALE</strong></td></tr>");
 	 	 	 					 	for(int j=0;j<subglNo.size();j++){
 	 	 	 			 				rs = cs.executeQuery();
 	 	 	 			 				while(rs.next()){
 	 	 	 			 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("102")){
 	 	 	 			 						if(chk_flag==false){
 	 	 	 			 			 sb.append("<tr><td colspan='3' align='left' style='background-color:  #aeaeae;color: black;'><strong>"+ rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>"); 
 	 	 	 			 				chk_flag=true;
 	 	 	 			 						} 
 	 	 	 			 				sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td>"+
 	 	 	 		 					"<td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 	 	 	 		 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
 	 	 	 			 				flagMail=true;
 	 	 	 			 					} 
 	 	 	 			 				}
 	 	 	 			 				rs=null;
 	 	 	 			 				chk_flag=false;
 	 	 	 			 				} 
 	 	 	 		 			}
 	 	 	 					if(i==2 && type.get(i).toString().equalsIgnoreCase("103")){
 	 	 	 						sb.append("<tr><td colspan='3' align='left' style='background-color: #6f2781;color: white;'><strong>SUBCONTRACT IN OUT</strong></td></tr>");
 	 	 	 					 	for(int j=0;j<subglNo.size();j++){
 	 	 	 			 				rs = cs.executeQuery();
 	 	 	 			 				while(rs.next()){
 	 	 	 			 					if(rs.getString("SUB_GLACNO").equalsIgnoreCase(subglNo.get(j).toString()) && rs.getString("TYPE").equalsIgnoreCase("103")){
 	 	 	 			 						if(chk_flag==false){
 	 	 	 			 						sb.append("<tr><td colspan='3' align='left' style='background-color: #aeaeae;color: black;'><strong>"+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
 	 	 	 			 				chk_flag=true;
 	 	 	 			 						}
 	 	 	 			 			sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td>"+
 	 	 	 		 					"<td align='right'><b>"+rs.getString("IN_QTY") +"</b></td>"+
 	 	 	 		 					"<td align='right'><b>"+rs.getString("OUT_QTY") +"</b></td></tr>");
 	 	 	 			 			flagMail=true;
 	 	 	 			 					}
 	 	 	 			 				}
 	 	 	 			 				rs=null;
 	 	 	 			 				chk_flag=false;
 	 	 	 			 				}
 	 	 	 					}
 	 	 	 		 		}
 	 	 	 		 		/*******************************************************************************************************************/
 	 	 			 		
 		 		
	 		
	 		
	 		
	 		
	 		
	 		
	 		
	 		

	 sb.append("</table><b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
			"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
			"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
			"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
			"</font></p>");
		 
			msg.setContent(sb.toString(), "text/html"); 
			if(flagMail==true){
			Transport transport = mailSession.getTransport("smtp");
			transport.connect(host, user, pass);
			transport.sendMessage(msg, msg.getAllRecipients());
			transport.close();
			System.out.println("msg Sent IN/OUT !!!");
			}
				con.close(); 
				Thread.sleep(60000);
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
