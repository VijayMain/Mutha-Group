package com.muthagroup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.dao.ApprovalDAO;

public class Approval_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			int Sheet_no = Integer.parseInt(request.getParameter("sheetNo"));
			int apType = Integer.parseInt(request.getParameter("approval_type"));
			String remark = request.getParameter("appRemark");
			HttpSession sess = request.getSession();
			int hid = 0;
			ApprovalDAO dao = new ApprovalDAO();

			hid = dao.approvalSheet(Sheet_no, apType, remark, sess);

			if (hid != 0) {
				response.sendRedirect("Approval_Requests.jsp?msg="+" Approval is successfully given");
			} else {
				System.out.println("Failed");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
