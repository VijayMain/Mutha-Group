package it.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.DMS_VO;

import javax.servlet.http.HttpSession;

public class DMS_DAO {
	private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());
	public Object attach_Filebase(DMS_VO bean, HttpSession session) {

		return null;
	}

	public int upload_newFolder(HttpSession session, DMS_VO bean) {
		int cnt_code = 0;
		try {
			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			
			PreparedStatement ps = con.prepareStatement("insert into mst_dmsfolder"
					+ "(FOLDER,SUBJECT,SHARE_FLAG,NOTE,STATUS,USER,TRAN_DATE,SYS_DATE)values(?,?,?,?,?,?,?,?)");
			ps.setString(1, bean.getFolder());
			ps.setString(2, bean.getSubject());
			ps.setInt(3, Integer.parseInt(bean.getShare_others()));
			ps.setString(4, bean.getNote());
			ps.setInt(5, 1);
			ps.setInt(6, uid);
			ps.setDate(7, curr_Date);
			ps.setDate(8, curr_Date);
			
			cnt_code = ps.executeUpdate();
			
			ps = con.prepareStatement("select max(CODE) as code from mst_dmsfolder");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				cnt_code = rs.getInt(rs.getInt("code"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt_code;
	}
}