<%@page import="java.util.Collections"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.security.AllPermission"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="jxl.format.BoldStyle"%>
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.format.BorderLineStyle"%>
<%@page import="jxl.format.Border"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@page import="jxl.write.WritableCellFormat"%>
<%@page import="jxl.format.Colour"%> 
<%@page import="jxl.format.UnderlineStyle"%>
<%@page import="jxl.write.WritableFont"%>
<%@page import="jxl.write.WritableCell"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="jxl.write.Number"%>
<%@page import="java.util.Date"%>
<%@page import="jxl.write.Boolean"%>
<%@page import="jxl.write.DateTime"%>
<%@page import="jxl.write.Label"%>
<%@page import="jxl.write.WritableSheet"%>
<%@page import="jxl.Workbook"%>
<%@page import="jxl.write.WritableWorkbook"%>
<%@page import="java.io.File"%>
<html>
<head>
<title>AJAX EXCEL</title>
</head>
<body> 
<%
try {
	
	String comp="",month="",db="",monthName="";
	comp = request.getParameter("comp");
	month = request.getParameter("month");
	db = request.getParameter("db");
	monthName = request.getParameter("monthName");
	
	String CompanyName="",maindb="";
	Connection con = null;
	if(comp.equalsIgnoreCase("103")){
		con = ConnectionUrl.getFoundryFMShopConnection(); 
		maindb = "FOUNDRYERP";
		CompanyName = "MUTHA FOUNDERS";
	}
	if(comp.equalsIgnoreCase("105")){
		con = ConnectionUrl.getDIFMShopConnection(); 
		maindb = "DIERP";
		CompanyName = "DHANASHREE INDUSTRIES";
	}
	if(comp.equalsIgnoreCase("106")){
		con = ConnectionUrl.getK1FMShopConnection(); 
		maindb = "K1ERP";
		CompanyName = "MUTHA ENGINEERING UNIT III ";
	} 
	
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";
	 
 	int val = listOfFiles.length + 1;
	
	File exlFile = new File("C:/reportxls/DailyProd"+val+".xls");
    WritableWorkbook writableWorkbook = Workbook.createWorkbook(exlFile); 
    WritableSheet writableSheet = writableWorkbook.createSheet("Sheet1", 0);
    
    Colour bckcolor = Colour.GREY_25_PERCENT;
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
    //font.setBoldStyle(WritableFont.BOLD);
    
    writableSheet.setColumnView(0, 6);
    writableSheet.setColumnView(1, 20);
    writableSheet.setColumnView(2, 16);
    writableSheet.setColumnView(3, 12);
    writableSheet.setColumnView(4, 12);
    writableSheet.setColumnView(5, 12);
    writableSheet.setColumnView(6, 12); 
    
    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK);
    cellRIghtformat.setAlignment(Alignment.RIGHT);
    cellRIghtformat.setFont(font);
    
    WritableCellFormat cellleftformat = new WritableCellFormat(); 
    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellleftformat.setFont(font);
    cellleftformat.setAlignment(Alignment.LEFT);

    writableSheet.mergeCells(0, 0,6, 0);
    Label labelHeading = new Label(0, 0, CompanyName + " Day wise Dispatch For The Month " + monthName , cellFormat);
    writableSheet.addCell(labelHeading);
    
    

    String ct=""; 
	int srno=0,finalCount=0; 
	double sum = 0;
	ArrayList dates = new ArrayList(); 
	ArrayList DayWIseSum = new ArrayList(); 
	double finalsum=0; 
	CallableStatement cs = con.prepareCall("{call Sel_RptDaywiseCastingSale(?,?,?)}");
	cs.setString(1, comp);
	cs.setString(2, month);
	cs.setString(3, db);
	ResultSet rs1 = cs.executeQuery();
	 while(rs1.next()){
		 dates.add(rs1.getString("Dates"));
	 }
	   
 // *********************************************************************************************************
HashSet hs = new HashSet();
hs.addAll(dates);
dates.clear();
dates.addAll(hs);
Collections.sort(dates); 
ArrayList dayUpdate = new ArrayList();
ArrayList dayUpdate1 = new ArrayList();
//***********************************************************************************************************
    Label label = new Label(0, 1, "Sr. No",cellFormat);
    Label label1 = new Label(1, 1, "Item Name",cellFormat);
    Label label2 = new Label(2, 1, "Grade Name",cellFormat);
    Label label3 = new Label(3, 1, "Schedule Qty",cellFormat);
    Label label4 = new Label(4, 1, "Disp / day",cellFormat);
    Label label5 = new Label(5, 1, "Avg Qty",cellFormat);
    Label label6 = new Label(6, 1, "Total Qty",cellFormat); 
     
	for (int index = 0; index < dates.size(); index++) {
		Label label_AddMe = new Label(index+7, 1, dates.get(index).toString(),cellFormat);
		writableSheet.addCell(label_AddMe);
		finalCount++;
		 } 
    
  	// Add the created Cells to the sheet
    writableSheet.addCell(label);
    writableSheet.addCell(label1);
    writableSheet.addCell(label2);
    writableSheet.addCell(label3);
    writableSheet.addCell(label4);
    writableSheet.addCell(label5);
    writableSheet.addCell(label6);
    
    
    
    
     //888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
	
	 for(int j=0;j<(dates.size());j++){
		 dayUpdate.add("-");
	}
	
	 for(int j=0;j<(dates.size());j++){
		 dayUpdate1.add("-");
	}
	 
	 for(int j=0;j<(dates.size());j++){
		 DayWIseSum.add("-");
	} 
	int l=0,r=2;
	CallableStatement cs11 = con.prepareCall("{call Sel_RptDaywiseCastingSale(?,?,?)}");
	cs11.setString(1, comp);
	cs11.setString(2, month);
	cs11.setString(3, db);
	ResultSet rs122 = cs11.executeQuery(); 
	while (rs122.next()) {
		if(ct==""){ 
			  srno = srno+1;
			  Label la0 = new Label(l, r, String.valueOf(srno) ,cellFormat);
			   writableSheet.addCell(la0);
			   l++; 
			   Label la1 = new Label(l, r, rs122.getString("MAT_NAME"),cellleftformat);
			   writableSheet.addCell(la1);
			   l++; 
			   Label la2 = new Label(l, r, rs122.getString("GRADE_NAME"),cellleftformat);
			   writableSheet.addCell(la2);
			   l++; 
			   Label la3 = new Label(l, r, rs122.getString("SCHEDULE_QTY"),cellRIghtformat);
			   writableSheet.addCell(la3);
			   l++; 
			   Label la4 = new Label(l, r, rs122.getString("PARDAY_DESPQTY"),cellRIghtformat);
			   writableSheet.addCell(la4);
			   l++; 
			   Label la5 = new Label(l, r, rs122.getString("AVG_QTY"),cellRIghtformat);
			   writableSheet.addCell(la5);
			   l++;
	CallableStatement callsp1 = con.prepareCall("{call Sel_RptDaywiseCastingSale(?,?,?)}");
	callsp1.setString(1, comp);
	callsp1.setString(2, month);
	callsp1.setString(3, db);
	
		ResultSet ressp1 = callsp1.executeQuery();
		while (ressp1.next()) {
			if(ressp1.getString("MAT_NAME").equalsIgnoreCase(rs122.getString("MAT_NAME"))){
			//	dayUpdate.add(Integer.parseInt(ressp1.getString("Dates"))-1, ressp1.getString("PROD_QTY")); 
				for(int j=0;j<(dates.size());j++){
					if(Integer.parseInt(ressp1.getString("Dates"))==Integer.parseInt(dates.get(j).toString())){
						dayUpdate.set(j, ressp1.getString("PARDAY_QTY"));
					}	 
				}
			}
		}
		// Horrizontal Sum Logic ====== > 
		
		for(int i2=0;i2<(dates.size());i2++){
			if(!dayUpdate.get(i2).toString().equalsIgnoreCase("-")){
			sum = sum +Double.parseDouble(dayUpdate.get(i2).toString());
		//	System.out.println("System Sum Patch = " + sum);
			}						
		} 
		Label la6 = new Label(l, r, String.valueOf(sum).replaceAll("\\.0*$", ""),cellRIghtformat);
		writableSheet.addCell(la6);
		l++;
		sum = 0;				
		for(int prd=0;prd<(dates.size());prd++){
			Label la7 = new Label(l, r, dayUpdate.get(prd).toString().replaceAll("\\.0*$", ""),cellRIghtformat);
			writableSheet.addCell(la7);
			l++; 
		}
		
		l=0;
		r++;
		
		// DayWIseSum.addAll(dayUpdate);
		for(int j=0;j<(dates.size());j++){
			DayWIseSum.set(j,dayUpdate.get(j).toString());
		}
		dayUpdate.clear();
		for(int j=0;j<(dates.size());j++){
			dayUpdate.add("-");
		}
		
		
	// 888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888	
		
		}else if(!rs122.getString("MAT_NAME").equalsIgnoreCase(ct)){
			l=0; 
			srno = srno+1;
			Label la0 = new Label(l, r, String.valueOf(srno),cellFormat);
			writableSheet.addCell(la0);
			l++; 
			Label la1 = new Label(l, r, rs122.getString("MAT_NAME"),cellleftformat);
			writableSheet.addCell(la1);
			l++; 
			Label la2 = new Label(l, r, rs122.getString("GRADE_NAME"),cellleftformat);
			writableSheet.addCell(la2);
			l++; 
			Label la3 = new Label(l, r, rs122.getString("SCHEDULE_QTY"),cellRIghtformat);
			writableSheet.addCell(la3);
			l++; 
			Label la4 = new Label(l, r, rs122.getString("PARDAY_DESPQTY"),cellRIghtformat);
			writableSheet.addCell(la4);
			l++; 
			Label la5 = new Label(l, r, rs122.getString("AVG_QTY"),cellRIghtformat);
			writableSheet.addCell(la5);
			l++; 
	  CallableStatement callsp = con.prepareCall("{call Sel_RptDaywiseCastingSale(?,?,?)}");
	  callsp.setString(1, comp);
	  callsp.setString(2, month);
	  callsp.setString(3, db);
		
		ResultSet ressp = callsp.executeQuery(); 
		while (ressp.next()) {
			if(ressp.getString("MAT_NAME").equalsIgnoreCase(rs122.getString("MAT_NAME"))){
				//dayUpdate1.add(Integer.parseInt(ressp.getString("Dates")), ressp.getString("PROD_QTY"));							
				for(int j=0;j<(dates.size());j++){
					if(Integer.parseInt(ressp.getString("Dates"))==Integer.parseInt(dates.get(j).toString())){
						dayUpdate1.set(j, ressp.getString("PARDAY_QTY"));
					}						 
				}
			}
		}
		
		// Horrizontal Sum Logic ====== >
		
		for(int i2=0;i2<(dates.size());i2++){
			if(!dayUpdate1.get(i2).toString().equalsIgnoreCase("-")){
			sum = sum +Double.parseDouble(dayUpdate1.get(i2).toString());
			//System.out.println("System Sum Patch = " + sum);
			}
		}
		
		for(int f=0;f<dates.size();f++){
			if(DayWIseSum.get(f).toString().equalsIgnoreCase("-")){
				DayWIseSum.set(f, 0);
			}
		}
		for(int i1=0;i1<dates.size();i1++){
			if(!dayUpdate1.get(i1).toString().equalsIgnoreCase("-")){							
				DayWIseSum.set(i1,(Double.parseDouble(DayWIseSum.get(i1).toString()) + Double.parseDouble(dayUpdate1.get(i1).toString())));
			//	DayWIseSum.remove(i1+1);
			}else{
				DayWIseSum.set(i1,DayWIseSum.get(i1).toString());
			//	DayWIseSum.remove(i1+1);
			}
		} 
		
		Label la6 = new Label(l, r, String.valueOf(sum).replaceAll("\\.0*$", ""),cellRIghtformat);
		writableSheet.addCell(la6);
		l++; 
		sum=0;
		
		for(int prd1=0;prd1<(dates.size());prd1++){
			Label la7 = new Label(l, r,dayUpdate1.get(prd1).toString().replaceAll("\\.0*$", ""),cellRIghtformat);
			writableSheet.addCell(la7);
			l++; 
			}
		//System.out.println("Date size ="+dayUpdate1.size() + " update = " + dayUpdate1);
		dayUpdate1.clear();
		for(int j=0;j<(dates.size());j++){
			 dayUpdate1.add("-");
		}
		l=0;
		r++;		
		} 
		ct = rs122.getString("MAT_NAME");
	}
 ct="";
 
 	Label la11 = new Label(l, r,"",cellRIghtformat);
	writableSheet.addCell(la11);
	l++;
	Label la12 = new Label(l, r,"",cellRIghtformat);
	writableSheet.addCell(la12);
	l++; 
	Label la13 = new Label(l, r,"",cellRIghtformat);
	writableSheet.addCell(la13);
	l++; 
	Label la14 = new Label(l, r,"",cellRIghtformat);
	writableSheet.addCell(la14);
	l++; 
	Label la15 = new Label(l, r,"",cellRIghtformat);
	writableSheet.addCell(la15);
	l++; 
	Label la16 = new Label(l, r,"",cellRIghtformat);
	writableSheet.addCell(la16);
	l++; 
	Label la17 = new Label(l, r,"Total",cellRIghtformat);
	writableSheet.addCell(la17);
	l++;
	for (int index = 0; index < dates.size(); index++) {
		Label la18 = new Label(l, r,DayWIseSum.get(index).toString().replaceAll("\\.0*$", ""),cellRIghtformat);
		writableSheet.addCell(la18);
		l++;
	}
    // ************************************************************************************************************************
    // Write and close the workbook
    writableWorkbook.write();
    writableWorkbook.close();
    
    String filePath = "C:/reportxls/DailyProd"+val+".xls";
%>
<span id="exportId">
<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=month%>','<%=db%>','<%=monthName%>')" style="cursor: pointer;">Generate Excel</button>
<a href="DownloadFile.jsp?filepath=<%=filePath %>" style="color: green;text-decoration: none;">Download File</a>
</span> 
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>