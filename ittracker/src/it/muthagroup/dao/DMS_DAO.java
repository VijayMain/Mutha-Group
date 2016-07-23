package it.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.DMS_VO;

import javax.servlet.http.HttpSession;

public class DMS_DAO {
	private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());
	public boolean attach_Filebase(DMS_VO bean, HttpSession session) {
		boolean flag = false;
		try {
			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			int up = 0;
			//  System.out.println(" = "+flag);
			PreparedStatement ps = con.prepareStatement("insert into tarn_dms(TRAN_NO,FILE,FILE_NAME,USER,TRAN_DATE,STATUS,NOTE,SYS_DATE)values(?,?,?,?,?,?,?,?)");
			ps.setInt(1, bean.getDmscode());
			ps.setBlob(2, bean.getBlob_file());
			ps.setString(3, bean.getBlob_name());
			ps.setInt(4, uid);
			ps.setDate(5, curr_Date);
			ps.setInt(6, 1);
			ps.setString(7, bean.getNote());
			ps.setDate(8, curr_Date);
			
			
			
			up = ps.executeUpdate();
			
			if(up>0){
				flag=true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public int upload_newFolder(HttpSession session, DMS_VO bean, ArrayList dMSComp_list, ArrayList dMSDept_list) {
		int cnt_code = 0,up=0;
		try {
			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			
			/*
			*
			************************************ Insert Into Main DMS Table ******************************************** 
			*
			*/
			// System.out.println("shres access = " + bean.getShared_access());
			PreparedStatement ps = con.prepareStatement("insert into mst_dmsfolder"
					+ "(FOLDER,SUBJECT,SHARE_FLAG,NOTE,STATUS,USER,TRAN_DATE,SYS_DATE,SHARED_ACCESS)values(?,?,?,?,?,?,?,?,?)");
			ps.setString(1, bean.getFolder());
			ps.setString(2, bean.getSubject());
			ps.setInt(3, Integer.parseInt(bean.getShare_others()));
			ps.setString(4, bean.getNote());
			ps.setInt(5, 1);
			ps.setInt(6, uid);
			ps.setDate(7, curr_Date);
			ps.setDate(8, curr_Date);
			ps.setInt(9, bean.getShared_access());
			
			up = ps.executeUpdate();
			
			/*
			*
			************************************ Get max count from Main DMS Table ******************************************** 
			*
			*/
			
			if(up>0){
			ps = con.prepareStatement("select max(CODE) from mst_dmsfolder");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				cnt_code = rs.getInt("max(CODE)"); 
			}
			
			/*
			*
			************************************ Insert Into tarn_dms Table ******************************************** 
			*
			*/
			
			
			ps = con.prepareStatement("insert into tarn_dms(TRAN_NO,FILE,FILE_NAME,USER,TRAN_DATE,STATUS,NOTE,SYS_DATE)values(?,?,?,?,?,?,?,?)");
			ps.setInt(1, cnt_code);
			ps.setBlob(2, bean.getBlob_file());
			ps.setString(3, bean.getBlob_name());
			ps.setInt(4, uid);
			ps.setDate(5, curr_Date);
			ps.setInt(6, 1);
			ps.setString(7, bean.getNote());
			ps.setDate(8, curr_Date);
			
			up = ps.executeUpdate();
			
			
			/*
			*
			************************************ Insert data into  mst_dept Table ******************************************** 
			*
			*/ 
			
			if(dMSDept_list.contains("0")){ 
			ps = con.prepareStatement("insert into mst_dept(DMS_CODE,DEPT)values(?,?)");
			ps.setInt(1, cnt_code);
			ps.setInt(2, 0);
			up = ps.executeUpdate();
			}else{
				for(int i=0;i<dMSDept_list.size();i++){
					ps = con.prepareStatement("insert into mst_dept(DMS_CODE,DEPT)values(?,?)");
					ps.setInt(1, cnt_code);
					ps.setInt(2, Integer.parseInt(dMSDept_list.get(i).toString()));
					up = ps.executeUpdate();
					}
			}
			
			/*
			*
			************************************ Insert data into  mst_comp Table ******************************************** 
			*
			*/
			
			if(dMSComp_list.contains("0")){
				ps = con.prepareStatement("insert into mst_comp(DMS_CODE,COMPANY)values(?,?)");
				ps.setInt(1, cnt_code);
				ps.setInt(2, 0);
				up = ps.executeUpdate();
			}else{
			for(int i=0;i<dMSComp_list.size();i++){
				ps = con.prepareStatement("insert into mst_comp(DMS_CODE,COMPANY)values(?,?)");
				ps.setInt(1, cnt_code);
				ps.setInt(2, Integer.parseInt(dMSComp_list.get(i).toString()));
				up = ps.executeUpdate();
			}
			}
			}
			
			/**************************************************** Upload Finish *************************************************/
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt_code;
	}
}