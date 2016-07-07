<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="com.muthagroup.conn_Url.Connection_Util"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Configure Vendor</title>  
<link href="tooplate_style.css" rel="stylesheet" type="text/css" /> 
<script src="js/jquery-1.11.1.js"></script>
<script type="text/javascript">
$(function () { function moveItems(origin, dest) {
    $(origin).find(':selected').appendTo(dest);
}
 
function moveAllItems(origin, dest) {
    $(origin).children().appendTo(dest);
}
 
$('#left').click(function () {
    moveItems('#sbTwo', '#sbOne');
});
 
$('#right').on('click', function () {
    moveItems('#sbOne', '#sbTwo');
});
 
$('#leftall').on('click', function () {
    moveAllItems('#sbTwo', '#sbOne');
});
 
$('#rightall').on('click', function () {
    moveAllItems('#sbOne', '#sbTwo');
});
});


function getAllVendors(str) { 
	document.getElementById("sbTwo").innerHTML = "";
	var xmlhttp;
	var xmlhttp2;
	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
		xmlhttp2 = new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp2 = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("getvendorname").innerHTML = xmlhttp.responseText; 
		}
	}; 
	xmlhttp2.onreadystatechange = function() {
		if (xmlhttp2.readyState == 4 && xmlhttp2.status == 200) {
			document.getElementById("getReportvendors").innerHTML = xmlhttp2.responseText; 
		}
	};
	xmlhttp.open("POST", "Get_AllVendorNames.jsp?q=" + str, true);
	xmlhttp2.open("POST", "Get_AllReportsvendors.jsp?q=" + str, true);
	/* xmlhttp2.open("POST", "Get_AllSelectedvendors.jsp?q=" + str, true);*/
	xmlhttp.send(); 
	xmlhttp2.send();
}; 
 
function getCompVendors(str) {
	var str1 = document.getElementById("company").value;
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
			document.getElementById("getvendors").innerHTML = xmlhttp.responseText; 
		}
	}; 
	xmlhttp.open("POST", "Get_AllSelectedvendors.jsp?q=" + str +"&comp="+str1, true);  
	xmlhttp.send(); 
 };
 
 function getSearchedVendor(str) {
	 var comp = document.getElementById("company").value;
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
				document.getElementById("getvendorname").innerHTML = xmlhttp.responseText; 
			}
		};
		xmlhttp.open("POST", "SearchedVendors.jsp?q=" + str +"&comp="+comp, true);  
		xmlhttp.send(); 
	 };
 
</script>
<script type="text/javascript">
function validateConfigForm() {
	var company = document.getElementById("company"); 
	var report = document.getElementById("report");
	var sbTwo = document.getElementById("sbTwo");
	 
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Select Company !!!"); 
			document.getElementById("config_btn").disabled = false;
			document.getElementById("waitImageconfig").style.visibility = "hidden";
			return false;
		}
		if (report.value=="0" || report.value==null || report.value=="" || report.value=="null") {
			alert("Please Select Report Name !!!"); 
			document.getElementById("config_btn").disabled = false;
			document.getElementById("waitImageconfig").style.visibility = "hidden";
			return false;
		}
		if (sbTwo.value=="0" || sbTwo.value==null || sbTwo.value=="" || sbTwo.value=="null") {
			alert("Please Select Vendor Names by clicking >> button !!!"); 
			document.getElementById("config_btn").disabled = false;
			document.getElementById("waitImageconfig").style.visibility = "hidden";
			return false;
		}
		document.getElementById("config_btn").disabled = true;
		document.getElementById("waitImageconfig").style.visibility = "visible";		
		return true;	
}
</script>
</head>
<body> 

<div id="tooplate_header_wrapper"> 
    <div id="tooplate_header"> 
        <div id="site_title">
        <p><b>MUTHA GROUP REPORTS</b></p> 
        </div> <!-- end of site_title -->
        
       <!--  <div id="header_phone_no"> 
			Toll Free: <span>08 324 552 409</span></div> -->  
       
        <div id="tooplate_menu">        	
            <div id="home_menu"><a href="Home.jsp"></a></div>    
            <ul>
            	<li><a href="Daily_Report.jsp">DAILY SALE</a></li>
                <li><a href="RawMaterials.jsp">RAW MATERIALS</a></li>
                <li><a href="Sub_ContractorStk.jsp">SUB-CONTRACTOR</a></li>
                <!-- <li><a href="Daily_Report.jsp">MEPL H25</a></li>
                <li><a href="Daily_Report.jsp">MFPL</a></li>
                <li><a href="Daily_Report.jsp">MEPL Unit III</a></li>
                <li><a href="Daily_Report.jsp">DI</a></li>  -->
                <li><a href="Configure.jsp">CONFIGURE</a></li>
                <li><a href="Add_Master.jsp" class="current">MASTER</a></li> 
            </ul>
        </div> <!-- end of tooplate_menu -->        
    </div>
</div> <!-- end of header_wrapper -->
 

<div id="tooplate_main">
    <div id="tooplate_content">
      
<%
try{
%>
<form action="Configure_Vendor_Controller" method="post" onsubmit="return validateConfigForm();"> 
<h4>Configure Company Vendors &#8658;</h4>
        <table width="100%" border="0">    
        <tr>
        <td colspan="4">
		<b>Company Name : </b>
		<select name="company" id="company" style="height: 25px;background-color: #EBECED;" onchange="getAllVendors(this.value)">
			<option value="">- - - - - - Select - - - - - -</option>
			<option value="101">MEPL H21</option> 
 			<option value="102">MEPL H25</option> 
			<option value="103">MFPL</option> 
 			<option value="105">DI</option> 
 			<option value="106">MEPL Unit III</option>
        </select>
        </td>
        </tr>
        
       <tr>
        <td colspan="4">
		<b>Report Name : </b>
		<span id="getReportvendors">
		<select name="report" id="report" style="height: 25px;background-color: #EBECED;font-family: Arial;font-size: 12px;" onchange="getCompVendors(this.value)">
			<option value="">- - - - - - Select - - - - - -</option> 
        </select>
        </span>
        </td>
        </tr>
        
        
        <tr>
        <td colspan="4">
		<b style="color: blue;">Search by Vendor Name : </b>
		<span id="getReportname"> 
		<input type="text" name="search" id="search" size="70" onkeyup="getSearchedVendor(this.value)" style="color: blue;font-family: Arial;font-size: 14px;"/>
        </span>
        </td>
        </tr>
         
        			<tr>
						<td colspan="4"><b>Select Multiple Vendor Names : </b></td>
					</tr>
					<tr>
						<td colspan="4" align="left">
						<span id="getvendorname"> 			
						 <select name="sbOne" id="sbOne" multiple="multiple" style="height: 200px;width: 400px;overflow: scroll;"> 
        					<option value="">Please Select Company Name</option> 
    					 </select>
    					</span>
 							<input type="button" id="left" value="<<"/>
    						<input type="button" id="right" value=">>"/>
    					<span id="getvendors">	
    					<select id="sbTwo" name="sbTwo" multiple="multiple" style="height: 200px;width: 400px;overflow: scroll;"> 
    					</select>
    					</span>
						</td>
					</tr>
					   
					<tr>
						<td colspan="4">
						<input type="submit" value="Submit" id="config_btn"/>
						<span id="waitImageconfig" style="visibility: hidden;"><strong style="color: blue;">Please Wait while loading......</strong></span>
						<% 
						if(request.getParameter("success")!=null){
						%>
						<span style="color: green;"><%=request.getParameter("success") %></span>	
						<%	
						}
						else{
						%>
						&nbsp;
						<%	
						}
						%> 
						</td>  
					</tr>					
				</table> 
			</form>

    <%
	}catch(Exception e){
		e.printStackTrace();
	}
    %>
        <div class="cleaner_h30"></div>
    </div>                 
</div>       
<div class="cleaner"></div>
<div class="cleaner"></div>
<div id="tooplate_footer_wrapper">

     <div id="tooplate_footer" style="color: white;">
     <%
     DateFormat formatter   = new SimpleDateFormat("dd/MM/yyyy"); 
     Date footer_date = new Date();
     %>
    <a href="http://www.muthagroup.com/" style="text-decoration: none;color: white;"><strong>Mutha Group of Foundries</strong> </a> &nbsp; | &nbsp; 
<strong>Mail to :</strong>&nbsp;
<a style="text-decoration: none;color: white;" href="mailto:itsupports@muthagroup.com?Subject=Need%20Assistance" target="_top">itsupports@muthagroup.com</a>&nbsp; | &nbsp;
Date :&nbsp;<strong><%=formatter.format(footer_date) %></strong> 
    
    </div> <!-- end of tooplate_footer -->

</div> 
    
</body>
</html>