package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.NewSheet_dao;
import com.muthagroup.vo.NewSheet_vo;

public class NewSheet_bo {
	//boolean flag=false;
	int basic_id=0;
	public int addNewSheet(HttpServletRequest request, NewSheet_vo bean) 
	{
		NewSheet_dao dao=new NewSheet_dao();
			
		basic_id=dao.addNewSheet(request,bean);
		
		return basic_id;
	}

}
