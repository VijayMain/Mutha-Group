package it.muthagroup.controller;

import it.muthagroup.vo.Feedback_vo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Feedback_controller")
public class Feedback_controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
				Feedback_vo vo = new Feedback_vo();	             
				vo.setInternetandnetwork(Integer.valueOf(request.getParameter("internetandnetwork")));
				vo.setPclaptop(Integer.valueOf(request.getParameter("pclaptop")));
				vo.setInhouse(Integer.valueOf(request.getParameter("inhouse")));
				vo.setErp(Integer.valueOf(request.getParameter("erp")));
				vo.setSatisfiedit(Integer.valueOf(request.getParameter("satisfiedit")));
				vo.setComment(request.getParameter("comment"));
				
				System.out.println("data = " + vo.getInternetandnetwork() + " + " + vo.getPclaptop()+ " + " + vo.getInhouse()+ " + " + vo.getErp()+ " + " + vo.getSatisfiedit() + " = " + vo.getComment());
				
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
