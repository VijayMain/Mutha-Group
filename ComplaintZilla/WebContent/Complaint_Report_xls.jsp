<%@page import="java.io.FileInputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.muthagroup.bo.GetUserName_BO"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
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
<%@page import="java.util.ArrayList"%>
<%@page import="jxl.write.Label"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Done Report</title>
</head>
<body>
<%
try{
	int uid, count = 0;
	SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MM-yyyy");
	Connection con = Connection_Utility.getConnection();
	GetUserName_BO ubo = new GetUserName_BO();
	uid = Integer.parseInt(session.getAttribute("uid").toString());
	String U_Name = ubo.getUserName(uid);
	count = Integer.parseInt(session.getAttribute("count").toString());
	
	
	
	int comp = Integer.parseInt(request.getParameter("comp"));
	String status  = request.getParameter("status");
	String fromDate  = request.getParameter("fromDate");
	String toDate  = request.getParameter("toDate");
	
	
	
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	PreparedStatement ps_sel = null;
	ResultSet rs_sel = null;
	 
    if(fromDate!="" && toDate !="" && comp==6){
    	ps_sel = con.prepareStatement("select * from complaint_tbl where Status_Id="+Integer.parseInt(status)+" and Complaint_Date BETWEEN '"+fromDate+"' and '"+toDate+"'");
    	rs_sel = ps_sel.executeQuery(); 
    }
    if(fromDate!="" && toDate !="" && comp!=6){
    	ps_sel = con.prepareStatement("select * from complaint_tbl where Status_Id="+Integer.parseInt(status)+" and Company_Id="+comp+" and Complaint_Date BETWEEN '"+fromDate+"' and '"+toDate+"'");
    	rs_sel = ps_sel.executeQuery(); 
    }
    if(comp!=6 && (fromDate=="" || toDate =="")){
    	ps_sel = con.prepareStatement("select * from complaint_tbl where Status_Id="+Integer.parseInt(status)+" and Company_Id="+comp);
    	rs_sel = ps_sel.executeQuery();
    }
    if(comp==6 && (fromDate=="" || toDate =="")){
    	ps_sel = con.prepareStatement("select * from complaint_tbl where Status_Id="+Integer.parseInt(status));
    	rs_sel = ps_sel.executeQuery(); 
    }
    
    if(Integer.parseInt(status)==0 && comp==6 && (fromDate=="" || toDate =="")){
    	ps_sel = con.prepareStatement("select * from complaint_tbl order by Company_Id");
    	rs_sel = ps_sel.executeQuery();
    }
    if(Integer.parseInt(status)==0 && comp!=6 && (fromDate=="" || toDate =="")){
    	ps_sel = con.prepareStatement("select * from complaint_tbl where Company_Id="+comp);
    	rs_sel = ps_sel.executeQuery();
    }
    if(Integer.parseInt(status)==0 && comp==6 && (fromDate!="" || toDate !="")){
    	ps_sel = con.prepareStatement("select * from complaint_tbl where Complaint_Date BETWEEN '"+fromDate+"' and '"+toDate+"' order by Company_Id");
    	rs_sel = ps_sel.executeQuery();
    }
    if(Integer.parseInt(status)==0 && comp!=6 && (fromDate!="" || toDate !="")){
    	ps_sel = con.prepareStatement("select * from complaint_tbl where Company_Id="+comp+" and Complaint_Date BETWEEN '"+fromDate+"' and '"+toDate+"'");
    	rs_sel = ps_sel.executeQuery();
    }
    
    
ArrayList alistFile = new ArrayList();
File folder = new File("C:/reportxls");
File[] listOfFiles = folder.listFiles();
String listname = "";  

	int val = listOfFiles.length + 1;

File exlFile = new File("C:/reportxls/Complaint"+val+".xls");
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

WritableCellFormat cellRIghtformat = new WritableCellFormat(); 
cellRIghtformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
font.setColour(Colour.BLACK); 
cellRIghtformat.setFont(font);
cellRIghtformat.setAlignment(Alignment.RIGHT);

WritableCellFormat cellFormatWrap = new WritableCellFormat();
cellFormatWrap.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
font.setColour(Colour.BLACK); 
cellFormatWrap.setFont(font);
cellFormatWrap.setAlignment(Alignment.RIGHT); 
cellFormatWrap.setWrap(true);

WritableCellFormat cellleftformat = new WritableCellFormat(); 
cellleftformat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
font.setColour(Colour.BLACK); 
cellleftformat.setFont(font); 	
cellleftformat.setAlignment(Alignment.LEFT);

WritableSheet writableSheet = writableWorkbook.createSheet("Complaints", 0);
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

Label label0 = new Label(0, 0, "Complaint No",cellFormat);
Label label = new Label(1, 0, "Company",cellFormat);
Label label1 = new Label(2, 0, "Customer Name",cellFormat);
Label label2 = new Label(3, 0, "Item Name",cellFormat);
Label label3 = new Label(4, 0, "Severity",cellFormat);
Label label4 = new Label(5, 0, "Status",cellFormat); 
Label label5 = new Label(6, 0, "Defect",cellFormat);
Label label6 = new Label(7, 0, "Complaint Received By",cellFormat);
Label label7 = new Label(8, 0, "Complaint Related To",cellFormat);
Label label8 = new Label(9, 0, "Complaint Registered By",cellFormat);
Label label9 = new Label(10, 0, "Complaint Assigned To",cellFormat);
Label label10 = new Label(11, 0, "Category",cellFormat);
Label label11 = new Label(12, 0, "Complaint Date",cellFormat);

// Add the created Cells to the sheet
writableSheet.addCell(label0);
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


int r=1;
while(rs_sel.next()){
	
	Label complaintno = new Label(0, r, rs_sel.getString("Complaint_No"),cellleftformat);
	writableSheet.addCell(complaintno);
	  
	PreparedStatement ps_comp = con.prepareStatement("select Company_Name from user_tbl_company where Company_Id=" + rs_sel.getInt("Company_Id"));
	ResultSet rs_comp = ps_comp.executeQuery();
	while (rs_comp.next()) {
		Label company = new Label(1, r, rs_comp.getString("Company_Name"),cellleftformat);
		writableSheet.addCell(company);
	}
	ps_comp.close();		
	rs_comp.close();
	
	PreparedStatement ps_cust = con.prepareStatement("select Cust_name from Customer_tbl where Cust_Id="+ rs_sel.getInt("Cust_Id"));
	ResultSet rs_cust = ps_cust.executeQuery();
	while (rs_cust.next()) {
		Label customer = new Label(2, r, rs_cust.getString("Cust_Name"),cellleftformat);
		writableSheet.addCell(customer);
	}
	ps_cust.close();	
	rs_cust.close();

	PreparedStatement ps_Item = con.prepareStatement("select Item_Name from Customer_tbl_Item where Item_Id=" + rs_sel.getInt("Item_id"));
	ResultSet rs_Item = ps_Item.executeQuery();
	while (rs_Item.next()) {
		Label severity = new Label(3, r, rs_Item.getString("Item_Name"),cellleftformat);
		writableSheet.addCell(severity);
	}
	ps_Item.close();
	rs_Item.close();
	
	PreparedStatement ps_priority = con.prepareStatement("select P_Type from Severity_tbl where P_Id=" + rs_sel.getInt("P_id"));
	ResultSet rs_priority = ps_priority.executeQuery();
	while (rs_priority.next()) {
		Label severity = new Label(4, r, rs_priority.getString("P_Type"),cellleftformat);
		writableSheet.addCell(severity);
	}
	ps_priority.close();
	rs_priority.close();

	PreparedStatement ps_Status = con.prepareStatement("select Status from Status_tbl where Status_Id=" + rs_sel.getInt("Status_id"));
	ResultSet rs_Status = ps_Status.executeQuery();
	while (rs_Status.next()) {
		Label statuscomp = new Label(5, r, rs_Status.getString("Status"),cellleftformat);
		writableSheet.addCell(statuscomp);
	} 
	ps_Status.close();
	rs_Status.close();

	
	

	PreparedStatement ps_Defect = con.prepareStatement("select Defect_Type from Defect_tbl where Defect_id=" + rs_sel.getInt("Defect_Id"));
	ResultSet rs_Defect = ps_Defect.executeQuery();
	while (rs_Defect.next()) {
		Label defect = new Label(6, r, rs_Defect.getString("Defect_Type"),cellleftformat);
		writableSheet.addCell(defect); 
	}	 
	ps_Defect.close();
	rs_Defect.close();
	
	Label receivedBy = new Label(7, r, rs_sel.getString("Complaint_Received_By"),cellleftformat);
	writableSheet.addCell(receivedBy);
	
	  
	PreparedStatement ps_related = con.prepareStatement("select Department from User_tbl_Dept where Dept_id=" + rs_sel.getInt("Complaint_Related_To"));
	ResultSet rs_related = ps_related.executeQuery();
	while (rs_related.next()) {
		Label relatedDept = new Label(8, r, rs_related.getString("Department"),cellleftformat);
		writableSheet.addCell(relatedDept);
	}
	ps_related.close();
	rs_related.close();
		
	PreparedStatement ps_registerer = con.prepareStatement("select U_Name from User_tbl where U_id=" + rs_sel.getInt("U_Id"));
	ResultSet rs_registerer = ps_registerer.executeQuery();
	while (rs_registerer.next()) {
		Label nameRegister = new Label(9, r, rs_registerer.getString("U_Name"),cellleftformat);
		writableSheet.addCell(nameRegister);
	}
	ps_registerer.close();
	rs_registerer.close();
	

	PreparedStatement ps_assigned = con.prepareStatement("select U_Name from User_tbl where U_id=" + rs_sel.getInt("Complaint_Assigned_To"));
	ResultSet rs_assigned = ps_assigned.executeQuery();
	while (rs_assigned.next()) {
		Label assigned = new Label(10, r,rs_assigned.getString("U_Name"),cellleftformat);
		writableSheet.addCell(assigned); 
	}
	ps_assigned.close();
	rs_assigned.close();

	PreparedStatement ps_category = con.prepareStatement("select Category from Category_tbl where category_id=" + rs_sel.getInt("category_id"));
	ResultSet rs_category = ps_category.executeQuery();
	while (rs_category.next()) {
		Label category = new Label(11, r,rs_category.getString("Category"),cellleftformat);
		writableSheet.addCell(category);  
	}
	ps_category.close();
	rs_category.close();
	
	Label complaintdate = new Label(12, r,sdf2.format(rs_sel.getDate("complaint_date")),cellleftformat);
	writableSheet.addCell(complaintdate);
	r++;
} 
rs_sel.close();

// --------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------- Complaint Actions -----------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------
WritableSheet writableSheet1 = writableWorkbook.createSheet("Action", 1);
writableSheet1.setColumnView(0, 20);
writableSheet1.setColumnView(1, 30);
writableSheet1.setColumnView(2, 30);
writableSheet1.setColumnView(3, 30);
writableSheet1.setColumnView(4, 30);
 
Label act1 = new Label(0, 0, "Complaint No",cellFormat);
Label act2 = new Label(1, 0, "Action Type",cellFormat);
Label act3 = new Label(2, 0, "Action Description",cellFormat);
Label act4 = new Label(3, 0, "Action Date",cellFormat);
Label act5 = new Label(4, 0, "Action Taken By",cellFormat);

// Add the created Cells to the sheet
writableSheet1.addCell(act1);
writableSheet1.addCell(act2);
writableSheet1.addCell(act3);
writableSheet1.addCell(act4);
writableSheet1.addCell(act5);

rs_sel = ps_sel.executeQuery();
PreparedStatement ps_action = null;
ResultSet rs_action = null;
r=1;
while(rs_sel.next()){
	ps_action = con.prepareStatement("select * from complaint_tbl_action where Complaint_No='"+rs_sel.getString("Complaint_No")+"'");
	rs_action = ps_action.executeQuery();
	while(rs_action.next()){
		Label compNo = new Label(0, r, rs_action.getString("Complaint_No"),cellleftformat);
		writableSheet1.addCell(compNo);
		
		Label actype = new Label(1, r,rs_action.getString("Action_Type"),cellleftformat);
		writableSheet1.addCell(actype);  
		
		Label acdesc= new Label(2, r,rs_action.getString("Action_Discription"),cellleftformat);
		writableSheet1.addCell(acdesc);  
		
		Label actiondate = new Label(3, r,sdf2.format(rs_action.getDate("Action_Date")),cellleftformat);
		writableSheet1.addCell(actiondate);
		
		PreparedStatement ps_actionby = con.prepareStatement("select * from user_tbl where U_Id=" + rs_action.getInt("U_Id"));
		ResultSet rs_actionby = ps_actionby.executeQuery();
		while (rs_actionby.next()) {
			Label actionBy = new Label(4, r,rs_actionby.getString("U_Name"),cellleftformat);
			writableSheet1.addCell(actionBy);  
		}
		ps_actionby.close();
		rs_actionby.close();
		
		
		r++;
	}
	rs_action.close();
}
rs_sel.close();


writableWorkbook.write();
writableWorkbook.close();
//************************************************************************************************************************
//************************************************ File Output Ligic *****************************************************
//************************************************************************************************************************
 String filePath = "C:/reportxls/Complaint"+val+".xls"; 
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
  con.close();
%>
<span id="exportId"> 
&nbsp;&nbsp;&nbsp;&nbsp;<button id="filebutton" onclick="getExcel_Report('<%=comp%>','<%=fromDate%>','<%=toDate%>','<%=status%>')" style="cursor: pointer;" disabled="disabled">Generate Excel</button>
<a href="DownloadFile.jsp?filepath=<%=filePath %>" style="color: green;text-decoration: none;font-family: Arial;font-size: 12px;"><b>Download File</b></a>
</span> 
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>