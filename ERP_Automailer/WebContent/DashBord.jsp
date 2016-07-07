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
			
			ArrayList weekOff = new ArrayList(); 
			boolean flag = false;
			
				int cnt = 0;
				DecimalFormat zeroDForm = new DecimalFormat("#####0");
				DecimalFormat twoDForm = new DecimalFormat("#####0.00"); 
				
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.DATE, -1); 
				SimpleDateFormat todaysDate = new SimpleDateFormat("dd/MM/yyyy");
				SimpleDateFormat sqlDate = new SimpleDateFormat("yyyyMMdd");				
				String todays_date = todaysDate.format(cal.getTime()).toString();
				String sql_date = sqlDate.format(cal.getTime()).toString();				
				
			//	System.out.println("Date Updated ===============> " + todays_date + "\n" + sql_date);
				// **********************************************************************************************************
				Date dateLogic = todaysDate.parse(todays_date);
				if(weekday[dateLogic.getDay()].equals("Tuesday")){
					cal.add(Calendar.DATE, -1);
					todays_date = todaysDate.format(cal.getTime()).toString();
					sql_date = sqlDate.format(cal.getTime()).toString();
				}
				System.out.println("Date Updated ===============> " + todays_date + "\n" + sql_date);
				// sql_date = "20141130";				
				// **********************************************************************************************************
				double req_perdayQty=0,avg_perdayQty=0,del_rating=0; 
				// ***************************************************************************************************************
				// *************************************************** Workdays ***************************************************
				Connection conlocal = ConnectionUrl.getLocalDatabase();
				
				String testDate = sql_date.substring(6,8) +"-"+ sql_date.substring(4,6) +"-"+ sql_date.substring(0,4);
				DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
				Date today = formatter.parse(testDate);

				String dayCNT = sql_date.substring(6,8);
				
				int month = Integer.parseInt(sql_date.substring(4,6));
				String fromDate = sql_date.substring(0,4)+sql_date.substring(4,6) +"01";
				
				System.out.println("Date Start Date = " + fromDate);
				
				// System.out.println("Date tod Todays = " + testDate);
				// System.out.println("Date Month = " + month);

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
			Date datesq = new Date();
			int day = datesq.getDate();

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
					//   System.out.println("Tuesday ======= !!!!! " + i);
				}
			}
			//   System.out.println("month  tues " + tues + "\t" + dd);
			int workdays = dd - tues;

			total_dd = workdays;

			//  System.out.println("total_dd  =====================>  " + total_dd);

			total_dd = total_dd - holliday;

		// System.out.println("Holliday = " + holliday);
		//	System.out.println("total_dd afer =====================>  " + total_dd);
		System.out.println("Week Off = " + weekOff);
			// ***************************************************************************************************************
			int space = 0;
			PreparedStatement ps_allHol = conlocal.prepareStatement("select count(montlyWeekdays_id) from montlyweekdays_tbl where month=" + month);
			ResultSet rs_allHol = ps_allHol.executeQuery();
			while (rs_allHol.next()) {
			//	System.out.println(rs_allHol.getString("count(montlyWeekdays_id)"));
				space = Integer.parseInt(rs_allHol.getString("count(montlyWeekdays_id)"));
			}

			PreparedStatement ps_Hol = conlocal.prepareStatement("select day from montlyweekdays_tbl where month=" + month);
			ResultSet rs_Hol = ps_Hol.executeQuery();
			while (rs_Hol.next()) {
				weekOff.add(rs_Hol.getString("day"));
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
			// System.out.println("Space = " + space);
			// System.out.println("Tuesday before = " + count_mnt);
			count_mnt = count_mnt - space;
			System.out.println("Total Woring Days = " + count_mnt);
			// ***************************************************************************************************************

			ArrayList getdata = new ArrayList();
			ArrayList setdata = new ArrayList();
			
			for (int i = 1; i <= Integer.parseInt(dayCNT); i++) {
				getdata.add("0");
				setdata.add(i);
			}
			System.out.println("Worked Days = " + setdata.size() + setdata);
			//System.out.println("Week off = " + weekOff);
			// ***************************************************************************************************************
				Connection con = ConnectionUrl.getMEPLH21ERP();
				
				String matcode = "";
				PreparedStatement ps_code = con.prepareStatement("select * from ENGERP..MSTACCTGLSUB where SUB_GLCODE='11'");
				ResultSet rs_code = ps_code.executeQuery();
				while (rs_code.next()) {
					matcode += rs_code.getString("SUB_GLACNO");
				}
				 
				ArrayList condition = new ArrayList();
				CallableStatement cs = con.prepareCall("{call Sel_RptDespatchPlanSale(?,?,?,?)}");
				cs.setString(1, "101");
				cs.setString(2, "0");
				cs.setString(3, matcode);
				cs.setString(4, sql_date);
				ResultSet rs = cs.executeQuery();
				while (rs.next()) {
					condition.add(rs.getString("CUST_CODE"));
				}
				
				CallableStatement cssale = con.prepareCall("{call Sel_RptCustDailySchVsSale(?,?,?,?,?)}");
				cssale.setString(1, "101");
				cssale.setString(2, "0");
				cssale.setString(3, fromDate);
				cssale.setString(4, sql_date);
				cssale.setString(5, matcode); 
				ResultSet rssale = null; 
				
				
				rs.close(); 
				Set<String> hs = new HashSet();
				hs.addAll(condition);
				condition.clear();
				condition.addAll(hs); 
			
				ResultSet rs_disp =null;
				//	System.out.println("Result set = "+condition);
				ArrayList compareList = new ArrayList();
				// ***************************************************************************************************************
				if (condition.size() > 0) {
		%>
		
		<p  style='font-family: Arial;font-size: 12px;'><a href='http://192.168.0.7/foundrymis/' style='text-decoration: none; color: green;'>Click and find details from Dispatch Plan Vs Sale Report</a>
			</p> 
				<b style='font-family: Arial; font-size: 11px;'>Dispatch Schedule of MEPL H21 on <%= todays_date %> (Please Note : All Amounts in lakhs)  </b>
				<table border='1' width='92%' style='font-family: Arial;'>
				<tr align='center' style='font-size: 11px;font-family: Arial; background-color: #acc8cc;'>
					<th class='th' rowspan='2'>Item Name</th>
					<th class='th' rowspan='2' width='20px'>REQ/DAY</th>
					<th class='th' rowspan='2' width='20px'>Sale AVG/DAY.</th>
					<th class='th' rowspan='2' width='20px'>Delivery Rating %</th>
					<th class='th' colspan='2'>Despatch Plan</th>
					<th class='th' colspan='2'>Sales</th>
					<th class='th' colspan='2'>Pending</th>
					 
					<th class='th' colspan='<%=setdata.size()%>'>All Date Shedule </th>
					
					</tr> <tr align='center'  style='font-size: 11px;font-family: Arial;background-color: #BCCED4;'>
					<th style='background-color: #BCCED4;'>Qty</th>
					<th style='background-color: #BCCED4;'>Amount</th> 										
					<th style='background-color: #BCCED4;'>Qty</th>	
					<th style='background-color: #BCCED4;'>Amount</th>	
					<th style='background-color: #BCCED4;'>Qty</th>
					<th style='background-color: #BCCED4;'>Amount</th>		
					<%
					for(int i=0;i<setdata.size();i++){
					%>
					<th style='background-color: #BCCED4;'><%=setdata.get(i).toString() %></th>
					<%
					}
					%> 			
				</tr>
				<%
				int col=10+getdata.size();
				double shedule_id = 0,perShed=0; 
					for(int i=0;i<condition.size();i++){
						cnt = 0;
					rs_disp = cs.executeQuery();
					while (rs_disp.next()) {
						if(condition.get(i).toString().equals(rs_disp.getString("CUST_CODE"))){
							if(cnt==0){
				%>			 
				<tr align='left' style='background-color: #E3E3E3;'>
					<td colspan='<%=col%>' style='font-size: 12px;'><b style='color: #AD5C00;'><%=rs_disp.getString("CUST_NAME")  %>"&#8658;</b></td></tr>
				<%
						cnt=1;
					}
					shedule_id = Double.parseDouble(rs_disp.getString("SCH_QTY"))/count_mnt;
					
				req_perdayQty = Double.parseDouble(rs_disp.getString("NOS_QTY"))/count_mnt;
				avg_perdayQty = Double.parseDouble(rs_disp.getString("SALE_QTY"))/total_dd;
				del_rating = (avg_perdayQty/req_perdayQty)*100;
				 %>
				<tr style='font-family: Arial;font-size: 10px;'>
					 <td align='left'><%=rs_disp.getString("MAT_NAME") %></td> 
					 <td align='right'><%=Math.round(req_perdayQty) %></td>
					 <td align='right'><%=Math.round(avg_perdayQty) %></td>
					 <td align='right'><%=twoDForm.format(del_rating) %></td>
					 <td align='right'><%=Math.round(Double.parseDouble(rs_disp.getString("NOS_QTY"))) %></td> 	 
					 <td align='right'><%=twoDForm.format(Double.parseDouble(rs_disp.getString("SCH_AMT"))/100000) %></td>   
					 <td align='right'><%=Math.round(Double.parseDouble(rs_disp.getString("SALE_QTY"))) %></td> 
					 <td align='right'><%=twoDForm.format(Double.parseDouble(rs_disp.getString("SALE_AMT"))/100000) %></td> 
					 <td align='right'><%=Math.round(Double.parseDouble(rs_disp.getString("PEND_QTY"))) %></td> 
					 <td align='right'><%=twoDForm.format(Double.parseDouble(rs_disp.getString("PEND_AMT"))/100000) %></td>
				<%
				 rssale = cssale.executeQuery();
				while(rssale.next()){
					if(rssale.getString("MAT_CODE").equalsIgnoreCase(rs_disp.getString("MAT_CODE"))){
					compareList.add(rssale.getString("SALE_QTY1"));
					compareList.add(rssale.getString("SALE_QTY2"));
					compareList.add(rssale.getString("SALE_QTY3"));
					compareList.add(rssale.getString("SALE_QTY4"));
					compareList.add(rssale.getString("SALE_QTY5"));
					compareList.add(rssale.getString("SALE_QTY6"));
					compareList.add(rssale.getString("SALE_QTY7"));
					compareList.add(rssale.getString("SALE_QTY8"));
					compareList.add(rssale.getString("SALE_QTY9"));
					compareList.add(rssale.getString("SALE_QTY10"));
					compareList.add(rssale.getString("SALE_QTY11"));
					compareList.add(rssale.getString("SALE_QTY12"));
					compareList.add(rssale.getString("SALE_QTY13"));
					compareList.add(rssale.getString("SALE_QTY14"));
					compareList.add(rssale.getString("SALE_QTY15"));
					compareList.add(rssale.getString("SALE_QTY16"));
					compareList.add(rssale.getString("SALE_QTY17"));
					compareList.add(rssale.getString("SALE_QTY18"));
					compareList.add(rssale.getString("SALE_QTY19"));
					compareList.add(rssale.getString("SALE_QTY20"));
					compareList.add(rssale.getString("SALE_QTY21"));
					compareList.add(rssale.getString("SALE_QTY22"));
					compareList.add(rssale.getString("SALE_QTY23"));
					compareList.add(rssale.getString("SALE_QTY24"));
					compareList.add(rssale.getString("SALE_QTY25"));
					compareList.add(rssale.getString("SALE_QTY26"));
					compareList.add(rssale.getString("SALE_QTY27"));
					compareList.add(rssale.getString("SALE_QTY28"));
					compareList.add(rssale.getString("SALE_QTY29"));
					compareList.add(rssale.getString("SALE_QTY30"));
					compareList.add(rssale.getString("SALE_QTY31"));
					
				//	System.out.println("print = " +rssale.getString("Name") +"Sale name " + compareList);
					}
				}
				
				for(int i1=0;i1<setdata.size();i1++){
					if(weekOff.contains(setdata.get(i1))){
				%>
				<td align='right' style='background-color:#4AC24A'>
				<%
				if(Math.round(Double.parseDouble(compareList.get(i1).toString())) !=0){
				%>
					<%=zeroDForm.format(shedule_id) %><br>
					<%=Math.round(Double.parseDouble(compareList.get(i1).toString())) %><br>
					<%=twoDForm.format(perShed) %><br>
				<%
				}else{
				%>
				Off
				<%	
				}
				%>
				</td>
				<%
					}else{
						perShed = (shedule_id/Double.parseDouble(compareList.get(i1).toString()))*100;
				%>
				<td align='right'>
					<%=zeroDForm.format(shedule_id) %><br>
					<%=Math.round(Double.parseDouble(compareList.get(i1).toString())) %><br>
					<%=twoDForm.format(perShed) %><br>
				</td>
				<%
				perShed =0;
					}
				}
				compareList.clear();
				%>	 
				 </tr>
				<%
						}
					}
						cnt=0;
					}
				  %>
		</table>
		<%			
				}else{
					
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>