package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Add_Others_dao;
import com.muthagroup.vo.Add_Others_vo;

public class Add_Others_bo 
{
	boolean flag=false;
	public boolean addOthers(Add_Others_vo vo, HttpServletRequest request) 
	{
		Add_Others_dao dao=new Add_Others_dao();
		
		flag=dao.addOthers(vo,request);
		
		return flag;
	}

}
