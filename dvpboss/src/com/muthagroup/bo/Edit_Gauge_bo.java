package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Edit_Gauge_dao;
import com.muthagroup.vo.Edit_Gauge_vo;

public class Edit_Gauge_bo {

	boolean flag=false;
	public boolean updateGauge(Edit_Gauge_vo vo, HttpServletRequest request) 
	{
		Edit_Gauge_dao dao=new Edit_Gauge_dao();
		
		flag=dao.updateGauge(vo,request);
		
		return flag;
	}

}
