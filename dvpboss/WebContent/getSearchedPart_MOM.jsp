<%@page import="java.sql.ResultSet"%>
<%@page import="com.muthagroup.connectionModel.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
try{
	String getmom = request.getParameter("q");
	String getmomComp = request.getParameter("r");
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	String compqry = " " , compsqr1 = " ";
	String all = "All";
	String partNAME = "";
	PreparedStatement ps_setPart = null;
	ResultSet rs_setPart = null;
	Connection con = Connection_Utility.getConnection(); 
			if(getmomComp.equalsIgnoreCase(all) && getmom.equalsIgnoreCase(all)){
				
			}
			if(getmomComp.equalsIgnoreCase(all) && !getmom.equalsIgnoreCase(all)){
				ps_setPart = con.prepareStatement("select * from dev_mom_tbl where part_code='"+getmom+"' ");
				rs_setPart = ps_setPart.executeQuery();
				while(rs_setPart.next()){
					partNAME = rs_setPart.getString("part_name");
				} 
				compsqr1 = " and part_name like('"+partNAME+"') ";
			}
			if(!getmomComp.equalsIgnoreCase(all) && getmom.equalsIgnoreCase(all)){
				
			compqry = " where company="+getmomComp+" "; 
			}
			if(!getmomComp.equalsIgnoreCase(all) && !getmom.equalsIgnoreCase(all)){
				
				compqry = " where company="+Integer.parseInt(getmomComp)+" ";
				compsqr1 = " and part_code='"+getmom+"' and company="+Integer.parseInt(getmomComp)+" ";
			} 
//	 System.out.println("qry = " + compqry + "   " + compsqr1);
%>
<span id="getMOM_Data">
<%
if(getmomComp.equalsIgnoreCase("All")){
%>
<input type="hidden" name="status" id="status" value="All">
<% 
}else{
%>
<input type="hidden" name="status" id="status" value="<%=getmomComp%>">
<% 
}
%>
			<table width="93%" border="1" class="gridtable">
				<tr align="center" style="background-color: #B0C9D6">
					<th width="1%" height="33" scope="col">M.No.</th> 
					<th width="12%" scope="col">COMPANY
							<select name="s_name" id="s_name" style="width : 20px;" onchange="getMOM_Data(this.value)">
								<option value=""></option>
								<option value="All">All</option>
								<%
									PreparedStatement ps_sname = con.prepareStatement("SELECT * FROM user_tbl_company where company_id in (SELECT distinct(company) FROM dev_mom_tbl)");
									ResultSet rs_sname = ps_sname.executeQuery();
									while(rs_sname.next()){
								%>					
								<option value="<%=rs_sname.getInt("Company_Id")%>"><%=rs_sname.getString("Company_Name") %></option>
					 			<%
									}
									ps_sname.close();
									rs_sname.close();
					 			%>
							</select>
					</th>
					<th width="12%" scope="col">PART NAME
								<select name="s_name" id="s_name" style="width : 20px;" onchange="getMOM_Partwise(this.value)">
								<option></option> 
								<%
									PreparedStatement ps_spart = con.prepareStatement("SELECT * FROM complaintzilla.dev_mom_tbl "+compqry+" group by part_name order by company");
									ResultSet rs_spart = ps_spart.executeQuery();
									while(rs_spart.next()){
								%>
								<option value="<%=rs_spart.getInt("part_code")%>"><%=rs_spart.getString("part_name") %></option>
					 			<%
									}
									ps_sname.close();
									rs_sname.close();
					 			%>
							</select>
					</th>
					<th width="10%" scope="col">MOM DATE</th> 
					<th width="10%" scope="col">CREATED BY</th> 
				</tr> 
				<%
				int mno = 1;
				PreparedStatement ps_comp = null,ps_user=null;
				ResultSet rs_comp = null,rs_user=null;
				PreparedStatement ps_mom = con.prepareStatement("select * from dev_mom_tbl where enable=1 "+compsqr1+" order by attached_date desc,company desc");
				ResultSet rs_mom = ps_mom.executeQuery();
				while(rs_mom.next()){
				%>
				<tr onclick="button1('<%=rs_mom.getInt("CODE")%>');" align="center" style="cursor: pointer;">
					<td><%=mno %></td>
				<%
					ps_comp = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_mom.getInt("company"));
					rs_comp = ps_comp.executeQuery();
					while(rs_comp.next()){
				%>
					<td align="left"><%=rs_comp.getString("Company_Name") %></td>
				<%
					}
				%>
					<td align="left"><%=rs_mom.getString("part_name") %></td>
					<td align="left"><%=sdf.format(rs_mom.getDate("mom_date")) %></td>
					<%
					ps_user = con.prepareStatement("select * from user_tbl where U_Id="+rs_mom.getInt("created_by"));
					rs_user = ps_user.executeQuery();
					while(rs_user.next()){
					%>
					<td align="left"><%=rs_user.getString("U_Name") %></td>
					<%
					}
					%>
				</tr> 
			<%
			mno++;
				}
			%>
			</table> 
		</span>	
		<%
}catch(Exception e){
	e.printStackTrace();
}
		%>
</body>
</html>