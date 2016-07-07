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
	
	String comp="",from="",to="",sup="";
	comp = request.getParameter("comp");
	from = request.getParameter("from");
	to = request.getParameter("to");
	sup = request.getParameter("sup");
	 
	ArrayList check_list = new ArrayList();
	
	String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
	String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);
	
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";
	
 	int val = listOfFiles.length + 1;
	
	File exlFile = new File("C:/reportxls/VBRR_stk"+val+".xls");
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
    
    if(!sup.equalsIgnoreCase("All_Suppliers")){
    
    
    writableSheet.setColumnView(0, 12);
    writableSheet.setColumnView(1, 12);
    writableSheet.setColumnView(2, 40);
    writableSheet.setColumnView(3, 12);
    writableSheet.setColumnView(4, 12);
    writableSheet.setColumnView(5, 12);
    writableSheet.setColumnView(6, 12);  
    
    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellRIghtformat.setFont(font);
    
    WritableCellFormat cellleftformat = new WritableCellFormat(); 
    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellleftformat.setFont(font);
    
    String supplier  = "Vendor Boring Receipt Report of "+ sup+" ( " + fromDate +"  to  "+toDate+" ) ";
    
    writableSheet.mergeCells(0, 0, 6, 0);
    Label labelName = new Label(0, 0, supplier,cellFormat);
    writableSheet.addCell(labelName);
    
    // Sr.No. Item Name Gate IN No GRN NO. GRN Date Challan No Challan Qty Challan Date 
 	
    Label label = new Label(0, 1, "GRN Date",cellFormat);
    Label label1 = new Label(1, 1, "GRN NO.",cellFormat);
    Label label2 = new Label(2, 1, "Item Name",cellFormat);
    Label label3 = new Label(3, 1, "Challan No",cellFormat);
    Label label4 = new Label(4, 1, "Challan Date",cellFormat); 
    Label label5 = new Label(5, 1, "Gate IN No",cellFormat); 
    Label label6 = new Label(6, 1, "Challan Qty",cellFormat);
    

  //Add the created Cells to the sheet
    writableSheet.addCell(label);
    writableSheet.addCell(label1);
    writableSheet.addCell(label2);
    writableSheet.addCell(label3);
    writableSheet.addCell(label4);
    writableSheet.addCell(label5);
    writableSheet.addCell(label6);  
     
    String CompanyName="";
    Connection con = null;
    if(comp.equalsIgnoreCase("101")){
    	CompanyName = "H-21";
    	con = ConnectionUrl.getMEPLH21ERP(); 
    }else{
    	CompanyName = "H-25";
    	con	= ConnectionUrl.getMEPLH25ERP(); 
    } 
    
  	//***********************************************************************************************************************************
    //***********************************************************************************************************************************
    int row=0,col=2;
    DecimalFormat zeroDForm = new DecimalFormat("0");
    CallableStatement cs = con.prepareCall("{call Sel_BoringRegister(?,?,?,?,?)}");
	cs.setString(1,comp);
	cs.setString(2,"0");
	cs.setString(3,from);
	cs.setString(4,to);
	cs.setString(5,"103,131"); 
	ResultSet rs = cs.executeQuery(); 
	while(rs.next()){
		if(sup.equalsIgnoreCase(rs.getString("AC_NAME"))){
			Label trndate_lable = new Label(row, col,rs.getString("PRN_TRANDATE") ,cellRIghtformat);
			row++;
			Number grn_lable = new Number(row, col,Integer.parseInt(rs.getString("GRN_NO") ) ,cellRIghtformat);
			row++;
			Label mat_lable = new Label(row, col, rs.getString("MATNAME") ,cellleftformat);
			row++;	
			Number cln_lable = new Number(row, col,Integer.parseInt(rs.getString("CHLNNO") ) ,cellRIghtformat);
			row++;
			Label chnDate_lable = new Label(row, col, rs.getString("CHLNDATE")  ,cellRIghtformat);
			row++; 
			Number inwd_lable = new Number(row, col,Integer.parseInt(rs.getString("INWNO") ) ,cellRIghtformat);
			row++; 
			Number chnQty_lable = new Number(row, col,Double.parseDouble(rs.getString("CHLN_QTY") ) ,cellRIghtformat); 
		
		writableSheet.addCell(trndate_lable);
		writableSheet.addCell(grn_lable);
		writableSheet.addCell(mat_lable);
		writableSheet.addCell(cln_lable);
		writableSheet.addCell(chnDate_lable); 
		writableSheet.addCell(inwd_lable);
		writableSheet.addCell(chnQty_lable); 
		
		row++;
		if(row==7){
			row=0;
			col++;
		}
	}
}
  //************************************************************************************************************************
  //************************************************ File Output Ligic *****************************************************
  //************************************************************************************************************************
    //Write and close the workbook
    writableWorkbook.write();
    writableWorkbook.close();
    
    String filePath = "C:/reportxls/VBRR_stk"+val+".xls";
    
    File downloadFile = new File(filePath);
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
    
    //forces download
    String headerKey = "Content-Disposition";
    String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
    response.setHeader(headerKey, headerValue);
      
    inStream.close(); 
%>
<span id="exportId"> 
<button id="filebutton" disabled="disabled" onclick="getExcel_Report('<%=comp%>','<%=sup%>','<%=from%>','<%=to%>')" style="cursor: pointer;">Generate Excel</button>
<a href="DownloadFile.jsp?filepath=<%=filePath %>" style="color: green;text-decoration: none;">Download File</a>
</span> 
<% 
 }else{
	 

		ResultSet rs = null;
	 writableSheet.setColumnView(0, 35);
	 writableSheet.setColumnView(1, 35);
	    writableSheet.setColumnView(2, 12);
	    writableSheet.setColumnView(3, 12);	    
	    writableSheet.setColumnView(4, 12);
	    writableSheet.setColumnView(5, 12);
	    writableSheet.setColumnView(6, 12);
	    writableSheet.setColumnView(7, 12);  
	    
	    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
	    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
	    font.setColour(Colour.BLACK); 
	    cellRIghtformat.setFont(font);
	    
	    WritableCellFormat cellleftformat = new WritableCellFormat(); 
	    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
	    font.setColour(Colour.BLACK); 
	    cellleftformat.setFont(font);
	    
	    String supplier  = "Vendor Boring Receipt Report of "+ sup+" ( " + fromDate +"  to  "+toDate+" ) ";
	    
	    writableSheet.mergeCells(0, 0, 7, 0);
	    Label labelName = new Label(0, 0, supplier,cellFormat);
	    writableSheet.addCell(labelName);
	    
	    // Sr.No. Item Name Gate IN No GRN NO. GRN Date Challan No Challan Qty Challan Date 
	 	
	    Label label = new Label(0, 1, "Suppliers Name",cellFormat);
	    Label label1 = new Label(1, 1, "Item Name",cellFormat);
	    Label label2 = new Label(2, 1, "GRN Date",cellFormat);
	    Label label3 = new Label(3, 1, "GRN NO.",cellFormat);
	    Label label4 = new Label(4, 1, "Challan No",cellFormat);
	    Label label5 = new Label(5, 1, "Challan Date",cellFormat); 
	    Label label6 = new Label(6, 1, "Gate IN No",cellFormat); 
	    Label label7 = new Label(7, 1, "Challan Qty",cellFormat);
	    

	  //Add the created Cells to the sheet
	    writableSheet.addCell(label);
	    writableSheet.addCell(label1);
	    writableSheet.addCell(label2);
	    writableSheet.addCell(label3);
	    writableSheet.addCell(label4);
	    writableSheet.addCell(label5);
	    writableSheet.addCell(label6);
	    writableSheet.addCell(label7);
	     
	    String CompanyName="";
	    Connection con = null;
	    if(comp.equalsIgnoreCase("101")){
	    	CompanyName = "H-21";
	    	con = ConnectionUrl.getMEPLH21ERP(); 
	    }else{
	    	CompanyName = "H-25";
	    	con	= ConnectionUrl.getMEPLH25ERP(); 
	    } 
	    
	  	//***********************************************************************************************************************************
	    //***********************************************************************************************************************************
	    int row=0,col=2;
	    DecimalFormat zeroDForm = new DecimalFormat("0");
	    CallableStatement cs = con.prepareCall("{call Sel_BoringRegister(?,?,?,?,?)}");
		cs.setString(1,comp);
		cs.setString(2,"0");
		cs.setString(3,from);
		cs.setString(4,to);
		cs.setString(5,"103,131");  
		
		ResultSet rs_check = cs.executeQuery();
		while(rs_check.next()){
		check_list.add(rs_check.getString("AC_NAME"));	
		}
		rs_check.close(); 
		
		HashSet hs = new HashSet();
		hs.addAll(check_list);
		check_list.clear();
		check_list.addAll(hs); 
		
		for(int i=0;i<check_list.size();i++){
		rs = cs.executeQuery();
		while(rs.next()){
			if(rs.getString("AC_NAME").equalsIgnoreCase(check_list.get(i).toString())){
				Label AC_NAME_lable = new Label(row, col, rs.getString("AC_NAME") ,cellleftformat);
				writableSheet.addCell(AC_NAME_lable);
				row++;				
				Label mat_lable = new Label(row, col, rs.getString("MATNAME") ,cellleftformat);
				row++;
				Label trndate_lable = new Label(row, col,rs.getString("PRN_TRANDATE") ,cellRIghtformat);
				row++;
				Number grn_lable = new Number(row, col,Integer.parseInt(rs.getString("GRN_NO") ) ,cellRIghtformat);
				
				row++;	
				Number cln_lable = new Number(row, col,Integer.parseInt(rs.getString("CHLNNO") ) ,cellRIghtformat);
				row++;
				Label chnDate_lable = new Label(row, col, rs.getString("CHLNDATE")  ,cellRIghtformat);
				row++; 
				Number inwd_lable = new Number(row, col,Integer.parseInt(rs.getString("INWNO") ) ,cellRIghtformat);
				row++; 
				Number chnQty_lable = new Number(row, col,Double.parseDouble(rs.getString("CHLN_QTY") ) ,cellRIghtformat); 
			
				
				writableSheet.addCell(mat_lable);
			writableSheet.addCell(trndate_lable);
			writableSheet.addCell(grn_lable); 
			writableSheet.addCell(cln_lable);
			writableSheet.addCell(chnDate_lable); 
			writableSheet.addCell(inwd_lable);
			writableSheet.addCell(chnQty_lable); 
			
			row++;
			if(row==8){
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
	    
	    String filePath = "C:/reportxls/VBRR_stk"+val+".xls";
	    
	    File downloadFile = new File(filePath);
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
	    
	    //forces download
	    String headerKey = "Content-Disposition";
	    String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
	    response.setHeader(headerKey, headerValue);
	    
	    inStream.close(); 
%>
<span id="exportId"> 
<button id="filebutton" disabled="disabled" onclick="getExcel_Report('<%=comp%>','<%=sup%>','<%=from%>','<%=to%>')" style="cursor: pointer;">Generate Excel</button>
<a href="DownloadFile.jsp?filepath=<%=filePath %>" style="color: green;text-decoration: none;">Download File</a>
</span>
<%	 
    }
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>