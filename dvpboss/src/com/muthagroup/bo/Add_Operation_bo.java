package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Add_Operation_dao;
import com.muthagroup.vo.Add_Operation_vo;

public class Add_Operation_bo {

	int oprel_id=0;
	boolean flag=false;
	public int addOperation(HttpServletRequest request, Add_Operation_vo vo) 
	{
		Add_Operation_dao dao=new Add_Operation_dao();
		oprel_id=dao.addOperation(request,vo);
		
		return oprel_id;
	}
	public boolean addOperation_Image(int uid, Add_Operation_vo vo,
			int op_rel_id) {
		Add_Operation_dao dao =new Add_Operation_dao();
		flag = dao.insert_image(uid,vo,op_rel_id);
		return flag;
	}

}
