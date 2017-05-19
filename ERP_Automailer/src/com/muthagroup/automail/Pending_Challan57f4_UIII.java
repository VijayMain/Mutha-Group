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

public class Pending_Challan57f4_UIII extends TimerTask {

	@Override
	public void run() {
		try{
			System.out.println("ERP 57f4 Pending Approval UIII !!!");
			
			Date d = new Date(); 
			Date datesq = new Date();
			int day = datesq.getDate(); 
			
			if (day==1 && d.getHours() == 8 && d.getMinutes() == 16) {
				
				Connection conLocal = ConnectionUrl.getLocalDatabase();
				
				SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.DATE, -30);  
				String nowDate = sdfFIrstDate.format(cal.getTime());
				
				/*System.out.println("Date K1 = " + nowDate);*/
				
				DecimalFormat twoDForm = new DecimalFormat("###,##0.00");
				
				String CurrentDate = nowDate.substring(6,8) +"/"+ nowDate.substring(4,6) +"/"+ nowDate.substring(0,4);
			 	
			boolean sent=false;
			String host = "send.one.com";
			String user = "itsupports@muthagroup.com";
			String pass = "itsupports@xyz";
	 		String from = "itsupports@muthagroup.com";
			String subject = "57F4 challans pending for over 30 days of MEPL UNIT III";
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// *********************************************************************************************
			ArrayList to_emails = new ArrayList();
			PreparedStatement ps_rec = conLocal.prepareStatement("select * from pending_approvee where type='to' and report='Pending_Challan57f4_UIII'");
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
			sb.append("<b style='color: #0D265E;'>This is an automatically generated email for ERP - Pending Challan 57f4 List of MEPL UNIT III</b>");
			sb.append("<table border='1' width='97%' style='font-family: Arial;'><tr style='font-size: 12px;background-color:#94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+
			"<th height='24'>Challan No</th>"+
			"<th>Challan DATE</th>"+
			"<th>WO NO</th>"+
			"<th>Supplier</th>"+
			"<th>Item Name</th>"+
			"<th>Bal Qty</th>"+
			"<th>Rate</th>"+
			"</tr>");
			/*____________________________________________ MEPL UNIT III __________________________________________*/
 
			String comp = "106";
			Connection con_K1 = ConnectionUrl.getK1ERPConnection();
			ArrayList codes = new ArrayList();
			 PreparedStatement ps=con_K1.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='12'");
			 ResultSet rs3=ps.executeQuery();
			 while(rs3.next()){
				  codes.add(rs3.getString("SUB_GLACNO"));
			 }
			  PreparedStatement ps_local = null,ps_localmax = null,ps_localPrev = null; 
			  ResultSet rs_localmax=null,rs_localPrev=null;
			  int ct=0;
			  for(int i=0;i<codes.size();i++){
				  if(i==0){
			  ps_local = conLocal.prepareStatement("insert into purchase_overdues_tbl(value,enable)values(?,?)");
			  ps_local.setString(1, codes.get(i).toString());
			  ps_local.setInt(2, 1);
			  ps_local.executeUpdate();
				  }else{
					  ps_localmax = conLocal.prepareStatement("select max(overdue_id) from purchase_overdues_tbl");
					  rs_localmax = ps_localmax.executeQuery();
					  while (rs_localmax.next()) {
						 ct = rs_localmax.getInt("max(overdue_id)");
					  }
					  ps_localPrev = conLocal.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
					  rs_localPrev=ps_localPrev.executeQuery();
					  while (rs_localPrev.next()) { 	  
					  ps_local = conLocal.prepareStatement("update purchase_overdues_tbl set value=? where overdue_id="+ct);
					  ps_local.setString(1, rs_localPrev.getString("value") + codes.get(i).toString()); 
					  ps_local.executeUpdate();
					}
				}
			}
			/*
				Pending challan 57f4
				exec "ENGERP"."dbo"."Sel_RptPendingChlnState";1 '101', '20170506', '21341,2136,2137,21310,2138','101122701101123768101120010101120013101122665101120020101122301101120043101120050101120051101123240101124490101121443101120069101120070101121562101123523101122050101120099101120111101123681101120118101121798101122471101120136101120146101123952101122804101120172101123203101122256101120185101121771101121718101123096101120192101122246101123557101120203101122598101120207101120219101121381101120228101124334101121721101120238101122434101121584101123541101120257101122629101123599101122318101123342101123429101120303101120307101120324101122128101124828101121719101122196101122114101120354101122977101122315101120380101120386101120402101120404101122197101122526101123335101120421101122738101120428101123531101120429101120431101121486101120440101120441101121974101124008101121388101120466101120469101120470101120472101120478101120487101122292101122707101120520101120525101123744101123537101121782101122388101123248101121536101120551101121738101120553101120556101123450101123590101120583101124649101120589101120592101122545101120609101123723101120616101123846101120643101122002101124452101123158101120646101124915101120647101120648101123098101120657101120669101123634101120679101123026101120684101123219101122680101122072101120697101125097101120738101120743101120744101120745101122106101122766101122603101120780101120789101122590101123214101120804101121622101120816101122673101124085101121561101120856101121924101122687101120887101122765101122322101122684101122854101121061101120929101122626101124214101120947101122112101122416101120966101120979101121744101122561101121007101122421101121024101122715101124414101122891101122617101121979101121048101121596101123400101121059101121063101121062101121067101121074101121087101121088101123530101123205101122859101121720101121131101121135101123451101121942101122270101124062101123584101121175101123418101122971101121195101122706101121220101121606101121777101122622101121251101123247101121266101121272101121274101121290101121288101122667101122538101121322101122206101124424101121350101122396101121994'
				select * from MSTACCTGLSUB where SUB_GLCODE =12
			*/
			CallableStatement cs = con_K1.prepareCall("{call Sel_RptPendingChlnState(?,?,?,?)}");
			cs.setString(1, comp);
			cs.setString(2, nowDate);
			cs.setString(3, "21341,2136,2137,21310,2138");
			ps_localPrev = conLocal.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
			rs_localPrev=ps_localPrev.executeQuery();
			while (rs_localPrev.next()) {
			cs.setString (4,rs_localPrev.getString("value"));
			}
			ResultSet rs = cs.executeQuery();
			while (rs.next()) {
			sb.append("<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;'>"+
			"<td align='right'>"+rs.getString("TRNNO")+"</td>"+
			"<td>"+rs.getString("TRAN_DATE")+"</td>"+
			"<td>&nbsp;"+rs.getString("WO_NO")+"</td>"+
			"<td>"+rs.getString("AC_NAME")+"</td>"+
			"<td>"+rs.getString("MAT_NAME")+"</td>"+
			"<td align='right'>"+rs.getString("BAL_QTY")+"</td>"+
			"<td align='right'>"+rs.getString("RATE")+"</td>"+
			"</tr>");
			sent = true;
			}
			con_K1.close();
			
			
            sb.append("</table><p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara </p><hr><p>"+
			"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
			"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
			"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
			"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
			"</font></p>");
		 
			msg.setContent(sb.toString(), "text/html");
	 
			if(sent==true){
			Transport transport = mailSession.getTransport("smtp");
			transport.connect(host, user, pass);
			transport.sendMessage(msg, msg.getAllRecipients());
			transport.close();
			System.out.println("msg Sent !!!");
			}
		conLocal.close();
	//	Thread.sleep(60000);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
