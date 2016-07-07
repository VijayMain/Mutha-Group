package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Edit_Fixture_dao;
import com.muthagroup.vo.Edit_Fixture_vo;

public class Edit_Fixture_bo {
	
	boolean flag=false;
	
	public boolean addFixture(Edit_Fixture_vo vo, HttpServletRequest request) 
	{
	
		Edit_Fixture_dao dao=new Edit_Fixture_dao();
		
		flag=dao.editFixture(vo,request);
		
		return flag;
	}

}
