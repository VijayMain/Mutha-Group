package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Edit_PPAPTrials_dao;
import com.muthagroup.vo.Add_PPAPTrials_vo;
import com.muthagroup.vo.Edit_PPAPTrials_vo;

public class Edit_PPAPTrials_bo {

	boolean flag=false;
	public boolean addPrePPAP(Add_PPAPTrials_vo vo, HttpServletRequest request) {
		
		
		Edit_PPAPTrials_dao dao=new Edit_PPAPTrials_dao();
		
		flag=dao.updatePPAP(vo,request);
		
		
		return flag;
	}

}
