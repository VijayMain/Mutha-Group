package com.muthagroup.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.bo.Add_IMM_bo;
import com.muthagroup.vo.Add_IMM_vo;


public class Add_IMM_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		int basic_id=0;
		String mat_type=null;
		String move_disc=null; 
		boolean flag=false;
		
		try
		{
			
			basic_id=Integer.parseInt(request.getParameter("basic_id"));
			
			mat_type=request.getParameter("material_type");
			move_disc=request.getParameter("move_disc");
			
//		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//		java.util.Date convertedDate = null;
		 
		
		
		Add_IMM_vo vo=new Add_IMM_vo();
		
		vo.setBasic_id(basic_id);
		vo.setMat_type(mat_type); 
		vo.setMove_disc(move_disc);
		
		
		Add_IMM_bo bo=new Add_IMM_bo();
		
		flag=bo.addIMM(vo,request);
		
		if(flag==true)
		{
			response.sendRedirect("Activity_Sheet.jsp?hid="+basic_id);
		}
		else
		{
			System.out.println("Error occured....");
		}
		
		
		}catch(Exception e)
		{
			e.printStackTrace();
			
		}
	
	
	}

}
