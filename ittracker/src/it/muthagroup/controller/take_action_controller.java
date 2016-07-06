package it.muthagroup.controller;

import it.muthagroup.bo.take_action_bo;
import it.muthagroup.vo.take_action_vo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class take_action_controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		HttpSession session=request.getSession();
		
		String status=null,remark=null,done_by=null;
		int req_no=0,uid=0;
		
		status=request.getParameter("status");
		remark=request.getParameter("remark_details");
		done_by=request.getParameter("done_by");
		req_no=Integer.parseInt(request.getParameter("req_no"));
		uid=Integer.parseInt(session.getAttribute("uid").toString());
		
		take_action_vo vo=new take_action_vo();
		
		vo.setDone_by(done_by);
		vo.setRemark(remark);
		vo.setReq_no(req_no);
		vo.setStatus(status);
		vo.setUid(uid); 
		
		take_action_bo bo=new take_action_bo();
		
		bo.takeAction(session,response,vo);
	} 
}