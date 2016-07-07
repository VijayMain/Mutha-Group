package com.muthagroup.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;

public class Add_HeadlinesController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			try {
				String heading = request.getParameter("headline");
				HttpSession session = request.getSession();
				int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
				Connection con = Connection_Utility.getConnection();
				PreparedStatement ps_head = con.prepareStatement("insert into homepage_headlines_tbl(headlines,created_date,created_by,enable_id)values(?,?,?,?)");
				ps_head.setString(1, heading);
				ps_head.setDate(2, curr_Date);
				ps_head.setInt(3, uid);
				ps_head.setInt(4, 1);
				int up = ps_head.executeUpdate();
				
				if(up>0){
					response.sendRedirect("Add_Headlines.jsp");
				}
				
			} catch (Exception e) {
				e.printStackTrace();	
			}
	}
}
