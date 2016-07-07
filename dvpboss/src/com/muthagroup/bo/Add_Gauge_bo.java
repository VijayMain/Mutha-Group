package com.muthagroup.bo;

import javax.servlet.http.HttpServletRequest;

import com.muthagroup.dao.Add_Gauge_dao;
import com.muthagroup.vo.Add_Gauge_vo;

public class Add_Gauge_bo 
{
	boolean flag=false;
	public boolean addGauge(Add_Gauge_vo vo, HttpServletRequest request) 
	{

		Add_Gauge_dao dao=new Add_Gauge_dao();
		
		flag=dao.addGauge(vo,request);

		return flag;
	}

}
