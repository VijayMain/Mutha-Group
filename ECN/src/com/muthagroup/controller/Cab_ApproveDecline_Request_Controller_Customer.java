package com.muthagroup.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.bo.Cab_ApproveDecline_Request_BO;
import com.muthagroup.bo.Cab_ApproveDecline_Request_Customer_BO;
import com.muthagroup.vo.Cab_ApproveDecline_Request_Customer_Vo;
import com.muthagroup.vo.Cab_ApproveDecline_Request_Vo;
//============================================================================-->
//============================ Controller  ===================================-->
//============================================================================-->
public class Cab_ApproveDecline_Request_Controller_Customer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try {

			// ************************************************************************************************************************

			HttpSession session = request.getSession();

			int uid = 0;
			int approval_type = 0;
			String remark = null;
			int cr_no = 0;
			int cr_status_id = 0;

			ArrayList appsellist = new ArrayList();

			System.out.println("input values ======== "
					+ request.getParameterValues("approver_selected"));
			if (request.getParameterValues("approver_selected") != null) {
				System.out.println("input values ======== "
						+ request.getParameterValues("approver_selected"));
				String[] appSel = request
						.getParameterValues("approver_selected");

				for (int i = 0; i < appSel.length; i++) {

					appsellist.add(appSel[i]);
				}

				System.out.println("Approvers Selected ==== " + appsellist);
			}

			uid = Integer.parseInt(session.getAttribute("uid").toString());

			approval_type = Integer.parseInt(request
					.getParameter("approval_name"));

			remark = request.getParameter("remark");

			cr_no = Integer.parseInt(request.getParameter("crno"));

			// Initialize input parameters ======== >>>
			Cab_ApproveDecline_Request_Customer_Vo bean = new Cab_ApproveDecline_Request_Customer_Vo(
					request);
			Cab_ApproveDecline_Request_Customer_BO bo = new Cab_ApproveDecline_Request_Customer_BO();

			bean.setApproval_type(approval_type);
			bean.setCr_no(cr_no);
			bean.setCr_status_id(cr_status_id);
			bean.setRemark(remark);
			bean.setUid(uid);
			System.out.println("Approval Type" + bean.getApproval_type());
			boolean flag = bo.Cab_ApproveDecline(bean, session, appsellist);

			if (flag == true) {
				response.sendRedirect("Cab_Home.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
//============================================================================--> 
//============================================================================-->