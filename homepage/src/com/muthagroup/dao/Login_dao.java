package com.muthagroup.dao;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;

public class Login_dao {
	public void check_Login(String name, String password, HttpSession session, HttpServletResponse response) {
		try {
			boolean flag = false;
			Connection con=Connection_Utility.getConnection();
			PreparedStatement ps = con.prepareStatement("select * from user_tbl where Dept_Id=26 or Dept_Id=21 having Enable_id=1");
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				if(rs.getString("Login_Name").equalsIgnoreCase(name) && rs.getString("Login_Password").equalsIgnoreCase(password)){
					flag = true;
					// Set Session timeout
					session.setMaxInactiveInterval(-1);
					session.setAttribute("uid", rs.getInt("U_Id"));
				}
			}	
			if(flag==true){
				response.sendRedirect("HR_Home.jsp");
			}else {
				String fail = "Login Failed !!!";
				response.sendRedirect("Attendance_Login.jsp?fail="+fail);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
}
