package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionUtility.Connection_Utility;
import com.muthagroup.vo.Search_Request_Vo;
//============================================================================-->
//============================ Data Access Model =============================-->
//============================================================================-->
public class Search_Request_DAO {

	boolean flag = false;
	ArrayList ListDisplay = new ArrayList();
	//============================================================================-->
	//======================= Search Request DAO ==================================-->
	
	public boolean searchRequestDAO(Search_Request_Vo bean,
			HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {

		try {

			// **********************************************************************************************************************
			Connection con = Connection_Utility.getConnection();
			int uid = 0;
			uid = Integer.parseInt(session.getAttribute("uid").toString());
			ResultSet rs = null;
			String Approved = null;
			int ap_id = 0;
			int cr_no1 = 0;
			ArrayList cr_list = new ArrayList();
			ArrayList cr_list1 = new ArrayList();
			ArrayList approval_list = new ArrayList();

			PreparedStatement ps_uidappr = con
					.prepareStatement("select * from user_tbl where U_Id="
							+ uid);
			String UName = null;
			ArrayList id1 = new ArrayList();
			ResultSet rs_uidappr = ps_uidappr.executeQuery();
			while (rs_uidappr.next()) {
				UName = rs_uidappr.getString("U_Name");
				PreparedStatement ps_id = con
						.prepareStatement("select * from user_tbl where U_Name='"
								+ UName + "'");
				ResultSet rs_id = ps_id.executeQuery();
				while (rs_id.next()) {
					id1.add(rs_id.getInt("U_Id"));
				}
			}

			// **********************************************************************************************************************
			for (int s = 0; s < id1.size(); s++) {

				if (bean.getEnd_date_sup() != null
						&& bean.getStart_date_sup() != null
						&& bean.getCompany_name_sup() != 0
						&& bean.getCompany_name_item() == 0
						&& bean.getItem_name_item() == 0
						&& bean.getStart_date_item() == null
						&& bean.getEnd_date_item() == null
						&& bean.getApproval_type_app() == 0
						&& bean.getEnd_date_app() == null
						&& bean.getStart_date_app() == null) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where U_Id="
									+ Integer.parseInt(id1.get(s).toString())
									+ " and CR_Date between '"
									+ bean.getStart_date_sup()
									+ "' and '"
									+ bean.getEnd_date_sup()
									+ "' and Company_Id="
									+ bean.getCompany_name_sup());
					rs = ps.executeQuery();
				} else if (bean.getCompany_name_item() != 0
						&& bean.getItem_name_item() != 0
						&& bean.getStart_date_item() != null
						&& bean.getEnd_date_item() != null
						&& bean.getApproval_type_app() == 0
						&& bean.getEnd_date_app() == null
						&& bean.getStart_date_app() == null
						&& bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() == 0) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where Company_Id="
									+ bean.getCompany_name_item()
									+ " and Item_Id="
									+ +bean.getItem_name_item()
									+ " and U_Id="
									+ Integer.parseInt(id1.get(s).toString())
									+ " and CR_Date between '"
									+ bean.getStart_date_item()
									+ "' and '"
									+ bean.getEnd_date_item() + "'");
					rs = ps.executeQuery();
				} else if (bean.getApproval_type_app() != 0
						&& bean.getStart_date_app() != null
						&& bean.getEnd_date_app() != null
						&& bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() == 0
						&& bean.getEnd_date_item() == null
						&& bean.getStart_date_item() == null
						&& bean.getCompany_name_item() == 0
						&& bean.getItem_name_item() == 0) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl_approval where Approval_Id="
									+ bean.getApproval_type_app()
									+ " and U_Id="
									+ Integer.parseInt(id1.get(s).toString())
									+ " and CR_Approval_Date between '"
									+ bean.getStart_date_app()
									+ "' and '"
									+ bean.getEnd_date_app() + "'");
					rs = ps.executeQuery();
				} else if (bean.getApproval_type_app() == 0
						&& bean.getStart_date_app() == null
						&& bean.getEnd_date_app() == null
						&& bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() != 0
						&& bean.getEnd_date_item() == null
						&& bean.getStart_date_item() == null
						&& bean.getCompany_name_item() == 0
						&& bean.getItem_name_item() == 0) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where U_Id="
									+ Integer.parseInt(id1.get(s).toString())
									+ " and Company_Id="
									+ bean.getCompany_name_sup());
					rs = ps.executeQuery();
				} else if (bean.getApproval_type_app() == 0
						&& bean.getStart_date_app() == null
						&& bean.getEnd_date_app() == null
						&& bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() != null
						&& bean.getCompany_name_sup() == 0
						&& bean.getEnd_date_item() == null
						&& bean.getStart_date_item() == null
						&& bean.getCompany_name_item() == 0
						&& bean.getItem_name_item() == 0) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where U_Id="
									+ Integer.parseInt(id1.get(s).toString())
									+ " and CR_Date='"
									+ bean.getStart_date_sup() + "'");
					rs = ps.executeQuery();
				}

				else if (bean.getApproval_type_app() == 0
						&& bean.getStart_date_app() == null
						&& bean.getEnd_date_app() == null
						&& bean.getEnd_date_sup() != null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() == 0
						&& bean.getEnd_date_item() == null
						&& bean.getStart_date_item() == null
						&& bean.getCompany_name_item() == 0
						&& bean.getItem_name_item() == 0) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where U_Id="
									+ Integer.parseInt(id1.get(s).toString())
									+ " and CR_Date='"
									+ bean.getEnd_date_sup()
									+ "'");
					rs = ps.executeQuery();
				}

				else if (bean.getApproval_type_app() == 0
						&& bean.getStart_date_app() == null
						&& bean.getEnd_date_app() == null
						&& bean.getEnd_date_sup() != null
						&& bean.getStart_date_sup() != null
						&& bean.getCompany_name_sup() == 0
						&& bean.getEnd_date_item() == null
						&& bean.getStart_date_item() == null
						&& bean.getCompany_name_item() == 0
						&& bean.getItem_name_item() == 0) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where U_Id="
									+ Integer.parseInt(id1.get(s).toString())
									+ " and CR_Date between '"
									+ bean.getStart_date_sup()
									+ "' and '"
									+ bean.getEnd_date_sup() + "'");
					rs = ps.executeQuery();
				} else if (bean.getApproval_type_app() == 0
						&& bean.getStart_date_app() == null
						&& bean.getEnd_date_app() == null
						&& bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() == 0
						&& bean.getEnd_date_item() == null
						&& bean.getStart_date_item() == null
						&& bean.getCompany_name_item() != 0
						&& bean.getItem_name_item() == 0) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where Company_Id="
									+ bean.getCompany_name_item()
									+ " and U_Id="
									+ Integer.parseInt(id1.get(s).toString()));
					rs = ps.executeQuery();
				} else if (bean.getCompany_name_item() != 0
						&& bean.getItem_name_item() != 0
						&& bean.getStart_date_item() == null
						&& bean.getEnd_date_item() == null
						&& bean.getApproval_type_app() == 0
						&& bean.getEnd_date_app() == null
						&& bean.getStart_date_app() == null
						&& bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() == 0) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where Company_Id="
									+ bean.getCompany_name_item()
									+ " and Item_Id="
									+ bean.getItem_name_item()
									+ " and U_Id="
									+ Integer.parseInt(id1.get(s).toString()));
					rs = ps.executeQuery();
				} else if (bean.getCompany_name_item() != 0
						&& bean.getItem_name_item() != 0
						&& bean.getStart_date_item() != null
						&& bean.getEnd_date_item() == null
						&& bean.getApproval_type_app() == 0
						&& bean.getEnd_date_app() == null
						&& bean.getStart_date_app() == null
						&& bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() == 0) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where Company_Id="
									+ bean.getCompany_name_item()
									+ " and Item_Id="
									+ bean.getItem_name_item()
									+ " and CR_Date='"
									+ bean.getStart_date_item()
									+ "' and U_Id="
									+ Integer.parseInt(id1.get(s).toString()));
					rs = ps.executeQuery();
				} else if (bean.getCompany_name_item() != 0
						&& bean.getItem_name_item() != 0
						&& bean.getStart_date_item() == null
						&& bean.getEnd_date_item() != null
						&& bean.getApproval_type_app() == 0
						&& bean.getEnd_date_app() == null
						&& bean.getStart_date_app() == null
						&& bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() == 0) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where Company_Id="
									+ bean.getCompany_name_item()
									+ " and Item_Id="
									+ bean.getItem_name_item()
									+ " and CR_Date='"
									+ bean.getEnd_date_item()
									+ "' and U_Id="
									+ Integer.parseInt(id1.get(s).toString()));
					rs = ps.executeQuery();
				} else if (bean.getCompany_name_item() == 0
						&& bean.getItem_name_item() != 0
						&& bean.getStart_date_item() == null
						&& bean.getEnd_date_item() == null
						&& bean.getApproval_type_app() == 0
						&& bean.getEnd_date_app() == null
						&& bean.getStart_date_app() == null
						&& bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() == 0) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where Item_Id="
									+ bean.getItem_name_item()
									+ " and U_Id="
									+ Integer.parseInt(id1.get(s).toString()));
					rs = ps.executeQuery();
				}

				else if (bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() == 0
						&& bean.getCompany_name_item() != 0
						&& bean.getItem_name_item() == 0
						&& bean.getStart_date_item() != null
						&& bean.getEnd_date_item() != null
						&& bean.getApproval_type_app() == 0
						&& bean.getEnd_date_app() == null
						&& bean.getStart_date_app() == null) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where Company_Id="
									+ bean.getCompany_name_item()
									+ " and U_Id="
									+ Integer.parseInt(id1.get(s).toString())
									+ " and CR_Date between '"
									+ bean.getStart_date_item()
									+ "' and '"
									+ bean.getEnd_date_item() + "'");
					rs = ps.executeQuery();
				} else if (bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() != null
						&& bean.getCompany_name_sup() != 0
						&& bean.getCompany_name_item() == 0
						&& bean.getItem_name_item() == 0
						&& bean.getStart_date_item() == null
						&& bean.getEnd_date_item() == null
						&& bean.getApproval_type_app() == 0
						&& bean.getEnd_date_app() == null
						&& bean.getStart_date_app() == null) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where U_Id="
									+ Integer.parseInt(id1.get(s).toString())
									+ " and CR_Date='"
									+ bean.getStart_date_sup()
									+ "' and Company_Id="
									+ bean.getCompany_name_sup());
					rs = ps.executeQuery();
				} else if (bean.getEnd_date_sup() != null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() != 0
						&& bean.getCompany_name_item() == 0
						&& bean.getItem_name_item() == 0
						&& bean.getStart_date_item() == null
						&& bean.getEnd_date_item() == null
						&& bean.getApproval_type_app() == 0
						&& bean.getEnd_date_app() == null
						&& bean.getStart_date_app() == null) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl where U_Id="
									+ Integer.parseInt(id1.get(s).toString())
									+ " and CR_Date='"
									+ bean.getEnd_date_sup()
									+ "' and Company_Id="
									+ bean.getCompany_name_sup());
					rs = ps.executeQuery();
				} else if (bean.getApproval_type_app() != 0
						&& bean.getStart_date_app() == null
						&& bean.getEnd_date_app() == null
						&& bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() == 0
						&& bean.getEnd_date_item() == null
						&& bean.getStart_date_item() == null
						&& bean.getCompany_name_item() == 0
						&& bean.getItem_name_item() == 0) {
					// System.out.println("Approval Type = " + bean.getApproval_type_app());
					PreparedStatement ps = con.prepareStatement("select * from cr_tbl_approval where Approval_Id="
									+ bean.getApproval_type_app()
									+ " and U_Id="
									+ Integer.parseInt(id1.get(s).toString()));
					rs = ps.executeQuery();
				} else if (bean.getApproval_type_app() != 0
						&& bean.getStart_date_app() != null
						&& bean.getEnd_date_app() == null
						&& bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() == 0
						&& bean.getEnd_date_item() == null
						&& bean.getStart_date_item() == null
						&& bean.getCompany_name_item() == 0
						&& bean.getItem_name_item() == 0) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl_approval where Approval_Id="
									+ bean.getApproval_type_app()
									+ " and U_Id="
									+ Integer.parseInt(id1.get(s).toString())
									+ " and CR_Approval_Date='"
									+ bean.getStart_date_app() + "'");
					rs = ps.executeQuery();
				} else if (bean.getApproval_type_app() != 0
						&& bean.getStart_date_app() == null
						&& bean.getEnd_date_app() != null
						&& bean.getEnd_date_sup() == null
						&& bean.getStart_date_sup() == null
						&& bean.getCompany_name_sup() == 0
						&& bean.getEnd_date_item() == null
						&& bean.getStart_date_item() == null
						&& bean.getCompany_name_item() == 0
						&& bean.getItem_name_item() == 0) {
					PreparedStatement ps = con
							.prepareStatement("select * from cr_tbl_approval where Approval_Id="
									+ bean.getApproval_type_app()
									+ " and U_Id="
									+ Integer.parseInt(id1.get(s).toString())
									+ " and CR_Approval_Date='"
									+ bean.getEnd_date_app() + "'");
					rs = ps.executeQuery();
				}

				else {
					//System.out.println("No value selectd");
				}

				while (rs.next()) {
					ListDisplay.add(rs.getInt("CR_No"));
				}
			}
			//System.out.println("List == " + ListDisplay);
			// RequestDispatcher rd =
			// request.getRequestDispatcher("/Search_Result.jsp");
			// request.setAttribute("disList", ListDisplay);
			// rd.forward(request, response);
			session.setAttribute("disList", ListDisplay);
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}
}
//============================================================================-->
//============================================================================-->