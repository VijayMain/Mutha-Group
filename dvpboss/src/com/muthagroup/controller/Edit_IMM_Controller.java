package com.muthagroup.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.bo.Edit_IMM_bo;
import com.muthagroup.vo.Edit_IMM_vo;


public class Edit_IMM_Controller extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		int basic_id=0;
		String mat_type=null;
		String move_disc=null; 
		boolean flag=false;
		int IMM_Id=0;
		try
		{
			if(request.getParameter("basic_id")!=null)
			{
				basic_id=Integer.parseInt(request.getParameter("basic_id"));
			}
			if(request.getParameter("IMM_Id")!=null)
			{
				IMM_Id=Integer.parseInt(request.getParameter("IMM_Id"));
			}
			
			mat_type=request.getParameter("material_type");
			move_disc=request.getParameter("move_disc");
			
			Edit_IMM_vo vo=new Edit_IMM_vo();			
			
			vo.setBasic_id(basic_id);
			vo.setMat_type(mat_type);
			vo.setMove_disc(move_disc);
			vo.setIMM_Id(IMM_Id);
			
			Edit_IMM_bo bo=new Edit_IMM_bo();
			
			flag=bo.updateIMM(vo,request);
			
			if(flag==true)
			{
				response.sendRedirect("Activity_Sheet.jsp?hid="+basic_id);
			}
			else
			{
				System.out.println("Error Occured....");
			}
		
		
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
