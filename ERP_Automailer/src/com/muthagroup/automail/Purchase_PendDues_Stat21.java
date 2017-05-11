package com.muthagroup.automail;
 
import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; 
import java.text.SimpleDateFormat;
import java.util.ArrayList;  
import java.util.Date; 
import java.util.Properties;
import java.util.TimerTask;  

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage; 
import javax.mail.internet.MimeMultipart;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import com.muthagroup.connectionERPUtil.ConnectionUrl;

public class Purchase_PendDues_Stat21 extends TimerTask {

	@Override
	public void run() {
		Date d = new Date();
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday" };
		ArrayList rem = new ArrayList();
		if (!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 15 && d.getMinutes() == 30) {
		
		try {
			String comp = "101";
			
			SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
			Date tdate = new Date();
			String nowDate = sdfFIrstDate.format(tdate);
			
			Connection con = ConnectionUrl.getMEPLH21ERP();
			PreparedStatement ps_category=null;
			ResultSet rs_category=null;
			
			ArrayList codes = new ArrayList();
			 PreparedStatement ps=con.prepareStatement("select * from ENGERP..MSTACCTGLSUB where SUB_GLCODE='12'");
			  ResultSet rs3=ps.executeQuery();
			  while(rs3.next()){
				  codes.add(rs3.getString("SUB_GLACNO"));
			  }
			  ArrayList removecode=new ArrayList();
			  rem.add("101120645");
			  rem.add("101120648");
			  rem.add("101122002");
			  rem.add("101123158");
			  rem.add("101120238");
			  rem.add("101120645");
			  rem.add("101120646");
			  rem.add("101121994");
			  rem.add("101123158");

			//  System.out.println("GL CODE = "  + codes);
			  codes.removeAll(rem);
			//  System.out.println("After Remove GL CODE = "  + codes);
			  
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
			  
			CallableStatement cs = con.prepareCall("{call Sel_OutstandingDetails(?,?,?,?,?,?)}");
			cs.setString(1, comp);
			cs.setString(2, "0");
			ps_localPrev = conLocal.prepareStatement("select * from purchase_overdues_tbl where overdue_id="+ct);
			rs_localPrev=ps_localPrev.executeQuery();
			while (rs_localPrev.next()) {
			cs.setString (3,rs_localPrev.getString("value"));
			}
			cs.setString(4, nowDate);
			cs.setString(5, "1");
			cs.setString(6, "1");
			
			
			//*************************************************************************************
			//*************************************************************************************
			//******************************* Excel Format *******************************************
			int row=2,col=0,sr=1;  
			String CompanyName="";   
			CompanyName = "MEPL H21"; 
			
			ArrayList alistFile = new ArrayList();
			File folder = new File("C:/reportxls");
			File[] listOfFiles = folder.listFiles();
			String listname = "";  
			
		 	int val = listOfFiles.length + 1; 
			
			File exlFile = new File("C:/reportxls/Automail"+val+".xls");
		    WritableWorkbook writableWorkbook = Workbook.createWorkbook(exlFile); 
		    WritableSheet writableSheet = writableWorkbook.createSheet("Sheet1", 0);
		    
		    Colour bckcolor = Colour.CORAL;
		    WritableFont font = new WritableFont(WritableFont.ARIAL);
		    font.setColour(Colour.BLACK); 
		    
		    WritableFont fontbold = new WritableFont(WritableFont.ARIAL);
		    fontbold.setColour(Colour.BLACK);
		    fontbold.setBoldStyle(WritableFont.BOLD);
		    
		    WritableCellFormat cellFormat = new WritableCellFormat();
		    cellFormat.setBackground(bckcolor);
		    cellFormat.setAlignment(Alignment.CENTRE);
		    cellFormat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK); 
		    cellFormat.setFont(fontbold); 
		    
		    writableSheet.setColumnView(0, 10);
		    writableSheet.setColumnView(1, 40);
		    writableSheet.setColumnView(2, 15);
		    writableSheet.setColumnView(3, 15);
		    writableSheet.setColumnView(4, 15);
		    writableSheet.setColumnView(5, 15);
		    writableSheet.setColumnView(6, 15);
		    writableSheet.setColumnView(7, 15);
		    writableSheet.setColumnView(8, 15);
		    writableSheet.setColumnView(9, 15);
		    writableSheet.setColumnView(10, 22);
		    
		    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
		    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
		    font.setColour(Colour.BLACK); 
		    cellRIghtformat.setFont(font);
		    cellRIghtformat.setAlignment(Alignment.RIGHT);
		    
		    WritableCellFormat cellleftformat = new WritableCellFormat(); 
		    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
		    font.setColour(Colour.BLACK); 
		    cellleftformat.setFont(font); 				
		    cellleftformat.setAlignment(Alignment.LEFT);
		        
		    writableSheet.mergeCells(0, 0, 10, 0);
		    Label labelName = new Label(0, 0,  "Overdue Vendor Payment of "+CompanyName,cellFormat);
		    writableSheet.addCell(labelName);
		    
		    Label label = new Label(0, 1, "Sr.No",cellFormat);
		    Label label1 = new Label(1, 1, "Supplier Name",cellFormat);
		    Label label2 = new Label(2, 1, "ERP Tran No",cellFormat);
		    Label label3 = new Label(3, 1, "ERP TRAN DATE",cellFormat);
		    Label label4 = new Label(4, 1, "Party Bill No",cellFormat);
		    Label label5 = new Label(5, 1, "Party Bill Date",cellFormat);
		    Label label6 = new Label(6, 1, "CREDIT_DAYS",cellFormat);
		    Label label7 = new Label(7, 1, "Due Date",cellFormat);
		    Label label8 = new Label(8, 1, "Overdue Days",cellFormat);
		    Label label9 = new Label(9, 1, "Amount",cellFormat);
		    Label label10 = new Label(10, 1, "Category",cellFormat);

		  // Add the created Cells to the sheet
		    writableSheet.addCell(label);
		    writableSheet.addCell(label1);
		    writableSheet.addCell(label2);
		    writableSheet.addCell(label3);
		    writableSheet.addCell(label4);
		    writableSheet.addCell(label5);
		    writableSheet.addCell(label6);
		    writableSheet.addCell(label7);
		    writableSheet.addCell(label8);
		    writableSheet.addCell(label9);
		    writableSheet.addCell(label10);
		  	//***********************************************************************************************************************************
		    //***********************************************************************************************************************************
		     
		    ResultSet rs = cs.executeQuery();		
		    while(rs.next()){
		    	if(!rs.getString("TRAN_TYPE").equalsIgnoreCase("103")){
		    		jxl.write.Number nolbl = new jxl.write.Number(col, row, sr,cellRIghtformat);
				    writableSheet.addCell(nolbl); 
				    col++;
				    sr++;		    
		    			Label lab1 = new Label(col, row, rs.getString("SUBGL_NAME"),cellleftformat);
		 			    writableSheet.addCell(lab1); 
		 			    col++;
		 			   jxl.write.Number lab2 = new jxl.write.Number(col, row, Integer.parseInt(rs.getString("REF_TRANNO")),cellRIghtformat);
					    writableSheet.addCell(lab2); 
					    col++;
					    Label lab3 = new Label(col, row, rs.getString("PRN_TRANDATE"),cellRIghtformat);
		 			    writableSheet.addCell(lab3); 
		 			    col++;
		 			   Label lab4 = new Label(col, row, rs.getString("EXT_REFNO"),cellRIghtformat);
					    writableSheet.addCell(lab4); 
					    col++; 
					    Label lab5 = new Label(col, row, rs.getString("PRN_EXTREFDATE"),cellRIghtformat);
		 			    writableSheet.addCell(lab5); 
		 			    col++;
		 			   Label lab6 = new Label(col, row, rs.getString("CREDIT_DAYS"),cellRIghtformat);
					    writableSheet.addCell(lab6); 
					    col++;
					    Label lab7 = new Label(col, row, rs.getString("PRN_DUEDATE"),cellRIghtformat);
		 			    writableSheet.addCell(lab7); 
		 			    col++;
		 			     
		 			  
		 			   jxl.write.Number lab8 = new jxl.write.Number(col, row,Integer.parseInt(rs.getString("DUE_DAYS")) ,cellRIghtformat);
					    writableSheet.addCell(lab8);
					    col++;
					    Label lab9 = new Label(col, row, rs.getString("AMOUNT"),cellRIghtformat);
					    writableSheet.addCell(lab9);
					    col++;
					    ps_category = con.prepareStatement("select * from ENGERP..MSTMATCATAG  where CODE='"+rs.getString("CATEGOARY")+"'");
					    rs_category = ps_category.executeQuery();
					    while(rs_category.next()){
					    Label lab10 = new Label(col, row, rs_category.getString("NAME"),cellRIghtformat);
					    writableSheet.addCell(lab10);
					    }
					    
					    if(col==10){
					    	col=0;
					    	row++;
					    }
		    	}	
		    }	 
		    
		  		// Write and close the workbook
		    	writableWorkbook.write();
		    	writableWorkbook.close();
			//*************************************************************************************
			//*************************************************************************************
		    	ResultSet rs123 = cs.executeQuery();		
			if (rs123.isBeforeFirst()) {				
			//************************************************************************************
	    	//************************************************************************************
				
		System.out.println("Email ERP Automailer.....");
		String host = "send.one.com";
		String user = "itsupports@muthagroup.com";
		String pass = "itsupports@xyz"; 
 		String from = "itsupports@muthagroup.com";
		String subject = "Payment due date exceeded for "+CompanyName+" !!!"; 
		boolean sessionDebug = false;
		// *********************************************************************************************
		// multiple recipients : == >
		// ********************************************************************************************* 
		String recipients[] = {"meplaccounts@muthagroup.com"};
		String cc_recipients[] = {"nileshss@muthagroup.com","internalaudit@muthagroup.com","kunalvm@muthagroup.com","ankatariya@muthagroup.com","mahesh@muthagroup.com"}; 

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
		sb.append("<p style='font-size: 12px;'>*** This is an automatically generated alert email for Over due vendor payment of MEPL H21 !!! ***</p>");
		 
		sb.append("<p style='font-size: 13px;'>Please find below attachment for Overdue Vendor Payment of MEPL H21.</p>");
		
		sb.append("<p><b style='color: #330B73; font-family: Arial;'>Thanks & Regards </b>"+
		"</P><p style='font-family: Arial;'>IT | Software Development | Mutha Group Satara</p><hr><p><b style='font-family: Arial;'>Disclaimer :</b></p><p>");
		
			sb.append("<font face='Arial' size='1'> <b style='color: #49454F;'>The information transmitted, including attachments, is intended only for"+
					"the person(s) or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission,"+
					"dissemination or other use of, or taking of any action in reliance upon this information by persons or entities other than the intended"+
					"recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b></font></p>");
	 	
		BodyPart messageBodyPart = new MimeBodyPart();
		messageBodyPart.setContent(sb.toString(),"Text/html");
		// Create a multipar message
		Multipart multipart = new MimeMultipart();

		// Set text message part
		multipart.addBodyPart(messageBodyPart);

		// Part two is attachment
		messageBodyPart = new MimeBodyPart();
		
		
		String filename = "C:/reportxls/Automail"+val+".xls";
		
		DataSource source = new FileDataSource(filename);
		messageBodyPart.setDataHandler(new DataHandler(source));
		messageBodyPart.setFileName(filename);
		multipart.addBodyPart(messageBodyPart);

		// Send the complete message parts
		msg.setContent(multipart);
		
		Transport transport = mailSession.getTransport("smtp");
		transport.connect(host, user, pass);
		transport.sendMessage(msg, msg.getAllRecipients());
		// ******************************************************************************
		transport.close(); 
		System.out.println("MEPL H21 Loop End");		
		}
			con.close();
	} catch (Exception e) {
	 e.printStackTrace();
	}   
		} 
		System.out.println("Purchase Due 16 !!!");
		}  
	}
