<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<html>
<head>
<script type="text/javascript" src="Stationary/jsapi"></script>
<script type="text/javascript">
	// Load the Visualization API and the piechart package. 
	google.load('visualization','1.0',{'packages': ['corechart']});

	// Set a callback to run when the Google Visualization API is loaded.
	google.setOnLoadCallback(drawChart); 
	// Callback that creates and populates a data table, 
	// instantiates the pie chart, passes in the data and 
	// draws it.

	function drawChart(){
		// Create the data table.
		var data = new google.visualization.DataTable();
<%
try{
	
	String newdate = "20/11/2016";
	String update = newdate.substring(3, 5)+"  =   " + newdate.substring(0, 2) + " = " + newdate.substring(5,10);
	System.out.println("N = = " + update);
	
	
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
		
		// Set chart options 
		var options = {'title':'How Much Pizza I Ate Last Night','width':800,'height':400};
		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
		chart.draw(data,options); 
	
		 /*  google.visualization.events.addListener(chart, 'select', function() {
		    	var selection = chart.getSelection();
		      if (selection.length > 0) {
		      	alert('Row ' + selection[0].row + ' was selected');
		      	window.location="Home.jsp?column";
		      }
		    }); */
		
		
	<%
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	}
</script> 
</head> 
<body> 







<div id="chart_div"></div> 
<script type="text/javascript">
    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(drawChart);
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ["Element", "Density", { role: "style" } ],
        ["Copper", 8.94, "#b87333"],
        ["Silver", 10.49, "silver"],
        ["Gold", 19.30, "gold"],
        ["Platinum", 21.45, "color: #e5e4e2"]
      ]);

      var view = new google.visualization.DataView(data);
      view.setColumns([0, 1, { calc: "stringify", sourceColumn: 1, type: "string", role: "annotation" }, 2]);

      var options = {
        title: "Density of Precious Metals, in g/cm^3",
        width: 600,
        height: 400,
        bar: {groupWidth: "95%"},
        legend: { position: "none" },
      };
      var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
      chart.draw(view, options);
  }
  </script>
<div id="columnchart_values" style="width: 900px; height: 300px;"></div>	


<%
SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd");

Calendar cal = Calendar.getInstance();
cal.add(Calendar.MONTH, -1);
cal.set(Calendar.DATE, 1);  
cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
 
Date lastDateOfPreviousMonth = cal.getTime();
System.out.println(sdfFIrstDate.format(lastDateOfPreviousMonth)); 
%>






<script type="text/javascript" src="js/loader.js"></script>

 <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawVisualization);


      function drawVisualization() {
        // Some raw data (not necessarily accurate)
        var data = google.visualization.arrayToDataTable([
         <%
         ArrayList fg = new ArrayList();
         fg.add("Month");
         fg.add("Bolivia");
         fg.add("Ecuador");
         fg.add("Madagascar");
         fg.add("Papua New Guinea");
         fg.add("Rwanda");
         fg.add("Average");
         fg.add("Rwanda");
         fg.add("Average");
         fg.add("Rwanda");
         fg.add("Average");
         
         %>                                                          
         ['100'],         
         ['2004/05',  165,      938,         522,    938,         522,             998,           450,      614.6 ,           450,      614.6]
      ]);

    var options = {
      title : 'Monthly Coffee Production by Country',
      vAxis: {title: 'Cups'},
      hAxis: {title: 'Month'},
      seriesType: 'bars',
    };

    var chart = new google.visualization.ComboChart(document.getElementById('chart_div4'));
    chart.draw(data, options);
  }
    </script> 
    <div id="chart_div4" style="width: 900px; height: 500px;"></div>
<%
String holli_date = "2016-02-29";
System.out.println("Date = " +holli_date.substring(0,4) +holli_date.substring(5,7)+holli_date.substring(8,10));
%>
 
<%
SimpleDateFormat sdfFIrst = new SimpleDateFormat("yyyyMMdd");
Calendar cal1 = Calendar.getInstance();
Date lastDate = cal1.getTime();
String toDate = sdfFIrst.format(lastDate);
String fromDate = toDate.substring(0, 6)+"01";
System.out.println("date now = " + fromDate + "date sub = " + toDate);
 
 
int year = Calendar.getInstance().get(Calendar.YEAR);
String ddate = "16/03/"+ year;
System.out.println("ksjdnjkdsnc = " + ddate);

ArrayList calarray = new ArrayList(); 
SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy/MM/dd");
Calendar cal3 = Calendar.getInstance();
Date date=cal3.getTime();  
for (int i=0;i<4;i++){
   cal3.add(Calendar.DAY_OF_MONTH,1);
   date=cal3.getTime();  
   calarray.add(sdf3.format(date).substring(8,10) +sdf3.format(date).substring(5,7));
}
System.out.println("list date = " + calarray.get(3) +","+ calarray.get(2) +","+ calarray.get(1) +","+ calarray.get(0));
%>







<%--
Calendar c = Calendar.getInstance(); 
c.set(Calendar.HOUR_OF_DAY, c.get(Calendar.HOUR_OF_DAY)+1); 
System.out.println(c.get(Calendar.HOUR_OF_DAY)); 
System.out.println(c.get(Calendar.MINUTE));
System.out.println(c.get(Calendar.AM_PM));
 
java.sql.Date dateIndate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
System.out.println("date sql = " + dateIndate);


--%>




<%--
String str="91'95'95354336";

String result = str.replaceAll("\\'","");
System.out.println("name list  = " + result);
--%>



</body>
</html>