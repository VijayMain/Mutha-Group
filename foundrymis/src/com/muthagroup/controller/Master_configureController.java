package com.muthagroup.controller;
 
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Masterconfigure_dao;
import com.muthagroup.vo.Masterconfigure_vo;

@WebServlet("/Master_configureController")
public class Master_configureController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try { 
			boolean flag=false;
			HttpSession session=request.getSession();
			String[] softNames= request.getParameterValues("software_selected");
			ArrayList<String> soft=new ArrayList<String>();	
			for(int i=0;i<softNames.length; i++)
			{
				soft.add(softNames[i]);
				System.out.println("selected softwares.. "+softNames[i]);
			}
			
			System.out.println("selected softwares.. "+soft); 
			
			String matType = request.getParameter("matType");
			
			System.out.println("selected user Id .. "+matType);
			
			Masterconfigure_vo vo=new Masterconfigure_vo(); 
			
			Set<String> se =new HashSet();
			se.addAll(soft);
			soft.clear();
			soft = new ArrayList<String>(se);
			 
			vo.setSoft(soft);
			vo.setMatType(matType);
			
			System.out.println("Data = " + vo.getSoft() + " mat = " + vo.getMatType());
			
			Masterconfigure_dao dao=new Masterconfigure_dao();
			
			flag=dao.addAccess(session,vo);
			
			if(flag==true)
			{
				response.sendRedirect("MasterFillingRel.jsp");
			}
			else
			{
				response.sendRedirect("MasterFillingRel.jsp");
			}
			} catch (Exception e) {
			e.printStackTrace();
			}
	}
}