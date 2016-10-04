package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Edit_By_Search_VO;

@SuppressWarnings("unused")
public class Edit_By_Search_DAO {
	int n = 0;
	// String c_arr[]=new String[n];

	@SuppressWarnings("rawtypes")
	ArrayList al = new ArrayList();

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void editBySearch(Edit_By_Search_VO bean,
			HttpServletRequest request, ServletContext sc,
			HttpServletResponse response) {
		try {

			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;

			PreparedStatement ps1 = null;
			ResultSet rs1 = null;

			ArrayList list = new ArrayList();
			// list.add("Vijay");
			// list.add("Anand");
			// list.add("Amit");
			// System.out.println(list);

			int status_id = 0;
			int company_id = 0;
			int severity = 0;
			int cust_id = 0;
			int p_id = 0;

			String complaint_no = null, received = null, discription = null, related = null, assigned = null, cdate = null;
			Timestamp date1=null,date2=null;
			
			date1 = bean.getDate1();
			date2 = bean.getDate2();

			company_id = bean.getCompany_id();
			cust_id = bean.getCust_id();
			severity = bean.getP_id();
			status_id = bean.getStatus_id();

			String cust = null;
			/*System.out.println(cust_id);
			System.out.println(date1);
			System.out.println(date2);
			// System.out.println(unit);
			System.out.println(status_id);*/

			con = Connection_Utility.getConnection();

			if (bean.getComplaint_no() == "") {

				if (cust_id != 0) {

					ps1 = con.prepareStatement("select Cust_Name from Customer_Tbl where Cust_Id=" + cust_id);

					rs1 = ps1.executeQuery();
					String cust_name = null;
					while (rs1.next()) {
						cust_name = rs1.getString("Cust_Name");
					}
					cust = cust_name.substring(0, 3);
				}
				// *****************************************************************************

				// Search when all contents are available

				// *****************************************************************************

				if (date1 != null && date2 != null && status_id != 0
						&& cust_id != 0 && company_id != 0 && severity != 0)

				{

					ps = con.prepareStatement("select * from complaint_tbl where complaint_date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and status_id="
							+ status_id
							+ " and company_id="
							+ company_id
							+ " and P_Id=" + severity);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// search when two Dates and company_id are available

				// *****************************************************************************

				else if (date1 != null && date2 != null && status_id == 0
						&& cust_id == 0 && company_id != 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where complaint_date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and Company_Id="
							+ company_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when only two dates are available

				// *****************************************************************************

				else if (date1 != null && date2 != null && status_id == 0
						&& cust_id == 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where complaint_date between '"
							+ date1 + "' and '" + date2 + "'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when two dates and status_idject id are available

				// *****************************************************************************

				else if (date1 != null && date2 != null && status_id != 0
						&& cust_id == 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where complaint_date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and status_id="
							+ status_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when only company_id is available

				// *****************************************************************************

				else if (date1 == null && date2 == null && company_id != 0
						&& status_id == 0 && cust_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where company_id="
							+ company_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when only status_idject id is available

				// ******************************************************************1***********

				else if (date1 == null && date2 == null && status_id != 0
						&& cust_id == 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where status_id="
							+ status_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when only company_id and status_idject_id are
				// available

				// *****************************************************************************

				else if (date1 == null && date2 == null && status_id != 0
						&& cust_id == 0 && company_id != 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where company_id="
							+ company_id + " and status_Id=" + status_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when only date2 is available

				// *****************************************************************************

				else if (date1 == null && date2 != null && status_id == 0
						&& cust_id == 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date='"
							+ date2 + "'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when only date1 is available

				// *****************************************************************************

				else if (date1 != null && date2 == null && status_id == 0
						&& cust_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date='"
							+ date1 + "'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when only customer name is available

				// *****************************************************************************

				else if (date1 == null && date2 == null && status_id == 0
						&& cust_id != 0 && company_id == 0 && severity == 0) {

					ps = con.prepareStatement("select * from complaint_tbl where Complaint_No like '"
							+ cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and two dates are available

				// *****************************************************************************

				else if (date1 != null && date2 != null && status_id == 0
						&& cust_id != 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and Complaint_No like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and two dates and status_idject_Id
				// are
				// available

				// *****************************************************************************

				else if (date1 != null && date2 != null && status_id != 0
						&& cust_id != 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and status_Id="
							+ status_id
							+ " and Complaint_No like '"
							+ cust
							+ "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and two dates and company_id are
				// available

				// *****************************************************************************

				else if (date1 != null && date2 != null && company_id != 0
						&& status_id == 0 && cust_id != 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and Company_Id="
							+ company_id
							+ " and Complaint_No like '"
							+ cust
							+ "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and two dates and
				// status_idject_id are available

				// *****************************************************************************

				else if (date1 != null && date2 != null && status_id != 0
						&& cust_id != 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and status_Id="
							+ status_id
							+ " and Complaint_No like '"
							+ cust
							+ "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and date1 are available

				// *****************************************************************************

				else if (date1 != null && date2 == null && status_id == 0
						&& cust_id != 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date ='"
							+ date1 + "' and Complaint_No like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and date2 are available

				// *****************************************************************************

				else if (date1 == null && date2 != null && status_id == 0
						&& cust_id != 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date ='"
							+ date2 + "' and Complaint_No like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and company_id are available

				// *****************************************************************************

				else if (date1 == null && date2 == null && company_id != 0
						&& status_id == 0 && cust_id != 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Company_Id ="
							+ company_id
							+ " and Complaint_No like '"
							+ cust
							+ "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and status_idject are available

				// *****************************************************************************

				else if (date1 == null && date2 == null && status_id != 0
						&& cust_id != 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where status_Id ="
							+ status_id
							+ " and Complaint_No like '"
							+ cust
							+ "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and status_idject id and company_id
				// are
				// available

				// *****************************************************************************

				else if (date1 == null && date2 == null && company_id != 0
						&& status_id != 0 && cust_id != 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where status_Id ="
							+ status_id
							+ " and Company_Id="
							+ company_id
							+ " and Complaint_No like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and status_idject and date1 are
				// available

				// *****************************************************************************

				else if (date1 != null && date2 == null && status_id != 0
						&& cust_id != 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where status_Id ="
							+ status_id
							+ " and Complaint_Date='"
							+ date1
							+ "' and Complaint_No like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and status_idject and date2 are
				// available

				// *****************************************************************************

				else if (date1 == null && date2 != null && status_id != 0
						&& cust_id != 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where status_Id ="
							+ status_id
							+ " and Complaint_Date='"
							+ date2
							+ "' and Complaint_No like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and company_id and date1 are
				// available

				// *****************************************************************************

				else if (date1 != null && date2 == null && company_id != 0
						&& status_id == 0 && cust_id != 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Company_Id ="
							+ company_id
							+ " and Complaint_Date='"
							+ date1
							+ "' and Complaint_No like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when status_idject and date2 are available

				// *****************************************************************************

				else if (date1 == null && date2 != null && status_id != 0
						&& cust_id == 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date='"
							+ date2 + "' and status_Id=" + status_id);
					rs = ps.executeQuery();
				}
				// *****************************************************************************

				// Search when status_idject and date1 are available

				// *****************************************************************************

				else if (date1 != null && date2 == null && status_id != 0
						&& cust_id == 0 && company_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date='"
							+ date1 + "' and status_Id=" + status_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and company_id and date2 are
				// available

				// *****************************************************************************

				else if (date1 == null && date2 != null && company_id != 0
						&& status_id == 0 && cust_id != 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Company_Id ="
							+ company_id
							+ " and Complaint_Date='"
							+ date2
							+ "' and Complaint_No like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and company_id and status_id and
				// date2 are available

				// *****************************************************************************

				else if (date1 == null && date2 != null && company_id != 0
						&& status_id != 0 && cust_id != 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Company_Id ="
							+ company_id
							+ " and Complaint_Date='"
							+ date2
							+ "' and status_Id="
							+ status_id
							+ " and Complaint_No like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when customer name and company_id and status_id and
				// date1 are available

				// *****************************************************************************

				else if (date1 != null && date2 == null && company_id != 0
						&& status_id != 0 && cust_id != 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Company_Id ="
							+ company_id
							+ " and Complaint_Date='"
							+ date1
							+ "' and status_Id="
							+ status_id
							+ " and Complaint_No like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when company_id and status_idject are available

				// *****************************************************************************

				else if (date1 == null && date2 == null && company_id != 0
						&& status_id != 0 && cust_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Company_Id ="
							+ company_id + " and status_Id=" + status_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when company_id and status_idject and date1 are
				// available

				// *****************************************************************************

				else if (date1 != null && date2 == null && company_id != 0
						&& status_id != 0 && cust_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Company_Id ="
							+ company_id
							+ " and status_Id="
							+ status_id
							+ " and Complaint_Date='" + date1 + "'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when company_id and status_idject and date2 are
				// available

				// *****************************************************************************

				else if (date1 == null && date2 != null && company_id != 0
						&& status_id != 0 && cust_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Company_Id ="
							+ company_id
							+ " and status_Id="
							+ status_id
							+ " and Complaint_Date='" + date2 + "'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when company_id and date2 are available

				// *****************************************************************************

				else if (date1 == null && date2 != null && company_id != 0
						&& status_id == 0 && cust_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Company_Id ="
							+ company_id
							+ " and Complaint_Date='"
							+ date2
							+ "'");
					rs = ps.executeQuery();
				}
				// *****************************************************************************

				// Search when company_id and date1 are available

				// *****************************************************************************

				else if (date1 != null && date2 == null && company_id != 0
						&& status_id == 0 && cust_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Company_Id ="
							+ company_id
							+ " and Complaint_Date='"
							+ date1
							+ "'");
					rs = ps.executeQuery();
				}
				// *****************************************************************************

				// Search when company_id and date1 and date2 are available

				// *****************************************************************************

				else if (date1 != null && date2 != null && company_id != 0
						&& status_id == 0 && cust_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and Company_Id="
							+ company_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when company_id and date1 and date2 and status_idject
				// are available

				// *****************************************************************************

				else if (date1 != null && date2 != null && company_id != 0
						&& status_id != 0 && cust_id == 0 && severity == 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and Company_Id="
							+ company_id + " and status_Id=" + status_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when only severity is available

				// *****************************************************************************

				else if (date1 == null && date2 == null && company_id == 0
						&& status_id == 0 && cust_id == 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where p_id="
							+ severity);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when company_id and severity are available

				// *****************************************************************************

				else if (date1 == null && date2 == null && company_id != 0
						&& status_id == 0 && cust_id == 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Company_Id="
							+ company_id + " and P_Id=" + severity);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when status_id and severity are available

				// *****************************************************************************

				else if (date1 == null && date2 == null && company_id != 0
						&& status_id != 0 && cust_id == 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Status_Id="
							+ status_id + " and P_Id=" + severity);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when Cust_id and severity are available

				// *****************************************************************************

				else if (date1 == null && date2 == null && company_id == 0
						&& status_id == 0 && cust_id != 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_no like '"
							+ cust + "%' and P_Id=" + severity);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date1 and severity are available

				// *****************************************************************************

				else if (date1 != null && date2 == null && company_id == 0
						&& status_id == 0 && cust_id == 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date='"
							+ date1 + "' and P_Id=" + severity);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date2 and severity are available

				// *****************************************************************************

				else if (date1 == null && date2 != null && company_id == 0
						&& status_id == 0 && cust_id == 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date='"
							+ date2 + "' and P_Id= " + severity);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date1 and date2 and severity are available

				// *****************************************************************************

				else if (date1 != null && date2 != null && company_id == 0
						&& status_id == 0 && cust_id == 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and P_Id="
							+ severity);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date1 and date2 and cust_id and severity are
				// available

				// *****************************************************************************

				else if (date1 != null && date2 != null && company_id == 0
						&& status_id == 0 && cust_id != 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and P_Id="
							+ severity
							+ " and Complaint_no like '"
							+ cust
							+ "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date1 and date2 and status_id and severity are
				// available

				// *****************************************************************************

				else if (date1 != null && date2 != null && company_id == 0
						&& status_id != 0 && cust_id == 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and P_Id="
							+ severity + " and status_id=" + status_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date1 and date2 and company_id and severity are
				// available

				// *****************************************************************************

				else if (date1 != null && date2 != null && company_id != 0
						&& status_id == 0 && cust_id == 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and P_Id="
							+ severity + " and company_id=" + company_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date1 and date2 and company_id and status_id and
				// severity are available

				// *****************************************************************************

				else if (date1 != null && date2 != null && company_id != 0
						&& status_id != 0 && cust_id == 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and P_Id="
							+ severity
							+ " and company_id="
							+ company_id
							+ " and status_id=" + status_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date1 and date2 and company_id and cust_id and
				// severity are available

				// *****************************************************************************

				else if (date1 != null && date2 != null && company_id != 0
						&& status_id == 0 && cust_id != 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and P_Id="
							+ severity
							+ " and company_id="
							+ company_id
							+ " and Complaint_no like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date1 and date2 and status_id and cust_id and
				// severity are available

				// *****************************************************************************

				else if (date1 != null && date2 != null && company_id == 0
						&& status_id != 0 && cust_id != 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date between '"
							+ date1
							+ "' and '"
							+ date2
							+ "' and P_Id="
							+ severity
							+ " and status_id="
							+ status_id
							+ " and Complaint_no like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date1 and status_id and cust_id and severity are
				// available

				// *****************************************************************************

				else if (date1 != null && date2 == null && company_id == 0
						&& status_id != 0 && cust_id != 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date ='"
							+ date1
							+ "' and P_Id="
							+ severity
							+ " and status_id="
							+ status_id
							+ " and Complaint_no like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date2 and status_id and cust_id and severity are
				// available

				// *****************************************************************************

				else if (date1 == null && date2 != null && company_id == 0
						&& status_id != 0 && cust_id != 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date ='"
							+ date2
							+ "' and P_Id="
							+ severity
							+ " and status_id="
							+ status_id
							+ " and Complaint_no like '" + cust + "%'");
					rs = ps.executeQuery();
				}
				// *****************************************************************************

				// Search when date2 and status_id and cust_id and severity are
				// available

				// *****************************************************************************

				else if (date1 == null && date2 == null && company_id == 0
						&& status_id != 0 && cust_id != 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where P_Id="
							+ severity
							+ " and status_id="
							+ status_id
							+ " and Complaint_no like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when status_id and severity are available

				// *****************************************************************************

				else if (date1 == null && date2 == null && company_id == 0
						&& status_id != 0 && cust_id == 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where P_Id="
							+ severity + " and status_id=" + status_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date2 and status_id and cust_id and severity are
				// available

				// *****************************************************************************

				else if (date1 == null && date2 != null && company_id == 0
						&& status_id != 0 && cust_id != 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date ='"
							+ date2
							+ "' and P_Id="
							+ severity
							+ " and status_id="
							+ status_id
							+ " and Complaint_no like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date2 and cust_id and company_id and severity are
				// available

				// *****************************************************************************

				else if (date1 == null && date2 != null && company_id != 0
						&& status_id == 0 && cust_id != 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date ='"
							+ date2
							+ "' and P_Id="
							+ severity
							+ " and company_id="
							+ company_id
							+ " and Complaint_no like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when status_id and cust_id and company_id and severity
				// are available

				// *****************************************************************************

				else if (date1 == null && date2 == null && company_id != 0
						&& status_id != 0 && cust_id != 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Status_Id ="
							+ status_id
							+ " and P_Id="
							+ severity
							+ " and company_id="
							+ company_id
							+ " and Complaint_no like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date1 and cust_id and company_id and severity are
				// available

				// *****************************************************************************

				else if (date1 != null && date2 == null && company_id != 0
						&& status_id == 0 && cust_id != 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date ='"
							+ date1
							+ "' and P_Id="
							+ severity
							+ " and company_id="
							+ company_id
							+ " and Complaint_no like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date1 and status_id and company_id and severity
				// are available

				// *****************************************************************************

				else if (date1 != null && date2 == null && company_id != 0
						&& status_id == 0 && cust_id != 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date ='"
							+ date1
							+ "' and P_Id="
							+ severity
							+ " and company_id="
							+ company_id
							+ " and Complaint_no like '" + cust + "%'");
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date1 and status_id and company_id and severity
				// are available

				// *****************************************************************************

				else if (date1 != null && date2 == null && company_id != 0
						&& status_id != 0 && cust_id == 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date ='"
							+ date1
							+ "' and P_Id="
							+ severity
							+ " and company_id="
							+ company_id
							+ " and status_id=" + status_id);
					rs = ps.executeQuery();
				}

				// *****************************************************************************

				// Search when date2 and status_id and company_id and severity
				// are available

				// *****************************************************************************

				else if (date1 == null && date2 != null && company_id != 0
						&& status_id != 0 && cust_id == 0 && severity != 0) {
					ps = con.prepareStatement("select * from complaint_tbl where Complaint_Date ='"
							+ date2
							+ "' and P_Id="
							+ severity
							+ " and company_id="
							+ company_id
							+ " and status_id=" + status_id);
					rs = ps.executeQuery();
				}
			}

			else if (bean.getComplaint_no() != null) {
				ps = con.prepareStatement("select * from complaint_tbl where Complaint_no='"
						+ bean.getComplaint_no() + "'");
				rs = ps.executeQuery();
			} else {
				response.sendRedirect("Search_Fail.jsp");
			}

			int item_id = 0;
			int defect_id = 0;
			int category_id = 0;
			int status_id1 = 0;
			int severity1 = 0;

			while (rs.next()) {
				// n=n+1;

				list.add(rs.getString("Complaint_No"));
				// System.out.println(rs.getString("Complaint_No"));

				cust_id = rs.getInt("cust_Id");

				item_id = rs.getInt("Item_Id");

				defect_id = rs.getInt("Defect_Id");

				category_id = rs.getInt("Category_Id");

				status_id1 = rs.getInt("Status_Id");

				company_id = rs.getInt("Company_Id");

				severity1 = rs.getInt("status_Id");

				received = rs.getString("Complaint_Received_By");

				discription = rs.getString("Complaint_Description");

				related = rs.getString("Complaint_Related_To");

				assigned = rs.getString("Complaint_Assigned_To");

				cdate = rs.getString("Complaint_Date");

			}

			// System.out.println(complaint_no);
			/*System.out.println(cust_id);
			System.out.println(item_id);
			System.out.println(defect_id);
			System.out.println(category_id);
			System.out.println(status_id1);
			System.out.println(company_id);
			System.out.println(received);
			System.out.println(severity1);
			System.out.println(discription);
			System.out.println(related);
			System.out.println(assigned);
			System.out.println(cdate);*/

			// bean.setComplaint_no(complaint_no);
			// session.setAttribute("complaint_no",complaint_no);

			// sc.getRequestDispatcher("/search_Result.jsp");
			//
			// request.getSession().setAttribute("Name", list);
			//
			// RequestDispatcher requestDispatcher = sc
			// .getRequestDispatcher("/Search_Result.jsp");
			// requestDispatcher.forward(request, response);
			// request.setAttribute("list", list);
			// response.sendRedirect("Search_Result.jsp");
			// RequestDispatcher
			// requestDispatcher=getServletContext().getRequestDispatcher("/Search_Result.jsp");
			// requestDispatcher.forward(request, response);
			// response.sendRedirect("Search_Result.jsp?al="+al);

			RequestDispatcher rd = request
					.getRequestDispatcher("/Search_Result.jsp");
			request.setAttribute("arry", list);
			rd.forward(request, response);

			// System.out.println("Data Loss !!!!!!");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Data Search Failed !!!!!!");
		}

	}
}
