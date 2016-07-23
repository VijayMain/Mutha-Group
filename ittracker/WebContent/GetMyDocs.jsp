<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get My Docs</title>
</head>
<body>
<span id="new_dms">
   <%
   try{
	   int code = Integer.parseInt(request.getParameter("q"));
	   String folder = request.getParameter("r"); 
   %>
   <div style="float: left;width: 49%">
			<table style="width: 100%;" class="tftable">
				<tr>
					<th colspan="7" align="center"><%=folder %></th>
				</tr>
				<tr>  
					<td align="center"><strong>Subject / File Name</strong></td>
					<!-- <td width="4%" align="center"><strong>Shared </strong></td> -->
			        <!-- <td width="12%" align="center"><strong>Companies</strong></td> -->
				    <!-- <td width="15%" align="center"><strong>Departments</strong></td> -->
				    <td align="center"><strong>Document</strong></td>
				    <td align="center"><strong>Note</strong></td>
				    <td align="center"><strong>Customize</strong></td>
				</tr>
				<tr>
				  <td align="left">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				  <td align="center" style="width: 2%">
				  	<img src="images/Add.png" style="height: 17px;cursor: pointer;" title="Add">
					<img src="images/edit.png" style="height: 17px;cursor: pointer;" title="Edit"> 
					<img src="images/delete.png" style="height: 17px;cursor: pointer;" title="Delete"> 
				  </td>
			  </tr>
			</table>
	</div>
	<div style="float: right;width: 49%">
	
	</div>
	<%
	}catch(Exception e){
		e.printStackTrace();
	}
	%>		
</span>
</body>
</html>