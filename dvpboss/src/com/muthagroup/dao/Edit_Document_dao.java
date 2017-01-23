package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Add_PPAPTrials_vo;

public class Edit_Document_dao {
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	public void addDoc(HttpSession session, Add_PPAPTrials_vo vo,
			HttpServletResponse response) {

		try {
			
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			int doc=0,docHist=0;
			Connection con=Connection_Utility.getConnection();
			PreparedStatement ps_doc=con.prepareStatement("update dev_document_tbl set apqp_doc=?,process_sheet=?,final_ppap=?,created_by=?,created_date=? where basic_id="+vo.getBasic_id()+" and document_id="+vo.getDocId());
			ps_doc.setString(1,vo.getApqp() );
			ps_doc.setString(2, vo.getPr_sheet());
			ps_doc.setString(3, vo.getFinal_ppap());
		//	ps_doc.setInt(4, vo.getBasic_id());
			ps_doc.setInt(4, uid);
			ps_doc.setDate(5, Date); 
			doc = ps_doc.executeUpdate();
			ps_doc.close();
			
			if(doc>0){
				
				PreparedStatement ps_docHist=con.prepareStatement("insert into dev_document_tbl_hist(apqp_doc,process_sheet,final_ppap,basic_id,created_by,created_date,document_id,created_date_hist)values(?,?,?,?,?,?,?,?)");
				ps_docHist.setString(1,vo.getApqp() );
				ps_docHist.setString(2, vo.getPr_sheet());
				ps_docHist.setString(3, vo.getFinal_ppap());
				ps_docHist.setInt(4, vo.getBasic_id());
				ps_docHist.setInt(5, uid);
				ps_docHist.setDate(6, Date);
				ps_docHist.setInt(7, vo.getDocId());
				ps_docHist.setDate(8, Date);
				docHist = ps_docHist.executeUpdate(); 
			}
			if(doc>0 && docHist>0){
				response.sendRedirect("Add_Trials.jsp?hid=" + vo.getBasic_id());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
