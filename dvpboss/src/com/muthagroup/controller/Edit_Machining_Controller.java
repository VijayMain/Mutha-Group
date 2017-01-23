package com.muthagroup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.bo.Edit_Machining_bo;
import com.muthagroup.vo.Edit_Machining_vo;


public class Edit_Machining_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String machine_name=null;
		String new_machine_name=null;
		double ct_sec=0;
		int mc_used=0;
		int basic_id=0;
		double prod_per_shift=0;
		double mc_reqd=0;
		double mc_allocated=0;
		int opnno_opn_rel_id=0;
		int mcode=0;
		
		boolean flag=false;
		
		
		machine_name=request.getParameter("machine_name");
		
		new_machine_name=request.getParameter("new_machine_name");
		
		if(request.getParameter("mc_availability")!=null)
		{
			mc_allocated=Double.parseDouble(request.getParameter("mc_availability"));
		}
		
		if(request.getParameter("ct_sec")!=null)
		{
			ct_sec=Double.parseDouble(request.getParameter("ct_sec"));
		}
		if(request.getParameter("mcs_used")!=null)
		{
			mc_used=Integer.parseInt(request.getParameter("mcs_used"));
		}
		if(request.getParameter("machine_code")!=null)
		{
			mcode=Integer.parseInt(request.getParameter("machine_code"));
		}
		if(request.getParameter("prod_per_shift")!=null)
		{
			prod_per_shift=Double.parseDouble(request.getParameter("prod_per_shift"));
		}
		if(request.getParameter("mc_reqd")!=null)
		{
			mc_reqd=Double.parseDouble(request.getParameter("mc_reqd"));
		}
		if(request.getParameter("basic_id")!=null)
		{
			basic_id=Integer.parseInt(request.getParameter("basic_id"));
		}
		if(request.getParameter("OpnNo_Opn_Rel_Id")!=null)
		{
			opnno_opn_rel_id=Integer.parseInt(request.getParameter("OpnNo_Opn_Rel_Id"));
		}
		
		Edit_Machining_vo vo=new Edit_Machining_vo();
		
		vo.setMcode(mcode);
		vo.setNew_machine_name(new_machine_name);
		vo.setBasic_id(basic_id);
		vo.setCt_sec(ct_sec);
		vo.setMachine_name(machine_name);
		vo.setMc_allocated(mc_allocated);
		vo.setMc_reqd(mc_reqd);
		vo.setMc_used(mc_used);
		vo.setOpnno_opn_rel_id(opnno_opn_rel_id);
		vo.setProd_per_shift(prod_per_shift);
		
		Edit_Machining_bo bo=new Edit_Machining_bo();
		
		flag=bo.editMachining(vo,request);
		
		if(flag==true)
		{
			response.sendRedirect("Activity_Sheet.jsp?hid="+basic_id);
		}
		else
		{
			System.out.println("Error occured....");
		}
	
	}

}
