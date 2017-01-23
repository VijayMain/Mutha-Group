package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Edit_NewSheet_dao;

import com.muthagroup.vo.Edit_NewSheet_vo;

public class Edit_NewSheet_bo {
	int basic_id=0;
	public int updateNewSheet(HttpServletRequest request, Edit_NewSheet_vo bean) {
		Edit_NewSheet_dao dao=new Edit_NewSheet_dao();
		System.out.println("Sheet No  BO==== " + bean.getSheet_no());
		basic_id=dao.updateNewSheet(request,bean);
		
		return basic_id;
		
	}

}
