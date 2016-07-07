package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.dao.add_FTD_dao;
import com.muthagroup.vo.add_FTD_vo;

public class add_FTD_bo {

	public void addFTD(HttpServletRequest request,
			HttpServletResponse response, add_FTD_vo vo) {
	
		add_FTD_dao dao=new add_FTD_dao();
		
		dao.addFTD(request,response,vo);
		
	}

}
