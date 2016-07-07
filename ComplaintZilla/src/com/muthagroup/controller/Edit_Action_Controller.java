package com.muthagroup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.bo.Complaint_Action_BO;
import com.muthagroup.bo.Edit_Action_BO;
import com.muthagroup.dao.Complaint_Action_Dao;
import com.muthagroup.dao.Edit_Action_Dao;
import com.muthagroup.vo.Edit_Action_vo;


public class Edit_Action_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String a_type=null,a_disc=null,c_no=null;
		int a_no=0;
		boolean flag=false;
		
		HttpSession session = null;
		
		a_type=request.getParameter("a_type");
		a_disc=request.getParameter("action_description");
		a_no=Integer.parseInt(request.getParameter("a_no"));
		c_no=request.getParameter("c_no");
		
		System.out.println("a-Type"+a_type);
		System.out.println("a-Disc"+a_disc);
		System.out.println("a-NO"+a_no);
		System.out.println("C_No"+c_no);
		
		Edit_Action_vo edit_a_vo=new Edit_Action_vo();
		
		edit_a_vo.setA_type(a_type);
		edit_a_vo.setA_disc(a_disc);
		edit_a_vo.setC_no(c_no);
		edit_a_vo.setA_no(a_no);
		
		
		Edit_Action_Dao edit_a_dao = new Edit_Action_Dao();
		Edit_Action_BO edit_a_bo = new Edit_Action_BO();
		
		flag=edit_a_bo.update_Action(edit_a_vo,session);
		
		
		
		if(flag==true)
		{
			response.sendRedirect("Complaint_Action.jsp?hid="+c_no);
		}
		else
		{
			System.out.println("Entry Failed");
		}
		
		
	}

}
