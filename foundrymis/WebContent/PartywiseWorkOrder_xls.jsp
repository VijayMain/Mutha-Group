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
<%
try {	   //  xmlhttp.open("POST", "PartywisePorder_xls.jsp?comp=" + comp +"&sup="+sup+"&from="+from+"&to="+to, true);
	 	String CompanyName="";
	    Connection con =null;    
	    String comp =request.getParameter("comp");
	    String sup = request.getParameter("sup");
	    String from =request.getParameter("from"); 
	    String to =request.getParameter("to");  
	    int row=0,col=1; 

	    
	    
	    String group="";
	    int ct=1; ;
	    if(comp.equalsIgnoreCase("101")){
	    	CompanyName = "H-21";
	    	con = ConnectionUrl.getMEPLH21ERP();   
	    }if(comp.equalsIgnoreCase("102")){
	    	CompanyName = "H-25";
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
	     
	    
	    
	    
	 // ArrayList<String> al = new ArrayList<String>();
	    boolean allFlag = false;
	     if(sup.equalsIgnoreCase("All_Supplier")){
	    	 allFlag = true;
	    /*  int cnt=0;
	     PreparedStatement ps_sp=con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLCODE=12");
	     ResultSet rs_sp=ps_sp.executeQuery();
	     while(rs_sp.next()){
	    	 if(cnt ==0 ){
	    		 sup = rs_sp.getString("SUB_GLACNO");
	    		 al.add(rs_sp.getString("SUB_GLACNO"));
	    		 cnt=1;
	    	 }else{
	    		 sup += rs_sp.getString("SUB_GLACNO");
	    		 al.add(rs_sp.getString("SUB_GLACNO"));
	    	 }
	     	} */
	     }else{
	    	 PreparedStatement ps_sp=con.prepareStatement("select * from MSTACCTGLSUB where SUB_GLACNO='"+sup+"'");
	    	 ResultSet rs_sp=ps_sp.executeQuery();
	    	 while(rs_sp.next()){
	    		 sup = rs_sp.getString("SUBGL_LONGNAME");
	    	 }
	     }
	   // System.out.println("Suppliers = " + sup);
	    
	String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
	 
	
	String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);
	DecimalFormat zeroDForm = new DecimalFormat("##0.00");
	DecimalFormat noDForm = new DecimalFormat("##0");
	
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";  
	
 	int val = listOfFiles.length + 1;
	
	File exlFile = new File("C:/reportxls/ReportWO"+val+".xls");
    WritableWorkbook writableWorkbook = Workbook.createWorkbook(exlFile); 
    WritableSheet writableSheet = writableWorkbook.createSheet("Sheet1", 0);
    
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
    
    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellRIghtformat.setFont(font);
    
    WritableCellFormat cellleftformat = new WritableCellFormat(); 
    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellleftformat.setFont(font); 				
    
    Label label = new Label(0, 0, "PO NO.",cellFormat);
    Label label1 = new Label(1, 0, "Amend No",cellFormat);
    Label label2 = new Label(2, 0, "PO DATE",cellFormat);
    Label label3 = new Label(3, 0, "Supplier Name",cellFormat);
    Label label4 = new Label(4, 0, "Part Name",cellFormat);
     /* Label label5 = new Label(5, 0, "With Effect From",cellFormat); */
    Label label5 = new Label(5, 0, "Sr No",cellFormat);
    Label label6 = new Label(6, 0, "Wgt kgs",cellFormat);
    Label label7 = new Label(7, 0, "Boring Wgt kgs",cellFormat);
    Label label8 = new Label(8, 0, "Rs/Pc",cellFormat);
    Label label9 = new Label(9, 0, "Remark",cellFormat);

  // Add the created Cells to the sheet
    writableSheet.addCell(label);
    writableSheet.addCell(label1);
    writableSheet.addCell(label2);
    writableSheet.addCell(label3);
    writableSheet.addCell(label4);
    /* writableSheet.addCell(label5); */
    writableSheet.addCell(label5);
    writableSheet.addCell(label6);
    writableSheet.addCell(label7);
    writableSheet.addCell(label8);
    writableSheet.addCell(label9);
  	//***********************************************************************************************************************************
    //***********************************************************************************************************************************
    CallableStatement cs11 = con.prepareCall("{call Sel_RptPORegister(?,?,?,?,?,?)}");
	cs11.setString(1,comp);
	cs11.setString(2,"0");
	cs11.setString(3,"4038,4034,4033,4039");
	cs11.setString(4,from);
	cs11.setString(5,to);
	cs11.setString(6,"0"); 
	
	ResultSet rs = cs11.executeQuery();
	
	if(allFlag==true){
while(rs.next()){
	Label po_nolbl = new Label(row, col, rs.getString("TRNNO").substring(3, 7) + " - " + rs.getString("PO_NO") ,cellRIghtformat); 
	row++;
	Number amdatelbl = new Number(row, col, Double.parseDouble(rs.getString("AMEND_NO")),cellRIghtformat); 
	row++;
	Label po_datelbl = new Label(row, col,rs.getString("PRN_PODATE"),cellleftformat); 
	row++; 
		Label supnamelbl = new Label(row, col, rs.getString("SUPP_NAME"),cellRIghtformat);
		row++;
		Label partnamelbl = new Label(row, col, rs.getString("MAT_NAME"),cellRIghtformat);
		row++;

Number srnolbl = new Number(row, col,Integer.parseInt(rs.getString("SR_NO")),cellRIghtformat); 
row++;
Number wtkglbl = new Number(row, col,Double.parseDouble(rs.getString("WEIGHT")),cellRIghtformat);
row++;
Number boriwtkglbl = new Number(row, col,Double.parseDouble(rs.getString("BORI_WEIGHT")),cellRIghtformat);
row++;
Number ratepplbl = new Number(row, col, Double.parseDouble(rs.getString("RATE")),cellRIghtformat); 
row++;
Label remarklbl = new Label(row, col, rs.getString("PAY_REMRK"),cellleftformat);

writableSheet.addCell(po_nolbl);
writableSheet.addCell(amdatelbl);
writableSheet.addCell(po_datelbl);
writableSheet.addCell(supnamelbl);
writableSheet.addCell(partnamelbl);  
		/* writableSheet.addCell(witheffectlbl); */
		writableSheet.addCell(srnolbl); 
		writableSheet.addCell(wtkglbl);
		writableSheet.addCell(boriwtkglbl);
		writableSheet.addCell(ratepplbl);	 
		writableSheet.addCell(remarklbl);
		row++;
		
		if(row==10){
			row=0;
			col++;   
		} 
}
	}
	if(allFlag==false){
		while(rs.next()){
			if(sup.equalsIgnoreCase(rs.getString("SUPP_NAME"))){
				Label po_nolbl = new Label(row, col, rs.getString("TRNNO").substring(3, 7) + " - " + rs.getString("PO_NO") ,cellRIghtformat); 
				row++;
				Number amdatelbl = new Number(row, col, Double.parseDouble(rs.getString("AMEND_NO")),cellRIghtformat);
				row++;
				Label po_datelbl = new Label(row, col,rs.getString("PRN_PODATE"),cellleftformat); 
				row++; 
			Label supnamelbl = new Label(row, col, rs.getString("SUPP_NAME"),cellRIghtformat);
			row++;
			Label partnamelbl = new Label(row, col, rs.getString("MAT_NAME"),cellRIghtformat);
			row++;
	
	
	
	Number srnolbl = new Number(row, col,Integer.parseInt(rs.getString("SR_NO")),cellRIghtformat); 
	row++;
	Number wtkglbl = new Number(row, col,Double.parseDouble(rs.getString("WEIGHT")),cellRIghtformat);
	row++;
	Number boriwtkglbl = new Number(row, col,Double.parseDouble(rs.getString("BORI_WEIGHT")),cellRIghtformat);
	row++;
	Number ratepplbl = new Number(row, col, Double.parseDouble(rs.getString("RATE")),cellRIghtformat); 
	row++;
	Label remarklbl = new Label(row, col, rs.getString("PAY_REMRK"),cellleftformat);

	writableSheet.addCell(po_nolbl);
	writableSheet.addCell(amdatelbl);
	writableSheet.addCell(po_datelbl);
	writableSheet.addCell(supnamelbl);
	writableSheet.addCell(partnamelbl);
			 /* writableSheet.addCell(witheffectlbl); */
			writableSheet.addCell(srnolbl); 
			writableSheet.addCell(wtkglbl);
			writableSheet.addCell(boriwtkglbl);
			writableSheet.addCell(ratepplbl);	 
			writableSheet.addCell(remarklbl);
			row++;
			
			if(row==10){
				row=0;
				col++;   
			} 
	}
	}
	}
  //************************************************************************************************************************
  //************************************************ File Output Ligic *****************************************************
  //************************************************************************************************************************
    //Write and close the workbook
    writableWorkbook.write();
    writableWorkbook.close();
    
    String filePath = "C:/reportxls/ReportWO"+val+".xls";
    
   /*  File downloadFile = new File(filePath);
    FileInputStream inStream = new FileInputStream(downloadFile);
      
    ServletContext context = getServletContext();
     
    // gets MIME type of the file
    String mimeType = context.getMimeType(filePath);
    if (mimeType == null) {        
        // set to binary type if MIME mapping not found
        mimeType = "application/octet-stream";
    }
      
    // modifies response
    response.setContentType(mimeType);
    response.setContentLength((int) downloadFile.length()); 
    // forces download
    String headerKey = "Content-Disposition";
    String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
    response.setHeader(headerKey, headerValue); 
    inStream.close();  */
%>
<span id="exportId"> 
<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=from%>','<%=to%>')" style="cursor: pointer;" disabled="disabled">Generate Excel</button>
<a href="DownloadFile.jsp?filepath=<%=filePath %>" style="color: green;text-decoration: none;">Download File</a>
</span> 
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>