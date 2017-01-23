package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Edit_Others_dao;
import com.muthagroup.vo.Edit_Others_vo;

public class Edit_Others_bo {
    boolean flag=false;
	public boolean updateOthers(Edit_Others_vo vo, HttpServletRequest request) 
	{
		Edit_Others_dao dao=new Edit_Others_dao();
		
		flag=dao.updateOthers(vo,request);
		
		return flag;
	}

}
