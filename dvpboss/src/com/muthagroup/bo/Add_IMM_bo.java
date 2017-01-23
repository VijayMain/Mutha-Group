package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Add_IMM_dao;
import com.muthagroup.vo.Add_IMM_vo;

public class Add_IMM_bo 
{
	boolean flag=false;

	public boolean addIMM(Add_IMM_vo vo, HttpServletRequest request) 
	{
		Add_IMM_dao dao=new Add_IMM_dao();
		
		flag=dao.addIMM(vo,request);

		return flag;
	}

}
