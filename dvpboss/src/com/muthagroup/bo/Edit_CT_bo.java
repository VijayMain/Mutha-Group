package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Edit_CT_dao;
import com.muthagroup.vo.Edit_CT_vo;

public class Edit_CT_bo {

	boolean flag=false;
	public boolean editCT(Edit_CT_vo vo, HttpServletRequest request) {
		
		Edit_CT_dao dao=new Edit_CT_dao();
		
		flag=dao.editCT(vo,request);
		
		
		return flag;
	}

}
