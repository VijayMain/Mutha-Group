<%@page import="java.util.HashSet"%>
<%@page import="java.util.HashMap"%>
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
<span id="exportId">  
<%
try {	   
	 	String CompanyName="";
	    Connection con =null;     
	    
	    String sqlfromDate =request.getParameter("sqlfromDate"); 
	    String sqltoDate =request.getParameter("sqltoDate"); 
	    String comp =request.getParameter("comp");
	    String sup =request.getParameter("passSuppliers").toString();
	    String passSuppliers =request.getParameter("passSuppliers").toString();
	    int getcategoryDate = Integer.parseInt(request.getParameter("getcategoryDate"));
	    String ps_matType=request.getParameter("ps_matType"); 
	    
	 //   System.out.println("syetem ===== " + ps_matType);
	    
	    String rep_cat="";
	    if(getcategoryDate==1){
	    	rep_cat = "ISSUES & RECEIPT";
	    }
	    if(getcategoryDate==2){
	    	rep_cat = "ISSUES";
	    }
	    if(getcategoryDate==3){
	    	rep_cat = "RECEIPT";
	    }
	    String matType = "";

	    if(request.getParameter("ps_matType").equalsIgnoreCase("All")){
	    	Connection conMaster = ConnectionUrl.getBWAYSERPMASTERConnection();
	    	PreparedStatement ps_mst = conMaster.prepareStatement("select * from CNFMATERIALS");
	    	ResultSet rs_mst = ps_mst.executeQuery();
	    	while(rs_mst.next()){
	    		matType = matType + rs_mst.getString("CODE") + ",";
	    	}
	    	matType = matType.substring(0, matType.length() - 1);
	    }else{
	    	matType = request.getParameter("ps_matType");
	    }  
	   // System.out.println("syetem = " + matType);
DecimalFormat twoDForm = new DecimalFormat("#####0.00");
DecimalFormat threeDForm = new DecimalFormat("#####0.000");
DecimalFormat noDForm = new DecimalFormat("####0");
   
if(comp.equalsIgnoreCase("101")){
	CompanyName = "H-21 MUTHA ENGINEERING";
	con = ConnectionUrl.getMEPLH21ERP();
}
if(comp.equalsIgnoreCase("102")){
	CompanyName = "H-25 MUTHA ENGINEERING";
	con	= ConnectionUrl.getMEPLH25ERP(); 
} 
if(comp.equalsIgnoreCase("103")){
	CompanyName = "MUTHA FOUNDERS PVT. LTD.";
	con = ConnectionUrl.getFoundryERPNEWConnection();   
}
if(comp.equalsIgnoreCase("105")){
	CompanyName = "DHANASHREE INDUSTRIES";
	con=ConnectionUrl.getDIERPConnection();
}
if(comp.equalsIgnoreCase("106")){
	CompanyName = "MUTHA ENGINEERING UNIT III";
	con = ConnectionUrl.getK1ERPConnection();
}
boolean allFlag = false;
String supName="";
 if(sup.equalsIgnoreCase("All_Supplier")){
	 allFlag = true; 
	 /* sup = "101110054,101110069,101110100,101110233,101120645,101110205,101110475,101122002,101124452,101110347,101123158"; */
	 sup="101110032,101121994,101110060,101110070,101120646,101110054,101110069,101110100,101110233,101120645,101110205,101110475,101122002,101124452,101110347,101123158";
	 supName = "ALL"; 
 }else{
	 if(sup.equalsIgnoreCase("101")){
		 sup="101110054,101110069,101110100,101110233,101120645"; 
		 supName="MUTHA ENGINEERING PVT LTD (D) UNIT I";
	 }
	 if(sup.equalsIgnoreCase("102")){
		 sup="101110205,101110475,101122002,101124452,101121994"; 
		 supName="MUTHA ENGINEERING PVT LTD (D) UNIT II";
	 }
	 if(sup.equalsIgnoreCase("106")){
		 sup="101110347,101123158"; 
		 supName="MUTHA ENGINEERING PVT LTD (D) UNIT III";
	 }
 }
  
	String Sheet_Name = "";
	int sheetcnt=0;

	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";
	int val = listOfFiles.length + 1;

	File exlFile = new File("C:/reportxls/BranchTransfer"+val+".xls");
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
	 	
	
			 
			 if(getcategoryDate ==1 || getcategoryDate ==2){
			  int col=1;
				Sheet_Name = "ISSUE";
			  	WritableSheet writableSheet = writableWorkbook.createSheet(Sheet_Name, sheetcnt); 
			  			writableSheet.setColumnView(0, 12);
					    writableSheet.setColumnView(1, 12);
					    writableSheet.setColumnView(2, 30);
					    writableSheet.setColumnView(3, 30);
					    writableSheet.setColumnView(4, 12);
					    writableSheet.setColumnView(5, 12);
					    writableSheet.setColumnView(6, 12);
					    writableSheet.setColumnView(7, 12);
					    writableSheet.setColumnView(8, 12);
					    writableSheet.setColumnView(9, 12);
					    writableSheet.setColumnView(10, 30);
					    
					    Label label1 = new Label(0, 0, "GRN NO",cellFormat);
					    Label label2 = new Label(1, 0, "TRAN DATE",cellFormat);
					    Label label3 = new Label(2, 0, "SUPPLIER",cellFormat);
					    Label label4 = new Label(3, 0, "MATERIAL NAME" , cellFormat); 
					    Label label5 = new Label(4, 0, "TYPE", cellFormat);
					    Label label6 = new Label(5, 0, "REF. NO",cellFormat);   
					    Label label7 = new Label(6, 0, "RATE",cellFormat);
					    Label label8 = new Label(7, 0, "CHALLAN QTY",cellFormat);
					    Label label9 = new Label(8, 0, "CASTING WT",cellFormat); 
					    Label label10 = new Label(9, 0, "TONNAGE",cellFormat); 
					    Label label11 = new Label(10, 0, "NARRATION",cellFormat); 
					 
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
				PreparedStatement ps_bt = con.prepareStatement("select CONVERT(INT, SUBSTRING(CONVERT(VARCHAR,TRNMATPOST.TRAN_NO),13,6)) AS GRN_NO, "+
						" TRNMATPOST.TRAN_NO, "+
						" TRNMATPOST.TRAN_DATE, "+
						" DBO.FORMAT_DATE(TRNMATPOST.TRAN_DATE) AS PRN_TRNDATE, "+
						" TRNMATPOST.SUB_GLACNO1 AS SUB_GLACNO, "+
						" MSTACCTGLSUB.SUBGL_LONGNAME, "+
						" TRNMATPOST.MAT_CODE, "+
						" TRNSTORMATI.RATE, "+
						" TRNMATPOST.MAT_VALUE, "+
						" MSTMATERIALS.NAME, "+
						" MSTMATERIALS.MATERIAL_TYPE, "+
						" CNFMATERIALS.NAME as MAT_TYPE, "+
						" MSTMATERIALS.CASTING_WT, (CAST(MSTMATERIALS.CASTING_WT as FLOAT) * CAST(TRNMATPOST.QTY AS FLOAT)) as TONNAGE, "+
						" TRNMATPOST.QTY, "+
						" TRNMATPOST.SR_NO, "+
						" TRNACCTMATH.SHORT_NARRTN, "+
						" TRNACCTMATH.EXT_REF1 "+
						" from TRNMATPOST "+
						" LEFT JOIN TRNACCTMATH ON  TRNMATPOST.TRAN_NO = TRNACCTMATH.TRAN_NO "+ 
						" LEFT JOIN MSTACCTGLSUB ON  TRNMATPOST.SUB_GLACNO1 = MSTACCTGLSUB.SUB_GLACNO "+ 
						" LEFT JOIN MSTMATERIALS ON  TRNMATPOST.MAT_CODE = MSTMATERIALS.CODE  "+
						" LEFT JOIN CNFMATERIALS ON  CNFMATERIALS.CODE = MSTMATERIALS.MATERIAL_TYPE "+ 
						" LEFT JOIN TRNSTORMATI ON  TRNMATPOST.TRAN_NO = TRNSTORMATI.TRAN_NO AND TRNSTORMATI.MAT_CODE=TRNMATPOST.MAT_CODE "+
						" where TRNMATPOST.TRAN_NO like '%171821333%' "+
						" and TRNMATPOST.STATUS_CODE=0  AND  MSTMATERIALS.MATERIAL_TYPE IN ("+matType+") AND"+
						" TRNMATPOST.TRAN_DATE between '"+sqlfromDate+"' AND '" + sqltoDate +
						"' and MSTACCTGLSUB.SUB_GLACNO in(" + sup + ") " +
						" ORDER BY MSTACCTGLSUB.SUBGL_LONGNAME,MSTMATERIALS.NAME");
				ResultSet rs_bt = ps_bt.executeQuery();
				while(rs_bt.next()){
					Label lab0 = new  Label(0, col, rs_bt.getString("GRN_NO"),cellleftformat);
					writableSheet.addCell(lab0);
					
					Label lab1 = new  Label(1, col, rs_bt.getString("PRN_TRNDATE"),cellleftformat);
					writableSheet.addCell(lab1);
					
					Label lab2 = new  Label(2, col, rs_bt.getString("SUBGL_LONGNAME"),cellleftformat);
					writableSheet.addCell(lab2);
					
					Label lab3 = new  Label(3, col, rs_bt.getString("NAME"),cellleftformat);
					writableSheet.addCell(lab3);
					
					Label lab4 = new  Label(4, col, rs_bt.getString("MAT_TYPE"),cellleftformat);
					writableSheet.addCell(lab4);
					
					Label lab5 = new  Label(5, col, rs_bt.getString("EXT_REF1"),cellleftformat);
					writableSheet.addCell(lab5);
					
					/* 
					Label lab6 = new  Label(6, col, rs_bt.getString("RATE"),cellleftformat);
					writableSheet.addCell(lab6); 
					*/
					
					Number lab6 = new  Number(6, col, Double.parseDouble(rs_bt.getString("RATE")),cellRIghtformat);
					writableSheet.addCell(lab6);
					
					Number lab7 = new  Number(7, col, Double.valueOf(rs_bt.getString("QTY")) * -1,cellRIghtformat);
					writableSheet.addCell(lab7);
					
					/* Label lab8 = new  Label(8, col, threeDForm.format(Double.valueOf(rs_bt.getString("CASTING_WT"))),cellleftformat);
					writableSheet.addCell(lab8); */
					
					Number lab8 = new  Number(8, col, Double.valueOf(rs_bt.getString("CASTING_WT")),cellRIghtformat);
					writableSheet.addCell(lab8);
					
					/* Label lab9 = new  Label(9, col, twoDForm.format(Double.valueOf(rs_bt.getString("TONNAGE")) * -1),cellleftformat);
					writableSheet.addCell(lab9); */
					
					Number lab9 = new  Number(9, col, Double.valueOf(rs_bt.getString("TONNAGE")) * -1,cellRIghtformat);
					writableSheet.addCell(lab9);
					
					Label lab10 = new  Label(10, col, rs_bt.getString("SHORT_NARRTN"),cellleftformat);
					writableSheet.addCell(lab10);
					
					col++;
				}
				sheetcnt++;
			 }
  //************************************************************************************************************************
   	 
					if(getcategoryDate ==1 || getcategoryDate ==3){
					  int col=1;
					  Sheet_Name = "RECEIPT"; 
					  	WritableSheet writableSheet1 = writableWorkbook.createSheet(Sheet_Name, sheetcnt); 
					  			writableSheet1.setColumnView(0, 12);
							    writableSheet1.setColumnView(1, 12);
							    writableSheet1.setColumnView(2, 30);
							    writableSheet1.setColumnView(3, 30);
							    writableSheet1.setColumnView(4, 12);
							    writableSheet1.setColumnView(5, 12);
							    writableSheet1.setColumnView(6, 12);
							    writableSheet1.setColumnView(7, 12);
							    writableSheet1.setColumnView(8, 12);
							    writableSheet1.setColumnView(9, 12);
							    writableSheet1.setColumnView(10, 30);
							    
							    Label label_rec1 = new Label(0, 0, "GRN NO",cellFormat);
							    Label label_rec2 = new Label(1, 0, "TRAN DATE",cellFormat);
							    Label label_rec3 = new Label(2, 0, "SUPPLIER",cellFormat);
							    Label label_rec4 = new Label(3, 0, "MATERIAL NAME" , cellFormat); 
							    Label label_rec5 = new Label(4, 0, "TYPE", cellFormat);
							    Label label_rec6 = new Label(5, 0, "REF. NO",cellFormat);   
							    Label label_rec7 = new Label(6, 0, "RATE",cellFormat);
							    Label label_rec8 = new Label(7, 0, "CHALLAN QTY",cellFormat);
							    Label label_rec9 = new Label(8, 0, "CASTING WT",cellFormat); 
							    Label label_rec10 = new Label(9, 0, "TONNAGE",cellFormat); 
							    Label label_rec11 = new Label(10, 0, "NARRATION",cellFormat); 
							 
							 writableSheet1.addCell(label_rec1);
							 writableSheet1.addCell(label_rec2);
							 writableSheet1.addCell(label_rec3);					 
							 writableSheet1.addCell(label_rec4);
							 writableSheet1.addCell(label_rec5);
							 writableSheet1.addCell(label_rec6);
							 writableSheet1.addCell(label_rec7);
							 writableSheet1.addCell(label_rec8);
							 writableSheet1.addCell(label_rec9);
							 writableSheet1.addCell(label_rec10);
							 writableSheet1.addCell(label_rec11);
					  PreparedStatement ps_bt = con.prepareStatement("select CONVERT(INT, SUBSTRING(CONVERT(VARCHAR,TRNMATPOST.TRAN_NO),13,6)) AS GRN_NO, "+
								" TRNMATPOST.TRAN_NO, "+
								" TRNMATPOST.TRAN_DATE, "+
								" DBO.FORMAT_DATE(TRNMATPOST.TRAN_DATE) AS PRN_TRNDATE, "+
								" TRNMATPOST.SUB_GLACNO1 AS SUB_GLACNO, "+
								" MSTACCTGLSUB.SUBGL_LONGNAME, "+
								" TRNMATPOST.MAT_CODE, "+
								" TRNSTORMATI.RATE, "+
								" TRNMATPOST.MAT_VALUE, "+
								" MSTMATERIALS.NAME, "+
								" MSTMATERIALS.MATERIAL_TYPE, "+
								" CNFMATERIALS.NAME as MAT_TYPE, "+
								" MSTMATERIALS.CASTING_WT, (CAST(MSTMATERIALS.CASTING_WT as FLOAT) * CAST(TRNMATPOST.QTY AS FLOAT)) as TONNAGE, "+
								" TRNMATPOST.QTY, "+
								" TRNMATPOST.SR_NO, "+
								" TRNACCTMATH.SHORT_NARRTN, "+
								" TRNACCTMATH.EXT_REF1 "+
								" from TRNMATPOST "+
								" LEFT JOIN TRNACCTMATH ON  TRNMATPOST.TRAN_NO = TRNACCTMATH.TRAN_NO "+ 
								" LEFT JOIN MSTACCTGLSUB ON  TRNMATPOST.SUB_GLACNO1 = MSTACCTGLSUB.SUB_GLACNO "+ 
								" LEFT JOIN MSTMATERIALS ON  TRNMATPOST.MAT_CODE = MSTMATERIALS.CODE  "+
								" LEFT JOIN CNFMATERIALS ON  CNFMATERIALS.CODE = MSTMATERIALS.MATERIAL_TYPE "+ 
								" LEFT JOIN TRNSTORMATI ON  TRNMATPOST.TRAN_NO = TRNSTORMATI.TRAN_NO AND TRNSTORMATI.MAT_CODE=TRNMATPOST.MAT_CODE "+
								" where TRNMATPOST.TRAN_NO like '%171820232%' "+
								" and TRNMATPOST.STATUS_CODE=0  AND  MSTMATERIALS.MATERIAL_TYPE IN ("+matType+") AND"+
								" TRNMATPOST.TRAN_DATE between '"+sqlfromDate+"' AND '" + sqltoDate +
								"' and MSTACCTGLSUB.SUB_GLACNO in(" + sup + ") " +
								"  ORDER BY MSTACCTGLSUB.SUBGL_LONGNAME,MSTMATERIALS.NAME");
						ResultSet rs_bt = ps_bt.executeQuery();
						while(rs_bt.next()){
							Label lab0 = new  Label(0, col, rs_bt.getString("GRN_NO"),cellleftformat);
							writableSheet1.addCell(lab0);
							
							Label lab1 = new  Label(1, col, rs_bt.getString("PRN_TRNDATE"),cellleftformat);
							writableSheet1.addCell(lab1);
							
							Label lab2 = new  Label(2, col, rs_bt.getString("SUBGL_LONGNAME"),cellleftformat);
							writableSheet1.addCell(lab2);
							
							Label lab3 = new  Label(3, col, rs_bt.getString("NAME"),cellleftformat);
							writableSheet1.addCell(lab3);
							
							Label lab4 = new  Label(4, col, rs_bt.getString("MAT_TYPE"),cellleftformat);
							writableSheet1.addCell(lab4);
							
							Label lab5 = new  Label(5, col, rs_bt.getString("EXT_REF1"),cellleftformat);
							writableSheet1.addCell(lab5);
							
							/* Label lab6 = new  Label(6, col, rs_bt.getString("RATE"),cellleftformat);
							writableSheet1.addCell(lab6); */
							
							Number lab6 = new  Number(6, col, Double.parseDouble(rs_bt.getString("RATE")),cellRIghtformat);
							writableSheet1.addCell(lab6);
							
							Number lab7 = new  Number(7, col, Double.valueOf(rs_bt.getString("QTY")),cellRIghtformat);
							writableSheet1.addCell(lab7);
							
							/* Label lab8 = new  Label(8, col, threeDForm.format(Double.valueOf(rs_bt.getString("CASTING_WT"))),cellleftformat);
							writableSheet1.addCell(lab8); */
							
							Number lab8 = new  Number(8, col, Double.valueOf(rs_bt.getString("CASTING_WT")),cellRIghtformat);
							writableSheet1.addCell(lab8);
							
							/* Label lab9 = new  Label(9, col, twoDForm.format(Double.valueOf(rs_bt.getString("TONNAGE"))),cellleftformat);
							writableSheet1.addCell(lab9); */
							
							Number lab9 = new  Number(9, col, Double.valueOf(rs_bt.getString("TONNAGE")),cellRIghtformat);
							writableSheet1.addCell(lab9);
							
							Label lab10 = new  Label(10, col, rs_bt.getString("SHORT_NARRTN"),cellleftformat);
							writableSheet1.addCell(lab10);
							col++;
						}
						sheetcnt++;
					 }
  
  //************************************************************************************************************************
   //************************************************ File Output Ligic *****************************************************
  //************************************************************************************************************************
  	  writableWorkbook.write();
  	  writableWorkbook.close(); 
    String filePath = "C:/reportxls/BranchTransfer"+val+".xls";    
%>

<button id="filebutton"  onclick="getExcel_Report('<%=sqlfromDate%>','<%=sqltoDate%>','<%=passSuppliers%>','<%=comp%>','<%=getcategoryDate%>','<%=ps_matType%>')" style="cursor: pointer;" disabled="disabled">Generate Excel</button>
<a href="DownloadFile.jsp?filepath=<%=filePath %>" style="color: green;text-decoration: none;">Download File</a>

<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</span> 
</body>
</html>