package com.muthagroup.bo;

import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Edit_DAO;

import com.muthagroup.vo.Edit_VO;

public class Edit_BO {

	public String Edit_Update(Edit_VO bean, HttpSession session) {

		Edit_DAO dao = new Edit_DAO();
		String cno = dao.Edit_Update_dao(bean, session);

		return cno;
	}

}
