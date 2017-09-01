package com.muthagroup.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.muthagroup.vo.ERPItem_MasterVO;

@WebServlet("/Master_ItemCreate")
public class Master_ItemCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			ERPItem_MasterVO vo = new ERPItem_MasterVO();
			String	itemName	= request.getParameter("itemName");
			vo.setNAME(itemName);
			String	invName	= request.getParameter("invName");
			vo.setINV_NAME(invName);
			String	SubGrade	= request.getParameter("SubGrade");
			vo.setCAST_GRADE(SubGrade);
			String	drpUnitCode2	= request.getParameter("drpUnitCode2");
			vo.setPURCHASE_UNIT(drpUnitCode2);
			String	txtSubGradeDesc	= request.getParameter("txtSubGradeDesc");
			vo.setSUB_GRADE_SPEC(txtSubGradeDesc);
			String	drpItemType	= request.getParameter("drpItemType");
			
			String	txtRefPartCode	= request.getParameter("txtRefPartCode");
			String	txtRevNo2	= request.getParameter("txtRevNo2");
			String	txtRevDate2	= request.getParameter("txtRevDate2");
			String	txtDrgLocation	= request.getParameter("txtDrgLocation");
			String	drpTestCode	= request.getParameter("drpTestCode");
			String	txtSpecNo	= request.getParameter("txtSpecNo");
			String	txtSpecRevNo	= request.getParameter("txtSpecRevNo");
			String	txtSpecRevDate2	= request.getParameter("txtSpecRevDate2");
			String	txtCastingWt	= request.getParameter("txtCastingWt");
			String	txtFinishWt	= request.getParameter("txtFinishWt");
			String	txtRate	= request.getParameter("txtRate");
			String	rdoDespType	= request.getParameter("rdoDespType"); 
			String	drpSaleAs	= request.getParameter("drpSaleAs");
			String	drpChapter	= request.getParameter("drpChapter");
			String	drpScrap	= request.getParameter("drpScrap");
			String	drpPurhGlAcNo	= request.getParameter("drpPurhGlAcNo");
			String	drpPurhRetAcNo	= request.getParameter("drpPurhRetAcNo");
			String	drpSaleGlAcno	= request.getParameter("drpSaleGlAcno");
			String	drpSaleRetAcno	= request.getParameter("drpSaleRetAcno");
			String	drpAcctGroup	= request.getParameter("drpAcctGroup");
			String	drpLocCode	= request.getParameter("drpLocCode");
			String	drpDbk	= request.getParameter("drpDbk");
			String	drpGoodsCat	= request.getParameter("drpGoodsCat");
			String	txtBHNSpec	= request.getParameter("txtBHNSpec");
			String	txtOldCode	= request.getParameter("txtOldCode");
			String	chkWTinputSale2	= request.getParameter("chkWTinputSale2");
			String	txtAddSpec	= request.getParameter("txtAddSpec");

			


		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}