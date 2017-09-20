<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%> 
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
label > input{ /* HIDE RADIO */
  visibility: hidden; /* Makes input not-clickable */
  position: absolute; /* Remove input from document flow */
}
label > input + img{ /* IMAGE STYLES */
  cursor:pointer;
  border:2px solid transparent;
}
label > input:checked + img{ /* (RADIO CHECKED) IMAGE STYLES */
  border:2px solid #f00;
}
</style>
<style type="text/css">
.rating-wrapper {
  overflow: hidden;
  display: inline-block;
}

.rating-input {
  position: absolute;
  left: 0;
  top: -50px;
}

.rating-star:hover,
.rating-star:hover ~ .rating-star {
  background-position: 0 0;
}

.rating-wrapper:hover .rating-star:hover,
.rating-wrapper:hover .rating-star:hover ~ .rating-star,
.rating-input:checked ~ .rating-star {
  background-position: 0 0;
}

.rating-star,
.rating-wrapper:hover .rating-star {
  float: right;
  display: block;
  width: 16px;
  height: 16px;
  background: url('icons/stars.png') 0 -16px;
}
</style>
</head>
<body>
	<%
	String name = "mydatais validfortheupdateinsystem";
	System.out.println("Data = = = = " + name.substring(name.length()-6));
		/* 
		 Calendar cal = Calendar.getInstance();  
		 cal.set(2010, 4, 14);

		 Calendar dob = Calendar.getInstance();
		 dob.setTime(cal.getTime());
		 Calendar today = Calendar.getInstance();
		 int age = today.get(Calendar.YEAR) - dob.get(Calendar.YEAR);

		 System.out.println(" Age = " + age);

		 java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());
		 DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		 DateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
		 String todays_date = df.format(curr_Date);

		 Date dateUp = df.parse(todays_date);

		 String up = df2.format(dateUp);

		 System.out.print("date 1 = " + todays_date + " date 2 = " + up);

		 String dd = "2015-04-30";

		 System.out.println("date = " + dd.substring(0, 4) + " = " + dd.substring(5, 7) + " = " + dd.substring(8, 10));

		 Calendar first_Datecal = Calendar.getInstance();   
		 first_Datecal.add(Calendar.DATE, -1);  
		 Date date_last = first_Datecal.getTime();
		 SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");  

		 System.out.println("Dtae = = " + sdfFIrstDate.format(date_last));
		 */

		Date d = new Date();
		String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday",
				"Thursday", "Friday", "Saturday" };
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		DateFormat dateFormat2 = new SimpleDateFormat("dd/MM/yyyy");

		Calendar cal = Calendar.getInstance();
		 cal.add(Calendar.DATE, -1);
		 String yes_date = dateFormat.format(cal.getTime()).toString(); 
		 String ason_date = dateFormat2.format(cal.getTime()).toString(); 			  
		//************************************************************************************************
		//		System.out.println("Date before  =  " +yes_date+"\n date before = "+ason_date); 
		/* 	if(weekday[d.getDay()].equals("Sunday")){
		 cal.add(Calendar.DATE, -1);
		 yes_date = dateFormat.format(cal.getTime()).toString(); 
		 ason_date = dateFormat2.format(cal.getTime()).toString();
		 } */
		/* Calendar cal = Calendar.getInstance();
		String yes_date = "";
		String ason_date = "";
		//cal.add(Calendar.DATE, -3);
		yes_date = dateFormat.format(cal.getTime()).toString();
		ason_date = dateFormat2.format(cal.getTime()).toString();
		System.out.println("Date after =  " + yes_date + " date after = "
				+ ason_date); */
	%>
	<table>
		<tr>
			<td align="right"></td>
		</tr>
	</table> 
<%
SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyyMMdd");
Calendar cal32 = Calendar.getInstance();
cal32.add(Calendar.DATE, +1);
String sql_date = sdfFIrstDate.format(cal32.getTime()).toString();
System.out.println("SQL DATE =  " + sql_date);
cal32.add(Calendar.DATE, +1);
sql_date = sdfFIrstDate.format(cal32.getTime()).toString();
System.out.println("SQL DATE =  " + sql_date);
cal32.add(Calendar.DATE, +1);
sql_date = sdfFIrstDate.format(cal32.getTime()).toString();
System.out.println("SQL DATE =  " + sql_date);
%>
	<b style='color: #0D265E; font-family: Arial;font-size: 11px;'>This is an automatically generated email from ERP Supplier Creation Portal - List of Approved Suppliers !!!</b>
	<p><b>To Approve ,</b><a href='http://localhost/foundrymis/approve.jsp'>Click Here</a></p>
	
	
	<table border='1' width='97%' style='font-family: Arial;'>
		<tr style='font-size: 12px; background-color: #94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<th height='24'>Registered By</th>
			<th>Approval Status</th>
			<th>Transfer To</th> 
		</tr>
		<tr style='font-size: 12px; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<td align='right'>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td> 
		</tr>
	</table>
<%
	Date date = new Date();
	java.sql.Timestamp timestamp = new java.sql.Timestamp(date.getTime());
	System.out.println("time = " + timestamp);
%>
<p>Please Note : Below attached document is pending for approval, Please Approve using IT Tracker-DMS</p>
					<table border='1' width='97%' style='font-family: Arial;'>
					<tr style='font-size: 12px;background-color:#94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'> 
								<th height="25">File Name</th> 
								<th>Carried Out By</th> 
								<th>Vide Bill No</th> 
								<th>Dated</th> 
								<th>For Rs.</th> 
								<th>Work / Purchase Order No</th>
								<th>Note</th>
								 <th style='color: white;background-color: #c10000'><strong></strong>Approval</th>
					</tr>
					<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
					</tr>
					</table>
					
<label>
  <input type="radio" name="fb" value="small" />
  <img src="lock.png">
</label>


<input type="radio" name="test" id="test" value="1"> ☆
<input type="radio" name="test" id="test" value="2"> ☆

<div class="rating-wrapper">
  <input type="radio" class="rating-star" id="rating-input-1-5" name="rating-input-1" /> 
  <label for="rating-input-1-5" class="rating-star"></label>
  <input type="radio" class="rating-input" id="rating-input-1-4" name="rating-input-1" />
  <label for="rating-input-1-4" class="rating-star"></label>
  <input type="radio" class="rating-input" id="rating-input-1-3" name="rating-input-1" />
  <label for="rating-input-1-3" class="rating-star"></label>
  <input type="radio" class="rating-input" id="rating-input-1-2" name="rating-input-1" />
  <label for="rating-input-1-2" class="rating-star"></label>
  <input type="radio" class="rating-input" id="rating-input-1-1" name="rating-input-1" />
  <label for="rating-input-1-1" class="rating-star"></label>
</div>

<%
ArrayList city = new ArrayList();
		  city.add("31");
		  city.add("31");
		  city.add("12");
		  city.add("12");


HashSet<String> hashSet = new HashSet<String>();
hashSet.addAll(city);
city.clear();
city.addAll(hashSet);

String nameSubstring = "20170301";
System.out.println("NameString = " + nameSubstring.substring(6) + " = " + city);




/* //Get today as a Calendar
Calendar today = Calendar.getInstance();
today.add(Calendar.DATE, 1);
java.sql.Date today1 = new java.sql.Date(today.getTimeInMillis()); 
System.out.println("today = " + today1);

SimpleDateFormat sdformat = new SimpleDateFormat("dd-MM-yyyy"); 
String sql_dateup = sdformat.format(today1.getTime()).toString();

//Subtract 1 day
today.add(Calendar.DATE, -3);
//Make an SQL Date out of that
java.sql.Date yesterday = new java.sql.Date(today.getTimeInMillis()); 
System.out.println("yes = " + yesterday +" = " + sql_dateup);

 */

SimpleDateFormat dateformat = new SimpleDateFormat("yyyyMMdd");
Calendar today = Calendar.getInstance();
SimpleDateFormat sdformat = new SimpleDateFormat("dd-MM-yyyy");  
java.sql.Date   today1 = new java.sql.Date(today.getTimeInMillis());

System.out.println("today = " + today1);

String email_datefrom = sdformat.format(today1.getTime()).toString();
java.sql.Date  yesterday = new java.sql.Date(today.getTimeInMillis());

%>





 








</body>
</html>