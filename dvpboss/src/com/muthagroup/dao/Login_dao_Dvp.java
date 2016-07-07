package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Login_VO_Dvp;

public class Login_dao_Dvp 
{
	boolean flag = false;
	public void checkLogin(HttpServletRequest request,
			HttpServletResponse response, Login_VO_Dvp vo) 
	{

		HttpSession session=request.getSession();

		try {
			Connection con = Connection_Utility.getConnection();

			PreparedStatement ps_user = null;
			ResultSet rs_user = null;
			System.out.println("Login DVP DAO");
			ps_user = con.prepareStatement("select * from user_tbl where Enable_Id=1");
			rs_user = ps_user.executeQuery();
			String str = null;
			int uid = 0;
			int dept_id = 0;
			int software_id = 5;
			session.setMaxInactiveInterval(-1);

			while (rs_user.next()) {
				uid = rs_user.getInt("U_Id");
				
				if (rs_user.getString("Login_Name").equalsIgnoreCase(vo.getUname())
						&& rs_user.getString("Login_Password").equalsIgnoreCase(vo.getPwd()))
				{
					System.out.println("User Id matched = " + uid);
					
					dept_id = rs_user.getInt("dept_id");
					
					System.out.println("Department Id . . " + dept_id);
					
					PreparedStatement ps_swAccess = con
							.prepareStatement("select * from it_software_access_tbl where U_Id="
									+ uid);
					ResultSet rs_swAccess = ps_swAccess.executeQuery();

					while (rs_swAccess.next()) {
						if (software_id == rs_swAccess.getInt("Software_Id")
								&& rs_swAccess.getInt("Enable_Id") == 1) {
							session.setAttribute("uid", rs_user.getInt("U_Id"));
							flag = true;
						} else {
							System.out.println("Access Not Provided for the DVP ....");
							str = "Access Denide..";
						}
					}
					rs_swAccess.close();
				}
				
			}
			rs_user.close();


			str="Check your credentials";
			
			if(flag==true)
			{
				response.sendRedirect("Home.jsp");
			}
			else
			{
				response.sendRedirect("Login_Error.jsp?str="+str);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		
	}

}
