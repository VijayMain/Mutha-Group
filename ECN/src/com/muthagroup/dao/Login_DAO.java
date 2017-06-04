package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionUtility.Connection_Utility;
import com.muthagroup.vo.Login_vo;
//============================================================================-->
//==================== Login Data Access Model ====================================-->
//============================================================================-->
public class Login_DAO {

	public boolean validateLogin(Login_vo vo, HttpSession session,
			HttpServletResponse response) {

		boolean flag = false;

		try {
			Connection con = Connection_Utility.getConnection();

			PreparedStatement ps_user = null;
			ResultSet rs_user = null;
			ps_user = con
					.prepareStatement("select * from user_tbl where Enable_Id=1");
			rs_user = ps_user.executeQuery();
			String str = null;
			int uid = 0;
			int dept_id = 0;
			int software_id = 2;
			session.setMaxInactiveInterval(-1);

			while (rs_user.next()) {
				uid = rs_user.getInt("U_Id");

				if (rs_user.getString("Login_Name").equalsIgnoreCase(
						vo.getLogin_Name())
						&& rs_user.getString("Login_Password")
								.equalsIgnoreCase(vo.getLogin_Password())) {
					// System.out.println("User Id matched = " + uid);
					dept_id = rs_user.getInt("dept_id");
					// System.out.println("Department Id . . " + dept_id);
					PreparedStatement ps_swAccess = con.prepareStatement("select * from it_software_access_tbl where U_Id="
									+ uid);
					ResultSet rs_swAccess = ps_swAccess.executeQuery();

					while (rs_swAccess.next()) {
						if (software_id == rs_swAccess.getInt("Software_Id")
								&& rs_swAccess.getInt("Enable_Id") == 1) {
							session.setAttribute("uid", rs_user.getInt("U_Id"));
							flag = true;
						} else {
							// System.out.println("Access Not Provided for the ECN");
							str = "Access Denide..";
						}
					}
					rs_swAccess.close();
				}
			}
			rs_user.close();

			if (flag == true) {
				response.sendRedirect("Cab_Home.jsp");
			} else {
				response.sendRedirect("Login_Fail.jsp?q=" + str);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}
}
//============================================================================--> 
//============================================================================-->