package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.vo.Add_Fixture_vo;
import com.muthagroup.dao.Add_Fixture_dao;

public class Add_Fixture_bo 
{
	boolean flag=false;
	public boolean addFixture(Add_Fixture_vo vo, HttpServletRequest request) 
	{
		Add_Fixture_dao dao=new Add_Fixture_dao();
		
		flag=dao.addFixture(vo,request);
		
		
		return flag;
	}

}
