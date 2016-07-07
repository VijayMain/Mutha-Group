package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Edit_IMM_dao;
import com.muthagroup.vo.Edit_IMM_vo;

public class Edit_IMM_bo {

	boolean flag=false;
	
	public boolean updateIMM(Edit_IMM_vo vo, HttpServletRequest request) 
	{
		Edit_IMM_dao dao=new Edit_IMM_dao();

		flag=dao.updateIMM(vo,request);
		
		return flag;
	}

}
