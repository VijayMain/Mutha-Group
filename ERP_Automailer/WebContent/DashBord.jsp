<%@page import="jxl.write.Label"%>
<%@page import="jxl.write.WritableSheet"%>
<%@page import="java.text.DateFormat"%>
<%@page import="jxl.format.BorderLineStyle"%>
<%@page import="jxl.format.Border"%>
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.write.WritableCellFormat"%>
<%@page import="jxl.write.WritableFont"%>
<%@page import="jxl.Workbook"%>
<%@page import="jxl.format.Colour"%>
<%@page import="jxl.write.WritableWorkbook"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Collections"%>
<%@page import="com.muthagroup.connectionERPUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<html>
<head>
<title>Dash Board</title>
</head>
<body>
<% 
try { 
	Connection con = ConnectionUrl.getLocalDatabase();

	SimpleDateFormat formatView = new SimpleDateFormat("dd/MM/yyyy");
	SimpleDateFormat formatsql = new SimpleDateFormat("yyyyMMdd");
	DecimalFormat mytotals = new DecimalFormat("######0.00");

	Calendar aCalendar = Calendar.getInstance();
	//add -1 month to current month
	aCalendar.add(Calendar.MONTH, -1);
	//set DATE to 1, so first date of previous month
	aCalendar.set(Calendar.DATE, 1);
	Date firstDateOfPreviousMonth = aCalendar.getTime();
	//set actual maximum date of previous month
	aCalendar.set(Calendar.DATE, aCalendar.getActualMaximum(Calendar.DAY_OF_MONTH));
	//read it
	Date lastDateOfPreviousMonth = aCalendar.getTime();
	String from_date = formatsql.format(firstDateOfPreviousMonth);
	String to_date = formatsql.format(lastDateOfPreviousMonth);
	String dateFrom = formatView.format(firstDateOfPreviousMonth);
	String dateTo = formatView.format(lastDateOfPreviousMonth);

	ArrayList listpara = new ArrayList();   
	ArrayList listyear = new ArrayList();
	ArrayList listmonthcnt = new ArrayList();
	ArrayList listmonth = new ArrayList(); 
//	System.out.println("fdate = " + from_date + "\nLast day = " + to_date);
//	System.out.println("fdate view = " + dateFrom + "\nLast day view = " + dateTo); 
	int year = Calendar.getInstance().get(Calendar.YEAR); 
	DateFormatSymbols dfs = new DateFormatSymbols();
	String[] months = dfs.getShortMonths(); 
	int cnt = 2;
	int yearcnt = year+1; 
	//  to adjust months to display =====>
	outerLoop:
	for(int i=0;i<=12;i++){ 
	 listyear.add(months[cnt] + yearcnt);
	 listmonth.add(months[cnt]);
	 listmonthcnt.add(cnt); 
	// System.out.println("List Year = " + listyear.get(i) +"List Month = " + listmonth.get(i) + "list Month cnt " + listmonthcnt.get(i) + "list for =" + yearfor);
	// 	listmonth.add(cnt);
	// System.out.println("Looop = " + cnt + " loop = " +  months[cnt] + " year = " + yearcnt); 
	 if(cnt==3){
		 break outerLoop;
	 } 
	 if(cnt==0){
		 cnt=11;
		 yearcnt--;
	}else{
		 cnt--;
	}
	} 
	Collections.reverse(listyear);
	Collections.reverse(listmonthcnt);
	Collections.reverse(listmonth);  
			// ***************************************************************************************************************
   	String Sheet_Name = "";
	int sheetcnt=0;

	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";
	int val = listOfFiles.length + 1;

	File exlFile = new File("C:/reportxls/SisterComp"+val+".xls");
	WritableWorkbook writableWorkbook = Workbook.createWorkbook(exlFile); 

	Colour bckcolor = Colour.TURQUOISE;
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
    
    Colour backHcolor = Colour.GREY_25_PERCENT;
    WritableCellFormat cellFormat_header = new WritableCellFormat();
    cellFormat_header.setBackground(backHcolor);
    cellFormat_header.setAlignment(Alignment.CENTRE); 
    cellFormat_header.setFont(fontbold); 
    
    Colour backHcolor1 = Colour.CORAL;
    WritableCellFormat cellFormat_header1 = new WritableCellFormat();
    cellFormat_header1.setBackground(backHcolor1);
    cellFormat_header1.setAlignment(Alignment.CENTRE); 
    cellFormat_header1.setFont(fontbold); 
    
    WritableCellFormat cellRIghtformat = new WritableCellFormat();
    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellRIghtformat.setFont(font);
    cellRIghtformat.setAlignment(Alignment.RIGHT);
    
    WritableCellFormat cellRIghtformatWrap = new WritableCellFormat(); 
    cellRIghtformatWrap.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellRIghtformatWrap.setFont(font);
    cellRIghtformatWrap.setAlignment(Alignment.RIGHT);
    cellRIghtformatWrap.setWrap(true);
    
    WritableCellFormat cellFormatWrap = new WritableCellFormat();
    cellFormatWrap.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellFormatWrap.setBackground(bckcolor);
    cellFormatWrap.setFont(fontbold);
    cellFormatWrap.setAlignment(Alignment.RIGHT); 
    cellFormatWrap.setWrap(true);
    
    WritableCellFormat cellleftformat = new WritableCellFormat(); 
    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellleftformat.setFont(font); 	
    cellleftformat.setAlignment(Alignment.LEFT);
	//-------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
   //--------------------------------------------------------------------------------------------------------------------------------------------------------------------
		Sheet_Name = "Sister Company Sale";
		con = ConnectionUrl.getMEPLH21ERP();
	   	WritableSheet writableSheet = writableWorkbook.createSheet(Sheet_Name, sheetcnt);
	  			writableSheet.setColumnView(0, 15);
			    writableSheet.setColumnView(1, 15);
			    writableSheet.setColumnView(2, 15);
			    writableSheet.setColumnView(3, 15);
			    writableSheet.setColumnView(4, 15);
			    writableSheet.setColumnView(5, 15);
			    writableSheet.setColumnView(6, 15);
			    writableSheet.setColumnView(7, 15);
			    writableSheet.setColumnView(8, 15);
			    writableSheet.setColumnView(9, 15);
			    writableSheet.setColumnView(10, 15);
			    writableSheet.setColumnView(11, 15);
			    writableSheet.setColumnView(12, 15);
			    writableSheet.setColumnView(13, 15);
			    writableSheet.setColumnView(14, 15); 
			    
			    writableSheet.mergeCells(0, 0,14, 0);
			    writableSheet.mergeCells(1, 1,2, 1); 
			    writableSheet.mergeCells(3, 1,4, 1);
			    writableSheet.mergeCells(5, 1,6, 1);
			    writableSheet.mergeCells(7, 1,8, 1);
			    writableSheet.mergeCells(9, 1,10, 1); 
			    writableSheet.mergeCells(11, 1,12, 1);
			    writableSheet.mergeCells(13, 1,14, 1);
			    writableSheet.mergeCells(15, 1,16, 1); 
			     
			    Label label_1 = new Label(0, 0, "INTER-COMPANY SALES ",cellFormat_header1);
			    Label label_2 = new Label(1, 1, "FOUNDERS TO ENGINEERING",cellFormat_header1);
			    Label label_3 = new Label(3, 1, "MEPL UIII TO ENGINEERING",cellFormat_header1);
			    Label label_4 = new Label(5, 1, "DHANSHREE TO ENGINEERING",cellFormat_header1);
			    Label label_5 = new Label(7, 1, "MEPL UIII TO FOUNDERS",cellFormat_header1);
			    Label label_6 = new Label(9, 1, "EGINEERING H-25 TO FOUNDERS",cellFormat_header1);
			    Label label_7 = new Label(11, 1, "DHANASHREE TO FOUNDERS",cellFormat_header1);
			    Label label_8 = new Label(13, 1, "TOTAL",cellFormat_header1);
			      
			 writableSheet.addCell(label_1);
			 writableSheet.addCell(label_2);
			 writableSheet.addCell(label_3);
			 writableSheet.addCell(label_4);
			 writableSheet.addCell(label_5);
			 writableSheet.addCell(label_6);
			 writableSheet.addCell(label_7);
			 writableSheet.addCell(label_8);
			 
			 Label row_1 = new Label(0, 1, "",cellFormat);
			 writableSheet.addCell(row_1);
			 
			 Label row_2 = new Label(0, 2, "",cellFormat);
			 writableSheet.addCell(row_2);
			 
			 Label row_head1 = new Label(1, 2, "TONNAGE",cellFormat); 
			 writableSheet.addCell(row_head1);
			 Label row_head2 = new Label(2, 2, "AMOUNT",cellFormat); 
			 writableSheet.addCell(row_head2);
			 
			 Label row_head3 = new Label(3, 2, "TONNAGE",cellFormat); 
			 writableSheet.addCell(row_head3);
			 Label row_head4 = new Label(4, 2, "AMOUNT",cellFormat); 
			 writableSheet.addCell(row_head4);
			 Label row_head5 = new Label(5, 2, "TONNAGE",cellFormat); 
			 writableSheet.addCell(row_head5);
			 Label row_head6 = new Label(6, 2, "AMOUNT",cellFormat); 
			 writableSheet.addCell(row_head6);
			 Label row_head7 = new Label(7, 2, "TONNAGE",cellFormat); 
			 writableSheet.addCell(row_head7);
			 Label row_head8 = new Label(8, 2, "AMOUNT",cellFormat); 
			 writableSheet.addCell(row_head8);
			 Label row_head9 = new Label(9, 2, "TONNAGE",cellFormat); 
			 writableSheet.addCell(row_head9);
			 Label row_head10 = new Label(10, 2, "AMOUNT",cellFormat); 
			 writableSheet.addCell(row_head10);
			 Label row_head11 = new Label(11, 2, "TONNAGE",cellFormat); 
			 writableSheet.addCell(row_head11);
			 Label row_head12 = new Label(12, 2, "AMOUNT",cellFormat); 
			 writableSheet.addCell(row_head12);
			 Label row_head13 = new Label(13, 2, "TONNAGE",cellFormat); 
			 writableSheet.addCell(row_head13);
			 Label row_head14 = new Label(14, 2, "AMOUNT",cellFormat); 
			 writableSheet.addCell(row_head14);
			 
			 
			 
			 
			 
			 // -----------------------------------------------------------------------------------------------------------------------------------------------------------------
			 cnt=3;
			 PreparedStatement ps_sis = null; 
				ResultSet rs_sis = null;
				Connection con_erp = null;
				double tonnage=0,amount=0,tonnageTotal=0,amountTotal=0;
				 
				for(int i=0;i<listmonthcnt.size();i++){
				Calendar calendar = Calendar.getInstance();
				int yearpart =  Integer.valueOf(listyear.get(i).toString().substring(listyear.get(i).toString().length() - 4));
				int monthPart = Integer.valueOf(listmonthcnt.get(i).toString());
				int dateDay = 1;
				calendar.set(yearpart, monthPart, dateDay);
				int numOfDaysInMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH); 
				String firstsql = formatsql.format(calendar.getTime());
				calendar.add(Calendar.DAY_OF_MONTH, numOfDaysInMonth-1); 
				String lastsql = formatsql.format(calendar.getTime());
				//System.out.println("First Day of month: " + listyear.get(i).toString() + firstsql  + "  = " + lastsql);
				
				// +++++++++++++++++++++++++++++++++++++++++++++ FOUNDERS TO ENGINEERING +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				con_erp = ConnectionUrl.getFoundryERPNEWConnection();
				ps_sis = con_erp.prepareStatement("SELECT TRNACCTMATISALE.TRAN_NO,TRNACCTMATISALE.TRAN_DATE,TRNACCTMATISALE.TRAN_SUBTYPE, "+
						"TRNACCTMATISALE.MAT_CODE, "+
						"TRNACCTMATISALE.MAT_NAME,TRNACCTMATISALE.DRG_NO,TRNACCTMATISALE.QTY, "+
						"TRNACCTMATISALE.WEIGHT,TRNACCTMATISALE.RATE,(CAST(TRNACCTMATISALE.WEIGHT as FLOAT) * CAST(TRNACCTMATISALE.QTY AS FLOAT)) as TONNAGE ,TRNACCTMATISALE.AMOUNT,TRNACCTMATISALE.CUST_SUB_GLACNO, "+
						"MSTACCTGLSUB.SUBGL_LONGNAME,MSTACCTGLSUB.SUB_GLACNO, "+
						"MSTMATERIALS.MATERIAL_TYPE,MSTMATERIALS.CODE FROM TRNACCTMATISALE "+
						"LEFT JOIN MSTACCTGLSUB ON TRNACCTMATISALE.CUST_SUB_GLACNO = MSTACCTGLSUB.SUB_GLACNO "+
						"LEFT JOIN MSTMATERIALS ON TRNACCTMATISALE.MAT_CODE = MSTMATERIALS.CODE "+
						"WHERE CUST_SUB_GLACNO "+
						"in(101110205,101110100) "+
						"AND TRAN_DATE BETWEEN '"+firstsql+"' AND '"+ lastsql + "' " +
						"AND MATERIAL_TYPE =101 AND TRAN_SUBTYPE IN (1,51) order by CUST_SUB_GLACNO ");
				rs_sis = ps_sis.executeQuery();
				while(rs_sis.next()){
					
					tonnage = Double.valueOf(rs_sis.getString("TONNAGE")) + tonnage;
					amount = Double.valueOf(rs_sis.getString("AMOUNT")) + amount;
					
				}
				tonnageTotal=tonnage+tonnageTotal;
				amountTotal=amount+amountTotal;
				
				
				
				Label row_11 = new Label(0, cnt, listyear.get(i).toString() ,cellRIghtformat);
				 writableSheet.addCell(row_11);
				 
				 Label row_22 = new Label(1, cnt, mytotals.format(tonnage)  ,cellRIghtformat);
				 writableSheet.addCell(row_22);
				 
				 Label row_33 = new Label(2, cnt, mytotals.format(amount)  ,cellRIghtformat);
				 writableSheet.addCell(row_33);
				
				tonnage=0;amount=0;
				
				// =================================================================================================================================
				// +++++++++++++++++++++++++++++++++++++++++++++ MEPL UIII TO ENGINEERING +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				con_erp = ConnectionUrl.getK1ERPConnection();
				ps_sis = con_erp.prepareStatement("SELECT TRNACCTMATISALE.TRAN_NO,TRNACCTMATISALE.TRAN_DATE,TRNACCTMATISALE.TRAN_SUBTYPE, "+
						"TRNACCTMATISALE.MAT_CODE, "+
						"TRNACCTMATISALE.MAT_NAME,TRNACCTMATISALE.DRG_NO,TRNACCTMATISALE.QTY, "+
						"TRNACCTMATISALE.WEIGHT,TRNACCTMATISALE.RATE,(CAST(TRNACCTMATISALE.WEIGHT as FLOAT) * CAST(TRNACCTMATISALE.QTY AS FLOAT)) as TONNAGE ,TRNACCTMATISALE.AMOUNT,TRNACCTMATISALE.CUST_SUB_GLACNO, "+
						"MSTACCTGLSUB.SUBGL_LONGNAME,MSTACCTGLSUB.SUB_GLACNO, "+
						"MSTMATERIALS.MATERIAL_TYPE,MSTMATERIALS.CODE FROM TRNACCTMATISALE "+
						"LEFT JOIN MSTACCTGLSUB ON TRNACCTMATISALE.CUST_SUB_GLACNO = MSTACCTGLSUB.SUB_GLACNO "+
						"LEFT JOIN MSTMATERIALS ON TRNACCTMATISALE.MAT_CODE = MSTMATERIALS.CODE "+
						"WHERE CUST_SUB_GLACNO "+
						"in(101110205,101110100)  "+
						" AND TRAN_DATE BETWEEN '"+firstsql+"' AND '"+ lastsql + "' " +
						" AND MATERIAL_TYPE =101 AND TRAN_SUBTYPE IN (1,51) order by CUST_SUB_GLACNO ");
				rs_sis = ps_sis.executeQuery();
				while(rs_sis.next()){
					tonnage = Double.valueOf(rs_sis.getString("TONNAGE")) + tonnage;
					amount = Double.valueOf(rs_sis.getString("AMOUNT")) + amount;
				}
				
				
				
				
				ps_sis = con_erp.prepareStatement("SELECT TRNSTORMATI.TRAN_NO,TRNSTORMATI.TRAN_DATE,TRNSTORMATI.TRAN_SUBTYPE, "+
						" TRNSTORMATI.MAT_CODE, "+
						" TRNSTORMATI.CHLN_QTY, "+
						" TRNSTORMATI.SUB_GLACNO, "+
						" MSTMATERIALS.CASTING_WT, (CAST(MSTMATERIALS.CASTING_WT as FLOAT) * CAST(TRNSTORMATI.CHLN_QTY AS FLOAT)) as TONNAGE "+
						" ,(CAST(TRNSTORMATI.RATE as FLOAT) * CAST(TRNSTORMATI.CHLN_QTY AS FLOAT)) as AMOUNT "+
						" ,TRNSTORMATI.RATE,TRNSTORMATI.SUB_GLACNO, "+
						" MSTACCTGLSUB.SUBGL_LONGNAME,MSTACCTGLSUB.SUB_GLACNO, "+
						" MSTMATERIALS.CASTING_WT,MSTMATERIALS.FINISH_WT, "+
						" MSTMATERIALS.MATERIAL_TYPE,MSTMATERIALS.CODE,MSTMATERIALS.NAME FROM TRNSTORMATI "+
						" LEFT JOIN MSTACCTGLSUB ON TRNSTORMATI.SUB_GLACNO = MSTACCTGLSUB.SUB_GLACNO "+
						" LEFT JOIN MSTMATERIALS ON TRNSTORMATI.MAT_CODE = MSTMATERIALS.CODE "+
						" WHERE TRNSTORMATI.SUB_GLACNO  "+
						" in(101110054,101110069,101110100,101110205,101110233,101110347, "+
						" 101110475,101120645,101122002,101123158,101124452) "+ 
						" AND TRNSTORMATI.TRAN_DATE BETWEEN '"+firstsql+"' AND '"+ lastsql + "' " +
						" and TRNSTORMATI.STATUS_CODE =0 "+
						" AND MSTMATERIALS.MATERIAL_TYPE =101 "+
						" AND TRNSTORMATI.TRAN_SUBTYPE IN (66) order by TRNSTORMATI.SUB_GLACNO,TRAN_NO");
				rs_sis = ps_sis.executeQuery();
				while(rs_sis.next()){
					tonnage = Double.valueOf(rs_sis.getString("TONNAGE")) + tonnage;
					amount = Double.valueOf(rs_sis.getString("AMOUNT")) + amount;
				}
			 
				
				tonnageTotal=tonnage+tonnageTotal;
				amountTotal=amount+amountTotal; 
				 
				 Label row_4 = new Label(3, cnt, mytotals.format(tonnage)  ,cellRIghtformat);
				 writableSheet.addCell(row_4);
				 
				 Label row_5 = new Label(4, cnt, mytotals.format(amount)  ,cellRIghtformat);
				 writableSheet.addCell(row_5);
				
				tonnage=0;amount=0;
				 
				// =================================================================================================================================
				
				// +++++++++++++++++++++++++++++++++++++++++++++ DHANSHREE TO ENGINEERING ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			con_erp = ConnectionUrl.getDIERPConnection();
			ps_sis = con_erp.prepareStatement("SELECT TRNACCTMATISALE.TRAN_NO,TRNACCTMATISALE.TRAN_DATE,TRNACCTMATISALE.TRAN_SUBTYPE, "+
					"TRNACCTMATISALE.MAT_CODE, "+
					"TRNACCTMATISALE.MAT_NAME,TRNACCTMATISALE.DRG_NO,TRNACCTMATISALE.QTY, "+
					"TRNACCTMATISALE.WEIGHT,TRNACCTMATISALE.RATE,(CAST(TRNACCTMATISALE.WEIGHT as FLOAT) * CAST(TRNACCTMATISALE.QTY AS FLOAT)) as TONNAGE ,TRNACCTMATISALE.AMOUNT,TRNACCTMATISALE.CUST_SUB_GLACNO, "+
					"MSTACCTGLSUB.SUBGL_LONGNAME,MSTACCTGLSUB.SUB_GLACNO, "+
					"MSTMATERIALS.MATERIAL_TYPE,MSTMATERIALS.CODE FROM TRNACCTMATISALE "+
					"LEFT JOIN MSTACCTGLSUB ON TRNACCTMATISALE.CUST_SUB_GLACNO = MSTACCTGLSUB.SUB_GLACNO "+
					"LEFT JOIN MSTMATERIALS ON TRNACCTMATISALE.MAT_CODE = MSTMATERIALS.CODE "+
					"WHERE CUST_SUB_GLACNO "+
					"in(101110205,101110100)  "+
					"AND TRAN_DATE BETWEEN '"+firstsql+"' AND '"+ lastsql + "' " +
					"AND MATERIAL_TYPE =101 AND TRAN_SUBTYPE IN (1,51) order by CUST_SUB_GLACNO ");
			rs_sis = ps_sis.executeQuery();
			while(rs_sis.next()){
				tonnage = Double.valueOf(rs_sis.getString("TONNAGE")) + tonnage;
				amount = Double.valueOf(rs_sis.getString("AMOUNT")) + amount;
			}
			tonnageTotal=tonnage+tonnageTotal;
			amountTotal=amount+amountTotal;
			
			Label row_6 = new Label(5, cnt, mytotals.format(tonnage)  ,cellRIghtformat);
			 writableSheet.addCell(row_6);
			 
			 Label row_7 = new Label(6, cnt, mytotals.format(amount)  ,cellRIghtformat);
			 writableSheet.addCell(row_7); 
			tonnage=0;amount=0;
			 
				// ===================================================================================================================================
				// +++++++++++++++++++++++++++++++++++++++++++++ MEPL UIII TO FOUNDERS +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		con_erp = ConnectionUrl.getK1ERPConnection();
		ps_sis = con_erp.prepareStatement("SELECT TRNACCTMATISALE.TRAN_NO,TRNACCTMATISALE.TRAN_DATE,TRNACCTMATISALE.TRAN_SUBTYPE, "+
				"TRNACCTMATISALE.MAT_CODE, "+
				"TRNACCTMATISALE.MAT_NAME,TRNACCTMATISALE.DRG_NO,TRNACCTMATISALE.QTY, "+
				"TRNACCTMATISALE.WEIGHT,TRNACCTMATISALE.RATE,(CAST(TRNACCTMATISALE.WEIGHT as FLOAT) * CAST(TRNACCTMATISALE.QTY AS FLOAT)) as TONNAGE ,TRNACCTMATISALE.AMOUNT,TRNACCTMATISALE.CUST_SUB_GLACNO, "+
				"MSTACCTGLSUB.SUBGL_LONGNAME,MSTACCTGLSUB.SUB_GLACNO, "+
				"MSTMATERIALS.MATERIAL_TYPE,MSTMATERIALS.CODE FROM TRNACCTMATISALE "+
				"LEFT JOIN MSTACCTGLSUB ON TRNACCTMATISALE.CUST_SUB_GLACNO = MSTACCTGLSUB.SUB_GLACNO "+
				"LEFT JOIN MSTMATERIALS ON TRNACCTMATISALE.MAT_CODE = MSTMATERIALS.CODE "+
				"WHERE CUST_SUB_GLACNO "+
				"in(101110070) "+
				"AND TRAN_DATE BETWEEN '"+firstsql+"' AND '"+ lastsql + "' " +
				"AND MATERIAL_TYPE =101 AND TRAN_SUBTYPE IN (1,51) order by CUST_SUB_GLACNO ");
		rs_sis = ps_sis.executeQuery();
		while(rs_sis.next()){
			tonnage = Double.valueOf(rs_sis.getString("TONNAGE")) + tonnage;
			amount = Double.valueOf(rs_sis.getString("AMOUNT")) + amount;
		}
		tonnageTotal=tonnage+tonnageTotal;
		amountTotal=amount+amountTotal;
		
		Label row_8 = new Label(7, cnt, mytotals.format(tonnage)  ,cellRIghtformat);
		 writableSheet.addCell(row_8);
		 
		 Label row_9 = new Label(8, cnt, mytotals.format(amount)  ,cellRIghtformat);
		 writableSheet.addCell(row_9); 
		tonnage=0;amount=0; 
				// ===================================================================================================================================
				
				// +++++++++++++++++++++++++++++++++++++++++++++ EGINEERING H-25 TO FOUNDERS ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		con_erp = ConnectionUrl.getMEPLH25ERP();
		ps_sis = con_erp.prepareStatement("SELECT TRNACCTMATISALE.TRAN_NO,TRNACCTMATISALE.TRAN_DATE,TRNACCTMATISALE.TRAN_SUBTYPE, "+
				"TRNACCTMATISALE.MAT_CODE, "+
				"TRNACCTMATISALE.MAT_NAME,TRNACCTMATISALE.DRG_NO,TRNACCTMATISALE.QTY, "+
				"TRNACCTMATISALE.WEIGHT,TRNACCTMATISALE.RATE,(CAST(TRNACCTMATISALE.WEIGHT as FLOAT) * CAST(TRNACCTMATISALE.QTY AS FLOAT)) as TONNAGE ,TRNACCTMATISALE.AMOUNT,TRNACCTMATISALE.CUST_SUB_GLACNO, "+
				"MSTACCTGLSUB.SUBGL_LONGNAME,MSTACCTGLSUB.SUB_GLACNO, "+
				"MSTMATERIALS.MATERIAL_TYPE,MSTMATERIALS.CODE FROM TRNACCTMATISALE "+
				"LEFT JOIN MSTACCTGLSUB ON TRNACCTMATISALE.CUST_SUB_GLACNO = MSTACCTGLSUB.SUB_GLACNO "+
				"LEFT JOIN MSTMATERIALS ON TRNACCTMATISALE.MAT_CODE = MSTMATERIALS.CODE "+
				"WHERE CUST_SUB_GLACNO "+
				"in(101110070) "+
				"AND TRAN_DATE BETWEEN '"+firstsql+"' AND '"+ lastsql + "' " +
				"AND MATERIAL_TYPE =101 AND TRAN_SUBTYPE IN (1,51) order by CUST_SUB_GLACNO ");
		rs_sis = ps_sis.executeQuery();
		while(rs_sis.next()){
			tonnage = Double.valueOf(rs_sis.getString("TONNAGE")) + tonnage;
			amount = Double.valueOf(rs_sis.getString("AMOUNT")) + amount;
		}
		tonnageTotal=tonnage+tonnageTotal;
		amountTotal=amount+amountTotal;
		
		Label row_10 = new Label(9, cnt, mytotals.format(tonnage)  ,cellRIghtformat);
		 writableSheet.addCell(row_10);
		 
		 Label row_111 = new Label(10, cnt, mytotals.format(amount)  ,cellRIghtformat);
		 writableSheet.addCell(row_111); 
		tonnage=0;amount=0;  
				// ===================================================================================================================================
				
				// +++++++++++++++++++++++++++++++++++++++++++++ DHANASHREE TO FOUNDERS +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		con_erp = ConnectionUrl.getDIERPConnection();
		ps_sis = con_erp.prepareStatement("SELECT TRNACCTMATISALE.TRAN_NO,TRNACCTMATISALE.TRAN_DATE,TRNACCTMATISALE.TRAN_SUBTYPE, "+
				"TRNACCTMATISALE.MAT_CODE, "+
				"TRNACCTMATISALE.MAT_NAME,TRNACCTMATISALE.DRG_NO,TRNACCTMATISALE.QTY, "+
				"TRNACCTMATISALE.WEIGHT,TRNACCTMATISALE.RATE,(CAST(TRNACCTMATISALE.WEIGHT as FLOAT) * CAST(TRNACCTMATISALE.QTY AS FLOAT)) as TONNAGE ,TRNACCTMATISALE.AMOUNT,TRNACCTMATISALE.CUST_SUB_GLACNO, "+
				"MSTACCTGLSUB.SUBGL_LONGNAME,MSTACCTGLSUB.SUB_GLACNO, "+
				"MSTMATERIALS.MATERIAL_TYPE,MSTMATERIALS.CODE FROM TRNACCTMATISALE "+
				"LEFT JOIN MSTACCTGLSUB ON TRNACCTMATISALE.CUST_SUB_GLACNO = MSTACCTGLSUB.SUB_GLACNO "+
				"LEFT JOIN MSTMATERIALS ON TRNACCTMATISALE.MAT_CODE = MSTMATERIALS.CODE "+
				"WHERE CUST_SUB_GLACNO "+
				"in(101110070) "+
				"AND TRAN_DATE BETWEEN '"+firstsql+"' AND '"+ lastsql + "' " +
				"AND MATERIAL_TYPE =101 AND TRAN_SUBTYPE IN (1,51) order by CUST_SUB_GLACNO ");
		rs_sis = ps_sis.executeQuery();
		while(rs_sis.next()){
			tonnage = Double.valueOf(rs_sis.getString("TONNAGE")) + tonnage;
			amount = Double.valueOf(rs_sis.getString("AMOUNT")) + amount;
		}
		tonnageTotal=tonnage+tonnageTotal;
		amountTotal=amount+amountTotal;
		
		Label row_12 = new Label(11, cnt, mytotals.format(tonnage)  ,cellRIghtformat);
		 writableSheet.addCell(row_12);
		 
		 Label row_13 = new Label(12, cnt, mytotals.format(amount)  ,cellRIghtformat);
		 writableSheet.addCell(row_13);  
		
		 Label row_14 = new Label(13, cnt, mytotals.format(tonnageTotal)  ,cellRIghtformat);
		 writableSheet.addCell(row_14);
		 
		 Label row_15 = new Label(14, cnt, mytotals.format(amountTotal)  ,cellRIghtformat);
		 writableSheet.addCell(row_15); 
		tonnage=0; amount=0;			
		tonnageTotal=0; amountTotal=0;
		cnt++;
	// ===================================================================================================================================
		} 
	//------------------------------------------------------------------------------------------------------------------------------------------------------------------
			 
			  
			 
			 
			 
			 
			 
			 
		  
		   // ***************************************************************************************************************************************************************************************************
			    writableWorkbook.write();
			    writableWorkbook.close();
			//***************************************************************************************************************************************************************************************************
		 
} catch (Exception e) {
	e.printStackTrace();
}
System.out.println("Schedule Report Loop END");  
%>
</body>
</html>