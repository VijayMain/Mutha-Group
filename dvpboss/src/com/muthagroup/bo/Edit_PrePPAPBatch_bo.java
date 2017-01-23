package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Edit_PrePPAPBatch_dao;
import com.muthagroup.vo.Add_PPAPTrials_vo;

public class Edit_PrePPAPBatch_bo {

	public Boolean editBatch(Add_PPAPTrials_vo vo, HttpServletRequest request) {

		boolean flag=false;
		Edit_PrePPAPBatch_dao dao=new Edit_PrePPAPBatch_dao();
		flag=dao.editPreppapBatch(vo,request);
		return flag;
	}

}
