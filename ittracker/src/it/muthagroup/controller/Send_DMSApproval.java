package it.muthagroup.controller;
 
import it.muthagroup.dao.DMSApproval_dao;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Send_DMSApproval")
public class Send_DMSApproval extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String folder_code = "", tran_no = "", approval = "", decline = "",hid_tranrel="";
			folder_code = request.getParameter("folder_code");
			tran_no  = request.getParameter("tran_no");
			approval  = request.getParameter("hid_code");
			hid_tranrel  = request.getParameter("hid_tranrel");
			
			
			DMSApproval_dao dao = new DMSApproval_dao();
			HttpSession session = request.getSession();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			
			dao.approvalGiven(folder_code,tran_no,approval,hid_tranrel,uid,response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}