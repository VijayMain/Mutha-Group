package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Admin_index_vo;

public class Admin_Index_DAO {

	Connection con = null;
	PreparedStatement ps = null;
	boolean flag = false;
	
	// Adding New User
	public boolean addUser(Admin_index_vo bean, HttpServletResponse response, HttpSession session) {

		try {

			boolean flag_user = false;
			int enable_id = 1;
			con = Connection_Utility.getConnection();
			
			int uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			PreparedStatement ps_checkUser = con
					.prepareStatement("select Login_Name from User_Tbl");

			ResultSet rs_checkUser = ps_checkUser.executeQuery();
			String login_name = null;
			while (rs_checkUser.next()) {
				login_name = rs_checkUser.getString("Login_Name");

				if (bean.getLogin_name().equals(login_name)) {
					flag_user = true;
					break;
				}
			}
			if (flag_user == true) {
				response.sendRedirect("L_Name_Error.jsp");
			}

			else {
				int grade_id=0;
				String u_desi=null;
				
				PreparedStatement ps_grade=con.prepareStatement("select Designation from user_tbl_grade where grade_id="+bean.getUser_designation());
				ResultSet rs_grade=ps_grade.executeQuery();
				while(rs_grade.next())
				{
					u_desi=rs_grade.getString("Designation");
				}
				

				ps = con.prepareStatement("insert into user_tbl(U_Name,U_Designation,Company_Id,Login_Name,Login_Password,U_Email,Dept_id,Enable_Id,Grade_Id)values(?,?,?,?,?,?,?,?,?)");
				ps.setString(1, bean.getUser_name());
				ps.setString(2, u_desi);
				ps.setInt(3, bean.getCompany());
				ps.setString(4, bean.getLogin_name());
				ps.setString(5, bean.getPassword());
				ps.setString(6, bean.getEmail());
				ps.setInt(7, bean.getDept());
				ps.setInt(8, enable_id);
				ps.setInt(9, bean.getUser_designation());
				int i = ps.executeUpdate();

				if (i > 0) {
					flag = true;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	// Adding New Company to list

	public boolean insertCompany(Admin_index_vo bean, HttpSession session) {
		boolean flag = false;
		try {
			con = Connection_Utility.getConnection();
			int uid=Integer.parseInt(session.getAttribute("uid").toString());
			ps = con.prepareStatement("insert into user_tbl_company(Company_Name,Created_By)values(?,?)");
			ps.setString(1, bean.getCompany_Name());
			ps.setInt(2,uid);
			int i = ps.executeUpdate();
			if (i > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

	// Adding New Customer

	public boolean insertCustomer(Admin_index_vo bean, HttpSession session) {
		try {
			int uid=Integer.parseInt(session.getAttribute("uid").toString());
			con = Connection_Utility.getConnection();
			ps = con.prepareStatement("insert into customer_tbl(Cust_Name,Email,Created_By)values(?,?,?)");
			ps.setString(1, bean.getCustomer_name());
			ps.setString(2, bean.getCustomer_email());
			ps.setInt(3,uid);
			int i = ps.executeUpdate();

			// Getting ID Of newly created Customer To relate it with the
			// particular company.
			PreparedStatement ps_cust_id = null;
			ps_cust_id = con
					.prepareStatement("select max(cust_id) from customer_tbl");
			ResultSet rs_cust = ps_cust_id.executeQuery();
			int cust_id = 0;
			while (rs_cust.next()) {
				cust_id = rs_cust.getInt(1);
			}

			// Creating the relation between Company and Customer
			PreparedStatement ps_rel = null;
			ps_rel = con
					.prepareStatement("insert into company_customer_relation_tbl(Company_Id,Cust_Id)values(?,?)");
			ps_rel.setInt(1, bean.getCompany());
			ps_rel.setInt(2, cust_id);
			int j = ps_rel.executeUpdate();

			if (i > 0 && j > 0) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

	// Adding New Item
	public boolean insertItem(Admin_index_vo bean, HttpSession session) {

		try {

			con = Connection_Utility.getConnection();
			int uid=Integer.parseInt(session.getAttribute("uid").toString());
			PreparedStatement ps_item = con
					.prepareStatement("insert into customer_tbl_item(Item_Name,Created_By)values(?,?)");
			ps_item.setString(1, bean.getIten_name());
			ps_item.setInt(2, uid);
			int i = ps_item.executeUpdate();
			
			// Getting ID Of newly created Item To relate it with the particular
			// customer.
			PreparedStatement ps_item_id = con
					.prepareStatement("select max(item_id) from customer_tbl_item");
			ResultSet rs_item_id = ps_item_id.executeQuery();
			int item_id = 0;

			while (rs_item_id.next()) {
				item_id = rs_item_id.getInt(1);
			}
			// Creating the relation between Item and Customer
			PreparedStatement ps_rel = con
					.prepareStatement("insert into customer_item_tbl(Cust_Id,Item_Id)values(?,?)");
			ps_rel.setInt(1, bean.getCustomer_id());
			ps_rel.setInt(2, item_id);

			int j = ps_rel.executeUpdate();

			if (i > 0 && j > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

	// Add New Defect

	public boolean insertDefect(Admin_index_vo bean, HttpSession session) {

		try {

			con = Connection_Utility.getConnection();
			PreparedStatement ps = con
					.prepareStatement("insert into defect_tbl(Defect_Type)values(?)");
			ps.setString(1, bean.getDefect());
			int i = ps.executeUpdate();
			if (i > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;

	}

	// Adding New Defect
	public boolean insertCategory(Admin_index_vo bean, HttpSession session) {

		try {

			con = Connection_Utility.getConnection();
			PreparedStatement ps = con
					.prepareStatement("insert into category_tbl(Category,Category_Initials)values(?,?)");
			ps.setString(1, bean.getCatagory_name());
			ps.setString(2, bean.getCat_init());
			int i = ps.executeUpdate();
			if (i > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;

	}

	// Adding new Action
	public boolean insertAction(Admin_index_vo bean, HttpSession session) {

		try {

			con = Connection_Utility.getConnection();
			PreparedStatement ps = con
					.prepareStatement("insert into action_type_tbl(Action_Type)values(?)");
			ps.setString(1, bean.getAction_Type());
			int i = ps.executeUpdate();
			if (i > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

	// Adding New Users to AutoMailing List
	public boolean insertAutoMailingList(Admin_index_vo bean, HttpSession session) {

		try {
			con = Connection_Utility.getConnection();
			String mailid = null;
			int uid=Integer.parseInt(session.getAttribute("uid").toString());
			// Get the MAil Id of particular User Which you want to add into
			// auto mailing list
			PreparedStatement ps_mail = con
					.prepareStatement("select * from user_tbl where u_id="
							+ bean.getU_id());
			ResultSet rs_mail = ps_mail.executeQuery();
			while (rs_mail.next()) {
				mailid = rs_mail.getString("U_Email");
			}
			// Adding U_ID And Mail Id to auto mailing list
			PreparedStatement ps = con
					.prepareStatement("insert into automail(U_id,Email,Company_id,Created_By)values(?,?,?,?)");
			ps.setInt(1, bean.getU_id());
			ps.setString(2, mailid);
			ps.setInt(3, bean.getCompany());
			ps.setInt(4, uid);
			int i = ps.executeUpdate();
			if (i > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

	public boolean insertDepartment(Admin_index_vo bean, HttpSession session) {
		
		try {
			int uid=Integer.parseInt(session.getAttribute("uid").toString());
			con = Connection_Utility.getConnection();
			PreparedStatement ps = con.prepareStatement("insert into user_tbl_dept(Department,Created_By)values(?,?)");
			ps.setString(1, bean.getDeparment());
			ps.setInt(2, uid);
			int i = ps.executeUpdate();
			if (i > 0) 
			{
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return flag;
	}

}
