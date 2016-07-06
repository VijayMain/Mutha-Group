package it.muthagroup.controller;

import it.muthagroup.bo.new_requisition_bo;
import it.muthagroup.vo.new_requisition_vo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class new_requisition_controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int req_no=0,rel_id=0,req_type_id=0;
		
		String req_details=null;
		
		boolean flag=false;
		
		HttpSession session=request.getSession();
		
		PrintWriter out=response.getWriter();
		
		req_no=Integer.parseInt(request.getParameter("req_no"));
		rel_id=Integer.parseInt(request.getParameter("rel_to"));
		req_type_id=Integer.parseInt(request.getParameter("req_type"));
		req_details=request.getParameter("req_details");
		
		new_requisition_vo vo=new new_requisition_vo();
		
		vo.setReq_no(req_no);
		vo.setRel_id(rel_id);
		vo.setReq_type_id(req_type_id);
		vo.setReq_details(req_details);
		
		new_requisition_bo bo=new new_requisition_bo();
		
		flag=bo.addReq(vo,session);
		if(flag==true)
		{
			response.sendRedirect("Requisition_Status.jsp");
		}
		else
		{
			out.println("Error.....");
		}
	}

}
