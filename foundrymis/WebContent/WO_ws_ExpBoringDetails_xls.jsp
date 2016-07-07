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
	Connection con =null;   
	String comp =request.getParameter("comp"); 
	String from =request.getParameter("from");
	String to =request.getParameter("to"); 
	String partyCode =request.getParameter("partyCode");
	String fromDate = from.substring(6,8) +"/"+ from.substring(4,6) +"/"+ from.substring(0,4);
	String toDate = to.substring(6,8) +"/"+ to.substring(4,6) +"/"+ to.substring(0,4);
	int row=3,col=0; 
	DecimalFormat twoDForm = new DecimalFormat("###0.00"); 
	 
	int ct=0;
	String CompanyName="";  
	double expected_Boring=0,recovery=0,openingwt=0;
	if(comp.equalsIgnoreCase("103")){
		CompanyName = "MUTHA FOUNDERS PVT. LTD.";
		con = ConnectionUrl.getFoundryERPNEWConnection();   
	} 
	String partName=""; 
	 
	CallableStatement cs11 = con.prepareCall("{call Sel_RptWOWiseBoringDetail(?,?,?,?)}");
	cs11.setString(1,comp);
	cs11.setString(2,"0");
	cs11.setString(3,from);
	cs11.setString(4,to); 
	ResultSet rs12 = cs11.executeQuery(); 
	while(rs12.next()){
		if(rs12.getString("SUB_GLACNO").equalsIgnoreCase(partyCode)){
			partName = rs12.getString("PARTY_NAME"); 
		}
	}   
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";  
	
 	int val = listOfFiles.length + 1; 
	
	File exlFile = new File("C:/reportxls/BoreDetl"+val+".xls");
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
    
    writableSheet.setColumnView(0, 15);
    writableSheet.setColumnView(1, 15);
    writableSheet.setColumnView(2, 35);
    writableSheet.setColumnView(3, 35);
    writableSheet.setColumnView(4, 15);
    writableSheet.setColumnView(5, 15);
    writableSheet.setColumnView(6, 15);
    writableSheet.setColumnView(7, 15);
    writableSheet.setColumnView(8, 15);
    writableSheet.setColumnView(9, 15);
    
    WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
    cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellRIghtformat.setFont(font);
    
    WritableCellFormat cellleftformat = new WritableCellFormat(); 
    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellleftformat.setFont(font); 				
        
    writableSheet.mergeCells(0, 0, 9, 0);
    Label labelName = new Label(0, 0, partName,cellFormat);
    writableSheet.addCell(labelName);
    
    Label label = new Label(0, 1, "W.O. No.",cellFormat);
    Label label1 = new Label(1, 1, "W.O. date ",cellFormat);
    Label label2 = new Label(2, 1, "Process Type",cellFormat);
    Label label3 = new Label(3, 1, "Item Description",cellFormat);
    Label label4 = new Label(4, 1, "Opening Bal.",cellFormat);
    Label label5 = new Label(5, 1, "Return boring.",cellFormat);
    Label label6 = new Label(6, 1, "Std.boring wt.",cellFormat);
    Label label7 = new Label(7, 1, "Inward qty",cellFormat);
    Label label8 = new Label(8, 1, "Expected boring",cellFormat); 
    Label label9 = new Label(9, 1, "Recovery bal",cellFormat);

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
  	//***********************************************************************************************************************************
    //***********************************************************************************************************************************
     double opBal=0,retBor=0,stdBore=0,inward=0,exp=0,reco=0;
    ResultSet rs = cs11.executeQuery();
    while(rs.next()){
    	if(rs.getString("SUB_GLACNO").equalsIgnoreCase(partyCode)){
    		if(rs.getString("MAT_CODE").equalsIgnoreCase("0")){
    			openingwt = Double.parseDouble(rs.getString("OPENING_WT"));
    			opBal = opBal + openingwt;
    			retBor = retBor + Double.parseDouble(rs.getString("RETURN_BORING"));
    			// merge cell (start from , row , up to , column)
    			 
    
    			 writableSheet.mergeCells(2, 2, 4, 1);
    			    Label labelName2 = new Label(0, 2, partName,cellleftformat);
    			    writableSheet.addCell(labelName2);

    	    		Number labelName3 = new Number(4, 2, Double.parseDouble(rs.getString("OPENING_WT")),cellRIghtformat);
    			    writableSheet.addCell(labelName3);
    			    Number labelName4 = new Number(5, 2, Double.parseDouble(rs.getString("RETURN_BORING")),cellRIghtformat);
    			    writableSheet.addCell(labelName4);
    		}else if(!rs.getString("MAT_CODE").equalsIgnoreCase("0")){
    			recovery=0;
    			expected_Boring=0;
    			if(rs.getString("EXPECTED_BORING")!=null && Double.parseDouble(rs.getString("EXPECTED_BORING"))!=0.000000){
    				 expected_Boring = Double.parseDouble(rs.getString("EXPECTED_BORING")); 
    			 }else{
    				 expected_Boring = 0;
    			 } 
    			recovery = openingwt + expected_Boring - Double.parseDouble(rs.getString("RETURN_BORING"));
    			stdBore = Double.parseDouble(rs.getString("BORI_WEIGHT")) + stdBore ;
    			inward = inward + Double.parseDouble(rs.getString("RECEIVED_QTY"));
    			exp = exp + expected_Boring;
    			reco = reco + recovery;
    			
    			Label lab1 = new Label(col, row, rs.getString("WO_DOCNO"),cellRIghtformat);
 			    writableSheet.addCell(lab1); 
 			    col++;
 			   Label lab2 = new Label(col, row, rs.getString("PRN_TRANDATE"),cellRIghtformat);
			    writableSheet.addCell(lab2); 
			    col++;
			    Label lab3 = new Label(col, row, rs.getString("NAME"),cellRIghtformat);
 			    writableSheet.addCell(lab3); 
 			    col++;
 			   Label lab4 = new Label(col, row, rs.getString("MAT_NAME"),cellRIghtformat);
			    writableSheet.addCell(lab4); 
			    col++;
			    col++;
			    col++;
			    Number lab5 = new Number(col, row, Double.parseDouble(rs.getString("BORI_WEIGHT")),cellRIghtformat);
 			    writableSheet.addCell(lab5); 
 			    col++;
 			   Number lab6 = new Number(col, row, Double.parseDouble(rs.getString("RECEIVED_QTY")),cellRIghtformat);
			    writableSheet.addCell(lab6); 
			    col++;
			    Number lab7 = new Number(col, row, expected_Boring,cellRIghtformat);
 			    writableSheet.addCell(lab7); 
 			    col++;
 			   Number lab8 = new Number(col, row, recovery,cellRIghtformat);
			    writableSheet.addCell(lab8);  
			    if(col==9){
			    	col=0;
			    	row++;
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
    
    String filePath = "C:/reportxls/BoreDetl"+val+".xls";
    
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
    // forces download
    String headerKey = "Content-Disposition";
    String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
    response.setHeader(headerKey, headerValue); 
    inStream.close(); 
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