package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Edit_Operation_dao;
import com.muthagroup.vo.Edit_Operation_vo;

public class Edit_Operation_bo {

	boolean flag = false;

	public boolean editOperation(HttpServletRequest request,
			Edit_Operation_vo vo) {
		Edit_Operation_dao dao = new Edit_Operation_dao();
		System.out.println("Vo is called00000000000");
		flag = dao.editOpration(vo, request);
		flag = true;
		return flag;
	}

	public boolean updateImage(Edit_Operation_vo vo, int uid) {
		Edit_Operation_dao dao = new Edit_Operation_dao();
		flag = dao.InsertOpImage(uid,vo);
		return flag;
	}

}
