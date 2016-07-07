package com.muthagroup.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.bo.Login_BO;
import com.muthagroup.vo.Login_VO;

public class Login_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String Complaint_No=null;
		
		try {
			Complaint_No=request.getParameter("complaint_no");
			Login_VO bean = new Login_VO(request);
			Login_BO bo = new Login_BO();
			bean.setComplaint_No(Complaint_No);
			
			bo.verify_Login(bean, session, response);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}
}
