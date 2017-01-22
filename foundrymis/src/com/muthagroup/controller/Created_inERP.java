package com.muthagroup.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.connectionUtil.ConnectionUrl;
 
@WebServlet("/Created_inERP")
public class Created_inERP extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String hid_code = request.getParameter("hid_code");
			Connection con = ConnectionUrl.getLocalDatabase();
			PreparedStatement ps = con.prepareStatement("update new_item_creation set created_inERP=1 where code=" + Integer.parseInt(hid_code));
			int up = ps.executeUpdate();
			
			if(up>0){
				response.sendRedirect("Supplier_Summary.jsp?createdflag=Success&hid_code="+hid_code);
			}else{
				response.sendRedirect("Supplier_Summary.jsp?createdflag=Error found&hid_code="+hid_code);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	} 
}
