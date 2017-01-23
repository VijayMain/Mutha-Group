package com.muthagroup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Add_Document_dao;
import com.muthagroup.vo.Add_PPAPTrials_vo;

 
public class Add_Document_controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		try {
			Add_PPAPTrials_vo vo =new Add_PPAPTrials_vo();
			Add_Document_dao dao=new Add_Document_dao();
			HttpSession session = request.getSession();
			
			String apqp = request.getParameter("apqp"); 
			String psheet = request.getParameter("pr_sheet");
			String final_ppap = request.getParameter("final_ppap"); 
			
			vo.setApqp(apqp);
			vo.setPr_sheet(psheet);
			vo.setFinal_ppap(final_ppap);
			vo.setBasic_id(Integer.parseInt(request.getParameter("basic_id")));
			dao.addDoc(session,vo,response);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}

}
