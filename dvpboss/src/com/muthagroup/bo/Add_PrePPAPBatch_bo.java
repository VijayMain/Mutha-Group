package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;
import com.muthagroup.dao.Add_PrePPAPBatch_dao;
import com.muthagroup.vo.Add_PPAPTrials_vo;

public class Add_PrePPAPBatch_bo {

	public Boolean addBatch(Add_PPAPTrials_vo vo, HttpServletRequest request) {
		boolean flag = false;

		Add_PrePPAPBatch_dao dao = new Add_PrePPAPBatch_dao();

		flag = dao.addBatch(vo, request);

		return flag;
	}

}
