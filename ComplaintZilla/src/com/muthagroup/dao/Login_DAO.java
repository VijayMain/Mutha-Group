package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Login_VO;

public class Login_DAO {

	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	boolean flag = false;
	int uid = 0;
	int dept_id = 0;
	String Complaint_No = null;

	public void authenticate_Login(Login_VO bean, HttpSession session,
			HttpServletResponse response) {

		try {

			con = Connection_Utility.getConnection();
			System.out.println("Get Connection");

			System.out.println("Complaint no get by mail  :::: "
					+ bean.getComplaint_No());

			session.setMaxInactiveInterval(-1);

			PreparedStatement ps_user;
			ResultSet rs_user;

			ps_user = con
					.prepareStatement("select * from user_tbl where Enable_id=1");
			rs_user = ps_user.executeQuery();

			int uid = 0;
			int dept_id = 0;
			String str = null;
			int software_id = 1;
			session.setMaxInactiveInterval(-1);

			while (rs_user.next()) {

				if (rs_user.getString("Login_Name").equalsIgnoreCase(
						bean.getLogin_Name())
						&& rs_user.getString("Login_Password")
								.equalsIgnoreCase(bean.getLogin_Password())) {
					System.out.println("User Id matched = " + uid);
					uid = rs_user.getInt("U_Id");

					dept_id = rs_user.getInt("dept_id");
					System.out.println("Department Id . . " + dept_id);
					PreparedStatement ps_swAccess = con
							.prepareStatement("select * from it_software_access_tbl where U_Id="
									+ uid);
					ResultSet rs_swAccess = ps_swAccess.executeQuery();

					if (rs_swAccess.equals("")) {
						str = "Access IS Denied . . . !";
						System.out
								.println("software access tbl is empty .....");

					} else {

						while (rs_swAccess.next()) {
							System.out
									.println("checking software access .....");
							if (software_id == rs_swAccess
									.getInt("Software_Id")
									&& rs_swAccess.getInt("Enable_Id") == 1) {
								session.setAttribute("uid",
										rs_user.getInt("U_Id"));
								flag = true;
							} else {
								str = "Access IS Denied . . . !";
								System.out.println("Access Is denied.....");
							}

						}

					}
					// rs_swAccess.close();
				}
				// rs_user.close();

			}
			if (flag == true) {

				if (dept_id == 8 || dept_id == 11) {
					System.out.println("hello m here 1");
					session.setAttribute("uid", uid);
					System.out.println("User Id ==== " + uid);
					response.sendRedirect("Marketing_Home.jsp");
				}

				else if (dept_id == 9 || dept_id == 18) {
					session.setAttribute("uid", uid);
					session.setAttribute("deptid", dept_id);
					response.sendRedirect("Admin_Index.jsp");
				}

				else {
					session.setAttribute("uid", uid);
					response.sendRedirect("Home.jsp");
				}

			}

			else

			{
				response.sendRedirect("Login_Error.jsp?q=" + str);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				System.out.println("Connection Closed");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
}
