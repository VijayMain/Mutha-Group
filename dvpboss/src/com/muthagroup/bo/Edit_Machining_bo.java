package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Edit_Machining_dao;
import com.muthagroup.vo.Edit_Machining_vo;

public class Edit_Machining_bo {

	boolean flag=false;
	
	public boolean editMachining(Edit_Machining_vo vo,
			HttpServletRequest request) 
	{
		Edit_Machining_dao dao=new Edit_Machining_dao();
		
		flag=dao.editMachining(vo,request);
		
		
		return flag;
	}

}
