package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Add_CT_dao;
import com.muthagroup.vo.Add_CT_vo;

public class Add_CT_bo 
{
	boolean flag=false;

	public boolean addCT(Add_CT_vo vo, HttpServletRequest request) 
	{
		Add_CT_dao dao=new Add_CT_dao();
		
		flag=dao.addCT(vo,request);
		
		return flag;
	}

}
