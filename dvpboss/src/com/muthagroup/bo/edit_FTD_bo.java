package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.dao.add_FTD_dao;
import com.muthagroup.dao.edit_FTD_dao;
import com.muthagroup.vo.edit_FTD_vo;

public class edit_FTD_bo {

	public void editFTD(HttpServletRequest request, HttpServletResponse response, edit_FTD_vo vo) {
		
		edit_FTD_dao dao=new edit_FTD_dao();
		
		dao.editFTD(request,response,vo);
		
	}

	
	
}
