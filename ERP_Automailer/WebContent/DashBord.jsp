<%@page import="jxl.write.Label"%>
<%@page import="jxl.write.WritableSheet"%>
<%@page import="jxl.format.BorderLineStyle"%>
<%@page import="jxl.format.Border"%>
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.write.WritableCellFormat"%>
<%@page import="jxl.Workbook"%>
<%@page import="jxl.write.WritableFont"%>
<%@page import="jxl.format.Colour"%>
<%@page import="jxl.write.WritableWorkbook"%>
<%@page import="java.io.File"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.muthagroup.connectionERPUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<html>
<head>
<title>Dash Board</title>
</head>
<body>
	<%
		try {
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };  
			boolean flag = true;
			ArrayList weekOff = new ArrayList();
			int cnt = 0;
			DecimalFormat zeroDForm = new DecimalFormat("#####0");
			DecimalFormat twoDForm = new DecimalFormat("#####0.00");
			
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -1);
			SimpleDateFormat todaysDate = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat sqlDate = new SimpleDateFormat("yyyyMMdd");	
			String todays_date = todaysDate.format(cal.getTime()).toString();
			String sql_date = sqlDate.format(cal.getTime()).toString();		 
			// **********************************************************************************************************
			Date dateLogic = todaysDate.parse(todays_date);
			if(weekday[dateLogic.getDay()].equals("Tuesday")){
				cal.add(Calendar.DATE, -1);
				todays_date = todaysDate.format(cal.getTime()).toString();
				sql_date = sqlDate.format(cal.getTime()).toString();
			} 
				cal.add(Calendar.DATE, -1); 
				String  sql_date_prev = sqlDate.format(cal.getTime()).toString();
				String sql_formatprev = sql_date_prev.substring(6,8) +"-"+ sql_date_prev.substring(4,6) +"-"+ sql_date_prev.substring(0,4);
			// **********************************************************************************************************
			double req_perdayQty=0,avg_perdayQty=0,del_rating=0; 
			// ***************************************************************************************************************
			// *************************************************** Workdays ***************************************************
	Connection conlocal = ConnectionUrl.getLocalDatabase();
	Connection con = null;
	String comp_id ="";
	String Sheet_Name = "";
	int sheetcnt=0;

	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";
	int val = listOfFiles.length + 1;

	File exlFile = new File("C:/reportxls/Sheduler"+val+".xls");
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
    
    Colour backHcolor = Colour.CORAL;
    WritableCellFormat cellFormat_header = new WritableCellFormat();
    cellFormat_header.setBackground(backHcolor);
    cellFormat_header.setAlignment(Alignment.LEFT); 
    cellFormat_header.setFont(fontbold); 
    
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
	  		String testDate = sql_date.substring(6,8) +"-"+ sql_date.substring(4,6) +"-"+ sql_date.substring(0,4);
	  		DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
			Date today = formatter.parse(testDate);
				String dayCNT = sql_date.substring(6,8); 
				int month = Integer.parseInt(sql_date.substring(4,6));
			String fromDate = sql_date.substring(0,4)+sql_date.substring(4,6) +"01";			 
				Calendar calendar = Calendar.getInstance();
			calendar.setTime(today);
			calendar.add(Calendar.MONTH, 1);
			calendar.set(Calendar.DAY_OF_MONTH, 1);
			calendar.add(Calendar.DATE, -1); 
			Date lastDayOfMonth = calendar.getTime(); 
			SimpleDateFormat sdfparse = new SimpleDateFormat("dd/MM/yyyy"); 
			Calendar calAvg = Calendar.getInstance(); 
		int total_dd = 0;
		int holliday = 0; 
		int day = Integer.parseInt(dayCNT); 
		PreparedStatement ps_week = conlocal.prepareStatement("select count(*) from montlyweekdays_tbl where month=" + month + " and day<" + day);
		ResultSet rs_week = ps_week.executeQuery();
		while (rs_week.next()) {
			holliday = Integer.parseInt(rs_week.getString("count(*)"));
		}
		PreparedStatement ps_holli = conlocal.prepareStatement("select * from montlyweekdays_tbl where day=" + day + " and month=" + month);
		ResultSet rs_holli = ps_holli.executeQuery();
		while (rs_holli.next()) {
			flag = false;
		}
		int dd = today.getDate();
		int tues = 0;
		for (int i = 1; i < dd; i++) {
			calAvg.set(Calendar.DAY_OF_MONTH, i);
			if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY) {
				tues++;
				weekOff.add(i); 
			}
		}
		int workdays = dd - tues; 
		total_dd = workdays;
		total_dd = total_dd - holliday;
		// ***************************************************************************************************************
		int space = 0;
		PreparedStatement ps_allHol = conlocal.prepareStatement("select count(montlyWeekdays_id) from montlyweekdays_tbl where month=" + month);
		ResultSet rs_allHol = ps_allHol.executeQuery();
		while (rs_allHol.next()) {
			space = Integer.parseInt(rs_allHol.getString("count(montlyWeekdays_id)"));
		} 
		PreparedStatement ps_Hol = conlocal.prepareStatement("select day from montlyweekdays_tbl where month=" + month);
		ResultSet rs_Hol = ps_Hol.executeQuery();
		while (rs_Hol.next()) {
			weekOff.add(rs_Hol.getInt("day"));
		}
		int count_mnt = lastDayOfMonth.getDate();
 		int tue_month = 0;
		for (int i = 1; i < count_mnt; i++) {
			calAvg.set(Calendar.DAY_OF_MONTH, i);
			if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY) {
				tue_month++;
			}
		}
		count_mnt = count_mnt - tue_month;
		count_mnt = count_mnt - space;
   		//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
		comp_id ="101";
		Sheet_Name = "MEPL H21";
		con = ConnectionUrl.getMEPLH21ERP();
		
	  	WritableSheet writableSheet = writableWorkbook.createSheet(Sheet_Name, sheetcnt);
		StringBuilder sb2 = new StringBuilder(); 
			PreparedStatement ps_code = con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE='11'");
			ResultSet rs_code = ps_code.executeQuery();
			while (rs_code.next()) {
				sb2.append(rs_code.getString("SUB_GLACNO"));
			}
			
			// exec "ENGERP"."dbo"."Sel_RptDespatchPlanSale";1 '101', '0', '101110001101110002101110003101110004101110005101110006101110007101110008101110009101110010101110011101110012101110013101110014101110015101110016101110017101110018101110019101110020101110021101110022101110023101110024101110025101110026101110027101110028101110029101110030101110031101110032101110033101110034101110035101110036101110037101110038101110039101110040101110041101110042101110043101110044101110045101110046101110047101110048101110049101110050101110051101110052101110055101110058101110059101110062101110063101110077101110081101110082101110094101110117101110129101110130101110131101110132101110135101110140101110141101110144101110148101110149101110150101110151101110160101110161101110162101110164101110165101110168101110179101110180101110181101110183101110184101110185101110186101110187101110191101110192101110193101110198101110199101110200101110202101110203101110205101110209101110210101110212101110230101110240101110247101110248101110249101110250101110251101110258101110261101110266101110269101110272101110280101110281101110282101110284101110287101110288101110291101110293101110298101110299101110300101110302101110304101110305101110307101110309101110311101110312101110313101110315101110316101110318101110322101110324101110325101110326101110327101110331101110342101110343101110344101110346101110347101110350101110353101110354101110362101110368101110369101110370101110371101110373101110374101110376101110379101110382101110383101110384101110387101110388101110389101110390101110391101110393101110394101110396101110399101110400101110402101110407101110408101110411101110418101110420101110426101110428101110442101110444101110454101110455101110460101110462101110463101110467101110469101110470101110471101110475101110476101110478101110479101110481101110483101110484101110493101110494101110495101110496101110497101110507101110508101110510101110515101110516101110517101110518101110519101110520101110523101110526101110529101110530101110539101110543101110544101110546101110547101110548101110550101110555101110556101110557101110558101110559101110561101110572' , '20170712'
			ArrayList custcodes=new ArrayList();
			CallableStatement cs = con.prepareCall("{call Sel_RptDespatchPlanSale(?,?,?,?)}");
			cs.setString(1, comp_id);
			cs.setString(2, "0"); 
			  cs.setString(3, sb2.toString());
			cs.setString(4, sql_date);
			ResultSet rs = cs.executeQuery();
			while (rs.next()) {
			custcodes.add(rs.getString("CUST_CODE"));
			} 					 
			rs.close();
			
			Set<String> hs = new HashSet();
			hs.addAll(custcodes);
			custcodes.clear();
			custcodes.addAll(hs);  
			
			
			CallableStatement cs_prev = con.prepareCall("{call Sel_RptDespatchPlanSale(?,?,?,?)}");
			cs_prev.setString(1, comp_id);
			cs_prev.setString(2, "0"); 
			cs_prev.setString(3, sb2.toString());
			cs_prev.setString(4, sql_date_prev);
			ResultSet rs_prev=null;
			String disp_qtyyes ="",disp_amtyes="",sale_qtyyes="",sale_amtyes="";
			// ***************************************************************************************************************
			if (custcodes.size() > 0) {
			//***************************************************************************************************************************************************************************************************
				writableSheet.setColumnView(0, 40);
			    writableSheet.setColumnView(1, 10);
			    writableSheet.setColumnView(2, 10);
			    writableSheet.setColumnView(3, 10);
			    writableSheet.setColumnView(4, 10);
			    writableSheet.setColumnView(5, 10);
			    writableSheet.setColumnView(6, 10);
			    writableSheet.setColumnView(7, 10);
			    writableSheet.setColumnView(8, 10);
			  
			    writableSheet.mergeCells(0, 2,0, 3);
			    writableSheet.mergeCells(1, 2,0, 3);
			    writableSheet.mergeCells(2, 2,0, 3);
			    writableSheet.mergeCells(3, 2,0, 3);
			    
			    writableSheet.mergeCells(4, 2,5, 2);
			    writableSheet.mergeCells(6, 2,7, 2);
			    writableSheet.mergeCells(8, 2,9, 2);
			    writableSheet.mergeCells(10, 2,11, 2);
			    writableSheet.mergeCells(12, 2,13, 2);
			     
			    
			    Label label_1 = new Label(0, 0, "Working Days",cellRIghtformat);
			    Label label_2 = new Label(0, 1, "Days Completed",cellRIghtformat);
			    //Label wofflable = new Label(3, 0, "Weekly Off / Holliday",cellRIghtformat);
			    Label label_val1 = new Label(1, 0, zeroDForm.format(count_mnt) , cellRIghtformat); 
			    Label label_val2 = new Label(1, 1, zeroDForm.format(total_dd), cellRIghtformat);
			    Label label = new Label(0, 2, "Name of Item",cellFormat); 
			    Label label1 = new Label(1, 2, "REQ/DAY",cellFormat);
			    Label label2 = new Label(2, 2, "Sale AVG/DAY",cellFormat);
			    Label label3 = new Label(3, 2, "Delivery Rating %",cellFormat);
			    
			    Label label4 = new Label(4, 2, "Despatch Plan",cellFormat);
			    Label label5 = new Label(4, 3, "Qty",cellFormat);
			    Label label6 = new Label(5, 3, "AMT",cellFormat);
			    
			    Label label7 = new Label(6, 2, "Yesterday's Despatch Plan ",cellFormat_header);
			    Label label8 = new Label(6, 3, "Qty",cellFormat);
			    Label label9 = new Label(7, 3, "AMT",cellFormat);
			    
			    Label label10 = new Label(8, 2, "Sales",cellFormat);		    
			    Label label11 = new Label(8, 3, "Qty",cellFormat);
			    Label label12 = new Label(9, 3, "AMT",cellFormat);
			    
			    Label label13 = new Label(10, 2, "Yesterday's Sales",cellFormat_header);
			    Label label14 = new Label(10, 3, "Qty",cellFormat);
			    Label label15 = new Label(11, 3, "AMT",cellFormat);
			    
			    Label label16 = new Label(12, 2, "Pending",cellFormat);
			    Label label17 = new Label(12, 3, "Qty",cellFormat);
			    Label label18 = new Label(13, 3, "AMT",cellFormat);
			     
			     
			 writableSheet.addCell(label_1);
			 writableSheet.addCell(label_2);
			 //writableSheet.addCell(wofflable);					 
			 writableSheet.addCell(label_val1);
			 writableSheet.addCell(label_val2);
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
			 writableSheet.addCell(label13);
			 writableSheet.addCell(label14);
			 writableSheet.addCell(label15);
			 writableSheet.addCell(label16);
			 writableSheet.addCell(label17);
			 writableSheet.addCell(label18);
			}
			
			// --------------------------------------------------------------------------------------------------------------------------------------------------------------
			int count=0;
			int col=4;
			// --------------------------------------------------------------------------------------------------------------------------------------------------------------
			for(int i=0;i<custcodes.size();i++){
			count=0;
			
			rs = cs.executeQuery(); 
			while(rs.next()){
				
				if(rs.getString("CUST_CODE").equalsIgnoreCase(custcodes.get(i).toString())){
					
				if(count==0){
					Label customer = new  Label(0, col, rs.getString("CUST_NAME"),cellFormat_header);
					writableSheet.addCell(customer);
					count ++;
					col++;
				}
				
				req_perdayQty = Double.parseDouble(rs.getString("NOS_QTY"))/count_mnt;
				avg_perdayQty = Double.parseDouble(rs.getString("SALE_QTY"))/total_dd;
				del_rating = (avg_perdayQty/req_perdayQty)*100;
				
				Label matName = new  Label(0, col, rs.getString("MAT_NAME"),cellleftformat);
				writableSheet.addCell(matName);
				
				Label reqperday = new  Label(1, col, zeroDForm.format(req_perdayQty),cellRIghtformat);
				writableSheet.addCell(reqperday);
				
				Label avgperday = new  Label(2, col, zeroDForm.format(avg_perdayQty),cellRIghtformat);
				writableSheet.addCell(avgperday);
				
				Label delrating = new  Label(3, col, zeroDForm.format(del_rating),cellRIghtformat);
				writableSheet.addCell(delrating);
				
				Label label_des_qty = new Label(4, col, zeroDForm.format(Math.round(Double.parseDouble(rs.getString("NOS_QTY")))),cellRIghtformat);
				writableSheet.addCell(label_des_qty);
				
				Label label_des_amt = new Label(5, col, twoDForm.format(Double.parseDouble(rs.getString("SCH_AMT"))/100000),cellRIghtformat);
				writableSheet.addCell(label_des_amt);
				 
				rs_prev = cs_prev.executeQuery();
				disp_qtyyes="0";
				disp_amtyes="0";
				sale_qtyyes="0";
				sale_amtyes="0";
				while(rs_prev.next()){
					if(rs_prev.getString("CUST_CODE").equalsIgnoreCase(custcodes.get(i).toString()) && 
						rs_prev.getString("MAT_CODE").equalsIgnoreCase(rs.getString("MAT_CODE"))){
						disp_qtyyes =rs_prev.getString("NOS_QTY");
						disp_amtyes=rs_prev.getString("SCH_AMT");
						sale_qtyyes=rs_prev.getString("SALE_QTY");
						sale_amtyes=rs_prev.getString("SALE_AMT"); 
					}
				}
				
				Label yes_des_qty = new Label(6, col, zeroDForm.format(Math.round(Double.parseDouble(disp_qtyyes))),cellRIghtformat);
				writableSheet.addCell(yes_des_qty);
				
				Label yes_des_amt = new Label(7, col, twoDForm.format(Double.parseDouble(disp_amtyes)/100000),cellRIghtformat);
				writableSheet.addCell(yes_des_amt);
				
				Label label_sale_qty = new Label(8, col, zeroDForm.format(Math.round(Double.parseDouble(rs.getString("SALE_QTY")))),cellRIghtformat);
				writableSheet.addCell(label_sale_qty);
				
				Label label_sale_amt = new Label(9, col, twoDForm.format(Double.parseDouble(rs.getString("SALE_AMT"))/100000),cellRIghtformat);
				writableSheet.addCell(label_sale_amt);
				
				Label yes_sale_qty = new Label(10, col, zeroDForm.format(Math.round(Double.parseDouble(sale_qtyyes))),cellRIghtformat);
				writableSheet.addCell(yes_sale_qty);
				
				Label yes_sale_amt = new Label(11, col, twoDForm.format(Double.parseDouble(sale_amtyes)/100000),cellRIghtformat);
				writableSheet.addCell(yes_sale_amt);
				 
				Label label_pend_qty = new Label(12, col, zeroDForm.format(Math.round(Double.parseDouble(rs.getString("PEND_QTY")))),cellRIghtformat);
				writableSheet.addCell(label_pend_qty);
				
				Label label_pend_amt = new Label(13, col, twoDForm.format(Double.parseDouble(rs.getString("PEND_AMT"))/100000),cellRIghtformat);
				writableSheet.addCell(label_pend_amt);
				
				col++;
			  }
			}
			
			}
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			 // ***************************************************************************************************************************************************************************************************
			     writableWorkbook.write();
			     writableWorkbook.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>