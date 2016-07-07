package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.muthagroup.connectionModel.Connection_Utility;

public class Login_Homedao {

	public void check_Login(String name, String password, HttpSession session,HttpServletResponse response) {
		try {
			boolean flag = false;
			String str=null,str1=null;
			Connection con = Connection_Utility.getConnection();
			PreparedStatement ps = con.prepareStatement("select * from user_tbl where Enable_id=1");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (rs.getString("Login_Name").equalsIgnoreCase(name) && rs.getString("Login_Password").equalsIgnoreCase(password)) {
					flag = true;
					// Set Session timeout
					session.setMaxInactiveInterval(-1);
					session.setAttribute("uid", rs.getInt("U_Id"));
				}
			} 
			str = "Login error !!!";
			str1 = "Please try again...."; 
			if(flag==true)
			{
				response.sendRedirect("homepage.jsp");
			}
			else
			{
				response.sendRedirect("homepage.jsp?str="+str+"&str1="+str1);
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
