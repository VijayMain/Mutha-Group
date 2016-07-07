<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
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
	String comp =request.getParameter("comp");
	String OnDateMIS =request.getParameter("OnDateMIS"); 
	String db =request.getParameter("db");
	
	System.out.println("data = " + comp + OnDateMIS + db);
	
	Connection con = null;
	String CompanyName="",maindb="";

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
	
	//****************************************************************************************************************************************
	
	ArrayList alistFile = new ArrayList();
	File folder = new File("C:/reportxls");
	File[] listOfFiles = folder.listFiles();
	String listname = "";
	int val = listOfFiles.length + 1;

	File exlFile = new File("C:/reportxls/FoundryMIS"+val+".xls");
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

	Colour backHcolor = Colour.GRAY_25;
	WritableCellFormat cellFormat_header = new WritableCellFormat();
	// cellFormat_header.setBackground(backHcolor);
	cellFormat_header.setAlignment(Alignment.CENTRE); 
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
	WritableSheet writableSheet = writableWorkbook.createSheet("TestSheet", 1);

	writableSheet.setColumnView(0, 8);
	writableSheet.setColumnView(1, 35);
	writableSheet.setColumnView(2, 15);
	writableSheet.setColumnView(3, 15);
	writableSheet.setColumnView(4, 15);
	writableSheet.setColumnView(5, 15);
	writableSheet.setColumnView(6, 15);
	writableSheet.setColumnView(7, 15);
	writableSheet.setColumnView(9, 18);
	writableSheet.setColumnView(10, 14);
	writableSheet.setColumnView(11, 15);
	writableSheet.setColumnView(12, 12);
	writableSheet.setColumnView(13, 14);
	writableSheet.setColumnView(14, 14);
	writableSheet.setColumnView(15, 14);

	writableSheet.mergeCells(0, 0,10, 0);
	//  Cell rows 0,1
	writableSheet.mergeCells(0, 1,0, 2);
	writableSheet.mergeCells(1, 1,1, 2);
	writableSheet.mergeCells(2, 1,2, 2);
	writableSheet.mergeCells(3, 1,3, 2);
	writableSheet.mergeCells(4, 1,4, 2);
	writableSheet.mergeCells(5, 1,5, 2);
	writableSheet.mergeCells(6, 1,0, 1);
	writableSheet.mergeCells(7, 1,0, 1);
	writableSheet.mergeCells(9, 1,0, 1);

	Label ReportName = new Label(0, 0, CompanyName + "  Dispatch Plan v/s Sales As on  +asOnDate ",cellFormat_header);
	writableSheet.addCell(ReportName);
	Label label3 = new Label(0, 1, "Sr.No",cellFormat);
	Label label4 = new Label(1, 1, "Item Name",cellFormat);
	Label label5 = new Label(2, 1, "REQ/PERDAY",cellFormat);
	Label label6 = new Label(3, 1, "Sale AVG/PERDAY",cellFormat);
	Label lab6 = new Label(4, 1, "Delivery Rating %",cellFormat);
	Label label7 = new Label(5, 1, "T",cellFormat);
	Label label8 = new Label(6, 1, "C",cellFormat);
	Label label9 = new Label(7, 1, "SI",cellFormat);
	Label lab9 = new Label(8, 1, "Tol",cellFormat);
	Label label13 = new Label(9, 1, "Avge",cellFormat);
	// -----------------------------------------------------------------------------------------------------------------------
	   writableSheet.addCell(label3);
	   writableSheet.addCell(label4);
	   writableSheet.addCell(label5);
	   writableSheet.addCell(label6);
	   writableSheet.addCell(lab6);
	   writableSheet.addCell(label7);
	   writableSheet.addCell(label8);
	   writableSheet.addCell(label9);
	   writableSheet.addCell(lab9);
	   writableSheet.addCell(label13);
	// --------------------------------------------------------------------------------------------------------------
	   writableWorkbook.write();
	   writableWorkbook.close();
	
   String filePath = "C:/reportxls/FoundryMIS" + val + ".xls";
%>
<span id="exportId">
<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=OnDateMIS%>','<%=db%>')" style="cursor: pointer; font-family: Arial; font-size: 12px;">Generate Excel</button> 
<a href="DownloadFile.jsp?filepath=<%=filePath %>" style="color: green;text-decoration: none;">Download File</a><img alt="#" src="images/fileload.gif" id="fileloading" style="visibility: hidden;" />
</span>
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>