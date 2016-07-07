<%@page import="java.io.FileInputStream"%>
<%@page import="jxl.write.Number"%>
<%@page import="jxl.write.Label"%>
<%@page import="jxl.format.BorderLineStyle"%>
<%@page import="jxl.format.Border"%>
<%@page import="jxl.format.Alignment"%>
<%@page import="jxl.write.WritableCellFormat"%>
<%@page import="jxl.write.WritableFont"%>
<%@page import="jxl.format.Colour"%>
<%@page import="jxl.write.WritableSheet"%>
<%@page import="jxl.Workbook"%>
<%@page import="jxl.write.WritableWorkbook"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionUtil.ConnectionUrl"%> 
<html>
<head> 
</head>
<body>
<%
try {
	Connection con =null;   
	String comp = "101";  
	int row=2,col=0,sr=1;  
	String CompanyName="";   
	
	if(comp.equalsIgnoreCase("101")){
		CompanyName = "MEPL H21";
		con = ConnectionUrl.getMEPLH21ERP();
	}
	if(comp.equalsIgnoreCase("102")){
		CompanyName = "MEPL H25";
		con = ConnectionUrl.getMEPLH25ERP();
	} 
	if(comp.equalsIgnoreCase("103")){
		CompanyName = "MUTHA FOUNDERS";
		con = ConnectionUrl.getFoundryERPNEWConnection();
	}
	if(comp.equalsIgnoreCase("105")){
		CompanyName = "DHANASHREE INDUSTRIES";
		con = ConnectionUrl.getDIERPConnection();
	}
	if(comp.equalsIgnoreCase("106")){
		CompanyName = "MEPL UNIT III";
		con = ConnectionUrl.getK1ERPConnection();
	} 
	
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
    writableSheet.setColumnView(1, 35);
    writableSheet.setColumnView(2, 15);
    writableSheet.setColumnView(3, 15);
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
    cellRIghtformat.setAlignment(Alignment.RIGHT);
    
    WritableCellFormat cellleftformat = new WritableCellFormat(); 
    cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
    font.setColour(Colour.BLACK); 
    cellleftformat.setFont(font); 				
    cellleftformat.setAlignment(Alignment.LEFT);
        
    writableSheet.mergeCells(0, 0, 9, 0);
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
    Label label8 = new Label(8, 1, "Due Days",cellFormat);
    Label label9 = new Label(9, 1, "Amount",cellFormat);

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
    
     CallableStatement cs = con.prepareCall("{call Sel_OutstandingDetails(?,?,?,?,?,?)}");
		cs.setString(1, "101");
		cs.setString(2, "0"); 
		cs.setString (3, "101120020101120003101120007101120009101120010101120013101120015"); 
		cs.setString(4, "20150320");
		cs.setString(5, "0");
		cs.setString(6, "1");
    ResultSet rs = cs.executeQuery();
    while(rs.next()){
    		Number nolbl = new Number(col, row, sr,cellRIghtformat);
		    writableSheet.addCell(nolbl); 
		    col++;
		    sr++;		    
    			Label lab1 = new Label(col, row, rs.getString("SUBGL_NAME"),cellleftformat);
 			    writableSheet.addCell(lab1); 
 			    col++;
 			   Number lab2 = new Number(col, row, Integer.parseInt(rs.getString("REF_TRANNO")),cellRIghtformat);
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
 			   Number lab8 = new Number(col, row, Integer.parseInt(rs.getString("DUE_DAYS")),cellRIghtformat);
			    writableSheet.addCell(lab8);
			    col++;
			    Label lab9 = new Label(col, row, rs.getString("AMOUNT"),cellRIghtformat);
			    writableSheet.addCell(lab9);  
			    			    
			    if(col==9){
			    	col=0;
			    	row++;
			    }
    		}	 
    
  		// Write and close the workbook
    	writableWorkbook.write();
    	writableWorkbook.close();
  //************************************************************************************************************************
  //************************************************ File Output Ligic *****************************************************
  //************************************************************************************************************************
    
    
    String filePath = "C:/reportxls/Automail"+val+".xls";
    
}catch(Exception e){
	e.printStackTrace();
}
%>

<table width="200" border="1">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td rowspan="2">&nbsp;</td>
    <td rowspan="2">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>


</body>
</html>