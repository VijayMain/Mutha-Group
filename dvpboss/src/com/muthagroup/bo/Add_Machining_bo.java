package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Add_Machining_dao;
import com.muthagroup.vo.Add_Machining_vo;

public class Add_Machining_bo {

	boolean flag=false;
	public boolean addMachining(Add_Machining_vo vo, HttpServletRequest request) 
	{
		Add_Machining_dao dao=new Add_Machining_dao();
		
		flag=dao.addMachiningData(vo,request);
		
		return flag;
	}

}
