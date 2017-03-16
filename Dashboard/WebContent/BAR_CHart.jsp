<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="Stationary/jsapi"></script>
</head>
<body>
<script type="text/javascript"> 
	google.load('visualization','1.0',{'packages': ['corechart']}); 
	google.setOnLoadCallback(drawChart); 
	function drawChart(){ 
	var data = new google.visualization.DataTable();
<%
try{ 
String newdate = "20/11/2016";
String update = newdate.substring(3, 5)+"  =   " + newdate.substring(0, 2) + " = " + newdate.substring(5,10);
String d1="oms";
String d2="Mus";
String d3="Mushrooms";
String d4="Onions";
String d5="Olives";
String d6="Zucchini";
String d7="Pepperoni";
double v1=5;
double v2=2;
double v3=5;
double v4=8;
double v5=10;
double v6=20;
double v7=1;
%>
		data.addColumn('string','Topping');
		data.addColumn('number','Slices');
		data.addRows([['<%=d1%>',<%=v1%>],['<%=d2%>',<%=v2%>],['<%=d3%>',<%=v3%>],['<%=d4%>',<%=v4%>],['<%=d5%>',<%=v5%>],['<%=d6%>',<%=v6%>],['<%=d7%>',<%=v7%>]]);
		var options = {'title':'How Much Pizza I Ate Last Night','width':800,'height':400}; 
		var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
		chart.draw(data,options); 
	<%
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	}
</script>
<div id="chart_div"></div> 
</body>
</html>