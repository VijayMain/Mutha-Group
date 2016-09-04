<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
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
	   Connection con = Connection_Utility.getConnection();
	   int code = Integer.parseInt(request.getParameter("q"));
	   String folder = request.getParameter("r"); 
	   PreparedStatement ps_use = null;
	   ResultSet rs_use = null;
	   String cr_use="",cr_note="";
   %> 
   <div style="float: left;width: 60%">
			<table style="width: 100%;" class="tftable">
				<tr>
					<th colspan="8" align="center"><%=folder %></th>
				</tr>
				<tr style="background-color: #acc8cc;">
					<td align="center" width="2%" style="padding: 3px;"><strong>S.No</strong></td>
					<td align="center"><strong>Subject / File Name</strong></td>
					<td align="center"><strong>Shared Rights</strong></td>
			        <td width="12%" align="center"><strong>Companies</strong></td>
				    <td width="15%" align="center"><strong>Departments</strong></td>
				    <td align="center"><strong>Document</strong></td>
				    <td align="center"><strong>Note</strong></td>
				    <td align="center"><strong>Add</strong></td>
				</tr>
				<%
				int sn=1,flagchk=0;
				String rights="",folderName="";
				PreparedStatement ps_data = null,ps_chk=null;
				ResultSet rs_data = null,rs_chk=null;
				PreparedStatement ps  = con.prepareStatement("select * from mst_dmsfolder where CODE=" + code);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					folderName = rs.getString("FOLDER");
					if(rs.getInt("SHARED_ACCESS")==1){
					rights = "Full";
					}else{
					rights = "Read Only";	
					}
					if(rs.getInt("SHARE_FLAG")==0){
						rights = "Sharing Off";
					}
				%>
				<tr>
				  <td align="center"><%=sn %></td>
				  <td align="left"><%=rs.getString("SUBJECT") %></td>
				  <td align="left"><%=rights %></td> 
				 <!--
					---------------------------------------------- Company ---------------------------------------------   
				 -->  
				  <td align="left">
				  <%
				  ps_chk = con.prepareStatement("select * from mst_comp where DMS_CODE="+code);
				  rs_chk = ps_chk.executeQuery();
				  while(rs_chk.next()){
					  if(rs_chk.getInt("COMPANY")==0){
						  flagchk = 1;
					  }
				  }
 				  if(flagchk==0){
				  ps_data = con.prepareStatement("SELECT company_name FROM complaintzilla.user_tbl_company where company_id in (SELECT company FROM complaintzilla.mst_comp where dms_code="+code+")");
				  rs_data = ps_data.executeQuery(); 
				  while(rs_data.next()){
				  %>
				  &nbsp;<%= rs_data.getString("company_name")%><b style="background-color: #eaf073">&nbsp;,&nbsp;</b>
				  <%
				  }  
 				  }else{
 				  %>
 				  ALL
 				  <%	  
 				  }
 				  flagchk = 0;
				  %>
				  </td> 
				  <!--
					---------------------------------------------- Department ---------------------------------------------   
				  -->  
				  <td align="left">
				  <%
				  ps_chk = con.prepareStatement("select * from mst_comp where DMS_CODE="+code);
				  rs_chk = ps_chk.executeQuery();
				  while(rs_chk.next()){
					  if(rs_chk.getInt("COMPANY")==0){
						  flagchk = 1;
					  }
				  }
 				  if(flagchk==0){
				  ps_data = con.prepareStatement("SELECT department FROM complaintzilla.user_tbl_dept where dept_id in (SELECT dept FROM complaintzilla.mst_dept where dms_code="+code+")");
				  rs_data = ps_data.executeQuery(); 
				  while(rs_data.next()){ 
				  %>
				  &nbsp;<%= rs_data.getString("department")%><b style="background-color: #eaf073">&nbsp;,&nbsp;</b>
				  <%
				  }
 				  }else{
 				  %>
 				  ALL
 				  <%  
 				  }
 				  flagchk = 0;
				  %>
				  </td>
				  <!--
					---------------------------------------------- Documents ---------------------------------------------   
				  -->  
				  <td align="left">
				  <%
				  ps_data = con.prepareStatement("SELECT * FROM tarn_dms where tran_no="+code);
				  rs_data = ps_data.executeQuery(); 
				  while(rs_data.next()){
					  ps_use = con.prepareStatement("select * from user_tbl where u_id="+rs_data.getInt("user"));
						 rs_use = ps_use.executeQuery();
						 while(rs_use.next()){
							 cr_use = rs_use.getString("u_name"); 
						 }
						 cr_note = rs_data.getString("note");
				  %>
				  <a href="Display_Doc.jsp?field=<%=rs_data.getInt("CODE")%>" style="color: #3a22c8" 
				  title="Created By <%=cr_use%>
Note : <%=rs_data.getString("note")%>"><b><%=rs_data.getString("File_Name")%></b></a><font style="color: black;font-family: Arial;">---<%= cr_note%></font> 
				 <br>
				  <%
				  } 
				  %>
				  </td>
				  <!--
					------------------------------------------------------------------------------------------------------   
				  -->  
				  <td align="left"><%=rs.getString("note") %></td>
				  <td align="center" style="width: 2%">
				  <%
				  if(rs.getInt("SHARE_FLAG")==1 && rs.getInt("SHARED_ACCESS")==1){
				  %>
				  	<img src="images/Add.png" style="height: 17px;cursor: pointer;" title="Add" onclick="AddNewDocs('<%=rs.getInt("CODE") %>','<%=rs.getString("FOLDER") %>')">
				  <%
				  }else{
				  %>
				  <b title="view only" style="background-color:#e1e38a;cursor: pointer;">---</b>
				  <%  
				  }
				  %>	
					<!-- <img src="images/edit.png" style="height: 17px;cursor: pointer;" title="Edit"> 
					<img src="images/delete.png" style="height: 17px;cursor: pointer;" title="Delete">  -->
				  </td>
			  </tr>
			  <%
			  sn++;
   				}
			  %>
			</table> 
			</div>
			<div style="float: right;width: 39%">
			<table style="width: 100%;" class="tftable">
				<tr>
					<th colspan="8" align="center"><marquee  behavior="alternate" scrolldelay="200"><b style="color: #348200;"> &#8647;===== HISTORY =====&#8649;</b></marquee></th>
				</tr>
				<tr style="background-color: #acc8cc;"> 
					<td align="center"><strong>Subject / File Name</strong></td>
					<td align="center"><strong>Document</strong></td>
			        <td align="center"><strong>Checked by</strong></td>
				    <td align="center"><strong>Date</strong></td> 
				    <td align="center"><strong>Status</strong></td> 
				</tr>
				<%
				ps  = con.prepareStatement("select * from mst_dmshist where DMS_CODE=" + code);
				rs = ps.executeQuery();
				while(rs.next()){
				%>
				<tr>
				  <td><%=folderName %></td>
				  <td><%=rs.getString("TRAN_FILE") %></td> 
				  <td><%=rs.getString("USER") %></td> 
				  <td><%=rs.getTimestamp("DATE")%></td>  
				  <td><%=rs.getString("STATUS") %></td> 
				 </tr>
				 <%
					}
				 %>
			</div>
	<%
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
</span>
</body>
</html>