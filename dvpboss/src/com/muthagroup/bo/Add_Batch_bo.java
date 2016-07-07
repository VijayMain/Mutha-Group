package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Add_Batch_dao;
import com.muthagroup.vo.Add_Batch_vo;

public class Add_Batch_bo {

	boolean flag=false;
	public boolean addBatch(Add_Batch_vo vo, HttpServletRequest request) {
		
		Add_Batch_dao dao=new Add_Batch_dao();
		
		flag=dao.addBatch(vo,request);

		return flag;
	}

}
