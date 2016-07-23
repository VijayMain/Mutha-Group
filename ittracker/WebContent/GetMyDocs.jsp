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
   %> 
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
				    <td align="center"><strong>Customize</strong></td>
				</tr>
				<%
				int sn=1,flagchk=0;
				String rights="";
				PreparedStatement ps_data = null,ps_chk=null;
				ResultSet rs_data = null,rs_chk=null;
				PreparedStatement ps  = con.prepareStatement("select * from mst_dmsfolder where CODE=" + code);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){ 
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
				  <td align="left"><%=sn %></td>
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
				  %>
				  &nbsp;<a href="Display_Doc.jsp?field=<%=rs_data.getInt("CODE")%>" style="color: #3a22c8"><b><%=rs_data.getString("File_Name")%></b></a>
				  <b style="background-color: #eaf073">&nbsp;,&nbsp;</b>
				  <%
				  } 
				  %>
				  </td>
				  <!--
					------------------------------------------------------------------------------------------------------   
				  -->  
				  <td align="left"><%=rs.getString("note") %></td>
				  <td align="center" style="width: 2%">
				  	<img src="images/Add.png" style="height: 17px;cursor: pointer;" title="Add">
					<img src="images/edit.png" style="height: 17px;cursor: pointer;" title="Edit"> 
					<img src="images/delete.png" style="height: 17px;cursor: pointer;" title="Delete"> 
				  </td>
			  </tr>
			  <%
			  sn++;
   				}
			  %>
			</table> 
	<%
	}catch(Exception e){
		e.printStackTrace();
	}
	%>		
</span>
</body>
</html>