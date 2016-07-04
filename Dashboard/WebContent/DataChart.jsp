<!DOCTYPE html>
<html lang="en">
<head>
 <title>WebHR Inc. | WebHR</title>
 <meta name="keywords" content="WebHR Inc." />
 <meta name="description" content="WebHR Inc." />
 <link href="stat/WebHRStyles.css" rel="stylesheet" />
 <link href="stat/stylesheet.css" type="text/css" rel="stylesheet" />
 <link href="stat/WebHRStyleSheet.css" type="text/css" rel="stylesheet" />
 <script src="stat/jsJQuery.js"></script>

 <style type="text/css">
  .main { text-align:left; font-family:Trebuchet MS, Arial; font-size:12px; color:#7d7d7d; }
			.main2 { text-align:left; font-family:Trebuchet MS, Arial; font-size:12px; color:#000000; }
  td { padding:3px; }
 </style>
</head>
<body style="background-image:url(); background-color:#ffffff;" topmargin="0" leftmargin="0"><style type="text/css" media="print">
		DIV.tableContainer { OVERFLOW: visible }
		TABLE > TBODY { OVERFLOW: visible }
		TD { HEIGHT: 14pt }
		THEAD { DISPLAY: table-header-group }
		THEAD TH { POSITION: static }
		THEAD TD { POSITION: static }
		TABLE TFOOT TR { POSITION: static }

		@media print { #DontPrint { display: none; } }
		</style>
		<style type="text/css">
		.WebHRReportTitle { font-size:24px; font-weight:bold; } 
		.WebHRReportHeader { border-top: 1px solid #d7d7d7; border-bottom: 1px solid #d7d7d7; color:#fff; font-weight:bold; font-size:12px; } 
		.WebHRReportFooter { border-top: 1px solid #a9a9a9; border-bottom: 1px solid #d7d7d7; font-weight:bold; font-size:12px; } 
		.WebHRReportContents { border-bottom: 1px solid #d7d7d7; font-size:12px; } 
		.WebHRReportTotal { background-color:#e8e8e8; border-bottom: 1px solid #d7d7d7; font-weight:bold; font-size:11px; } 

		</style>
		<div style="margin-top:10px; margin-left:10px; float:left;"><img src="http://demo.webhr.co/hr/include/image.php?org=demo&img=L3JlcG9ydGhlYWRlci5wbmc=" border="0" /></div>
		<div style="float:right;"><div align="right" id="DontPrint" style="margin-top:8px; width:200px; margin-right:10px;">
			 <div style="float:left;"><a href="javascript:window.print();"><img style="float:left;" src="../images/icons/iconPrint.gif" border="0" title="Print">&nbsp;Print</a></div>
			 <div style="float:left; margin-left:20px;"><a href="#noanchor" onclick="$('#divEmail').show();"><img style="float:left;" src="../images/icons/iconEmail.png" border="0" title="Email" />&nbsp;Email</a></div>
			 <div style="float:left; margin-left:20px;"><a href="#noanchor" onclick="$('#divExport').show();"><img style="float:left;" src="../images/icons/save.gif" border="0" title="Export" />&nbsp;Export</a></div>
			</div></div>
		<div style="clear:both;"></div><div align="center"><div align="left" style="display:none; width:600px; padding: 10px;" class="WebHRBox2" id="divEmail">
			<div style="font-size:22px; font-weight:bold; float:left;">Email Report</div><div style="float:right;"><a href="#noanchor" onclick="$('#divEmail').hide();">CLOSE</a></div><div style="clear:both;"></div>
			<form method="post" action="../reports/?action=EmailReport&reporttype=HRReports&report=PayrollSummary">
			 <div style="float:left; margin-top:10px; width:120px;">Your Name:</div><div style="margin-top:10px; float:left; font-weight:bold;">System Administrator</div><div style="clear:both;"></div>
			 <div style="float:left; margin-top:10px; width:120px;">Your Email:</div><div style="margin-top:10px; font-weight:bold; float:left;">info@vergesystems.com</div><div style="clear:both;"></div>
			 <div style="float:left; margin-top:10px; width:120px;">Recipient Name:</div><div style="margin-top:10px; float:left;"><input type="text" name="rn" id="rn" style="width:150px;" class="WebHRForm1" /></div><div style="clear:both;"></div>
			 <div style="float:left; margin-top:10px; width:120px;">Recipient Email:</div><div style="margin-top:10px; float:left;"><input type="text" name="re" id="re" style="width:150px;" class="WebHRForm1" /></div><div style="clear:both;"></div>
			 <div style="float:left; margin-top:10px; width:120px;">Message:</div><div style="margin-top:10px; float:left;"><textarea style="width:300px; height:60px;" name="m" id="m"></textarea></div><div style="clear:both;"></div>
			 <div style="margin-left:120px; margin-top:20px;"><input class="WebHRSolidButton_Blue" type="submit" value="Send Email" /></div>
			</form>
			</div></div><div align="center"><div align="left" style="display:none; width:600px; padding: 10px;" class="WebHRBox2" id="divExport">
			<div style="font-size:22px; font-weight:bold; float:left;">Export Report</div><div style="float:right;"><a href="#noanchor" onclick="$('#divExport').hide();">CLOSE</a></div><div style="clear:both;"></div>
			 <div style="height:20px;"></div>
			 <div align="center" style="float:left; width:25%;"><a href="../reports/?action=ExportReport&exporttype=pdf&reporttype=HRReports&report=PayrollSummary"><img src="../images/reports/iconExport_PDF.png" border="0" /><br />Export as PDF File</a></div>
			 <div align="center" style="float:left; width:25%;"><a href="?action=ExportReport&exporttype=html&reporttype=HRReports&report=PayrollSummary"><img src="../images/reports/iconExport_HTML.png" border="0" /><br />Export as HTML File</a></div>
			 <div align="center" style="float:left; width:25%;"><a href="?action=ExportReport&exporttype=word&reporttype=HRReports&report=PayrollSummary"><img src="../images/reports/iconExport_DOC.png" border="0" /><br />Export as MS Word File</a></div>
			 <div align="center" style="float:left; width:25%;"><a href="?action=ExportReport&exporttype=excel&exportxls=true&reporttype=HRReports&report=PayrollSummary"><img src="../images/reports/iconExport_XLS.png" border="0" /><br />Export as Excel File</a></div>
			 <div style="clear:both;"></div>
			 <div style="height:20px;"></div>
			</div></div><div align="center" class="WebHRReportTitle">Payroll Summary Report</div><script src="../../system/VSF-PHP/components/Highcharts/js/highcharts.js"></script><br />
		<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center">
		 <tr>
		  <td style="width:300px;" valign="top">
           <table border="0" cellspacing="0" cellpadding="5" width="100%" align="center">
	        <tr style="background-color:#428bca;">
		     <td class="WebHRReportHeader" colspan="2">Payroll Summary</td>
		    </tr>
			<tr><td class="WebHRReportContents">Total Salaries Paid</td><td align="right" class="WebHRReportContents">126,440</td></tr>
			<tr><td class="WebHRReportContents">Salaries Paid this Year</td><td align="right" class="WebHRReportContents">0</td></tr>
			<tr><td class="WebHRReportContents">Average Yearly Salaries</td><td align="right" class="WebHRReportContents">126,440</td></tr>
		    <tr><td><br /></td></tr>
			<tr><td class="WebHRReportContents" style="background-color:#e8e8e8;" colspan="2">Top Station</td></tr>
			<tr><td class="WebHRReportContents">WebHR Head Office</td><td align="right" class="WebHRReportContents">126,440</td></tr>
		    <tr><td><br /></td></tr>
			<tr><td class="WebHRReportContents" style="background-color:#e8e8e8;" colspan="2">Top Department</td></tr>
			<tr><td class="WebHRReportContents">Information Technology</td><td align="right" class="WebHRReportContents">90,620</td></tr>
		    <tr><td><br /></td></tr>
			<tr><td class="WebHRReportContents" style="background-color:#e8e8e8;" colspan="2">Top Designation</td></tr>
			<tr><td class="WebHRReportContents">Software Engineer</td><td align="right" class="WebHRReportContents">50,820</td></tr>
		   </table>

		  </td>
		  <td style="width:4px;"></td>
		  <td valign="top">
		   <table border="0" cellspacing="0" cellpadding="5" width="100%" align="center">
	        <tr style="background-color:#428bca;"><td colspan="3" class="WebHRReportHeader">Yearly Employees Salaries</td></tr>
			<tr>
			 <td valign="top" style="width:400px;"><table border="0" cellspacing="0" cellpadding="5" width="100%" align="center"><tr><td style="width:100px;" class="WebHRReportContents">2010</td><td align="right" class="WebHRReportContents">126,440</td></tr><tr><td style="width:100px;" class="WebHRReportTotal">Total</td><td align="right" class="WebHRReportTotal">126,440</td></tr></table></td>
			 <td valign="top"><script type="text/javascript">
		$(function () {
        $("#YearlySalariesGraph").highcharts({
            chart: { renderTo: "histogram", type: "column", backgroundColor:"rgba(255, 255, 255, 0)" },
            title: { text: "" },
			credits: { enabled:false },
            xAxis: { categories: [ "2010" ], labels: { rotation: -90, align: "right", style: { fontSize: "10px", fontFamily: "Trebuchet MS, Verdana, sans-serif" } } },
            yAxis: { min: 0, title: { text: "Yearly Salaries" }  },
            legend: { enabled: false },
            tooltip: { formatter: function() { return "<b>" + this.x + "</b><br/>Total Yearly Salaries: "+ Highcharts.numberFormat(this.y, 0); } },
            series: [{
                name: "Yearly Salaries",
                data: [ {y:126440.0000, color: "#AFD8F8"} ],
                dataLabels: { enabled: true, rotation: -90, color: "#FFFFFF", align: "right", x: 4, y: 10, style: { fontSize: "11px", fontFamily: "Trebuchet MS, Verdana, sans-serif" } }
				}  ]
			});
		});
		</script>
		<div id="YearlySalariesGraph" style="min-width: 100%; height: 300px; margin: 0 auto"></div></td>
			</tr>
		   </table>
		   <br />
		   <table border="0" cellspacing="0" cellpadding="5" width="100%" align="center">
	        <tr style="background-color:#428bca;"><td colspan="3" class="WebHRReportHeader">Station Wise Salaries</td></tr>
			<tr>
			 <td valign="top" style="width:400px;"><table border="0" cellspacing="0" cellpadding="5" width="100%" align="center"><tr><td style="width:300px;" class="WebHRReportContents">WebHR Head Office</td><td align="right" class="WebHRReportContents">126,440</td></tr><tr><td style="width:100px;" class="WebHRReportTotal">Total</td><td align="right" class="WebHRReportTotal">126,440</td></tr></table></td>
			 <td valign="top">
		<script type="text/javascript">
		$(function () {
    	
        $("#StationSalariesGraph").highcharts({
		    colors: ['#00275e', '#7892c0', '#F6BD0F', '#8BBA00', '#FF8E46', '#008E8E', '#D64646'],
            chart: { renderTo: "histogram", backgroundColor:"rgba(255, 255, 255, 0)", plotBackgroundColor: null, plotBorderWidth: null, plotShadow: false },
            title: { text: "" },
			credits: { enabled:false },
            tooltip: { formatter: function() { return "<b>" + this.point.name + "</b>: "+ this.point.y ; } },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: "pointer",
                    dataLabels: {
                        enabled: true,
                        color: "#000000",
                        connectorColor: "#000000",
                        formatter: function() { return(this.point.name + ":<br />"+ this.percentage.toFixed(0) +" %"); }
                    }
                }
            },
            series: [{
                type: "pie",
				name: "",
                data: [ ["WebHR Head Office", 126440.0000] ]
            }]
	        });
		});
		</script>
		<div id="StationSalariesGraph" style="height: 300px; margin: 0 auto"></div></td>
			</tr>
		   </table>
		   <br />
		   <table border="0" cellspacing="0" cellpadding="5" width="100%" align="center">
	        <tr style="background-color:#428bca;"><td colspan="3" class="WebHRReportHeader">Department Wise Salaries</td></tr>
			<tr>
			 <td valign="top" style="width:400px;"><table border="0" cellspacing="0" cellpadding="5" width="100%" align="center"><tr><td style="width:300px;" class="WebHRReportContents">Information Technology</td><td align="right" class="WebHRReportContents">90,620</td></tr><tr><td style="width:300px;" class="WebHRReportContents">Graphics & Multimedia</td><td align="right" class="WebHRReportContents">35,820</td></tr><tr><td style="width:100px;" class="WebHRReportTotal">Total</td><td align="right" class="WebHRReportTotal">126,440</td></tr></table></td>
			 <td valign="top">
		<script type="text/javascript">
		$(function () {
    	
        $("#DepartmentSalariesGraph").highcharts({
		    colors: ['#00275e', '#7892c0', '#F6BD0F', '#8BBA00', '#FF8E46', '#008E8E', '#D64646'],
            chart: { renderTo: "histogram", backgroundColor:"rgba(255, 255, 255, 0)", plotBackgroundColor: null, plotBorderWidth: null, plotShadow: false },
            title: { text: "" },
			credits: { enabled:false },
            tooltip: { formatter: function() { return "<b>" + this.point.name + "</b>: "+ this.point.y ; } },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: "pointer",
                    dataLabels: {
                        enabled: true,
                        color: "#000000",
                        connectorColor: "#000000",
                        formatter: function() { return(this.point.name + ":<br />"+ this.percentage.toFixed(0) +" %"); }
                    }
                }
            },
            series: [{
                type: "pie",
				name: "",
                data: [ ["Information Technology", 90620.0000],["Graphics & Multimedia", 35820.0000] ]
            }]
	        });
		});
		</script>
		<div id="DepartmentSalariesGraph" style="height: 300px; margin: 0 auto"></div></td>
			</tr>
		   </table>

		   <br />
		   <table border="0" cellspacing="0" cellpadding="5" width="100%" align="center">
	        <tr style="background-color:#428bca;"><td colspan="3" class="WebHRReportHeader">Designation Wise Salaries</td></tr>
			<tr>
			 <td valign="top" style="width:400px;"><table border="0" cellspacing="0" cellpadding="5" width="100%" align="center"><tr><td style="width:300px;" class="WebHRReportContents">Software Engineer</td><td align="right" class="WebHRReportContents">50,820</td></tr><tr><td style="width:300px;" class="WebHRReportContents">Chief Technology Officer</td><td align="right" class="WebHRReportContents">39,800</td></tr><tr><td style="width:300px;" class="WebHRReportContents">Graphics Designer</td><td align="right" class="WebHRReportContents">35,820</td></tr><tr><td style="width:100px;" class="WebHRReportTotal">Total</td><td align="right" class="WebHRReportTotal">126,440</td></tr></table></td>
			 <td valign="top"><script type="text/javascript">
		$(function () {
        $("#DesignationSalariesGraph").highcharts({
            chart: { renderTo: "histogram", type: "bar", backgroundColor:"rgba(255, 255, 255, 0)" },
            title: { text: "" },
			credits: { enabled:false },
            xAxis: { categories: [ "Software Engineer","Chief Technology Officer","Graphics Designer" ], labels: { style: { fontSize: "10px"} } },
            yAxis: { min: 0, title: { text: "Designation wise Salaries" }  },
            legend: { enabled: false },
            tooltip: { formatter: function() { return "<b>" + this.x + "</b><br/>Total Designation wise Salaries: "+ Highcharts.numberFormat(this.y, 0); } },
            series: [{
                name: "Designation wise Salaries",
                data: [ {y:50820.0000, color: "#AFD8F8"},{y:39800.0000, color: "#F6BD0F"},{y:35820.0000, color: "#8BBA00"} ],
                dataLabels: { enabled: true, rotation: -90, color: "#FFFFFF", align: "right", x: 4, y: 10, style: { fontSize: "11px", fontFamily: "Trebuchet MS, Verdana, sans-serif" } }
				}  ]
			});
		});
		</script>
		<div id="DesignationSalariesGraph" style="min-width: 100%; height: 500px; margin: 0 auto"></div></td>
			</tr>
		   </table>

		  </td>
		 </tr>
		</table></body></html>