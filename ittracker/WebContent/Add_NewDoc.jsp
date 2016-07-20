<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>DMS</title>
</head>
<body>
	<%
		try {
			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
	%>
	<span id="new_dms">
		<form action="Add_NewDMSDoc" method="post" enctype="multipart/form-data" onSubmit="return validateForm();">
			<table style="width: 100%;" class="tftable">
				<tr>
					<th colspan="5" align="center"><strong>Add New Document</strong></th>
				</tr>
				<tr>
					<td width="16%" align="left"><b>Header / Folder Name</b></td>
					<td colspan="4" align="left">
					<input type="text" id="folder" name="folder" style="background-color:#d5f1ff;" maxlength="45"  onkeyup="get_allAvailFolders(this.value)"/>
					<span id="availFolder">
					<input type="hidden" name="avail" id="avail" value="1">
					</span>
					</td>
				</tr>
				<tr>
					<td align="left"><b>Subject / File Name</b></td>
					<td colspan="4" align="left"><input type="text" id="subject" name="subject" size="60" readonly="readonly" style="background-color:#d5f1ff;"/></td>
				</tr>
				<tr>
					<td align="left"><b>Share To Others</b></td>
					<td colspan="4" align="left"><input type="radio" name="share" value="yes" id="share_yes" /> Yes
					<input type="radio" name="share" value="no" id="share_no" /> No</td>
				</tr>
				<tr>
					<td align="left"><b>Shared User Access</b><br>(If Shared)</td>
					<td colspan="4" align="left"><input type="checkbox" name="add_access" value="add_files" id="add_access" style=""/>  Add More Files</td>
				</tr>
				<tr>
					<td align="left"><b>Share To (If Yes)</b><br>Use Ctrl to select Multiple </td>
					<td width="8%" align="left"><b>Company :</b> &nbsp;&nbsp;&nbsp;</td>
				    <td width="15%" align="left">
				    <select name="company" id="company" size="7" multiple="multiple" tabindex="1" style="width: 150px;background-color:#d5f1ff;">
                      <option value="">- - - - - All - - - - -</option>
                      <%
							PreparedStatement ps_comp = con.prepareStatement("select * from user_tbl_company");
							ResultSet rs_comp = ps_comp.executeQuery();
							while(rs_comp.next()){
					  %>
                      <option value="<%=rs_comp.getInt("Company_Id")%>"><%=rs_comp.getString("Company_Name") %></option>
                      <%
							}
					  %>
                    </select></td>
				    <td width="9%" align="left"><b>Department :</b> &nbsp;</td>
				    <td width="52%" align="left"><select name="department" id="department"  size="7" multiple="multiple" tabindex="1" style="width: 200px;background-color:#d5f1ff;">
                    <option value="">- - - - - All - - - - -</option>
                      <%
					  PreparedStatement ps_dept = con.prepareStatement("select distinct(Department),dept_id from user_tbl_dept order by Department");
					  ResultSet rs_dept = ps_dept.executeQuery();
					  while(rs_dept.next()){
					  %>
                      <option value="<%=rs_dept.getInt("dept_id")%>"><%=rs_dept.getString("Department") %></option>
                      <%
							}
					  %>
                    </select></td>
				</tr>
				<tr>
					<td align="left"><b>Document</b></td>
					<td colspan="4" align="left">
					<table id="tblSample">
						<tr>&nbsp;&nbsp;&nbsp;
						<strong><input type="button" value="  Click To ADD Files  " name="button" onclick="addRowToTable();" /></strong> &nbsp;&nbsp;
								<input type="button" value=" Delete [Selected] " onclick="deleteChecked();" />&nbsp;&nbsp;
								<input type="hidden" id="srno" name="srno" value="">
						</tr>
						<tbody></tbody>
					 </table>
				    </td>
				</tr>
				<tr>
				  <td align="left"><strong>Note</strong></td>
			      <td colspan="4" align="left"><textarea name="note" id="note" rows="2" cols="50" style="background-color:#d5f1ff;"></textarea></td>
		      </tr>
				<tr>
					<td colspan="5" align="left" style="padding-left: 20px;"><input
						type="submit" name="submit" value="   SAVE   "
						style="height: 30px; width: 200px; font-weight: bold;" /></td>
				</tr>
			</table>
		</form>
	</span>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>