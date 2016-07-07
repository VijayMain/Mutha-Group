package com.muthagroup.dao;

import groovy.swing.factory.TDFactory;

import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.NewSheet_vo;

public class NewSheet_dao {

	private static final java.sql.Date curr_Date = new java.sql.Date(
			System.currentTimeMillis());

	boolean flag = false;
	

	public int addNewSheet(HttpServletRequest request, NewSheet_vo bean) 
	{
		int maxBasic_Id = 0;
		int uid = 0;
		HttpSession session = request.getSession();

		uid = Integer.parseInt(session.getAttribute("uid").toString());

		try {
			Connection con = Connection_Utility.getConnection();

			PreparedStatement ps_chkCustomer = null;
			ResultSet rs_chkCustomer = null;

			PreparedStatement ps_chkPartName = null;
			ResultSet rs_chkPartName = null;


			//******************************************************************************************
			// Chk customer and add history... 
			//******************************************************************************************

			
			
			int chkCust = 0;
			String cust_name = null;
			int maxCustId = 0;
			boolean chkCustFlag = false;

			int chkPartName = 0;
			String part_name = null;
			int maxPartNameId = 0;
			boolean chkPartNameFlag = false;

			ps_chkCustomer = con
					.prepareStatement("select Cust_Id,Cust_Name from Customer_Tbl");
			rs_chkCustomer = ps_chkCustomer.executeQuery();

			
			
			
			
			while (rs_chkCustomer.next()) {
				cust_name = rs_chkCustomer.getString("Cust_Name");

				if (cust_name.equalsIgnoreCase(bean.getCust_name())) {
					chkCustFlag = true;
					maxCustId = rs_chkCustomer.getInt("Cust_Id");

				}
			}

			if (chkCustFlag == false) {
				System.out.println("customer name not matched...");
				PreparedStatement ps_addCust = con
						.prepareStatement("insert into Customer_Tbl(Cust_Name,Email,created_by)values(?,?,?)");

				ps_addCust.setString(1, bean.getCust_name());
				ps_addCust.setString(2, "");
				ps_addCust.setInt(3, uid);

				chkCust = ps_addCust.executeUpdate();

				if (chkCust > 0) {
					PreparedStatement ps_getMaxCust = con
							.prepareStatement("select max(Cust_Id) from Customer_Tbl");
					ResultSet rs_getMaxCust = ps_getMaxCust.executeQuery();

					while (rs_getMaxCust.next()) {
						maxCustId = rs_getMaxCust.getInt("max(Cust_Id)");
					}
				}
				System.out.println("customer Id when name not matched ==="
						+ maxCustId);
			} else {
				System.out.println("customer name matched...");
				System.out.println("customer Id when name matched ==="
						+ maxCustId);
			}


			//******************************************************************************************
			// Chk part  and add history... 
			//******************************************************************************************


			
			
			ps_chkPartName = con
					.prepareStatement("select partName_id,Part_Name from cs_part_Name_tbl");
			rs_chkPartName = ps_chkPartName.executeQuery();

			while (rs_chkPartName.next()) {
				part_name = rs_chkPartName.getString("Part_Name");

				if (part_name.equalsIgnoreCase(bean.getPart_name())) {
					chkPartNameFlag = true;
					maxPartNameId = rs_chkPartName.getInt("PartName_Id");
				}
			}
			if (chkPartNameFlag == true) {
				System.out.println("part name matched...");
				System.out.println("part name id ... " + maxPartNameId);
			} else {
				PreparedStatement ps_addPartName = con
						.prepareStatement("insert into cs_part_name_tbl(Part_Name,Created_By,Created_Date,Enable_Id)values(?,?,?,?)");
				ps_addPartName.setString(1, bean.getPart_name());
				ps_addPartName.setInt(2, uid);
				ps_addPartName.setDate(3, curr_Date);
				ps_addPartName.setInt(4, 1);

				chkPartName = ps_addPartName.executeUpdate();

				if (chkPartName > 0) {
					PreparedStatement ps_getMaxPartName_Id = con
							.prepareStatement("select max(PartName_Id) from cs_part_Name_tbl");
					ResultSet rs_getMaxPartName_Id = ps_getMaxPartName_Id
							.executeQuery();
					while (rs_getMaxPartName_Id.next()) {
						maxPartNameId = rs_getMaxPartName_Id
								.getInt("max(PartName_Id)");
					}
					System.out.println("Part name not matched....");
					System.out.println("part name id...." + maxPartNameId);

					PreparedStatement ps_addPartName_Hist = con
							.prepareStatement("insert into cs_part_name_tbl_hist(PartName_Id,Part_Name,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?)");

					ps_addPartName_Hist.setInt(1, maxPartNameId);
					ps_addPartName_Hist.setString(2, bean.getPart_name());
					ps_addPartName_Hist.setInt(3, uid);
					ps_addPartName_Hist.setDate(4, curr_Date);
					ps_addPartName_Hist.setDate(5, curr_Date);
					ps_addPartName_Hist.setInt(6, 1);
					int i = 0;

					i = ps_addPartName_Hist.executeUpdate();

					if (i > 0) {
						PreparedStatement ps_addPartCust_Rel = con
								.prepareStatement("insert into cs_cust_partname_rel_tbl(Cust_ID,PartName_Id,Created_By,Created_Date,Enable_Id)values(?,?,?,?,?)");

						ps_addPartCust_Rel.setInt(1, maxCustId);
						ps_addPartCust_Rel.setInt(2, maxPartNameId);
						ps_addPartCust_Rel.setInt(3, uid);
						ps_addPartCust_Rel.setDate(4, curr_Date);
						ps_addPartCust_Rel.setInt(5, 1);

						int j = 0;
						int maxPartCustRel_Id = 0;

						j = ps_addPartCust_Rel.executeUpdate();

						if (j > 0) {
							PreparedStatement ps_getMaxPartCustRel_Id = con
									.prepareStatement("select max(CP_Rel_Id) from cs_cust_partname_rel_tbl");
							ResultSet rs_getMaxPartCustRel_Id = ps_getMaxPartCustRel_Id
									.executeQuery();

							while (rs_getMaxPartCustRel_Id.next()) {
								maxPartCustRel_Id = rs_getMaxPartCustRel_Id
										.getInt("max(CP_Rel_Id)");
							}

							System.out.println("cust part relation id... "
									+ maxPartCustRel_Id);

							int k = 0;

							PreparedStatement ps_addPartCustRel_Hist = con
									.prepareStatement("insert into cs_cust_partname_rel_tbl_hist(CP_Rel_ID,Cust_Id,PartName_Id,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
							ps_addPartCustRel_Hist.setInt(1, maxPartCustRel_Id);
							ps_addPartCustRel_Hist.setInt(2, maxCustId);
							ps_addPartCustRel_Hist.setInt(3, maxPartNameId);
							ps_addPartCustRel_Hist.setInt(4, uid);
							ps_addPartCustRel_Hist.setDate(5, curr_Date);
							ps_addPartCustRel_Hist.setDate(6, curr_Date);
							ps_addPartCustRel_Hist.setInt(7, 1);

							k = ps_addPartCustRel_Hist.executeUpdate();

							if (k > 0) {
								System.out
										.println("part cust history added...");
							}
						}

					}
				}
			}

			//******************************************************************************************
			// Chk part No 
			//******************************************************************************************
			
			
			int chkPartNo = 0;
			int chkPartNo_Hist = 0;
			String part_no = null;
			int maxPartNoId = 0;
			boolean chkPartNoFlag = false;

			PreparedStatement ps_chkPartNo = con
					.prepareStatement("select PartNo_Id,Part_No from cs_part_no_tbl");
			ResultSet rs_chkPartNo = ps_chkPartNo.executeQuery();

			while (rs_chkPartNo.next()) {
				part_no = rs_chkPartNo.getString("Part_no");

				if (part_no.equalsIgnoreCase(bean.getPart_no())) {
					chkPartNoFlag = true;
					maxPartNoId = rs_chkPartNo.getInt("PartNo_Id");
				}
			}

			if (chkPartNoFlag == true) {
				System.out.println("part no matched...");
				System.out.println("Max part no id.. :" + maxPartNoId);
			} else {
				System.out.println("part no not matched...");

				PreparedStatement ps_addPartNo = con
						.prepareStatement("insert into cs_part_no_tbl(Part_No,PartName_Id,Created_By,Created_Date,Enable_Id)values(?,?,?,?,?)");

				ps_addPartNo.setString(1, bean.getPart_no());
				ps_addPartNo.setInt(2, maxPartNameId);
				ps_addPartNo.setInt(3, uid);
				ps_addPartNo.setDate(4, curr_Date);
				ps_addPartNo.setInt(5, 1);

				chkPartNo = ps_addPartNo.executeUpdate();

				if (chkPartNo > 0) {
					PreparedStatement ps_getMaxPartNoId = con
							.prepareStatement("select max(PartNo_Id) from cs_part_no_tbl");
					ResultSet rs_getMaxPartNoId = ps_getMaxPartNoId
							.executeQuery();

					while (rs_getMaxPartNoId.next()) {
						maxPartNoId = rs_getMaxPartNoId
								.getInt("max(PartNo_Id)");
					}

					System.out.println("Part no not matched ...");
					System.out.println("max part no id..." + maxPartNoId);

					PreparedStatement ps_addPartNo_Hist = con
							.prepareStatement("insert into cs_part_no_tbl_hist(PartNo_Id,Part_No,PartName_Id,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
					ps_addPartNo_Hist.setInt(1, maxPartNoId);
					ps_addPartNo_Hist.setString(2, bean.getPart_no());
					ps_addPartNo_Hist.setInt(3, maxPartNameId);
					ps_addPartNo_Hist.setInt(4, uid);
					ps_addPartNo_Hist.setDate(5, curr_Date);
					ps_addPartNo_Hist.setDate(6, curr_Date);
					ps_addPartNo_Hist.setInt(7, 1);

					chkPartNo_Hist = ps_addPartNo_Hist.executeUpdate();

					if (chkPartNo_Hist > 0) {
						System.out.println("Part no history added....");
					}

				}

			}
			

			//******************************************************************************************
			// Chk grade and add history... 
			//******************************************************************************************


			
			int addGrade_var = 0;
			int addGradeHist_var = 0;
			String grade = null;
			int maxGrade_Id = 0;
			boolean chkGradeFlag = false;
			
			PreparedStatement ps_chkGrade=con.prepareStatement("select Grade_Id,Grade_Name from cs_grade_mst_tbl");
			ResultSet rs_ChkGrade=ps_chkGrade.executeQuery();
			
			while(rs_ChkGrade.next())
			{
				if(bean.getGrade_type().equals(rs_ChkGrade.getString("Grade_Name")))
				{
					maxGrade_Id=rs_ChkGrade.getInt("Grade_Id");
					chkGradeFlag=true;
				}
			}
			
			if(chkGradeFlag==true)
			{
				System.out.println("Grade name matched....grade id="+maxGrade_Id);
			}
			else
			{
				PreparedStatement ps_addGrade=con.prepareStatement("insert into cs_grade_mst_tbl(Grade_Name,Created_By,Created_Date,Enable_id)values(?,?,?,?)");
				
				ps_addGrade.setString(1, bean.getGrade_type());
				ps_addGrade.setInt(2, uid);
				ps_addGrade.setDate(3,curr_Date);
				ps_addGrade.setInt(4,1);
				
				addGrade_var=ps_addGrade.executeUpdate();
				
				if(addGrade_var>0)
				{
					PreparedStatement ps_getMaxGradeId=con.prepareStatement("select max(Grade_Id) from cs_grade_mst_tbl");
					ResultSet rs_getMaxGradeId=ps_getMaxGradeId.executeQuery();
					
					while(rs_getMaxGradeId.next())
					{
						maxGrade_Id=rs_getMaxGradeId.getInt("max(Grade_Id)");
					}
					rs_getMaxGradeId.close();
					ps_getMaxGradeId.close();
					
					PreparedStatement ps_addGradeHist=con.prepareStatement("insert into cs_grade_mst_tbl_hist(Grade_Id,Grade_Name,Created_By,Created_Date,Created_Date_Hist,Enable_id)values(?,?,?,?,?,?)");
					
					ps_addGradeHist.setInt(1, maxGrade_Id);
					ps_addGradeHist.setString(2, bean.getGrade_type());
					ps_addGradeHist.setInt(3, uid);
					ps_addGradeHist.setDate(4, curr_Date);
					ps_addGradeHist.setDate(5, curr_Date);
					ps_addGradeHist.setInt(6, 1);
					
					addGradeHist_var=ps_addGradeHist.executeUpdate();
					if(addGradeHist_var>0)
					{
						System.out.println("Grade name not matched... grade added with hist... id="+maxGrade_Id);
					}
					
				}
				
			}
			
			
			int basicInfo_var = 0;
			int basicInfo_var_Hist = 0;
			

			PreparedStatement ps_addBasicInfo = con
					.prepareStatement("insert into dev_basicinfo_tbl(PartName_Id,Cust_Id,PartNo_Id,Revision_No,Revision_Date,Mkt_Approval,Schedule_Per_Month,PO_No_From_Cust,PO_Rcvd_At_Dev_Date,Grade_Id,Created_By,Created_Date,Enable_Id,PO_Date_From_Cust,Planned_Start_Date,Planned_End_Date,Actual_Start_Date,Actual_End_Date)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

			ps_addBasicInfo.setInt(1, maxPartNameId);
			ps_addBasicInfo.setInt(2, maxCustId);
			ps_addBasicInfo.setInt(3, maxPartNoId);
			ps_addBasicInfo.setString(4, bean.getRevesion_no());
			ps_addBasicInfo.setDate(5, bean.getRevised_date());
			ps_addBasicInfo.setString(6, bean.getMarketing_apr());
			ps_addBasicInfo.setInt(7, bean.getSchedule_per_month());
			ps_addBasicInfo.setString(8, bean.getPo_number());
			ps_addBasicInfo.setDate(9, bean.getPo_received_date());
			ps_addBasicInfo.setInt(10, maxGrade_Id);
			ps_addBasicInfo.setInt(11, uid);
			ps_addBasicInfo.setDate(12, curr_Date);
			ps_addBasicInfo.setInt(13, 1);
			ps_addBasicInfo.setDate(14, bean.getPo_date());
			ps_addBasicInfo.setDate(15, bean.getPlan_start_date());
			ps_addBasicInfo.setDate(16, bean.getPlan_end_date());
			ps_addBasicInfo.setDate(17, bean.getAct_start_date());
			ps_addBasicInfo.setDate(18, bean.getAct_start_date());

			basicInfo_var = ps_addBasicInfo.executeUpdate();

			if (basicInfo_var > 0) {

				PreparedStatement ps_getMaxBasicId = con
						.prepareStatement("select max(basic_Id) from dev_basicinfo_tbl");
				ResultSet rs_getMaxBasicId = ps_getMaxBasicId.executeQuery();

				while (rs_getMaxBasicId.next()) {
					maxBasic_Id = rs_getMaxBasicId.getInt("max(basic_id)");
				}

				PreparedStatement ps_addBasicInfo_Hist = con
						.prepareStatement("insert into dev_basicinfo_tbl_hist(Created_Date_Hist,PartName_Id,Cust_Id,PartNo_Id,Revision_No,Revision_Date,Mkt_Approval,Schedule_Per_Month,PO_No_From_Cust,PO_Rcvd_At_Dev_Date,Grade_Id,Created_By,Created_Date,Enable_Id,PO_Date_From_Cust,Basic_Id,Planned_Start_Date,Planned_End_Date,Actual_Start_Date,Actual_End_Date)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

				ps_addBasicInfo_Hist.setDate(1, curr_Date);
				ps_addBasicInfo_Hist.setInt(2, maxPartNameId);
				ps_addBasicInfo_Hist.setInt(3, maxCustId);
				ps_addBasicInfo_Hist.setInt(4, maxPartNoId);
				ps_addBasicInfo_Hist.setString(5, bean.getRevesion_no());
				ps_addBasicInfo_Hist.setDate(6, bean.getRevised_date());
				ps_addBasicInfo_Hist.setString(7, bean.getMarketing_apr());
				ps_addBasicInfo_Hist.setInt(8, bean.getSchedule_per_month());
				ps_addBasicInfo_Hist.setString(9, bean.getPo_number());
				ps_addBasicInfo_Hist.setDate(10, bean.getPo_received_date());
				ps_addBasicInfo_Hist.setInt(11, maxGrade_Id);
				ps_addBasicInfo_Hist.setInt(12, uid);
				ps_addBasicInfo_Hist.setDate(13, curr_Date);
				ps_addBasicInfo_Hist.setInt(14, 1);
				ps_addBasicInfo_Hist.setDate(15, bean.getPo_date());
				ps_addBasicInfo_Hist.setInt(16, maxBasic_Id);
				ps_addBasicInfo_Hist.setDate(17, bean.getPlan_start_date());
				ps_addBasicInfo_Hist.setDate(18, bean.getPlan_end_date());
				ps_addBasicInfo_Hist.setDate(19, bean.getAct_start_date());
				ps_addBasicInfo_Hist.setDate(20, bean.getAct_end_date());

				basicInfo_var_Hist = ps_addBasicInfo_Hist.executeUpdate();
				int maxPartPhoto_Id = 0;
				int partNoPhoto_var = 0;
				int partNoPhotoHist_var = 0;

				if (basicInfo_var_Hist > 0)
				{
					System.out.println("Basic info added with the history.....");
					
					int ProjLead_VarHist=0;
					int maxProjectLead_Id=0;
					int ProjLead_Var=0;


					//******************************************************************************************
					// add Basic sheet and Project leader  and add history... 
					//******************************************************************************************


					
					PreparedStatement ps_addProjectLead=con.prepareStatement("insert into dev_basic_projectlead_rel_tbl(Basic_Id,Project_Lead,Created_By,Created_Date)values(?,?,?,?)");
					
					ps_addProjectLead.setInt(1, maxBasic_Id);
					ps_addProjectLead.setInt(2, bean.getProject_leader());
					ps_addProjectLead.setInt(3, uid);
					ps_addProjectLead.setDate(4,curr_Date);
					
					ProjLead_Var=ps_addProjectLead.executeUpdate();
					
					if(ProjLead_Var>0)
					{
						PreparedStatement ps_getMaxProjectLead_Id=con.prepareStatement("select max(BPL_Rel_Id) from dev_basic_projectlead_rel_tbl");
						ResultSet rs_getMaxProjectLead_Id=ps_getMaxProjectLead_Id.executeQuery();
						
						while(rs_getMaxProjectLead_Id.next())
						{
							maxProjectLead_Id=rs_getMaxProjectLead_Id.getInt("max(BPL_Rel_Id)");
						}
						rs_getMaxProjectLead_Id.close();
						ps_getMaxProjectLead_Id.close();
						
						PreparedStatement ps_addProjectLead_Hist=con.prepareStatement("insert into dev_basic_projectlead_rel_tbl_hist(Basic_Id,Project_Lead,Created_By,Created_Date,Created_Date_Hist,BPL_Rel_Id)values(?,?,?,?,?,?)");
						ps_addProjectLead_Hist.setInt(1, maxBasic_Id);
						ps_addProjectLead_Hist.setInt(2, bean.getProject_leader());
						ps_addProjectLead_Hist.setInt(3, uid);
						ps_addProjectLead_Hist.setDate(4, curr_Date);
						ps_addProjectLead_Hist.setDate(5, curr_Date);
						ps_addProjectLead_Hist.setInt(6, maxProjectLead_Id);
						
						ProjLead_VarHist=ps_addProjectLead_Hist.executeUpdate();
						
						if(ProjLead_VarHist>0)
						{
							System.out.println("Project lead added with history...");
						}
					}
					
					//******************************************************************************************
					// add Basic sheet and related person  and add history... 
					//******************************************************************************************

						
					int maxRelatedPerson_Id=0;
					int RelPerson_Var=0;
					int RelPersonHist_Var=0;
					
					PreparedStatement ps_addRelPerson=con.prepareStatement("insert into dev_basic_relperson_rel_tbl(Basic_Id,Related_Person,Created_By,Created_Date)values(?,?,?,?)");
					
					ps_addRelPerson.setInt(1, maxBasic_Id);
					ps_addRelPerson.setInt(2, bean.getRelated_person());
					ps_addRelPerson.setInt(3, uid);
					ps_addRelPerson.setDate(4,curr_Date);
					
					RelPerson_Var=ps_addRelPerson.executeUpdate();
					
					if(RelPerson_Var>0)
					{
						PreparedStatement ps_getMaxRelPerson_Id=con.prepareStatement("select max(BCF_Rel_Id) from dev_basic_relperson_rel_tbl");
						ResultSet rs_getMaxRelPerson_Id=ps_getMaxRelPerson_Id.executeQuery();
						
						while(rs_getMaxRelPerson_Id.next())
						{
							maxRelatedPerson_Id=rs_getMaxRelPerson_Id.getInt("max(BCF_Rel_Id)");
						}
						rs_getMaxRelPerson_Id.close();
						ps_getMaxRelPerson_Id.close();
						
						PreparedStatement ps_addRelPerson_Hist=con.prepareStatement("insert into dev_basic_relperson_rel_tbl_hist(BCF_Rel_Id,Basic_Id,Releted_person,Created_By,Created_Date,Created_Date_Hist)values(?,?,?,?,?,?)");
						
						ps_addRelPerson_Hist.setInt(1, maxRelatedPerson_Id);
						ps_addRelPerson_Hist.setInt(2, maxBasic_Id);
						ps_addRelPerson_Hist.setInt(3, bean.getRelated_person());
						ps_addRelPerson_Hist.setInt(4, uid);
						ps_addRelPerson_Hist.setDate(5, curr_Date);
						ps_addRelPerson_Hist.setDate(6, curr_Date);
	
						RelPersonHist_Var=ps_addRelPerson_Hist.executeUpdate();
						
						if(RelPersonHist_Var>0)
						{
							System.out.println(" Related Person added with history...");
						}
					}
					
					
					//******************************************************************************************
					//  casting_vendor is avilable casting_from not available
					//  add casting vendor and basic rel  and add history... 
					//******************************************************************************************

					int maxCV_Id=0;
					boolean maxCV_Id_flag=false;
					int maxCF_BasicId=0;
					int CF_BasicId_var=0;
					int CF_BasicId_var_Hist=0;
					
					if(bean.getCasting_from()==0 && !bean.getCV_name().equalsIgnoreCase("null"))
					{
						System.out.println("######################### add casting vendor relation...");
						
						PreparedStatement ps_chkCV_Id=con.prepareStatement("select castingvendor_id,castingvendor_name from dev_castingvendor_tbl");
						ResultSet rs_chkCV_Id=ps_chkCV_Id.executeQuery();
						while(rs_chkCV_Id.next())
						{
							if(bean.getCV_name().equalsIgnoreCase(rs_chkCV_Id.getString("castingvendor_name")))
							{
								maxCV_Id=rs_chkCV_Id.getInt("castingvendor_id");
								maxCV_Id_flag=true;
							}
						}
						int addCV_Name_var=0;
						int addCV_NameHist_Var=0;
						int CV_basic_rel_var=0;
						int CV_basic_rel_var_hist=0;
						int maxCVB_Rel_Id=0;
						if(maxCV_Id_flag==true)
						{
							System.out.println("################################ casting vendor name matched...id="+maxCV_Id);
						}
						else
						{
							PreparedStatement ps_addCV_Name=con.prepareStatement("insert into dev_castingvendor_tbl(castingvendor_name,created_by,Enable_Id,created_date)values(?,?,?,?)");
							
							ps_addCV_Name.setString(1, bean.getCV_name());
							ps_addCV_Name.setInt(2, uid);
							ps_addCV_Name.setInt(3, 1);
							ps_addCV_Name.setDate(4, curr_Date);
							
							addCV_Name_var=ps_addCV_Name.executeUpdate();
							
							if(addCV_Name_var>0)
							{
								PreparedStatement ps_getMaxCV=con.prepareStatement("select max(castingvendor_id) from dev_castingvendor_tbl");
								ResultSet rs_getMaxCV=ps_getMaxCV.executeQuery();
								
								while(rs_getMaxCV.next())
								{
									maxCV_Id=rs_getMaxCV.getInt("max(castingvendor_id)");
								}
								rs_getMaxCV.close();
								ps_getMaxCV.close();
										
								PreparedStatement ps_addCV_Name_Hist=con.prepareStatement("insert into dev_castingvendor_tbl_hist(castingvendor_id,created_by,Enable_Id,created_date,created_date_hist,castingvendor_name)values(?,?,?,?,?,?)");
								ps_addCV_Name_Hist.setInt(1,maxCV_Id);
								ps_addCV_Name_Hist.setInt(2, uid);
								ps_addCV_Name_Hist.setInt(3, 1);
								ps_addCV_Name_Hist.setDate(4, curr_Date);
								ps_addCV_Name_Hist.setDate(5, curr_Date);
								ps_addCV_Name_Hist.setString(6, bean.getCV_name());
								
								addCV_NameHist_Var=ps_addCV_Name_Hist.executeUpdate();
								
								if(addCV_NameHist_Var>0)
								{
									System.out.println("############################### casting vendor name not matched .. added with history.... "+maxCV_Id);
								}
							}
							
						}
						
						PreparedStatement ps_addCV_Basic_Rel=con.prepareStatement("insert into dev_basic_castingvendor_rel_tbl(CastingVendor_Id,Basic_Id,Created_By,Created_Date,Enable_id)values(?,?,?,?,?)");
						ps_addCV_Basic_Rel.setInt(1, maxCV_Id);
						ps_addCV_Basic_Rel.setInt(2, maxBasic_Id);
						ps_addCV_Basic_Rel.setInt(3, uid);
						ps_addCV_Basic_Rel.setDate(4, curr_Date);
						ps_addCV_Basic_Rel.setInt(5, 1);
						CV_basic_rel_var=ps_addCV_Basic_Rel.executeUpdate();
						
						if(CV_basic_rel_var>0)
						{
							PreparedStatement ps_getMaxCVB_Rel_Id=con.prepareStatement("select max(BCV_Rel_Id) from dev_basic_castingvendor_rel_tbl");
							ResultSet rs_getMaxCVB_Rel_Id=ps_getMaxCVB_Rel_Id.executeQuery();
							
							while(rs_getMaxCVB_Rel_Id.next())
							{
								maxCVB_Rel_Id=rs_getMaxCVB_Rel_Id.getInt("max(BCV_Rel_Id)");
							}
							rs_getMaxCVB_Rel_Id.close();
							ps_getMaxCVB_Rel_Id.close();
							
							PreparedStatement ps_addCV_Basic_Rel_Hist=con.prepareStatement("insert into dev_basic_castingvendor_rel_tbl_hist(BCV_Rel_Id,CastingVendor_Id,Basic_Id,Created_By,Created_Date,Created_Date_Hist,Enable_id)values(?,?,?,?,?,?,?)");
							
							ps_addCV_Basic_Rel_Hist.setInt(1, maxCVB_Rel_Id);
							ps_addCV_Basic_Rel_Hist.setInt(2, maxCV_Id);
							ps_addCV_Basic_Rel_Hist.setInt(3, maxBasic_Id);
							ps_addCV_Basic_Rel_Hist.setInt(4, uid);
							ps_addCV_Basic_Rel_Hist.setDate(5,curr_Date);
							ps_addCV_Basic_Rel_Hist.setDate(6, curr_Date);
							ps_addCV_Basic_Rel_Hist.setInt(7, 1);
							
							CV_basic_rel_var_hist=ps_addCV_Basic_Rel_Hist.executeUpdate();
							if(CV_basic_rel_var_hist>0)
							{
								System.out.println("############################### castin vendor relation with basic is added....");
							}
							
						}
					}
					else if(bean.getCasting_from()!=0 && bean.getCV_name().equalsIgnoreCase("null"))
					{
						//******************************************************************************************
						//  casting vendor is not avilable casting_from  available
						//  add casting from and basic rel  and history added ... 
						//******************************************************************************************
						
						System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@ add casting from id relation...");
						
						PreparedStatement ps_addCastingFrom_Basic_Rel=con.prepareStatement("insert into dev_basic_casting_rel_tbl(Casting_From_Id,Basic_Id,Created_By,Created_Date,Enable_Id)values(?,?,?,?,?)");
						
						ps_addCastingFrom_Basic_Rel.setInt(1, bean.getCasting_from());
						ps_addCastingFrom_Basic_Rel.setInt(2, maxBasic_Id);
						ps_addCastingFrom_Basic_Rel.setInt(3, uid);
						ps_addCastingFrom_Basic_Rel.setDate(4, curr_Date);
						ps_addCastingFrom_Basic_Rel.setInt(5, 1);
						
						CF_BasicId_var=ps_addCastingFrom_Basic_Rel.executeUpdate();
						if(CF_BasicId_var>0)
						{
							PreparedStatement ps_getMaxCF_Basic_Rel_Id=con.prepareStatement("select max(BC_Rel_Id) from dev_basic_casting_rel_tbl");
							ResultSet rs_getMaxCF_Basic_Rel_Id=ps_getMaxCF_Basic_Rel_Id.executeQuery();
							while(rs_getMaxCF_Basic_Rel_Id.next())
							{
								maxCF_BasicId=rs_getMaxCF_Basic_Rel_Id.getInt("max(BC_Rel_Id)");
							}
							rs_getMaxCF_Basic_Rel_Id.close();
							ps_getMaxCF_Basic_Rel_Id.close();
							
							PreparedStatement ps_addCastingFrom_Basic_Rel_Hist=con.prepareStatement("insert into dev_basic_casting_rel_tbl_hist(BC_Rel_Id,CastingFrom_Id,Basic_Id,Created_by,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
							
							ps_addCastingFrom_Basic_Rel_Hist.setInt(1, maxCF_BasicId);
							ps_addCastingFrom_Basic_Rel_Hist.setInt(2, bean.getCasting_from());
							ps_addCastingFrom_Basic_Rel_Hist.setInt(3, maxBasic_Id);
							ps_addCastingFrom_Basic_Rel_Hist.setInt(4, uid);
							ps_addCastingFrom_Basic_Rel_Hist.setDate(5, curr_Date);
							ps_addCastingFrom_Basic_Rel_Hist.setDate(6, curr_Date);
							ps_addCastingFrom_Basic_Rel_Hist.setInt(7, 1);
							
							CF_BasicId_var_Hist=ps_addCastingFrom_Basic_Rel_Hist.executeUpdate();
							
							if(CF_BasicId_var_Hist>0)
							{
								System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ casting from and basic relation is added with history...");
							}
						}
					}
					else
					{
						//******************************************************************************************
						//  casting vendor and casting_from both are available
						//  add casting_vendor-basic rel and casting_from-basic relation and add history for both... 
						//******************************************************************************************
							System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ casting_vendor-basic rel and casting_from-basic relation and add history for both.....");
						
						PreparedStatement ps_chkCV_Id=con.prepareStatement("select castingvendor_id,castingvendor_name from dev_castingvendor_tbl");
						ResultSet rs_chkCV_Id=ps_chkCV_Id.executeQuery();
						while(rs_chkCV_Id.next())
						{
							if(bean.getCV_name().equalsIgnoreCase(rs_chkCV_Id.getString("castingvendor_name")))
							{
								maxCV_Id=rs_chkCV_Id.getInt("castingvendor_id");
								maxCV_Id_flag=true;
							}
						}
						int addCV_Name_var=0;
						int addCV_NameHist_Var=0;
						int CV_basic_rel_var=0;
						int CV_basic_rel_var_hist=0;
						int maxCVB_Rel_Id=0;
						if(maxCV_Id_flag==true)
						{
							System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ casting vendor name matched...id="+maxCV_Id);
						}
						else
						{
							PreparedStatement ps_addCV_Name=con.prepareStatement("insert into dev_castingvendor_tbl(castingvendor_name,created_by,Enable_Id,created_date)values(?,?,?,?)");
							
							ps_addCV_Name.setString(1, bean.getCV_name());
							ps_addCV_Name.setInt(2, uid);
							ps_addCV_Name.setInt(3, 1);
							ps_addCV_Name.setDate(4, curr_Date);
							
							addCV_Name_var=ps_addCV_Name.executeUpdate();
							
							if(addCV_Name_var>0)
							{
								PreparedStatement ps_getMaxCV=con.prepareStatement("select max(castingvendor_id) from dev_castingvendor_tbl");
								ResultSet rs_getMaxCV=ps_getMaxCV.executeQuery();
								
								while(rs_getMaxCV.next())
								{
									maxCV_Id=rs_getMaxCV.getInt("max(castingvendor_id)");
								}
								rs_getMaxCV.close();
								ps_getMaxCV.close();
										
								PreparedStatement ps_addCV_Name_Hist=con.prepareStatement("insert into dev_castingvendor_tbl_hist(castingvendor_id,created_by,Enable_Id,created_date,created_date_hist,castingvendor_name)values(?,?,?,?,?,?)");
								ps_addCV_Name_Hist.setInt(1,maxCV_Id);
								ps_addCV_Name_Hist.setInt(2, uid);
								ps_addCV_Name_Hist.setInt(3, 1);
								ps_addCV_Name_Hist.setDate(4, curr_Date);
								ps_addCV_Name_Hist.setDate(5, curr_Date);
								ps_addCV_Name_Hist.setString(6, bean.getCV_name());
								
								addCV_NameHist_Var=ps_addCV_Name_Hist.executeUpdate();
								
								if(addCV_NameHist_Var>0)
								{
									System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ casting vendor name not matched in .. added with history.... "+maxCV_Id);
								}
							}
							
						}
						
						PreparedStatement ps_addCV_Basic_Rel=con.prepareStatement("insert into dev_basic_castingvendor_rel_tbl(CastingVendor_Id,Basic_Id,Created_By,Created_Date,Enable_Id)values(?,?,?,?,?)");
						ps_addCV_Basic_Rel.setInt(1, maxCV_Id);
						ps_addCV_Basic_Rel.setInt(2, maxBasic_Id);
						ps_addCV_Basic_Rel.setInt(3, uid);
						ps_addCV_Basic_Rel.setDate(4, curr_Date);
						ps_addCV_Basic_Rel.setInt(5, 1);
						CV_basic_rel_var=ps_addCV_Basic_Rel.executeUpdate();
						
						if(CV_basic_rel_var>0)
						{
							PreparedStatement ps_getMaxCVB_Rel_Id=con.prepareStatement("select max(BCV_Rel_Id) from dev_basic_castingvendor_rel_tbl");
							ResultSet rs_getMaxCVB_Rel_Id=ps_getMaxCVB_Rel_Id.executeQuery();
							
							while(rs_getMaxCVB_Rel_Id.next())
							{
								maxCVB_Rel_Id=rs_getMaxCVB_Rel_Id.getInt("max(BCV_Rel_Id)");
							}
							rs_getMaxCVB_Rel_Id.close();
							ps_getMaxCVB_Rel_Id.close();
							
							PreparedStatement ps_addCV_Basic_Rel_Hist=con.prepareStatement("insert into dev_basic_castingvendor_rel_tbl_hist(BCV_Rel_Id,CastingVendor_Id,Basic_Id,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
							
							ps_addCV_Basic_Rel_Hist.setInt(1, maxCVB_Rel_Id);
							ps_addCV_Basic_Rel_Hist.setInt(2, maxCV_Id);
							ps_addCV_Basic_Rel_Hist.setInt(3, maxBasic_Id);
							ps_addCV_Basic_Rel_Hist.setInt(4, uid);
							ps_addCV_Basic_Rel_Hist.setDate(5,curr_Date);
							ps_addCV_Basic_Rel_Hist.setDate(6, curr_Date);
							ps_addCV_Basic_Rel_Hist.setInt(7, 1);
							
							CV_basic_rel_var_hist=ps_addCV_Basic_Rel_Hist.executeUpdate();
							if(CV_basic_rel_var_hist>0)
							{
								System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ casting vendor relation with basic is added....");
							}
							
						}

						System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ add casting from id relation...");
						
						PreparedStatement ps_addCastingFrom_Basic_Rel=con.prepareStatement("insert into dev_basic_casting_rel_tbl(Casting_From_Id,Basic_Id,Created_By,Created_Date,Enable_id)values(?,?,?,?,?)");
						
						ps_addCastingFrom_Basic_Rel.setInt(1, bean.getCasting_from());
						ps_addCastingFrom_Basic_Rel.setInt(2, maxBasic_Id);
						ps_addCastingFrom_Basic_Rel.setInt(3, uid);
						ps_addCastingFrom_Basic_Rel.setDate(4, curr_Date);
						ps_addCastingFrom_Basic_Rel.setInt(5,1);
						
						CF_BasicId_var=ps_addCastingFrom_Basic_Rel.executeUpdate();
						if(CF_BasicId_var>0)
						{
							PreparedStatement ps_getMaxCF_Basic_Rel_Id=con.prepareStatement("select max(BC_Rel_Id) from dev_basic_casting_rel_tbl");
							ResultSet rs_getMaxCF_Basic_Rel_Id=ps_getMaxCF_Basic_Rel_Id.executeQuery();
							while(rs_getMaxCF_Basic_Rel_Id.next())
							{
								maxCF_BasicId=rs_getMaxCF_Basic_Rel_Id.getInt("max(BC_Rel_Id)");
							}
							rs_getMaxCF_Basic_Rel_Id.close();
							ps_getMaxCF_Basic_Rel_Id.close();
							
							PreparedStatement ps_addCastingFrom_Basic_Rel_Hist=con.prepareStatement("insert into dev_basic_casting_rel_tbl_hist(BC_Rel_Id,CastingFrom_Id,Basic_Id,Created_by,Created_Date,Created_Date_Hist,Enable_id)values(?,?,?,?,?,?,?)");
							
							ps_addCastingFrom_Basic_Rel_Hist.setInt(1, maxCF_BasicId);
							ps_addCastingFrom_Basic_Rel_Hist.setInt(2, bean.getCasting_from());
							ps_addCastingFrom_Basic_Rel_Hist.setInt(3, maxBasic_Id);
							ps_addCastingFrom_Basic_Rel_Hist.setInt(4, uid);
							ps_addCastingFrom_Basic_Rel_Hist.setDate(5, curr_Date);
							ps_addCastingFrom_Basic_Rel_Hist.setDate(6, curr_Date);
							ps_addCastingFrom_Basic_Rel_Hist.setInt(7, 1);
							
							CF_BasicId_var_Hist=ps_addCastingFrom_Basic_Rel_Hist.executeUpdate();
							
							if(CF_BasicId_var_Hist>0)
							{
								System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ casting from and basic relation is added with history...");
							}
						}
						
					}
					
					
					int maxPV_Id=0;
					boolean maxPV_Id_flag=false;
					int maxPlant_BasicId=0;
					int Plant_BasicId_var=0;
					int Plant_BasicId_var_Hist=0;
					
					//******************************************************************************************
					//  plant_vendor is avilable plant not available
					//  add plant vendor and basic rel  and add history... 
					//******************************************************************************************
					if(bean.getPlant_name()==0 && !bean.getPV_name().equalsIgnoreCase("null"))
					{
						System.out.println(" plant_vendor is avilable plant not available....");
						bean.getPV_name();
						
						//****************************************************************************
						
						PreparedStatement ps_chkPV_Id=con.prepareStatement("select plantvendor_id,plantvendor_name from dev_plantvendor_tbl");
						ResultSet rs_chkPV_Id=ps_chkPV_Id.executeQuery();
						while(rs_chkPV_Id.next())
						{
							if(bean.getPV_name().equalsIgnoreCase(rs_chkPV_Id.getString("plantvendor_name")))
							{
								maxPV_Id=rs_chkPV_Id.getInt("plantvendor_id");
								maxPV_Id_flag=true;
							}
						}
						int addPV_Name_var=0;
						int addPV_NameHist_Var=0;
						int PV_basic_rel_var=0;
						int PV_basic_rel_var_hist=0;
						int maxPVB_Rel_Id=0;
						if(maxPV_Id_flag==true)
						{
							System.out.println("plant vendor name matched...id="+maxPV_Id);
						}
						else
						{
							PreparedStatement ps_addPV_Name=con.prepareStatement("insert into dev_plantvendor_tbl(plantvendor_name,created_by,Enable_Id,created_date)values(?,?,?,?)");
							
							ps_addPV_Name.setString(1, bean.getPV_name());
							ps_addPV_Name.setInt(2, uid);
							ps_addPV_Name.setInt(3, 1);
							ps_addPV_Name.setDate(4, curr_Date);
							
							addPV_Name_var=ps_addPV_Name.executeUpdate();
							
							if(addPV_Name_var>0)
							{
								PreparedStatement ps_getMaxPV=con.prepareStatement("select max(plantvendor_id) from dev_plantvendor_tbl");
								ResultSet rs_getMaxPV=ps_getMaxPV.executeQuery();
								
								while(rs_getMaxPV.next())
								{
									maxPV_Id=rs_getMaxPV.getInt("max(plantvendor_id)");
								}
								rs_getMaxPV.close();
								ps_getMaxPV.close();
										
								PreparedStatement ps_addPV_Name_Hist=con.prepareStatement("insert into dev_plantvendor_tbl_hist(plantvendor_id,created_by,Enable_Id,created_date,created_date_hist,plantvendor_name)values(?,?,?,?,?,?)");
								ps_addPV_Name_Hist.setInt(1,maxPV_Id);
								ps_addPV_Name_Hist.setInt(2, uid);
								ps_addPV_Name_Hist.setInt(3, 1);
								ps_addPV_Name_Hist.setDate(4, curr_Date);
								ps_addPV_Name_Hist.setDate(5, curr_Date);
								ps_addPV_Name_Hist.setString(6, bean.getCV_name());
								
								addPV_NameHist_Var=ps_addPV_Name_Hist.executeUpdate();
								
								if(addPV_NameHist_Var>0)
								{
									System.out.println("plant vendor name not matched .. added with history.... "+maxPV_Id);
								}
							}
							
						}
						
						PreparedStatement ps_addPV_Basic_Rel=con.prepareStatement("insert into dev_basic_plantvendor_rel_tbl(PlantVendor_Id,Basic_Id,Created_By,Created_Date,Enable_Id)values(?,?,?,?,?)");
						ps_addPV_Basic_Rel.setInt(1, maxPV_Id);
						ps_addPV_Basic_Rel.setInt(2, maxBasic_Id);
						ps_addPV_Basic_Rel.setInt(3, uid);
						ps_addPV_Basic_Rel.setDate(4, curr_Date);
						ps_addPV_Basic_Rel.setInt(5, 1);
						
						PV_basic_rel_var=ps_addPV_Basic_Rel.executeUpdate();
						
						if(PV_basic_rel_var>0)
						{
							PreparedStatement ps_getMaxPVB_Rel_Id=con.prepareStatement("select max(BVP_Rel_Id) from dev_basic_plantvendor_rel_tbl");
							ResultSet rs_getMaxPVB_Rel_Id=ps_getMaxPVB_Rel_Id.executeQuery();
							
							while(rs_getMaxPVB_Rel_Id.next())
							{
								maxPVB_Rel_Id=rs_getMaxPVB_Rel_Id.getInt("max(BVP_Rel_Id)");
							}
							rs_getMaxPVB_Rel_Id.close();
							ps_getMaxPVB_Rel_Id.close();
							
							PreparedStatement ps_addCV_Basic_Rel_Hist=con.prepareStatement("insert into dev_basic_plantvendor_rel_tbl_hist(BVP_Rel_Id,PlantVendor_Id,Basic_Id,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
							
							ps_addCV_Basic_Rel_Hist.setInt(1, maxPVB_Rel_Id);
							ps_addCV_Basic_Rel_Hist.setInt(2, maxPV_Id);
							ps_addCV_Basic_Rel_Hist.setInt(3, maxBasic_Id);
							ps_addCV_Basic_Rel_Hist.setInt(4, uid);
							ps_addCV_Basic_Rel_Hist.setDate(5,curr_Date);
							ps_addCV_Basic_Rel_Hist.setDate(6, curr_Date);
							ps_addCV_Basic_Rel_Hist.setInt(7, 1);
							
							PV_basic_rel_var_hist=ps_addCV_Basic_Rel_Hist.executeUpdate();
							if(PV_basic_rel_var_hist>0)
							{
								System.out.println("plant vendor relation with basic is added....");
							}
							
						}
					}
					
					else if(bean.getPlant_name()!=0 && bean.getPV_name().equalsIgnoreCase("null"))
					{
						//******************************************************************************************
						//  plant_vendor is not avilable plant is available
						//  add plant and basic rel  and add history... 
						//******************************************************************************************
						System.out.println("plant_vendor is not avilable plant is available.....");
						
						PreparedStatement ps_addPlant_Basic_Rel=con.prepareStatement("insert into dev_basic_plant_rel_tbl(Plant_Id,Basic_Id,Created_By,Created_Date,Enable_Id)values(?,?,?,?,?)");
						
						ps_addPlant_Basic_Rel.setInt(1, bean.getPlant_name());
						ps_addPlant_Basic_Rel.setInt(2, maxBasic_Id);
						ps_addPlant_Basic_Rel.setInt(3, uid);
						ps_addPlant_Basic_Rel.setDate(4, curr_Date);
						ps_addPlant_Basic_Rel.setInt(5, 1);
						
						Plant_BasicId_var=ps_addPlant_Basic_Rel.executeUpdate();
						if(Plant_BasicId_var>0)
						{
							PreparedStatement ps_getMaxPlant_Basic_Rel_Id=con.prepareStatement("select max(BP_Rel_Id) from dev_basic_plant_rel_tbl");
							ResultSet rs_getMaxPlant_Basic_Rel_Id=ps_getMaxPlant_Basic_Rel_Id.executeQuery();
							while(rs_getMaxPlant_Basic_Rel_Id.next())
							{
								maxPlant_BasicId=rs_getMaxPlant_Basic_Rel_Id.getInt("max(BP_Rel_Id)");
							}
							rs_getMaxPlant_Basic_Rel_Id.close();
							ps_getMaxPlant_Basic_Rel_Id.close();
							
							PreparedStatement ps_addPlant_Basic_Rel_Hist=con.prepareStatement("insert into dev_basic_plant_rel_tbl_hist(BP_Rel_Id,Plant_Id,Basic_Id,Created_by,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
							
							ps_addPlant_Basic_Rel_Hist.setInt(1, maxPlant_BasicId);
							ps_addPlant_Basic_Rel_Hist.setInt(2, bean.getPlant_name());
							ps_addPlant_Basic_Rel_Hist.setInt(3, maxBasic_Id);
							ps_addPlant_Basic_Rel_Hist.setInt(4, uid);
							ps_addPlant_Basic_Rel_Hist.setDate(5, curr_Date);
							ps_addPlant_Basic_Rel_Hist.setDate(6, curr_Date);
							ps_addPlant_Basic_Rel_Hist.setInt(7,1);
							
							Plant_BasicId_var_Hist=ps_addPlant_Basic_Rel_Hist.executeUpdate();
							
							if(Plant_BasicId_var_Hist>0)
							{
								System.out.println("plant and basic relation is added with history...");
							}
						}
						
						
					}
					
					else
					{
						//******************************************************************************************
						//  plant_vendor and plant both are available
						//  add plant_vendor-basic rel and plant-basic relation and add history... 
						//******************************************************************************************
						System.out.println("plant_vendor and plant both are available");
						
						//****************************************************************************
						
						PreparedStatement ps_chkPV_Id=con.prepareStatement("select plantvendor_id,plantvendor_name from dev_plantvendor_tbl");
						ResultSet rs_chkPV_Id=ps_chkPV_Id.executeQuery();
						while(rs_chkPV_Id.next())
						{
							if(bean.getPV_name().equalsIgnoreCase(rs_chkPV_Id.getString("plantvendor_name")))
							{
								maxPV_Id=rs_chkPV_Id.getInt("plantvendor_id");
								maxPV_Id_flag=true;
							}
						}
						int addPV_Name_var=0;
						int addPV_NameHist_Var=0;
						int PV_basic_rel_var=0;
						int PV_basic_rel_var_hist=0;
						int maxPVB_Rel_Id=0;
						if(maxPV_Id_flag==true)
						{
							System.out.println("plant vendor name matched...id="+maxPV_Id);
						}
						else
						{
							PreparedStatement ps_addPV_Name=con.prepareStatement("insert into dev_plantvendor_tbl(plantvendor_name,created_by,Enable_Id,created_date)values(?,?,?,?)");
							
							ps_addPV_Name.setString(1, bean.getPV_name());
							ps_addPV_Name.setInt(2, uid);
							ps_addPV_Name.setInt(3, 1);
							ps_addPV_Name.setDate(4, curr_Date);
							
							addPV_Name_var=ps_addPV_Name.executeUpdate();
							
							if(addPV_Name_var>0)
							{
								PreparedStatement ps_getMaxPV=con.prepareStatement("select max(plantvendor_id) from dev_plantvendor_tbl");
								ResultSet rs_getMaxPV=ps_getMaxPV.executeQuery();
								
								while(rs_getMaxPV.next())
								{
									maxPV_Id=rs_getMaxPV.getInt("max(plantvendor_id)");
								}
								rs_getMaxPV.close();
								ps_getMaxPV.close();
										
								PreparedStatement ps_addPV_Name_Hist=con.prepareStatement("insert into dev_plantvendor_tbl_hist(plantvendor_id,created_by,Enable_Id,created_date,created_date_hist,plantvendor_name)values(?,?,?,?,?,?)");
								ps_addPV_Name_Hist.setInt(1,maxPV_Id);
								ps_addPV_Name_Hist.setInt(2, uid);
								ps_addPV_Name_Hist.setInt(3, 1);
								ps_addPV_Name_Hist.setDate(4, curr_Date);
								ps_addPV_Name_Hist.setDate(5, curr_Date);
								ps_addPV_Name_Hist.setString(6, bean.getCV_name());
								
								addPV_NameHist_Var=ps_addPV_Name_Hist.executeUpdate();
								
								if(addPV_NameHist_Var>0)
								{
									System.out.println("plant vendor name not matched .. added with history.... "+maxPV_Id);
								}
							}
							
						}
						
						PreparedStatement ps_addPV_Basic_Rel=con.prepareStatement("insert into dev_basic_plantvendor_rel_tbl(PlantVendor_Id,Basic_Id,Created_By,Created_Date,Enable_Id)values(?,?,?,?,?)");
						ps_addPV_Basic_Rel.setInt(1, maxPV_Id);
						ps_addPV_Basic_Rel.setInt(2, maxBasic_Id);
						ps_addPV_Basic_Rel.setInt(3, uid);
						ps_addPV_Basic_Rel.setDate(4, curr_Date);
						ps_addPV_Basic_Rel.setInt(5, 1);
						
						PV_basic_rel_var=ps_addPV_Basic_Rel.executeUpdate();
						
						if(PV_basic_rel_var>0)
						{
							PreparedStatement ps_getMaxPVB_Rel_Id=con.prepareStatement("select max(BVP_Rel_Id) from dev_basic_plantvendor_rel_tbl");
							ResultSet rs_getMaxPVB_Rel_Id=ps_getMaxPVB_Rel_Id.executeQuery();
							
							while(rs_getMaxPVB_Rel_Id.next())
							{
								maxPVB_Rel_Id=rs_getMaxPVB_Rel_Id.getInt("max(BVP_Rel_Id)");
							}
							rs_getMaxPVB_Rel_Id.close();
							ps_getMaxPVB_Rel_Id.close();
							
							PreparedStatement ps_addCV_Basic_Rel_Hist=con.prepareStatement("insert into dev_basic_plantvendor_rel_tbl_hist(BVP_Rel_Id,PlantVendor_Id,Basic_Id,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
							
							ps_addCV_Basic_Rel_Hist.setInt(1, maxPVB_Rel_Id);
							ps_addCV_Basic_Rel_Hist.setInt(2, maxPV_Id);
							ps_addCV_Basic_Rel_Hist.setInt(3, maxBasic_Id);
							ps_addCV_Basic_Rel_Hist.setInt(4, uid);
							ps_addCV_Basic_Rel_Hist.setDate(5,curr_Date);
							ps_addCV_Basic_Rel_Hist.setDate(6, curr_Date);
							ps_addCV_Basic_Rel_Hist.setInt(7, 1);
							
							PV_basic_rel_var_hist=ps_addCV_Basic_Rel_Hist.executeUpdate();
							if(PV_basic_rel_var_hist>0)
							{
								System.out.println("plant vendor relation with basic is added....");
							}
							
						}
						
						PreparedStatement ps_addPlant_Basic_Rel=con.prepareStatement("insert into dev_basic_plant_rel_tbl(Plant_Id,Basic_Id,Created_By,Created_Date,Enable_Id)values(?,?,?,?,?)");
						
						ps_addPlant_Basic_Rel.setInt(1, bean.getPlant_name());
						ps_addPlant_Basic_Rel.setInt(2, maxBasic_Id);
						ps_addPlant_Basic_Rel.setInt(3, uid);
						ps_addPlant_Basic_Rel.setDate(4, curr_Date);
						ps_addPlant_Basic_Rel.setInt(5, 1);
						
						Plant_BasicId_var=ps_addPlant_Basic_Rel.executeUpdate();
						if(Plant_BasicId_var>0)
						{
							PreparedStatement ps_getMaxPlant_Basic_Rel_Id=con.prepareStatement("select max(BP_Rel_Id) from dev_basic_plant_rel_tbl");
							ResultSet rs_getMaxPlant_Basic_Rel_Id=ps_getMaxPlant_Basic_Rel_Id.executeQuery();
							while(rs_getMaxPlant_Basic_Rel_Id.next())
							{
								maxPlant_BasicId=rs_getMaxPlant_Basic_Rel_Id.getInt("max(BP_Rel_Id)");
							}
							rs_getMaxPlant_Basic_Rel_Id.close();
							ps_getMaxPlant_Basic_Rel_Id.close();
							
							PreparedStatement ps_addPlant_Basic_Rel_Hist=con.prepareStatement("insert into dev_basic_plant_rel_tbl_hist(BP_Rel_Id,Plant_Id,Basic_Id,Created_by,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
							
							ps_addPlant_Basic_Rel_Hist.setInt(1, maxPlant_BasicId);
							ps_addPlant_Basic_Rel_Hist.setInt(2, bean.getPlant_name());
							ps_addPlant_Basic_Rel_Hist.setInt(3, maxBasic_Id);
							ps_addPlant_Basic_Rel_Hist.setInt(4, uid);
							ps_addPlant_Basic_Rel_Hist.setDate(5, curr_Date);
							ps_addPlant_Basic_Rel_Hist.setDate(6, curr_Date);
							ps_addPlant_Basic_Rel_Hist.setInt(7, 1);
							
							Plant_BasicId_var_Hist=ps_addPlant_Basic_Rel_Hist.executeUpdate();
							
							if(Plant_BasicId_var_Hist>0)
							{
								System.out.println("plant and basic relation is added with history...");
							}
						}
					}
					
					if(bean.getPartImage_file_name()!="")
					{
					PreparedStatement ps_addPartNo_Photo = con
							.prepareStatement("insert into dev_partno_photo_tbl(partno_id,attachment,file_name,created_by,created_date,Enable_id)values(?,?,?,?,?,?)");

					ps_addPartNo_Photo.setInt(1, maxPartNoId);
					ps_addPartNo_Photo
							.setBlob(2, bean.getPartImage_file_blob());
					ps_addPartNo_Photo.setString(3,
							bean.getPartImage_file_name());
					ps_addPartNo_Photo.setInt(4, uid);
					ps_addPartNo_Photo.setDate(5, curr_Date);
					ps_addPartNo_Photo.setInt(6, 1);

					partNoPhoto_var = ps_addPartNo_Photo.executeUpdate();

					if (partNoPhoto_var > 0) 
					{
						PreparedStatement ps_getMaxPartImageAttach_Id = con
								.prepareStatement("select max(part_photo_id) from dev_partno_photo_tbl");
						ResultSet rs_getMaxPartImageAttach_Id = ps_getMaxPartImageAttach_Id
								.executeQuery();

						while (rs_getMaxPartImageAttach_Id.next()) {
							maxPartPhoto_Id = rs_getMaxPartImageAttach_Id
									.getInt("max(part_photo_id)");
						}

						PreparedStatement ps_addPartNo_Photo_Hist = con.prepareStatement("insert into dev_partno_photo_tbl_hist(part_photo_id,attachment,file_name,created_by,created_date,created_date_hist,partno_id,Enable_Id)values(?,?,?,?,?,?,?,?)");

						ps_addPartNo_Photo_Hist.setInt(1, maxPartPhoto_Id);
						ps_addPartNo_Photo_Hist.setBlob(2,
								bean.getPartImage_file_blob());
						ps_addPartNo_Photo_Hist.setString(3,
								bean.getPartImage_file_name());
						ps_addPartNo_Photo_Hist.setInt(4, uid);
						ps_addPartNo_Photo_Hist.setDate(5, curr_Date);
						ps_addPartNo_Photo_Hist.setDate(6, curr_Date);
						ps_addPartNo_Photo_Hist.setInt(7, maxPartNoId);
						ps_addPartNo_Photo_Hist.setInt(8, 1);

						partNoPhotoHist_var = ps_addPartNo_Photo_Hist
								.executeUpdate();
						
						if(partNoPhotoHist_var>0)
						{
							System.out.println("part no photo added with history.....");
						}
						
					}
					}
					else
					{
						System.out.println("Part no photo not aailable.....");
					}
					//*************************************************************************
					// Basic id PO attachment 
					//********************************************************************
					
					
						int BI_POAttach_var = 0;
						int maxBI_POAttach_Id = 0;
						int BI_POAttachHist_var = 0;
						
						int max2DAttach_Id=0;
						int max3DAttach_Id=0;
						
						int TwoDAttach_var=0;
						int TwoDAttachHist_var=0;
						int ThreeDAttach_var=0;
						int ThreeDAttachHist_var=0;
						
						
					if(bean.getPo_file_name()!=null)
					{
									PreparedStatement ps_POAttach = con
									.prepareStatement("insert into dev_basicinfo_po_attachment_tbl(Basic_Id,File_Name,Attachment,Attached_By,Attached_Date,Enable_id)values(?,?,?,?,?,?)");

							ps_POAttach.setInt(1, maxBasic_Id);
							ps_POAttach.setString(2, bean.getPo_file_name());
							ps_POAttach.setBlob(3, bean.getPo_file_blob());
							ps_POAttach.setInt(4, uid);
							ps_POAttach.setDate(5, curr_Date);
							ps_POAttach.setInt(6, 1);

							BI_POAttach_var = ps_POAttach.executeUpdate();

							if (BI_POAttach_var > 0) 
							{
								PreparedStatement ps_getMaxPO_Id = con
										.prepareStatement("select max(BI_PO_Attach_Id) from dev_basicinfo_po_attachment_tbl");
								ResultSet rs_getMaxPO_Id = ps_getMaxPO_Id
										.executeQuery();

								while (rs_getMaxPO_Id.next()) {
									maxBI_POAttach_Id = rs_getMaxPO_Id
											.getInt("max(BI_PO_Attach_Id)");
								}

								PreparedStatement ps_POAttach_hist = con
										.prepareStatement("insert into dev_basicinfo_po_attachment_tbl_hist(basic_id,bi_po_attach_id,file_name,attachment,attached_by,attached_date,attached_date_hist,Enable_id)values(?,?,?,?,?,?,?,?)");

								ps_POAttach_hist.setInt(1, maxBasic_Id);
								ps_POAttach_hist.setInt(2, maxBI_POAttach_Id);
								ps_POAttach_hist.setString(3,
										bean.getPo_file_name());
								ps_POAttach_hist.setBlob(4,
										bean.getPo_file_blob());
								ps_POAttach_hist.setInt(5, uid);
								ps_POAttach_hist.setDate(6, curr_Date);
								ps_POAttach_hist.setDate(7, curr_Date);
								ps_POAttach_hist.setInt(8, 1);

								BI_POAttachHist_var = ps_POAttach_hist.executeUpdate();

								if (BI_POAttachHist_var > 0) 
								{
									System.out.println("PO attached with basic info.... and history also...");
								}
							}
					}else
					{
						System.out.println("PO for attachment....");
					}
					
					if(bean.getTwoD_drawing_file_name()!=null)
					{
									PreparedStatement ps_add2DDrawing=con.prepareStatement("insert into dev_2d_drawing_attachment(Basic_Id,File_Name,Attachment,Attached_By,Attached_Date,Enable_Id)values(?,?,?,?,?,?)");
									ps_add2DDrawing.setInt(1, maxBasic_Id);
									ps_add2DDrawing.setString(2, bean.getTwoD_drawing_file_name());
									ps_add2DDrawing.setBlob(3, bean.getTwoD_drawing());
									ps_add2DDrawing.setInt(4, uid);
									ps_add2DDrawing.setDate(5, curr_Date);
									ps_add2DDrawing.setInt(6, 1);
									
									TwoDAttach_var=ps_add2DDrawing.executeUpdate();
									
									if(TwoDAttach_var>0)
									{
										PreparedStatement ps_get2DAttachId=con.prepareStatement("select max(2d_drawing_attach_id) from dev_2d_drawing_attachment");
										ResultSet rs_get2DAttachId=ps_get2DAttachId.executeQuery();
										while(rs_get2DAttachId.next())
										{
											max2DAttach_Id=rs_get2DAttachId.getInt("max(2d_drawing_attach_id)");
										}
										
										PreparedStatement ps_add2DDrawing_hist=con.prepareStatement("insert into dev_2d_drawing_attachment_hist(Basic_Id,2d_drawing_attach_id,File_Name,Attachment,Attached_By,Attached_Date,attached_date_hist,Enable_Id)values(?,?,?,?,?,?,?,?)");
										ps_add2DDrawing_hist.setInt(1, maxBasic_Id);
										ps_add2DDrawing_hist.setInt(2, max2DAttach_Id);
										ps_add2DDrawing_hist.setString(3, bean.getTwoD_drawing_file_name());
										ps_add2DDrawing_hist.setBlob(4, bean.getTwoD_drawing());
										ps_add2DDrawing_hist.setInt(5, uid);
										ps_add2DDrawing_hist.setDate(6, curr_Date);
										ps_add2DDrawing_hist.setDate(7, curr_Date);
										ps_add2DDrawing_hist.setInt(8, 1);
										
										TwoDAttachHist_var=ps_add2DDrawing_hist.executeUpdate();
										if(TwoDAttachHist_var>0 )
										{
											System.out.println("two d attachment is added with history....");
										}
									}
					}
					else
					{
						System.out.println("2 d drawing is not available for attachment...");
					}
										if(bean.getThreeD_drawing_file_name()!="")
										{
											System.out.println("3 d frawing ,.....");
											PreparedStatement ps_add3DDrawing=con.prepareStatement("insert into dev_3d_drawing_attachment_tbl(Basic_Id,File_Name,Attachment,Attached_By,Attached_Date,Enable_id)values(?,?,?,?,?,?)");
											ps_add3DDrawing.setInt(1, maxBasic_Id);
											ps_add3DDrawing.setString(2, bean.getThreeD_drawing_file_name());
											ps_add3DDrawing.setBlob(3, bean.getThreeD_drawing());
											ps_add3DDrawing.setInt(4, uid);
											ps_add3DDrawing.setDate(5, curr_Date);
											ps_add3DDrawing.setInt(6, 1);
											
											ThreeDAttach_var=ps_add3DDrawing.executeUpdate();
											
											if(ThreeDAttach_var>0 && bean.getThreeD_drawing()!=null && bean.getThreeD_drawing_file_name()!=null)
											{
												PreparedStatement ps_get3DDrawing_Id=con.prepareStatement("select max(3D_drawing_attach_id) from dev_3d_drawing_attachment_tbl");
												ResultSet rs_get3DDrawing_Id=ps_get3DDrawing_Id.executeQuery();
												
												while(rs_get3DDrawing_Id.next())
												{
													max3DAttach_Id=rs_get3DDrawing_Id.getInt("max(3D_drawing_attach_id)");
												}
												
												PreparedStatement ps_add3DDrawing_hist=con.prepareStatement("insert into dev_3d_drawing_attachment_tbl_Hist(Basic_Id,3D_drawing_attach_id,File_Name,Attachment,Attached_By,Attached_Date,attached_date_hist,Enable_id)values(?,?,?,?,?,?,?,?)");
												
												ps_add3DDrawing_hist.setInt(1, maxBasic_Id);
												ps_add3DDrawing_hist.setInt(2, max3DAttach_Id);
												ps_add3DDrawing_hist.setString(3, bean.getThreeD_drawing_file_name());
												ps_add3DDrawing_hist.setBlob(4, bean.getThreeD_drawing());
												ps_add3DDrawing_hist.setInt(5, uid);
												ps_add3DDrawing_hist.setDate(6, curr_Date);
												ps_add3DDrawing_hist.setDate(7, curr_Date);
												ps_add3DDrawing_hist.setInt(8, 1);
												
												ThreeDAttachHist_var=ps_add3DDrawing_hist.executeUpdate();
												if(ThreeDAttachHist_var>0)
												{
													System.out.println("3D Attachment is added with hstory....");
													
												}
											}
											
										}
										else
										{
											System.out.println("3 D attachment is not available....");
											
										}
										flag=true;
									}
								}
							
			} catch (Exception e) {
			e.printStackTrace();
		}
		return maxBasic_Id;
	}

	public boolean attach_File(NewSheet_vo bean, HttpSession session, int basic_id) {
		System.out.println("File===== " + bean.getFile_Name_ext());
		
		try
		{
			
			Connection con=Connection_Utility.getConnection();
			int uid=Integer.parseInt(session.getAttribute("uid").toString());
			int addOther_var=0;
			int addOtherHist_var=0;
			int maxOtherId=0;
			
			PreparedStatement ps_addOtherAttachment=con.prepareStatement("insert into dev_other_attachement(Basic_Id,file_name,attachment,attached_by,attached_date,Enable_Id)values(?,?,?,?,?,?)");
			ps_addOtherAttachment.setInt(1, basic_id);
			ps_addOtherAttachment.setString(2, bean.getFile_Name_ext());
			ps_addOtherAttachment.setBlob(3, bean.getOther_file_blob());
			ps_addOtherAttachment.setInt(4, uid);
			ps_addOtherAttachment.setDate(5,curr_Date);
			ps_addOtherAttachment.setInt(6, 1);
			
			addOther_var=ps_addOtherAttachment.executeUpdate();
			
			if(addOther_var>0)
			{
				PreparedStatement ps_del = con.prepareStatement("delete from dev_other_attachement where File_Name='"+ "" + "'");
				ps_del.executeUpdate();
				
				PreparedStatement ps_getMaxOtherId=con.prepareStatement("select max(other_attach_id) from dev_other_attachement");
				ResultSet rs_getMaxOtherId=ps_getMaxOtherId.executeQuery();
				while(rs_getMaxOtherId.next())
				{
					maxOtherId=rs_getMaxOtherId.getInt("max(other_attach_id)");
				}
				rs_getMaxOtherId.close();
				ps_getMaxOtherId.close();
				
				if(maxOtherId>0)
				{
				PreparedStatement ps_addOtherAttachment_Hist=con.prepareStatement("insert into dev_other_attachement_hist(Basic_Id,other_attach_id,file_name,attachment,attached_by,attached_date,attached_date_hist,Enable_Id)values(?,?,?,?,?,?,?,?)");
				ps_addOtherAttachment_Hist.setInt(1, basic_id);
				ps_addOtherAttachment_Hist.setInt(2, maxOtherId);
				ps_addOtherAttachment_Hist.setString(3, bean.getFile_Name_ext());
				ps_addOtherAttachment_Hist.setBlob(4, bean.getOther_file_blob());
				ps_addOtherAttachment_Hist.setInt(5, uid);
				ps_addOtherAttachment_Hist.setDate(6,curr_Date);
				ps_addOtherAttachment_Hist.setDate(7,curr_Date);
				ps_addOtherAttachment_Hist.setInt(8, 1);
				
				addOtherHist_var=ps_addOtherAttachment_Hist.executeUpdate();
				
				if(addOtherHist_var>0)
				{
					flag=true;
					System.out.println("Other file attached...");
				}
				}
				else
				{
					flag=true;
				}
			}
				
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		return flag;
	}

}
