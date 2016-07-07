package com.muthagroup.dao;
import java.sql.Connection;
import java.sql.PreparedStatement; 
import java.util.ArrayList;
import javax.servlet.http.HttpServletResponse; 
import com.muthagroup.conn_Url.Connection_Util;

public class ConfigureCompanywise_Dao {

	public void setConfiguration(String comp, ArrayList accesslist,
			HttpServletResponse response) {
		try {
			Connection con_Local=null;
			con_Local = Connection_Util.getLocalDatabase();
			int up=0;
			PreparedStatement ps_del = con_Local.prepareStatement("delete from company_report_rel_tbl where company_id="+Integer.parseInt(comp));
			int delRp = ps_del.executeUpdate();
			for(int i=0;i<accesslist.size();i++){
			PreparedStatement ps_up = con_Local.prepareStatement("insert into company_report_rel_tbl(company_id,reports_id)values(?,?)");
			ps_up.setInt(1, Integer.parseInt(comp));
			ps_up.setInt(2, Integer.parseInt(accesslist.get(i).toString()));
			up = ps_up.executeUpdate();
			}	
			if(up>0){
				String success = "Data inserted successfully....";
				response.sendRedirect("CompanyWise_Reports.jsp?success="+success); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
}