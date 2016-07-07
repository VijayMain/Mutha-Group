package com.muthagroup.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.connectionUtil.ConnectionUrl;

public class Get_ASMFile_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String company = request.getParameter("company");
			String file_format = request.getParameter("file_typeasn");
 
			Connection con = null;
			int csv = 0; 
			 
			if (company.equalsIgnoreCase("101")) {
				
				if(file_format.equalsIgnoreCase("csv")){
					con = ConnectionUrl.getMEPLH21ERP();
					PreparedStatement ps = con.prepareStatement("update MSTACCTCONST set GL_ACNO=0 where CODE=192 and GL_ACNO=5");
					csv = ps.executeUpdate();
				}
				if(file_format.equalsIgnoreCase("txt")){
					con = ConnectionUrl.getMEPLH21ERP();
					PreparedStatement ps = con.prepareStatement("update MSTACCTCONST set GL_ACNO=5 where CODE=192 and GL_ACNO=0");
					csv = ps.executeUpdate();	 
				}
			}
			if (company.equalsIgnoreCase("102")) {
				if(file_format.equalsIgnoreCase("csv")){
					con = ConnectionUrl.getMEPLH25ERP();
					PreparedStatement ps = con.prepareStatement("update MSTACCTCONST set GL_ACNO=0 where CODE=192 and GL_ACNO=5");
					csv = ps.executeUpdate(); 
				}
				if(file_format.equalsIgnoreCase("txt")){
					con = ConnectionUrl.getMEPLH25ERP();
					PreparedStatement ps = con.prepareStatement("update MSTACCTCONST set GL_ACNO=5 where CODE=192 and GL_ACNO=0");
					csv = ps.executeUpdate();	
				} 
			}
			 
			if(csv>0){
				String success="Success";
				response.sendRedirect("MachineShop_Home.jsp?successasm="+success);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}