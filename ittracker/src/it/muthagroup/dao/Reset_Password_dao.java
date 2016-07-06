package it.muthagroup.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.Reset_Password_vo;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Reset_Password_dao {

	String pwd1=null;
	String pwd2=null;
	int user_id=0;
	
	Connection con=Connection_Utility.getConnection();
	
	public void reset_password(Reset_Password_vo vo, HttpSession session, HttpServletResponse response) 
	{
		pwd1=vo.getPwd1();
		pwd2=vo.getPwd2();
		user_id=vo.getUser_id();
		int i=0;
		
		System.out.println("Password details.... "+pwd1+" and "+pwd2+" and "+user_id);
		
		try {
			PreparedStatement ps_resPwd=con.prepareStatement("update user_tbl set Login_Password=? where u_id="+user_id);
			
			ps_resPwd.setString(1, pwd1);
			
			i=ps_resPwd.executeUpdate();
			
			if(i>0)
			{
				try {
					response.sendRedirect("User_List.jsp");
				} catch (IOException e) {
				
					e.printStackTrace();
				}
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
				
		
	}

	
}
