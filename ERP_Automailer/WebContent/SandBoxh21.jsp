<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.muthagroup.connectionERPUtil.ConnectionUrl"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<html>
<head>
<title>TEST SIDE</title>
</head>
<body>
	<%
		try {
			Connection conlocal = ConnectionUrl.getLocalDatabase();
			ArrayList weekOff = new ArrayList();
			
			
			boolean flag = false;
			int cnt = 0;
			DecimalFormat zeroDForm = new DecimalFormat("#####0");
			DecimalFormat twoDForm = new DecimalFormat("#####0.00");

			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -1);
			SimpleDateFormat todaysDate = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat sqlDate = new SimpleDateFormat("yyyyMMdd");
			String todays_date = todaysDate.format(cal.getTime())
					.toString();
			String sql_date = sqlDate.format(cal.getTime()).toString();
			System.out.println("Date Updated  111111  ===============> " + todays_date + "\n" + sql_date);

			String testDate = sql_date.substring(6, 8) + "-" + sql_date.substring(4, 6) + "-" + sql_date.substring(0, 4);
			DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
			Date today = formatter.parse(testDate);

			int month = Integer.parseInt(sql_date.substring(4, 6));
			System.out.println("Date tod Todays = " + testDate);
			System.out.println("Date Month = " + month);

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
				System.out.println("Its a holliday !!!");
			}

			int dd = today.getDate();
			int tues = 0;
			for (int i = 1; i < dd; i++) {
				calAvg.set(Calendar.DAY_OF_MONTH, i);
				if (calAvg.get(Calendar.DAY_OF_WEEK) == calAvg.TUESDAY) {
					tues++;
					weekOff.add(i);
					System.out.println("Tuesday ======= !!!!! " + i);
				}
			}
			System.out.println("month  tues " + tues + "\t" + dd);
			int workdays = dd - tues;

			total_dd = workdays;

			System.out.println("total_dd  =====================>  " + total_dd);

			total_dd = total_dd - holliday;

			System.out.println("Holliday = " + holliday);
			System.out.println("total_dd afer =====================>  " + total_dd);
			// ***************************************************************************************************************
			int space = 0;
			PreparedStatement ps_allHol = conlocal.prepareStatement("select count(montlyWeekdays_id) from montlyweekdays_tbl where month=" + month);
			ResultSet rs_allHol = ps_allHol.executeQuery();
			while (rs_allHol.next()) {
				System.out.println(rs_allHol.getString("count(montlyWeekdays_id)"));
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
			System.out.println("Space = " + space);
			System.out.println("Tuesday before = " + count_mnt);
			count_mnt = count_mnt - space;
			System.out.println("Tuesday = " + count_mnt);
			// ***************************************************************************************************************
			
			
			ArrayList getdata = new ArrayList();
			ArrayList setdata = new ArrayList();
			for(int i=1;i<=total_dd;i++){
				getdata.add("0");
				setdata.add(i);
			} 
			System.out.println("Tuesday = " + setdata + "  " + getdata);
			System.out.println("Week off = " + weekOff); 
				
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>