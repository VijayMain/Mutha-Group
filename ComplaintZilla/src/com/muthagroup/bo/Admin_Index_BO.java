package com.muthagroup.bo;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Admin_Index_DAO;
import com.muthagroup.vo.Admin_index_vo;
import com.sun.mail.iap.Response;

@SuppressWarnings("unused")
public class Admin_Index_BO {
	HttpServletResponse response;
	public Admin_Index_BO(HttpServletResponse response) {
		this.response= response;
	}

	public boolean insertData(Admin_index_vo bean, HttpSession session) {

		String u_name = bean.getUser_name();
		int u_desig = bean.getUser_designation();
		int company = bean.getCompany();
		System.out.println(company+" Company_id");
		
		int dept_id=bean.getDept();
		String email = bean.getEmail();
		String loginName = bean.getLogin_name();
		String password = bean.getPassword();
		String company_Name = bean.getCompany_Name();
		String Cust_Name = bean.getCustomer_name();
		String Mail_Id = bean.getCustomer_email();
		String item_Name = bean.getIten_name();
		int cust_Id = bean.getCustomer_id();
	//	String subject = bean.getSubject();
		String defect = bean.getDefect();
		String cat_name = bean.getCatagory_name();
		String action_Type = bean.getAction_Type();
		String department=bean.getDeparment();
		
		int u_id=bean.getU_id();	
		System.out.println(u_id+" User_id");
		boolean flag = false;

		Admin_Index_DAO dao = new Admin_Index_DAO();

		if (u_name != null && u_desig != 0 && company != 0 && dept_id!=0 && email != null
				&& loginName != null && password != null)
		{
			flag = dao.addUser(bean,response,session);
		}
		else if (bean.getCompany_Name() != null) 
		{
			flag = dao.insertCompany(bean,session);
		} 
		else if (company!=0 && Cust_Name != null && Mail_Id != null) 
		{
			flag = dao.insertCustomer(bean,session);
		}
		else if (cust_Id != 0 && item_Name != null) 
		{
			flag = dao.insertItem(bean,session);
		} 
		else if (defect != null) 
		{
			flag = dao.insertDefect(bean,session);
		} 
		else if (cat_name != null) 
		{
			flag = dao.insertCategory(bean,session);
		}
		else if (action_Type != null) {
			flag = dao.insertAction(bean,session);
		}
		else if (u_id !=0 && company !=0)
		{
			flag=dao.insertAutoMailingList(bean,session);
		}
		else if(department!=null)
		{
			flag=dao.insertDepartment(bean,session);
		}
		else {
			try {
				response.sendRedirect("Insertion_fail.jsp");
			} catch (IOException e) {
				
				e.printStackTrace();
			}
			//flag = false;
		}

		return flag;
	}

}
