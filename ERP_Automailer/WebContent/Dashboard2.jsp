<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		Date d = new Date();
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday" };
		Date datesq = new Date();
		int day = datesq.getDate();

		ArrayList rem = new ArrayList();
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
	%>
	<b style='color: #0D265E; font-family: Arial; font-size: 11px;'>*** This is an automatically generated email Sister Company Sale from " + dateFrom + " to " + dateTo + " ***</b>
	<table border='1' width='100%' style='font-family: Arial; text-align: center; font-family: Arial; font-size: 12px;'>
		<tr style='font-size: 12px; background-color: #174655;color:white;height:23px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center; font-weight: bold;'>
			<td colspan='15'>Inter - company sales</td>
		</tr>
		<tr style='font-size: 12px; background-color: #a0d799; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center; font-weight: bold;'>
			<td></td>
			<td colspan="2">FOUNDERS TO ENGINEERING</td>
			<td colspan="2">MEPL UIII TO ENGINEERING</td>
			<td colspan="2">DHANSHREE TO ENGINEERING</td>
			<td colspan="2">MEPL UIII TO FOUNDERS</td>
			<td colspan="2">EGINEERING H-25 TO FOUNDERS</td>
			<td colspan="2">DHANASHREE TO FOUNDERS</td>
			<td colspan="2">TOTAL</td>			
		</tr>
		<tr style='font-size: 12px; background-color: #d9e6e8; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center; font-weight: bold;'>
			<td></td>
			<td>TONNAGE</td>
			<td>AMOUNT</td>
			<td>TONNAGE</td>
			<td>AMOUNT</td>
			<td>TONNAGE</td>
			<td>AMOUNT</td>
			<td>TONNAGE</td>
			<td>AMOUNT</td>
			<td>TONNAGE</td>
			<td>AMOUNT</td>
			<td>TONNAGE</td>
			<td>AMOUNT</td>
			<td>TONNAGE</td>
			<td>AMOUNT</td>			
		</tr> 
		<% 
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
		%>
		<tr style='font-size: 12px;border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center; font-weight: bold;'>
			<td><%=listyear.get(i).toString() %></td>
			<td align="right"><%=mytotals.format(tonnage) %></td>
			<td align="right"><%=mytotals.format(amount) %></td>
			
		<%
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
				"AND TRAN_DATE BETWEEN '"+firstsql+"' AND '"+ lastsql + "' " +
				"AND MATERIAL_TYPE =101 AND TRAN_SUBTYPE IN (1,51) order by CUST_SUB_GLACNO ");
		rs_sis = ps_sis.executeQuery();
		while(rs_sis.next()){
			tonnage = Double.valueOf(rs_sis.getString("TONNAGE")) + tonnage;
			amount = Double.valueOf(rs_sis.getString("AMOUNT")) + amount;
		}
		tonnageTotal=tonnage+tonnageTotal;
		amountTotal=amount+amountTotal;
		%>
		<td align="right"><%=mytotals.format(tonnage) %></td>
	    <td align="right"><%=mytotals.format(amount) %></td>
	<%
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
	%>
	<td align="right"><%=mytotals.format(tonnage) %></td>
    <td align="right"><%=mytotals.format(amount) %></td>  
<%
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
%>
<td align="right"><%=mytotals.format(tonnage) %></td>
<td align="right"><%=mytotals.format(amount) %></td>   
<%
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
%>
<td align="right"><%=mytotals.format(tonnage) %></td>
<td align="right"><%=mytotals.format(amount) %></td>
<%
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
%>
<td align="right"><%=mytotals.format(tonnage) %></td>
<td align="right"><%=mytotals.format(amount) %></td>   
<td align="right"><%=mytotals.format(tonnageTotal) %></td>   
<td align="right"><%=mytotals.format(amountTotal) %></td>   
</tr> 
<%
tonnage=0; amount=0;			
tonnageTotal=0; amountTotal=0;
		// ===================================================================================================================================
		}
		%>
	</table>
</body>
</html>