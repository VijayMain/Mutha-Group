package com.muthagroup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.bo.Edit_Others_bo;
import com.muthagroup.vo.Edit_Others_vo;


public class Edit_Others_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String other=null;
		boolean flag=true;
		int basic_id=0;
		int rel_id=0;
		
		
		if(request.getParameter("basic_id")!=null)
		{
			basic_id=Integer.parseInt(request.getParameter("basic_id"));
		}
		if(request.getParameter("rel_id")!=null)
		{
			rel_id=Integer.parseInt(request.getParameter("rel_id"));
		}
		
		
		request.getParameter("rel_id");
		
		other=request.getParameter("description");
		
		Edit_Others_vo vo=new Edit_Others_vo();
		
		vo.setBasic_id(basic_id);
		vo.setOther(other);
		vo.setRel_id(rel_id);
		
		Edit_Others_bo bo=new Edit_Others_bo();
		
		flag=bo.updateOthers(vo,request);
		
		if(flag==true)
		{
			response.sendRedirect("Activity_Sheet.jsp?hid="+basic_id);
		}
		else
		{
			System.out.println("Error occured... Edit other controller...");
		}
		
	}

}
