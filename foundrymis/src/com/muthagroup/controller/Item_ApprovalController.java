package com.muthagroup.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.dao.ItemCreation_Approval_dao;

public class Item_ApprovalController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
				String status = request.getParameter("hid_status");
				String code = request.getParameter("hid_mode");
				HttpSession session=request.getSession();
				String userName = session.getAttribute("uname").toString(); 
				
				if(!status.equalsIgnoreCase("") && !code.equalsIgnoreCase("")){
					ItemCreation_Approval_dao dao = new ItemCreation_Approval_dao();
					dao.approvalStatus_Update(status,code,response,userName);
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}