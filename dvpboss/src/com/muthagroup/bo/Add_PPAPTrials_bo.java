package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Add_PPAPTrials_dao;
import com.muthagroup.vo.Add_PPAPTrials_vo;

public class Add_PPAPTrials_bo {
	boolean flag=false;
	public boolean addPPAPBatch(Add_PPAPTrials_vo vo, HttpServletRequest request) {
		
		Add_PPAPTrials_dao dao=new Add_PPAPTrials_dao();
		
		flag=dao.addPrePPAP(vo,request);
		
		return flag;
	}

}
