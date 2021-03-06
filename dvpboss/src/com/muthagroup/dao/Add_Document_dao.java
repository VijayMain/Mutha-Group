package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Add_PPAPTrials_vo;

public class Add_Document_dao {
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	public void addDoc(HttpSession session, Add_PPAPTrials_vo vo, HttpServletResponse response) {

		try {
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			int doc=0,docHist=0,doc_count=0;
			Connection con=Connection_Utility.getConnection();
			PreparedStatement ps_doc=con.prepareStatement("insert into dev_document_tbl(apqp_doc,process_sheet,final_ppap,basic_id,created_by,created_date)values(?,?,?,?,?,?)");
			ps_doc.setString(1,vo.getApqp() );
			ps_doc.setString(2, vo.getPr_sheet());
			ps_doc.setString(3, vo.getFinal_ppap());
			ps_doc.setInt(4, vo.getBasic_id());
			ps_doc.setInt(5, uid);
			ps_doc.setDate(6, Date); 
			doc = ps_doc.executeUpdate();
			ps_doc.close();
			
			if(doc>0){
				PreparedStatement ps_sel=con.prepareStatement("select max(document_id) from dev_document_tbl");
				ResultSet rs_sel=ps_sel.executeQuery();
				while(rs_sel.next()){
					doc_count = rs_sel.getInt("max(document_id)");
				}
				ps_sel.close();
				rs_sel.close();
				
				PreparedStatement ps_docHist=con.prepareStatement("insert into dev_document_tbl_hist(apqp_doc,process_sheet,final_ppap,basic_id,created_by,created_date,document_id,created_date_hist)values(?,?,?,?,?,?,?,?)");
				ps_docHist.setString(1,vo.getApqp() );
				ps_docHist.setString(2, vo.getPr_sheet());
				ps_docHist.setString(3, vo.getFinal_ppap());
				ps_docHist.setInt(4, vo.getBasic_id());
				ps_docHist.setInt(5, uid);
				ps_docHist.setDate(6, Date);
				ps_docHist.setInt(7, doc_count);
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
