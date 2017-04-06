package com.muthagroup.automail;

import java.io.File;
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
import jxl.format.Colour; 
import jxl.write.Alignment;
import jxl.write.Border;
import jxl.write.BorderLineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import com.muthagroup.connectionERPUtil.ConnectionUrl;

public class TvsMotorsH21 extends TimerTask {
	@Override
	public void run() {
		try {
			//-------------------------------------------------------- Date Logic ---------------------------------------------------------
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
			/*ArrayList rem = new ArrayList();*/ 
			if (d.getHours() == 12 && d.getMinutes() == 48) {
				System.out.println("Automail loop Start");
			Connection con = ConnectionUrl.getLocalDatabase();
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd"); 
			boolean flag=false;
			Date tdate = new Date(); 
			String nowDate = sdfFIrstDate.format(tdate);
			
			String CurrentDate = nowDate.substring(6,8) +"/"+ nowDate.substring(4,6) +"/"+ nowDate.substring(0,4);
			
			System.out.println("ERP TVS  Summary Starts !!! " + CurrentDate);
			
				String host = "send.one.com";
				String user = "itsupports@muthagroup.com";
				String pass = "itsupports@xyz";
		 		String from = "itsupports@muthagroup.com";
				String subject = "TVS Dispatch Report dated " + CurrentDate;
				boolean sessionDebug = false;
				// *********************************************************************************************
				// multiple recipients : == >
				// *********************************************************************************************
				ArrayList listemailTo = new ArrayList();
				/*ArrayList listemailCc = new ArrayList();*/
				String report = "TVS_DispatchReport";
				PreparedStatement psauto = con.prepareStatement("select * from pending_approvee where report='"+report+"'");
				ResultSet rsauto = psauto.executeQuery();
				while (rsauto.next()) { 
						listemailTo.add(rsauto.getString("email"));
				}
				
				String recipients[] = new String[listemailTo.size()];  
				
				for(int i=0;i<listemailTo.size();i++){
					recipients[i] = listemailTo.get(i).toString();
				} 
				// *********************************************************************************************
				 

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
				
				//*******************************************************************************************************************************
				//*********************************************** Excel Logic To Create Report **************************************************
				Connection con_erp = ConnectionUrl.getFoundryERPNEWConnection();   
				String comp = "103";
				DecimalFormat twoDForm = new DecimalFormat("###0.##"); 
				int ct=0;  
				ArrayList alistFile = new ArrayList();
				File folder = new File("C:/reportxls");
				File[] listOfFiles = folder.listFiles();
				String listname = ""; 
			 	int val = listOfFiles.length + 1; 
				File exlFile = new File("C:/reportxls/" + val + "TVS_Dispatch"+".xls");
			    WritableWorkbook writableWorkbook = Workbook.createWorkbook(exlFile); 
			    WritableSheet writableSheet = writableWorkbook.createSheet("TVS Sale", 0);
			    
			    Colour bckcolor = Colour.LIGHT_ORANGE;
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
			    
			    writableSheet.setColumnView(0, 6);
			    writableSheet.setColumnView(1, 15);
			    writableSheet.setColumnView(2, 15);
			    writableSheet.setColumnView(3, 38);
			    writableSheet.setColumnView(4, 15);
			    writableSheet.setColumnView(5, 15);
			    writableSheet.setColumnView(6, 15);
			    writableSheet.setColumnView(7, 15);
			    writableSheet.setColumnView(8, 15);
			    writableSheet.setColumnView(9, 15);
			    writableSheet.setColumnView(10, 15);
			    writableSheet.setColumnView(11, 15);
			    writableSheet.setColumnView(12, 15); 
			    
			    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
			    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
			    font.setColour(Colour.BLACK); 
			    cellRIghtformat.setFont(font);
			    
			    WritableCellFormat cellleftformat = new WritableCellFormat(); 
			    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
			    font.setColour(Colour.BLACK); 
			    cellleftformat.setFont(font); 				
			        
			    Label label = new Label(0, 0, "Sr.No.",cellFormat);
			    Label label1 = new Label(1, 0, "Invoice No",cellFormat);
			    Label label2 = new Label(2, 0, "Invoice Date",cellFormat);
			    Label label3 = new Label(3, 0, "Part Name",cellFormat);
			    Label label4 = new Label(4, 0, "Sale Rate",cellFormat);
			    Label label5 = new Label(5, 0, "Qty",cellFormat); 
			    Label label6 = new Label(6, 0, "Packets",cellFormat); 
			    Label label7 = new Label(7, 0, "Weight",cellFormat); 
			    Label label8 = new Label(8, 0, "Total Weight",cellFormat); 
			    Label label9 = new Label(9, 0, "Basic Amount",cellFormat); 
			    Label label10 = new Label(10, 0, "Total Amount",cellFormat); 
			    Label label11 = new Label(11, 0, "Company",cellFormat); 
			    Label label12 = new Label(12, 0, "Vehicle No",cellFormat); 

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
			    writableSheet.addCell(label11);
			    writableSheet.addCell(label12);
			  	//***********************************************************************************************************************************
			    int cnt=1,row=0,col=1,srno=1;
			    double tot_wt =0;
				// exec "ENGERP"."dbo"."Sel_CustomerwiseDespatchmutha";1 '101', '0', '20170303', '20170403', '101110048', '115'
			 	CallableStatement cs11 = con_erp.prepareCall("{call Sel_CustomerwiseDespatchmutha(?,?,?,?,?,?)}");
				cs11.setString(1,comp);
				cs11.setString(2,"0");
				cs11.setString(3,"20170402");
				cs11.setString(4,nowDate);
				cs11.setString(5,"101110048");
				cs11.setString(6,"115");
				ResultSet rs1 = cs11.executeQuery();
			while(rs1.next()){
			jxl.write.Number sr_nolbl = new jxl.write.Number(row, col,srno ,cellRIghtformat);
			writableSheet.addCell(sr_nolbl);
			row++;
			Label invno_lbl = new Label(row, col, rs1.getString("INV_NO"), cellleftformat);
			writableSheet.addCell(invno_lbl);
			row++;
			Label invoicedate_lbl = new Label(row, col, rs1.getString("PRN_TRANDATE"), cellleftformat);
			writableSheet.addCell(invoicedate_lbl);
			row++;
			
			Label partName_lbl = new Label(row, col, rs1.getString("MAT_NAME"), cellleftformat);
			writableSheet.addCell(partName_lbl);
			row++;
			Label saleRate_lbl = new Label(row, col, rs1.getString("RATE"), cellleftformat);
			writableSheet.addCell(saleRate_lbl);
			row++;
			Label qty_lbl = new Label(row, col, rs1.getString("QTY"), cellleftformat);
			writableSheet.addCell(qty_lbl);
			row++;
			Label packets_lbl = new Label(row, col, rs1.getString("TOTAL_BOXES"), cellleftformat);
			writableSheet.addCell(packets_lbl);
			row++;
			Label weight_lbl = new Label(row, col, rs1.getString("WEIGHT"), cellleftformat);
			writableSheet.addCell(weight_lbl);
			row++;
			
			tot_wt =  Double.parseDouble(rs1.getString("WEIGHT")) * Double.parseDouble(rs1.getString("QTY"));
			
			Label totWeight_lbl = new Label(row, col, String.valueOf(tot_wt), cellleftformat);
			writableSheet.addCell(totWeight_lbl);
			row++; 
			Label itemAmt_lbl = new Label(row, col, rs1.getString("ITEM_AMOUNT"), cellleftformat);
			writableSheet.addCell(itemAmt_lbl);
			row++; 
			Label invAmt_lbl = new Label(row, col, rs1.getString("INV_AMOUNT"), cellleftformat);
			writableSheet.addCell(invAmt_lbl);
			row++;
			Label mfplSale_lbl = new Label(row, col, "MFPL Sale", cellleftformat);
			writableSheet.addCell(mfplSale_lbl);
			row++;
			Label vehicleNo_lbl = new Label(row, col, rs1.getString("VEHICLE_NO"), cellleftformat);
			writableSheet.addCell(vehicleNo_lbl);
			
			flag=true;
			
			srno ++;
			if(row==12){
			row=0;
			col++;
			}
		}
	
		//************************************************************************************************************************
			
			
			
			  //************************************************ File Output Ligic *****************************************************
			  //************************************************************************************************************************
			    //Write and close the workbook
			    writableWorkbook.write();
			    writableWorkbook.close();
				//*******************************************************************************************************************************
				
				StringBuilder sb = new StringBuilder();
				
				//*******************************************************************************************************************************
				sb.append("<p style='color: #0D265E; font-family: Arial; font-size: 11px;'>*** This is an automatically generated email of Work Order Wise Expected Boring Summary Report !!! ***</p>"+ 
						"<p><b>Please find below attached Work Order Wise Expected Boring Summary Report of MFPL from " + CurrentDate + "</p>");				 
	sb.append("<p><b style='color: #330B73;font-family: Arial;'>Thanks & Regards </b></P><p style='font-family: Arial;'> IT | Software Development | Mutha Group Satara </p><hr><p>"+
			"<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"+
			"<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"+
			"it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"+
			"or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"+
			"</font></p>");

	//*******************************************************************************************************************************
	//*******************************************************************************************************************************
	BodyPart messageBodyPart = new MimeBodyPart();
	messageBodyPart.setContent(sb.toString(),"Text/html");
	// Create a multipar message
	Multipart multipart = new MimeMultipart();

	// Set text message part
	multipart.addBodyPart(messageBodyPart);

	// Part two is attachment
	messageBodyPart = new MimeBodyPart();
	 
	String filename = "C:/reportxls/" + val + "TVS_Dispatch"+".xls";
	
	DataSource source = new FileDataSource(filename);
	messageBodyPart.setDataHandler(new DataHandler(source));
	messageBodyPart.setFileName(filename);
	multipart.addBodyPart(messageBodyPart);

	// Send the complete message parts
	msg.setContent(multipart);
	
	if(flag==true){
	Transport transport = mailSession.getTransport("smtp");
	transport.connect(host, user, pass);
	transport.sendMessage(msg, msg.getAllRecipients()); 
	transport.close();
	}
	
			System.out.println("Automail loop End");
			Thread.sleep(60000);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	}
