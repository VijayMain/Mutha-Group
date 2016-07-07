package com.muthagroup.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;

public class MIS_LoginDAO {

	public void checkLogin(HttpServletRequest request,
			HttpServletResponse response, String uname, String pwd) {
		boolean flag=false;
		 try {
			 	HttpSession session=request.getSession();

				Connection con = Connection_Utility.getConnection();

				PreparedStatement ps_user = null;
				ResultSet rs_user = null;
				ps_user = con.prepareStatement("select * from user_tbl where Enable_Id=1");
				rs_user = ps_user.executeQuery();
				String str = null,str1 = null;
				int uid = 0;
				int dept_id = 0;
				int software_id = 7; 
				
				session.setMaxInactiveInterval(-1);

				while (rs_user.next()) {
					uid = rs_user.getInt("U_Id");
					
					if (rs_user.getString("Login_Name").equalsIgnoreCase(uname) && rs_user.getString("Login_Password").equals(pwd))
					{
						
						uid = rs_user.getInt("U_Id");
						System.out.println("User Id matched = "+uid);
						dept_id=rs_user.getInt("dept_id");
						System.out.println("Department Id . . "+dept_id);
						PreparedStatement ps_swAccess=con.prepareStatement("select * from it_software_access_tbl where U_Id="+uid);
						ResultSet rs_swAccess=ps_swAccess.executeQuery();
						
						while(rs_swAccess.next())
						{
							if(software_id==rs_swAccess.getInt("Software_Id") && rs_swAccess.getInt("Enable_Id")==1)
							{
								System.out.println("login chked... user id is..."+uid);
									session.setAttribute("uid", rs_user.getInt("U_Id"));
								flag=true;
							}
						}
						rs_swAccess.close(); 
					}  
				} 
				str = "Login error !!!";
				str1 = "Please try again....";
				
				if(flag==true)
				{
					response.sendRedirect("HomePage.jsp");
				}
				else
				{
					response.sendRedirect("MIS_Login.jsp?str="+str+"&str1="+str1);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} 
	} 
}