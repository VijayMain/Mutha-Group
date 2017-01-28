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
			
			if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 10 && d.getMinutes() == 18){
			
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
	 		boolean chk_flag=false,chk_grand=false;
	 		/**************************************************************************************************************/
	 	  		String CompanyName="";
	 			String comp = "";
	 			ArrayList subgl = new ArrayList();
	 		 	String DATE_FORMAT = "yyyyMMdd";
	 		    SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
	 		    Calendar c1 = Calendar.getInstance(); // today
	 		    
	 		    String DATE_FORMAT2 = "dd/MM/yyyy";
	 		    SimpleDateFormat sdf2 = new SimpleDateFormat(DATE_FORMAT2);
	 		    Calendar c2 = Calendar.getInstance(); // today
	 		    
	 			String datesql = sdf.format(c1.getTime());
	 			String printdate = sdf2.format(c1.getTime());
	 		
	 		sb.append("<b style='color: #0D265E;font-family: Arial;font-size: 11px;'>*** This is an automatically generated email of ERP Stock In/Out Register ***</b><table border='1' width='90%' style='font-family: Arial;text-align: center;font-family: Arial;font-size: 12px;'>"+
	 	"<tr style='font-size: 12px; background-color: #c8e6f0; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;font-weight: bold;'>"+
	 	"<td colspan='3'>Stock In/Out Register as on "+printdate +"</td>"+
	 	"</tr>"+
	 	"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;font-weight: bold;'>"+
	 	"<td>Part Name</td>"+
	 	"<td>In Qty</td>"+
	 	"<td>Out Qty</td>"+
	 	"</tr>");
	 		
	 		
	 		
	 		subgl.clear();
	 		comp = "101";
	 		CompanyName = "MEPL H-21";
	 		con = ConnectionUrl.getMEPLH21ERP();
	 		CallableStatement cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
	 		cs.setString(1, comp);
	 		cs.setString(2, "0");
	 		cs.setString(3, datesql);
	 		/* cs.setString(3, "20170122"); */
	 		cs.setString(4, "101102103");
	 		ResultSet rs = cs.executeQuery();
	 		while(rs.next()){
	 		subgl.add(rs.getString("SUB_GLACNO"));
	 		chk_flag=true;
	 		}
	 		Set<String> hs = new HashSet();
	 		hs.addAll(subgl);
	 		subgl.clear();
	 		subgl.addAll(hs);
	 		 
	 		int flag=0,sno=1;
	 		double sum_inqty=0,sum_outqty=0;
	 		for(int i=0;i<subgl.size();i++){
	 		if(i==0){
	 		
	 		sb.append("<tr><td colspan='3' align='left' style='background-color: #382891;color: white;'><strong>"+CompanyName +" ===> </strong></td></tr>");
	 		
	 		} 
	 		flag=i;
	 		rs = cs.executeQuery();
	 		while(rs.next()){
	 			if(subgl.get(i).toString().equalsIgnoreCase(rs.getString("SUB_GLACNO"))){
	 			   if(flag==i){
	 		chk_grand=true;
	 		
	 		sb.append("<tr><td colspan='3' align='left' style='background-color: #fdffaa'><strong>"+sno +" &nbsp; "+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
	 		
	 		sno++;
	 		}
	 			   
	 		sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td><td align='right'>"+rs.getString("IN_QTY") +"</td><td align='right'>"+rs.getString("OUT_QTY") +"</td></tr>");	   
	 		
	 		sum_inqty=Double.parseDouble(rs.getString("IN_QTY")) + sum_inqty;
	 		sum_outqty=Double.parseDouble(rs.getString("OUT_QTY")) + sum_outqty;
	 		flag++;
	 				}
	 			}
	 		} 
	 		if(chk_grand==true){ 
	 		sb.append("<tr style='background-color: #b5fdfd'><td><strong>Grand Total </strong> </td><td align='right'>"+ sum_inqty+"</td><td align='right'>"+ sum_outqty +"</td></tr> ");
	 		}
	 		
	 		subgl.clear();
	 		chk_grand=false;
	 		comp = "102";
	 		CompanyName = "MEPL H-25";
	 		con = ConnectionUrl.getMEPLH25ERP();
	 		cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
	 		cs.setString(1, comp);
	 		cs.setString(2, "0");
	 		cs.setString(3, datesql);
	 		/* cs.setString(3, "20170122"); */
	 		cs.setString(4, "101102103");
	 		rs = cs.executeQuery();
	 		while(rs.next()){
	 		subgl.add(rs.getString("SUB_GLACNO"));
	 		chk_flag=true;
	 		} 
	 		hs.clear();
	 		hs.addAll(subgl);
	 		subgl.clear();
	 		subgl.addAll(hs);
	 		 
	 		flag=0;sno=1;
	 		sum_inqty=0;sum_outqty=0;
	 		for(int i=0;i<subgl.size();i++){
	 		if(i==0){
	 			chk_grand=true;	 			
	 		sb.append("<tr><td colspan='3' align='left' style='background-color: #382891;color: white;'><strong>"+CompanyName +" ===> </strong></td></tr>");	
	 		} 
	 		flag=i;
	 		rs = cs.executeQuery();
	 		while(rs.next()){
	 			if(subgl.get(i).toString().equalsIgnoreCase(rs.getString("SUB_GLACNO"))){
	 	if(flag==i){	
	 		
	 		sb.append("<tr><td colspan='3' align='left' style='background-color: #fdffaa'><strong>"+sno +"&nbsp; "+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
	 		sno++;
	 	}
	 	sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td><td align='right'>"+rs.getString("IN_QTY") +"</td><td align='right'>"+rs.getString("OUT_QTY") +"</td></tr>");
	 	
	 	sum_inqty=Double.parseDouble(rs.getString("IN_QTY")) + sum_inqty;
	 	sum_outqty=Double.parseDouble(rs.getString("OUT_QTY")) + sum_outqty;
	 	flag++;
	 			}
	 		}
	 	} 
	 	if(chk_grand==true){
	 		sb.append("<tr style='background-color: #b5fdfd'><td><strong>Grand Total </strong> </td><td align='right'>"+ sum_inqty +"</td><td align='right'>"+sum_outqty +"</td></tr>");
	 	}
	 	subgl.clear();
	 	chk_grand=false;
	 	comp = "103";
	 	CompanyName = "MFPL";
	 	con = ConnectionUrl.getFoundryERPNEWConnection();
	 	cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
	 	cs.setString(1, comp);
	 	cs.setString(2, "0");
	 	cs.setString(3, datesql);
	 	/* cs.setString(3, "20170122"); */
	 	cs.setString(4, "101102103");
	 	rs = cs.executeQuery();
	 	while(rs.next()){
	 	subgl.add(rs.getString("SUB_GLACNO"));
	 	chk_flag=true;
	 	} 
	 	hs.clear();
	 	hs.addAll(subgl);
	 	subgl.clear();
	 	subgl.addAll(hs);
	 	 
	 	flag=0;sno=1;
	 	sum_inqty=0;sum_outqty=0;
	 	for(int i=0;i<subgl.size();i++){
	 	if(i==0){
	 		chk_grand=true;
	 		
	 		sb.append("<tr><td colspan='3' align='left' style='background-color: #382891;color: white;'><strong>"+CompanyName +" ===> </strong></td></tr>");
	 	} 
		flag=i;
		rs = cs.executeQuery();
		while(rs.next()){
			if(subgl.get(i).toString().equalsIgnoreCase(rs.getString("SUB_GLACNO"))){
				if(flag==i){
		sb.append("<tr><td colspan='3' align='left' style='background-color: #fdffaa'><strong>"+sno +" &nbsp; "+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
		sno++;
		}
	 	
		sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td><td align='right'>"+rs.getString("IN_QTY") +"</td><td align='right'>"+rs.getString("OUT_QTY") +"</td></tr>");
		sum_inqty=Double.parseDouble(rs.getString("IN_QTY")) + sum_inqty;
		sum_outqty=Double.parseDouble(rs.getString("OUT_QTY")) + sum_outqty;
		flag++;
				}
			}
		} 
		if(chk_grand==true){
			
	 	sb.append("<tr style='background-color: #b5fdfd'><td><strong>Grand Total </strong> </td><td align='right'>"+ sum_inqty+"</td><td align='right'>"+ sum_outqty +"</td></tr>");
		}
		
		subgl.clear();
		chk_grand=false;
		comp = "105";
		CompanyName = "DI";
		con = ConnectionUrl.getDIERPConnection();
		cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
		cs.setString(1, comp);
		cs.setString(2, "0");
		cs.setString(3, datesql);
		/* cs.setString(3, "20170122"); */
		cs.setString(4, "101102103");
		rs = cs.executeQuery();
		while(rs.next()){
		subgl.add(rs.getString("SUB_GLACNO"));
		chk_flag=true;
		} 
		hs.clear();
		hs.addAll(subgl);
		subgl.clear();
		subgl.addAll(hs);
		 
		flag=0;sno=1;
		sum_inqty=0;sum_outqty=0;
		for(int i=0;i<subgl.size();i++){
		if(i==0){
			chk_grand=true;
			sb.append("<tr><td colspan='3' align='left' style='background-color: #382891;color: white;'><strong>"+CompanyName +" ===> </strong></td></tr>");
		} 
		flag=i;
		rs = cs.executeQuery();
		while(rs.next()){
			if(subgl.get(i).toString().equalsIgnoreCase(rs.getString("SUB_GLACNO"))){
	if(flag==i){
		sb.append("<tr><td colspan='3' align='left' style='background-color: #fdffaa'><strong>"+sno +" &nbsp; "+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>"); 
		sno++;
	}
	sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td><td align='right'>"+rs.getString("IN_QTY") +"</td><td align='right'>"+rs.getString("OUT_QTY") +"</td></tr>");
	sum_inqty=Double.parseDouble(rs.getString("IN_QTY")) + sum_inqty;
	sum_outqty=Double.parseDouble(rs.getString("OUT_QTY")) + sum_outqty;
	flag++;
			}
		}
	} 
	if(chk_grand==true){
		sb.append("<tr style='background-color: #b5fdfd'><td><strong>Grand Total </strong></td><td align='right'>"+ sum_inqty +"</td><td align='right'>"+ sum_outqty +"</td></tr>");
	}
	subgl.clear();
	chk_grand=false;
	comp = "106";
	CompanyName = "MEPL UNIT III";
	con = ConnectionUrl.getK1ERPConnection();
	cs = con.prepareCall("{call Sel_RptStockInoutStatus(?,?,?,?)}");
	cs.setString(1, comp);
	cs.setString(2, "0");
	cs.setString(3, datesql);
	/* cs.setString(3, "20170122"); */
	cs.setString(4, "101102103");
	rs = cs.executeQuery();
	while(rs.next()){
	subgl.add(rs.getString("SUB_GLACNO"));
	chk_flag=true;
	} 
	hs.clear();
	hs.addAll(subgl);
	subgl.clear();
	subgl.addAll(hs);
	 
	flag=0;sno=1;
	sum_inqty=0;sum_outqty=0;
	for(int i=0;i<subgl.size();i++){
	if(i==0){
		chk_grand=true;
		
		sb.append("<tr><td colspan='3' align='left' style='background-color: #382891;color: white;'><strong>"+CompanyName +" ===> </strong></td></tr>");
	} 
	flag=i;
	rs = cs.executeQuery();
	while(rs.next()){
		if(subgl.get(i).toString().equalsIgnoreCase(rs.getString("SUB_GLACNO"))){
if(flag==i){
	sb.append("<tr><td colspan='3' align='left' style='background-color: #fdffaa'><strong>"+sno +" &nbsp; "+rs.getString("SUBGL_LONGNAME") +"</strong></td></tr>");
	sno++;
	}
sb.append("<tr><td align='left'>"+rs.getString("NAME") +"</td><td align='right'>"+rs.getString("IN_QTY") +"</td><td align='right'>"+rs.getString("OUT_QTY") +"</td></tr>");	
sum_inqty=Double.parseDouble(rs.getString("IN_QTY")) + sum_inqty;
sum_outqty=Double.parseDouble(rs.getString("OUT_QTY")) + sum_outqty;
flag++;
		}
	}
} 
if(chk_grand==true){

	sb.append("<tr style='background-color: #b5fdfd'><td><strong>Grand Total </strong> </td><td align='right'>"+ sum_inqty +"</td><td align='right'>"+ sum_outqty +"</td></tr>");
}	
			sb.append("</table><b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
			"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
			"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
			"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
			"</font></p>");
		 
			msg.setContent(sb.toString(), "text/html");
			
			if(chk_flag==true){
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
