package com.muthagroup.bo;

import javax.servlet.http.HttpSession;

import com.muthagroup.dao.Edit_Action_Dao;
import com.muthagroup.vo.Edit_Action_vo;

public class Edit_Action_BO {

	boolean flag=false;
	public boolean update_Action(Edit_Action_vo edit_a_vo, HttpSession session) {
		Edit_Action_Dao edit_a_dao = new Edit_Action_Dao();
		
		flag=edit_a_dao.update_Actio_Dao(edit_a_vo, session);
		
		return flag;
	}

}
