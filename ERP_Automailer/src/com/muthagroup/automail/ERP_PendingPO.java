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

public class ERP_PendingPO extends TimerTask {

	@Override
	public void run() {
		try {
			System.out.println("ERP Pending PO");
			Date d = new Date();
			String weekday[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
			
			/*if (weekday[d.getDay()].equals("Monday") && d.getHours() == 9 && d.getMinutes() == 33) {*/
				if (weekday[d.getDay()].equals("Monday") && d.getHours() == 15 && d.getMinutes() == 5) {
			boolean flag=false;
			String comp="";
			SimpleDateFormat formatView = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat formatsql = new SimpleDateFormat("yyyyMMdd");
			Calendar aCalendar = Calendar.getInstance();			
			//		Set DATE to 1, So first date of previous month.			
			aCalendar.set(Calendar.DATE, 1);
			Date firstDateOfPreviousMonth = aCalendar.getTime();
			aCalendar.set(Calendar.DATE,aCalendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			String from_date = formatsql.format(firstDateOfPreviousMonth);
			String dateFrom = formatView.format(firstDateOfPreviousMonth);
			
			// Date lastDateOfPreviousMonth = aCalendar.getTime();
			// String to_date = formatsql.format(lastDateOfPreviousMonth); 
			// String dateTo = formatView.format(lastDateOfPreviousMonth); 
			//	System.out.println("From Date : " + from_date + " To Date : " + to_date + " from =" +dateFrom+ " to = " + dateTo);

			String to_date = formatsql.format(d);
			String dateTo = formatView.format(d); 
			
			String host = "send.one.com";
			String user = "erp@muthagroup.com";
			String pass = "erp@xyz";
	 		String from = "erp@muthagroup.com";
			String subject = "ERP Pending PO from " + dateFrom + " to " + dateTo;
			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// ********************************************************************************************* 
			ArrayList listemailTo = new ArrayList();
			String report = "ERP_PendingPO";
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
			// exec "ENGERP"."dbo"."Sel_RptSupplierPendingPoStat";1 '101', '0', '20170601', '20170615', '101120013101120020101120022101120024101122301101124846101120035101120037101120040101123523101122003101125197101125045101124848101120095101124706101124486101123952101123096101120234101120238101124911101120267101122629101124943101120275101122829101122593101124828101121808101120390101120391101120401101120402101122526101121417101121405101120458101125246101124649101124687101120616101122943101125192101120630101123158101120646101121586101122671101120684101124771101124739101122980101120724101120730101125122101124595101122716101124731101123125101120770101120780101122590101125180101120804101120823101120827101123820101120838101122387101120859101124672101120863101122932101125125101122765101122626101120944101124707101124837101121602101120995101125074101124777101121048101121596101124718101122153101123874101121100101122702101121110101121116101121130101122698101122792101121186101121185101121195101122260101121231101121544101121261101124322101124705101121334101121340101122140101123057101121370101122927'
			// select * from MSTACCTGLSUB where SUB_GLCODE =12
			sb.append("<b style='color: #0D265E;font-size: 10px;'>This is an automatically generated email for ERP Pending PO from " + dateFrom + " to " + dateTo + " !!!</b>");
			sb.append("<table border='1' style='font-size: 12px; color: #333333; width: 99%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;'>"+
									"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"+
									"<th scope='col'>ORDER NO</th><th scope='col'>PO DATE</th><th scope='col'>SUPPLIER</th>"+
									"<th scope='col'>MATERIAL</th><th scope='col'>EXT REF</th><th scope='col'>ORDER QTY</th>"+
									"<th scope='col'>ORDER AMOUNT</th><th scope='col'>ORDER RATE</th><th scope='col'>RECV QTY</th><th scope='col'>RECV AMT</th>"+
									"<th scope='col'>PUR PO NO</th><th scope='col'>PENDING QTY</th><th scope='col'>PEND QTY</th><th scope='col'>VALUE AMT</th></tr>");
	/***********************************************************************************************************************************************/		
	sb.append("<tr style='font-size: 12px; background-color: #ffc082; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;height: 25px;'>"
			+ "<td colspan='14'><b>MEPL H21 ==> </b></td></tr>");
	
	Connection con_erp = ConnectionUrl.getMEPLH21ERP();
	ArrayList codes = new ArrayList();
	 PreparedStatement ps=con_erp.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='12'");
	  ResultSet rs3=ps.executeQuery();
	  while(rs3.next()){
		  		  codes.add(rs3.getString("SUB_GLACNO"));
	  }
 	  Connection conLocal = ConnectionUrl.getLocalDatabase();
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
	  // exec "ENGERP"."dbo"."Sel_RptSupplierPendingPoStat";1 '101', '0', '20170601', '20170615', '101120013
	  comp = "101";
	  CallableStatement cs = con_erp.prepareCall("{call Sel_RptSupplierPendingPoStat(?,?,?,?,?)}");
		cs.setString(1, comp);
		cs.setString(2, "0");
		cs.setString(3, from_date);
		cs.setString(4, to_date);
		ps_localPrev = conLocal.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
		rs_localPrev=ps_localPrev.executeQuery();
		while (rs_localPrev.next()) {
		cs.setString (5,rs_localPrev.getString("value"));
		}
		ResultSet rs = cs.executeQuery();
	    while(rs.next()){
	    	flag_avail=true;
	    	sb.append("<tr><td align='right'>"+rs.getString("ORDER_NO")+"</td>"+
	    						"<td>"+rs.getString("PRN_PODATE")+"</td>"+
	    						"<td>"+rs.getString("SUP_NAME")+"</td>"+
	    						"<td>"+rs.getString("MAT_NAME")+"</td>"+
	    						"<td>"+rs.getString("EXT_REFNO")+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_QTY")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_AMOUNT")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_RATE")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("RECV_QTY")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("RECV_AMT")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PURPO_NO")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PENDING_QTY")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PEND_QTY")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("VALUE_AMT")))+"</td></tr>");
	    }
	/*********************************************************************************************************/ 		
		sb.append("<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"+
			"<th scope='col'>ORDER NO</th><th scope='col'>PO DATE</th><th scope='col'>SUPPLIER</th>"+
			"<th scope='col'>MATERIAL</th><th scope='col'>EXT REF</th><th scope='col'>ORDER QTY</th>"+
			"<th scope='col'>ORDER AMOUNT</th><th scope='col'>ORDER RATE</th><th scope='col'>RECV QTY</th><th scope='col'>RECV AMT</th>"+
			"<th scope='col'>PUR PO NO</th><th scope='col'>PENDING QTY</th><th scope='col'>PEND QTY</th><th scope='col'>VALUE AMT</th></tr><tr style='font-size: 12px; background-color: #ffc082; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;height: 25px;'>"
		+ "<td colspan='14'><b>MEPL H25 ==></b></td></tr>");
		
		con_erp = ConnectionUrl.getMEPLH25ERP();
		codes.clear();
		ps=con_erp.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='12'");
		rs3=ps.executeQuery();
		while(rs3.next()){
			  codes.add(rs3.getString("SUB_GLACNO"));
		}
	 	conLocal = ConnectionUrl.getLocalDatabase();	  
		ps_local = null;
		ps_localmax = null;
		ps_localPrev = null; 
		rs_localmax=null;
		rs_localPrev=null;
		ct=0;
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
		  // exec "H25ERP"."dbo"."Sel_RptSupplierPendingPoStat";1 '102', '0', '20170601', '20170615', '101120013
		  comp = "102";
		  cs = con_erp.prepareCall("{call Sel_RptSupplierPendingPoStat(?,?,?,?,?)}");
			cs.setString(1, comp);
			cs.setString(2, "0");
			cs.setString(3, from_date);
			cs.setString(4, to_date);
			ps_localPrev = conLocal.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
			rs_localPrev=ps_localPrev.executeQuery();
			while (rs_localPrev.next()) {
			cs.setString (5,rs_localPrev.getString("value"));
			}
			rs = cs.executeQuery();		
		    while(rs.next()){ 	    	
		    	flag_avail=true;
		    	sb.append("<tr><td align='right'>"+rs.getString("ORDER_NO")+"</td>"+
						"<td>"+rs.getString("PRN_PODATE")+"</td>"+
						"<td>"+rs.getString("SUP_NAME")+"</td>"+
						"<td>"+rs.getString("MAT_NAME")+"</td>"+
						"<td>"+rs.getString("EXT_REFNO")+"</td>"+
						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_QTY")))+"</td>"+
						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_AMOUNT")))+"</td>"+
						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_RATE")))+"</td>"+
						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("RECV_QTY")))+"</td>"+
						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("RECV_AMT")))+"</td>"+
						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PURPO_NO")))+"</td>"+
						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PENDING_QTY")))+"</td>"+
						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PEND_QTY")))+"</td>"+
						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("VALUE_AMT")))+"</td></tr>");
		    }
	/*********************************************************************************************************/
		    sb.append("<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"+
					"<th scope='col'>ORDER NO</th><th scope='col'>PO DATE</th><th scope='col'>SUPPLIER</th>"+
					"<th scope='col'>MATERIAL</th><th scope='col'>EXT REF</th><th scope='col'>ORDER QTY</th>"+
					"<th scope='col'>ORDER AMOUNT</th><th scope='col'>ORDER RATE</th><th scope='col'>RECV QTY</th><th scope='col'>RECV AMT</th>"+
					"<th scope='col'>PUR PO NO</th><th scope='col'>PENDING QTY</th><th scope='col'>PEND QTY</th><th scope='col'>VALUE AMT</th></tr><tr style='font-size: 12px; background-color: #ffc082; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;height: 25px;'>"
					+ "<td colspan='14'><b>MFPL ==></b></td></tr>");
			
			con_erp = ConnectionUrl.getFoundryERPNEWConnection();
			codes.clear();
			ps=con_erp.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='12'");
			rs3=ps.executeQuery();
			while(rs3.next()){
				  codes.add(rs3.getString("SUB_GLACNO"));
			}
		 	conLocal = ConnectionUrl.getLocalDatabase();	  
			ps_local = null;
			ps_localmax = null;
			ps_localPrev = null; 
			rs_localmax=null;
			rs_localPrev=null;
			ct=0;
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
			  // exec "FOUNDRYERP"."dbo"."Sel_RptSupplierPendingPoStat";1 '103', '0', '20170601', '20170615', '101120013
			  comp = "103";
			  cs = con_erp.prepareCall("{call Sel_RptSupplierPendingPoStat(?,?,?,?,?)}");
				cs.setString(1, comp);
				cs.setString(2, "0");
				cs.setString(3, from_date);
				cs.setString(4, to_date);
				ps_localPrev = conLocal.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
				rs_localPrev=ps_localPrev.executeQuery();
				while (rs_localPrev.next()) {
				cs.setString (5,rs_localPrev.getString("value"));
				}
				rs = cs.executeQuery();		
			    while(rs.next()){ 	    	
			    	flag_avail=true;
			    	sb.append("<tr><td align='right'>"+rs.getString("ORDER_NO")+"</td>"+
    						"<td>"+rs.getString("PRN_PODATE")+"</td>"+
    						"<td>"+rs.getString("SUP_NAME")+"</td>"+
    						"<td>"+rs.getString("MAT_NAME")+"</td>"+
    						"<td>"+rs.getString("EXT_REFNO")+"</td>"+
    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_QTY")))+"</td>"+
    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_AMOUNT")))+"</td>"+
    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_RATE")))+"</td>"+
    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("RECV_QTY")))+"</td>"+
    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("RECV_AMT")))+"</td>"+
    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PURPO_NO")))+"</td>"+
    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PENDING_QTY")))+"</td>"+
    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PEND_QTY")))+"</td>"+
    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("VALUE_AMT")))+"</td></tr>");
			    }
	/*********************************************************************************************************/
			    sb.append("<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"+
						"<th scope='col'>ORDER NO</th><th scope='col'>PO DATE</th><th scope='col'>SUPPLIER</th>"+
						"<th scope='col'>MATERIAL</th><th scope='col'>EXT REF</th><th scope='col'>ORDER QTY</th>"+
						"<th scope='col'>ORDER AMOUNT</th><th scope='col'>ORDER RATE</th><th scope='col'>RECV QTY</th><th scope='col'>RECV AMT</th>"+
						"<th scope='col'>PUR PO NO</th><th scope='col'>PENDING QTY</th><th scope='col'>PEND QTY</th><th scope='col'>VALUE AMT</th></tr><tr style='font-size: 12px; background-color: #ffc082; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;height: 25px;'>"
						+ "<td colspan='14'><b>MEPL UIII ==></b></td></tr>");
				con_erp = ConnectionUrl.getK1ERPConnection();
				codes.clear();
				ps=con_erp.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='12'");
				rs3=ps.executeQuery();
				while(rs3.next()){
					  codes.add(rs3.getString("SUB_GLACNO"));
				}
			 	conLocal = ConnectionUrl.getLocalDatabase();
				ps_local = null;
				ps_localmax = null;
				ps_localPrev = null;
				rs_localmax=null;
				rs_localPrev=null;
				ct=0;
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
				  // exec "FOUNDRYERP"."dbo"."Sel_RptSupplierPendingPoStat";1 '106', '0', '20170601', '20170615', '101120013
				  comp = "106";
				  cs = con_erp.prepareCall("{call Sel_RptSupplierPendingPoStat(?,?,?,?,?)}");
					cs.setString(1, comp);
					cs.setString(2, "0");
					cs.setString(3, from_date);
					cs.setString(4, to_date);
					ps_localPrev = conLocal.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
					rs_localPrev=ps_localPrev.executeQuery();
					while (rs_localPrev.next()) {
					cs.setString (5,rs_localPrev.getString("value"));
					}
					rs = cs.executeQuery();		
				    while(rs.next()){ 	    	
				    	flag_avail=true;
				    	sb.append("<tr><td align='right'>"+rs.getString("ORDER_NO")+"</td>"+
	    						"<td>"+rs.getString("PRN_PODATE")+"</td>"+
	    						"<td>"+rs.getString("SUP_NAME")+"</td>"+
	    						"<td>"+rs.getString("MAT_NAME")+"</td>"+
	    						"<td>"+rs.getString("EXT_REFNO")+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_QTY")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_AMOUNT")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_RATE")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("RECV_QTY")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("RECV_AMT")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PURPO_NO")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PENDING_QTY")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PEND_QTY")))+"</td>"+
	    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("VALUE_AMT")))+"</td></tr>");
				    }
	/*********************************************************************************************************/
				    sb.append("<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;height: 25px;'>"+
							"<th scope='col'>ORDER NO</th><th scope='col'>PO DATE</th><th scope='col'>SUPPLIER</th>"+
							"<th scope='col'>MATERIAL</th><th scope='col'>EXT REF</th><th scope='col'>ORDER QTY</th>"+
							"<th scope='col'>ORDER AMOUNT</th><th scope='col'>ORDER RATE</th><th scope='col'>RECV QTY</th><th scope='col'>RECV AMT</th>"+
							"<th scope='col'>PUR PO NO</th><th scope='col'>PENDING QTY</th><th scope='col'>PEND QTY</th><th scope='col'>VALUE AMT</th></tr><tr style='font-size: 12px; background-color: #ffc082; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;height: 25px;'>"
							+ "<td colspan='14'><b>DI ==></b></td></tr>");
					con_erp = ConnectionUrl.getDIERPConnection();
					codes.clear();
					ps=con_erp.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='12'");
					rs3=ps.executeQuery();
					while(rs3.next()){
						  codes.add(rs3.getString("SUB_GLACNO"));
					}
				 	conLocal = ConnectionUrl.getLocalDatabase();
					ps_local = null;
					ps_localmax = null;
					ps_localPrev = null;
					rs_localmax=null;
					rs_localPrev=null;
					ct=0;
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
					  // exec "DIERP"."dbo"."Sel_RptSupplierPendingPoStat";1 '105', '0', '20170601', '20170615', '101120013
					  comp = "105";
					  cs = con_erp.prepareCall("{call Sel_RptSupplierPendingPoStat(?,?,?,?,?)}");
						cs.setString(1, comp);
						cs.setString(2, "0");
						cs.setString(3, from_date);
						cs.setString(4, to_date);
						ps_localPrev = conLocal.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
						rs_localPrev=ps_localPrev.executeQuery();
						while (rs_localPrev.next()) {
						cs.setString (5,rs_localPrev.getString("value"));
						}
						rs = cs.executeQuery();
					    while(rs.next()){
					    	flag_avail=true;
					    	sb.append("<tr><td align='right'>"+rs.getString("ORDER_NO")+"</td>"+
		    						"<td>"+rs.getString("PRN_PODATE")+"</td>"+
		    						"<td>"+rs.getString("SUP_NAME")+"</td>"+
		    						"<td>"+rs.getString("MAT_NAME")+"</td>"+
		    						"<td>"+rs.getString("EXT_REFNO")+"</td>"+
		    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_QTY")))+"</td>"+
		    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_AMOUNT")))+"</td>"+
		    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("ORDER_RATE")))+"</td>"+
		    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("RECV_QTY")))+"</td>"+
		    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("RECV_AMT")))+"</td>"+
		    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PURPO_NO")))+"</td>"+
		    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PENDING_QTY")))+"</td>"+
		    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("PEND_QTY")))+"</td>"+
		    						"<td align='right'>"+Math.round(Double.valueOf(rs.getString("VALUE_AMT")))+"</td></tr>");
					    }
    /***********************************************************************************************************/ 
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
			ps_localPrev = conLocal.prepareStatement("delete from erp_database.purchase_overdues_tbl");
			int del = ps_localPrev.executeUpdate();
			}
			System.out.println("ERP Pending PO");
			con.close();
			Thread.sleep(60000);
			}
		} catch (Exception e) {
		 e.printStackTrace();
		}
	}
}