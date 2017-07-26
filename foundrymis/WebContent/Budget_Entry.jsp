<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
<%@page import="java.sql.Connection"%>
<html>
<head>
<script language="JavaScript"> 
var nHist = window.history.length;
if(window.history[nHist] != window.location)
  window.history.forward(); 
</script> 
<title>MRM Operations</title> 
<link rel="stylesheet" href="js/jquery-ui.css"/>
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> 
<script>
	$(function() {
		$("#tabs").tabs();
	});
	$(document).ready(
			  function () {
			    $( "#holiday" ).datepicker({
			      changeMonth: true,
			      changeYear: true,
			      minDate: "-2100",
			      beforeShowDay: function(date) {
			          var day = date.getDay();
			          return [(day != 2), ''];
			      }
			    });
			  }
	);

</script>
<STYLE TYPE="text/css" MEDIA=all>
.tftable {
	font-size: 12px;
	color: #333333;
	width: 100%; 
	border: 1px solid #963;
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 5px; 
	border: 1px solid #963;
}

.tftable tr {
	background-color: #ffffff;
	border: 1px solid #963;
}

.tftable td {
	font-size: 12px;
	padding: 7px;  
	border: 1px solid #963;
}
.tft {
	font-size: 12px;
	color: #333333;
	width: 100%; 
	border: 1px solid #963;
}

.tft th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 3px; 
	border: 1px solid #963;
}

.tft tr {
	background-color: #ffffff;
	border: 1px solid #963;
}

.tft td {
	font-size: 12px;   
	border: 1px solid #963;
}
</STYLE>
<script type="text/javascript">
function ValidationMRM_Para() {
	var para = document.getElementById("para"); 
	 
		if (para.value=="0" || para.value==null || para.value=="" || para.value=="null") {
			alert("Please Provide Parameter First !!!");  
			return false;
		}
		return true;
}
 
</script>
<script type="text/javascript">
function validatenumerics(key) {
//getting key code of pressed key
var keycode = (key.which) ? key.which : key.keyCode;
//comparing pressed keycodes
if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46) {
    alert("Only allow numeric Data entry");
    return false;
}else 
{
	return true;
};
}
</script> 
<script type="text/javascript">
<%
if(request.getParameter("status")!=null){
%>
alert("Done");
<%
}
%>
</script>
<script type="text/javascript">
function deleteRec(str) {
	var xmlhttp;
	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("delId").innerHTML = xmlhttp.responseText;
		}
	};
	xmlhttp.open("POST", "DeleteRecord.jsp?q=" + str, true);
	xmlhttp.send();
};
</script>
</head>
<body bgcolor="#DEDEDE" style="font-family: Arial;">
	<% 
	try {
		Connection con = null , conerp = null;
		
		Connection conlocal = Connection_Utility.getConnection();
		Connection conextra = ConnectionUrl.getLocalDatabase();
		
		String maindb = "",db = "";
		
		String comp = request.getParameter("comp");
		String year = request.getParameter("year");
		
		String yearfor = String.valueOf(Integer.parseInt(year)-1) + year.substring(year.length()-2);
		
		DecimalFormat twoDForm = new DecimalFormat("#####0.00"); 
		
		String nameComp = "";
		if(comp.equalsIgnoreCase("103")){
			con = ConnectionUrl.getFoundryFMShopConnection();
			conerp = ConnectionUrl.getFoundryERPNEWConnection();
			db = "FOUNDRYERP";
			maindb = "FOUNDRYFMSHOP"; 
			nameComp = "MUTHA FOUNDERS PVT.LTD.";
		}
		if(comp.equalsIgnoreCase("105")){
			con = ConnectionUrl.getDIFMShopConnection();
			conerp = ConnectionUrl.getDIERPConnection();
			db = "DIERP";
			maindb = "DIFMSHOP";
			nameComp = "DHANASHREE INDUSTRIES";
		}
		if(comp.equalsIgnoreCase("106")){
			con = ConnectionUrl.getK1FMShopConnection();
			conerp = ConnectionUrl.getK1ERPConnection();
			db = "K1ERP";
			maindb = "K1FMSHOP";
			nameComp = "MUTHA ENGINEERING PVT.LTD.UNIT III ";
		}
		
		SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd");  
		Date tdate = new Date();
		String todaysDate = sdfFIrstDate.format(tdate); 
	%>
<strong style="color: blue;font-family: Arial;font-size: 14px;"><%= nameComp %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
<strong style="color: #1B5869;font-family: Arial;font-size: 14px;">MRM Operation Budget Entry for <%=yearfor %></strong> 
<br/> 
<strong style="font-family: Arial;font-size: 13px;"><a href="HomePage.jsp" style="text-decoration: none;">&lArr;BACK</a></strong>
<br>
<%
if(request.getParameter("notif")!=null){
%>
<strong style="color: #1631e9;font-family: Arial;font-size: 12px;"><%=request.getParameter("notif") %></strong>
<% 
}
%> 
<div style="height: 550px;overflow: scroll;background-color: white;">
					 
<div id="tabs">
		<ul> 
		<%
		if(request.getParameter("success")!=null){
		%>
		<li><a href="#tabs-2"><b>Add Holidays</b></a></li>
		<li><a href="#tabs-1"><b>Add Budget</b></a></li>
		<%
		}else{
		%>
			<li><a href="#tabs-1"><b>Add Budget</b></a></li>
			<li><a href="#tabs-2"><b>Add Holidays</b></a></li>
		<%	
		}
		%> 
		</ul> 	
	<!------------------------------------------------------------------------------------------------------------------->
	<%
	ArrayList listpara = new ArrayList();   
	ArrayList listyear = new ArrayList();
	ArrayList listmonthcnt = new ArrayList();
	ArrayList listmonth = new ArrayList();
	
	/* listpara.add("Actual Days");
	listpara.add("No of working days"); */
	listpara.add("Sales, Rs Lacs");
	listpara.add("Sales, MT");
	/* listpara.add("Sale / Day, MT"); */
	listpara.add("Rev Sales, Rs Lacs");
	listpara.add("Rev Sales, MT");
	listpara.add("Prod, MT");
	/* listpara.add("Prod / Day, MT"); */
	listpara.add("Good.Prod, MT");
	
	DateFormatSymbols dfs = new DateFormatSymbols();
	String[] months = dfs.getShortMonths();
	 
	int cnt = 2;
	int yearcnt = Integer.parseInt(year);
	
	//  to adjust months to display =====>
	outerLoop:
	for(int i=0;i<=12;i++){
	  
	 listyear.add(months[cnt] + yearcnt);
	 listmonth.add(months[cnt]);
	 listmonthcnt.add(cnt);
	 
	// System.out.println("List Year = " + listyear.get(i) +"List Month = " + listmonth.get(i) + "list Month cnt " + listmonthcnt.get(i) + "list for =" + yearfor);
	// 	listmonth.add(cnt);
	//	System.out.println("Looop = " + cnt + " loop = " +  months[cnt] + " year = " + yearcnt);
	 
	 
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
	 
	//	System.out.println("list year =  " + listyear + "list month = " + listmonthcnt);
	%>				
		<div id="tabs-1" align="left" style="height: 550px;"> 
		
<table class="tftable" style="border: 0px;">
  <tr>
    <th>Sr. No</th>
    <th>Parameters</th>
    <%
    for(int l=0;l<listyear.size();l++){
    %>
    <th><%=listyear.get(l) %></th>
    <%
    }
    %> 
    <td style="background-color: #7ce484;border: 1px solid #963;" align="center"><b>SAVE</b></td>
  </tr>
  <%
  int para_id=0,chkflag =0;
  PreparedStatement ps_chk=null,ps_para =null;
  ResultSet rs_chk=null,rs_para=null; 
  for(int i=0;i<listpara.size();i++){
	 // System.out.println("list years = " + listpara.get(i) + "  " + listmonthcnt.get(0));  
  %>
  <form action="Add_MRMOperation" method="post">
  <input type="hidden" name="para" id="para" value="<%=listpara.get(i).toString()%>">
  <input type="hidden" name="year" id="year" value="<%=yearfor%>">  
  <input type="hidden" name="comppass" id="comppass" value="<%=comp%>">
  <input type="hidden" name="yearpass" id="yearpass" value="<%=year%>">
  <tr>
    <td align="center"><%=i+1 %></td>
    <td><b><%=listpara.get(i).toString() %></b></td>
    <%
    ps_para = conlocal.prepareStatement("select * from mrmop_parameters where name='"+listpara.get(i).toString()+"'");
	rs_para = ps_para.executeQuery();
	while(rs_para.next()){
		para_id = rs_para.getInt("code");
	}
	
	//<!---------------------------------------------------------------------------------------------------------------------------->
    ps_chk = conlocal.prepareStatement("select * from mrm_operation where company='"+comp+"' and foryear='"+yearfor+"' and para_code="+para_id +" and month_cnt=3");
    rs_chk = ps_chk.executeQuery(); 
    rs_chk.last();
	chkflag = rs_chk.getRow();
	rs_chk.beforeFirst();
	if(chkflag>0){
    while(rs_chk.next()){
    %>
    <td><input type="text" value="<%=rs_chk.getString("budget") %>" name="budget_1" id="budget_1" size="5"  style="width: 100%;text-align:right; padding: 3px; margin: 0px; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
    <%
    }	
	}else{
	%>
	<td><input type="text" name="budget_1" id="budget_1" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
	<%
	}
    %>
    <!---------------------------------------------------------------------------------------------------------------------------->
    <%
    ps_chk = conlocal.prepareStatement("select * from mrm_operation where  company='"+comp+"' and   foryear='"+yearfor+"' and para_code="+para_id +" and month_cnt=4");
    rs_chk = ps_chk.executeQuery(); 
    rs_chk.last();
	chkflag = rs_chk.getRow();
	rs_chk.beforeFirst();
	if(chkflag>0){
    while(rs_chk.next()){
    %> 
    <td><input type="text" value="<%=rs_chk.getString("budget") %>" name="budget_2" id="budget_2" size="5" style="width: 100%; padding: 3px;text-align:right; margin: 0px; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
    <%
    }	
	}else{
	%>
	<td><input type="text" name="budget_2" id="budget_2" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
	<%
	}
    %>
    <!---------------------------------------------------------------------------------------------------------------------------->
    <!---------------------------------------------------------------------------------------------------------------------------->
    <%
    ps_chk = conlocal.prepareStatement("select * from mrm_operation where  company='"+comp+"' and   foryear='"+yearfor+"' and para_code="+para_id +" and month_cnt=5");
    rs_chk = ps_chk.executeQuery(); 
    rs_chk.last();
	chkflag = rs_chk.getRow();
	rs_chk.beforeFirst();
	if(chkflag>0){
    while(rs_chk.next()){
    %>  
    <td><input type="text" value="<%=rs_chk.getString("budget") %>" name="budget_3" id="budget_3" size="5" style="width: 100%; padding: 3px;text-align:right; margin: 0px; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
    <%
    }	
	}else{
	%>
	<td><input type="text" name="budget_3" id="budget_3" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>
	<%
	}
    %>
    <!---------------------------------------------------------------------------------------------------------------------------->
    <%
    ps_chk = conlocal.prepareStatement("select * from mrm_operation where  company='"+comp+"' and   foryear='"+yearfor+"' and para_code="+para_id +" and month_cnt=6");
    rs_chk = ps_chk.executeQuery(); 
    rs_chk.last();
	chkflag = rs_chk.getRow();
	rs_chk.beforeFirst();
	if(chkflag>0){
    while(rs_chk.next()){
    %>   
    <td><input type="text" value="<%=rs_chk.getString("budget") %>" name="budget_4" id="budget_4" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
    <%
    }	
	}else{
	%>
	<td><input type="text" name="budget_4" id="budget_4" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>
	<%
	}
    %>
    <!---------------------------------------------------------------------------------------------------------------------------->
    <%
    ps_chk = conlocal.prepareStatement("select * from mrm_operation where  company='"+comp+"' and   foryear='"+yearfor+"' and para_code="+para_id +" and month_cnt=7");
    rs_chk = ps_chk.executeQuery(); 
    rs_chk.last();
	chkflag = rs_chk.getRow();
	rs_chk.beforeFirst();
	if(chkflag>0){
    while(rs_chk.next()){
    %>   
    <td><input type="text" value="<%=rs_chk.getString("budget") %>" name="budget_5" id="budget_5" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
    <%
    }	
	}else{
	%>
	<td><input type="text" name="budget_5" id="budget_5" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>
	<%
	}
    %>
    <!---------------------------------------------------------------------------------------------------------------------------->
    <!---------------------------------------------------------------------------------------------------------------------------->
    <%
    ps_chk = conlocal.prepareStatement("select * from mrm_operation where  company='"+comp+"' and   foryear='"+yearfor+"' and para_code="+para_id +" and month_cnt=8");
    rs_chk = ps_chk.executeQuery(); 
    rs_chk.last();
	chkflag = rs_chk.getRow();
	rs_chk.beforeFirst();
	if(chkflag>0){
    while(rs_chk.next()){
    %>   
    <td><input type="text" value="<%=rs_chk.getString("budget") %>" name="budget_6" id="budget_6" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
    <%
    }	
	}else{
	%>
	<td><input type="text" name="budget_6" id="budget_6" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>
	<%
	}
    %>
    <!---------------------------------------------------------------------------------------------------------------------------->
    <%
    ps_chk = conlocal.prepareStatement("select * from mrm_operation where  company='"+comp+"' and   foryear='"+yearfor+"' and para_code="+para_id +" and month_cnt=9");
    rs_chk = ps_chk.executeQuery(); 
    rs_chk.last();
	chkflag = rs_chk.getRow();
	rs_chk.beforeFirst();
	if(chkflag>0){
    while(rs_chk.next()){
    %>   
    <td><input type="text" value="<%=rs_chk.getString("budget") %>" name="budget_7" id="budget_7" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
    <%
    }	
	}else{
	%>
	<td><input type="text" name="budget_7" id="budget_7" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>
	<%
	}
    %>
    <!---------------------------------------------------------------------------------------------------------------------------->
    <%
    ps_chk = conlocal.prepareStatement("select * from mrm_operation where  company='"+comp+"' and   foryear='"+yearfor+"' and para_code="+para_id +" and month_cnt=10");
    rs_chk = ps_chk.executeQuery(); 
    rs_chk.last();
	chkflag = rs_chk.getRow();
	rs_chk.beforeFirst();
	if(chkflag>0){
    while(rs_chk.next()){
    %>   
    <td><input type="text" value="<%=rs_chk.getString("budget") %>" name="budget_8" id="budget_8" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
    <%
    }	
	}else{
	%>
	<td><input type="text" name="budget_8" id="budget_8" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>
	<%
	}
    %>
    <!---------------------------------------------------------------------------------------------------------------------------->
    <%
    ps_chk = conlocal.prepareStatement("select * from mrm_operation where  company='"+comp+"' and   foryear='"+yearfor+"' and para_code="+para_id +" and month_cnt=11");
    rs_chk = ps_chk.executeQuery(); 
    rs_chk.last();
	chkflag = rs_chk.getRow();
	rs_chk.beforeFirst();
	if(chkflag>0){
    while(rs_chk.next()){
    %>   
    <td><input type="text" value="<%=rs_chk.getString("budget") %>" name="budget_9" id="budget_9" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
    <%
    }	
	}else{
	%>
	<td><input type="text" name="budget_9" id="budget_9" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>
	<%
	}
    %>
    <!---------------------------------------------------------------------------------------------------------------------------->
    <%
    ps_chk = conlocal.prepareStatement("select * from mrm_operation where  company='"+comp+"' and   foryear='"+yearfor+"' and para_code="+para_id +" and month_cnt=0");
    rs_chk = ps_chk.executeQuery(); 
    rs_chk.last();
	chkflag = rs_chk.getRow();
	rs_chk.beforeFirst();
	if(chkflag>0){
    while(rs_chk.next()){
    %>   
    <td><input type="text" value="<%=rs_chk.getString("budget") %>" name="budget_10" id="budget_10" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
    <%
    }	
	}else{
	%>
	<td><input type="text" name="budget_10" id="budget_10" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>
	<%
	}
    %>
    <!---------------------------------------------------------------------------------------------------------------------------->
    <%
    ps_chk = conlocal.prepareStatement("select * from mrm_operation where  company='"+comp+"' and   foryear='"+yearfor+"' and para_code="+para_id +" and month_cnt=1");
    rs_chk = ps_chk.executeQuery(); 
    rs_chk.last();
	chkflag = rs_chk.getRow();
	rs_chk.beforeFirst();
	if(chkflag>0){
    while(rs_chk.next()){
    %>   
    <td><input type="text" value="<%=rs_chk.getString("budget") %>" name="budget_11" id="budget_11" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
    <%
    }	
	}else{
	%>
	<td><input type="text" name="budget_11" id="budget_11" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>
	<%
	}
    %>
    <!---------------------------------------------------------------------------------------------------------------------------->
    <%
    ps_chk = conlocal.prepareStatement("select * from mrm_operation where  company='"+comp+"' and   foryear='"+yearfor+"' and para_code="+para_id +" and month_cnt=2");
    rs_chk = ps_chk.executeQuery(); 
    rs_chk.last();
	chkflag = rs_chk.getRow();
	rs_chk.beforeFirst();
	if(chkflag>0){
    while(rs_chk.next()){
    %>   
    <td><input type="text" value="<%=rs_chk.getString("budget") %>" name="budget_12" id="budget_12" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>	
    <%
    }
	}else{
	%>
	<td><input type="text" name="budget_12" id="budget_12" size="5" style="width: 100%; padding: 3px; margin: 0px;text-align:right; border: 1px solid #CCC;" onkeypress="return validatenumerics(event);"></td>
	<%
	}
    %>
    <!---------------------------------------------------------------------------------------------------------------------------->
    <td><input type="submit" name="submit" value="SAVE"> </td>
  </tr>
  </form>
  <%
  }
  %>
</table>
	<br>
	<marquee behavior="alternate" scrolldelay="150" direction="right"><strong style="font-size: 15px;font-family: Arial; color: #38314A;">Note : Commit single row at a time</strong></marquee>	
		
		</div> 
<!----------------------------------------------------------------------------------------------------------------------->
<!----------------------------------------------------------------------------------------------------------------------->
		<div id="tabs-2" align="left" style="height: 550px;">
		 
		 <div style="width: 45%;float: left;">
				
		<form action="Import_Hollidays"  method="post"> 
		<input type="hidden" name="comppass" id="comppass" value="<%=comp%>">
  		<input type="hidden" name="yearpass" id="yearpass" value="<%=year%>">
				<table border="0" style="font-size: 13px;">
					<tr>
						<td><b style="color: red;">*</b> <b>Select Holidays (In YYYY-MM-DD)</b></td>
						<td><b>:</b></td>
						<td>
<input type="text" name="holiday" id="holiday" value="<%=todaysDate %>" readonly="readonly" style="width: 200px;"/>
						</td> 
					</tr>
					<tr>
						<td><b>Remark(If Any)</b></td>
						<td><b>:</b></td> 
						<td><textarea rows="5" cols="27" name="remark" id="remark"></textarea></td> 
					</tr>
					<tr>
						<td colspan="3" align="center"><input type="submit" value="  Click to Add  " style="height: 27px;width: 300px;font-weight: bold;"> </td>  
					</tr> 
				<tr>			
				<%
				if(request.getParameter("success")!=null){
				%>
		 		<td colspan="3" align="left"><b style="color: blue;"><%=request.getParameter("success") %></b></td>
				<%	
				}
				%>
				</tr>		
				</table>
		</form>
				
				</div>
<!----------------------------------------------------------------------------------------------------------------------->
<!----------------------------------------------------------------------------------------------------------------------->
		<div style="width: 54%;float: right;overflow: scroll;height: 550px;">
		<span id="delId">
				<table class="tft" border="1"> 
					<tr align="center">
						<th width="3%">H.No.</th>  
						<th>Holiday (In DD/MM/YYYY)</th>
						<th>Remark</th>
						<th>Remove</th> 
					</tr>
				<%
				int hcnt=1;
				PreparedStatement ps_wekk = conextra.prepareStatement("select * from montlyweekdays_tbl order by year desc");
				ResultSet rs_wekk = ps_wekk.executeQuery();
				while(rs_wekk.next()){
				%>
					<tr>
						<td align="center"><%=hcnt %></td>
						<td align="center"><%=rs_wekk.getString("day") %>/<%=rs_wekk.getString("month") %>/<%=rs_wekk.getString("year") %></td>
						<td><%=rs_wekk.getString("remark") %></td>
						<td align="center"><input type="button" value="DELETE" onclick="deleteRec('<%=rs_wekk.getInt("montlyWeekdays_id")%>')"></td>
					</tr>
				<%
				hcnt++;
				}
				%>
				</table>
			</span>		
			</div>
		</div>
<!----------------------------------------------------------------------------------------------------------------------->
<!----------------------------------------------------------------------------------------------------------------------->
<!------------------------------------------------------------------------------------------------------------------->
		<!-- <div id="tabs-3" align="left">
		
		</div> -->
	<!------------------------------------------------------------------------------------------------------------------->		
</div>
	
</div>
	<%
		con.close();
		conlocal.close();
		conextra.close(); 
		conerp.close();
		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}
	%>
</body>
</html>