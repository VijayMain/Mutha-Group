package com.muthagroup.dao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Edit_NewSheet_vo;

import java.io.InputStream;
import java.sql.*;
public class Edit_NewSheet_dao 
{

	boolean flag=false;
	int basic_id=0;
	
	private static final java.sql.Date curr_Date =new java.sql.Date(System.currentTimeMillis());
	public int updateNewSheet(HttpServletRequest request, Edit_NewSheet_vo bean) 
	{
		
		try
		{
			basic_id=bean.getSheet_no();
			
			System.out.println("updateNewSheet called basic id==="+basic_id);
			Connection con=Connection_Utility.getConnection();
			
			int uid=0;
			
			HttpSession session=request.getSession();
			
			uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			
			
			
			int chkCust = 0;
			String cust_name = null;
			int maxCustId = 0;
			boolean chkCustFlag = false;
			
			int addNewCust_var=0;
			int addNewCustHist_var=0;
			boolean chkNewCustFlag = false;
			
			if(bean.getNew_customer()!=null)
			{
				PreparedStatement ps_chkNewCustomer = con
						.prepareStatement("select Cust_Id,Cust_Name from Customer_Tbl");
				ResultSet rs_chkNewCustomer = ps_chkNewCustomer.executeQuery();

				while (rs_chkNewCustomer.next()) {
					cust_name = rs_chkNewCustomer.getString("Cust_Name");

					if (cust_name.equalsIgnoreCase(bean.getNew_customer())) 
					{
						chkNewCustFlag = true;
						maxCustId = rs_chkNewCustomer.getInt("Cust_Id");
					}
				}
				rs_chkNewCustomer.close();
				ps_chkNewCustomer.close();
				
				if(chkNewCustFlag==true)
				{
					System.out.println("new customer matched.... maxCustId="+maxCustId);
				}
				else
				{
					PreparedStatement ps_addNewCust =con.prepareStatement("insert into customer_tbl(Cust_Name,Email,created_by)values(?,?,?)");
					ps_addNewCust.setString(1, bean.getNew_customer());
					ps_addNewCust.setString(2, "");
					ps_addNewCust.setInt(3, uid);
					
					addNewCust_var=ps_addNewCust.executeUpdate();
					
					if(addNewCust_var>0)
					{
						
						PreparedStatement ps_getMaxCust = con
								.prepareStatement("select max(Cust_Id) from Customer_Tbl");
						ResultSet rs_getMaxCust = ps_getMaxCust.executeQuery();

						while (rs_getMaxCust.next()) {
							maxCustId = rs_getMaxCust.getInt("max(Cust_Id)");
						}
						rs_getMaxCust.close();
						ps_getMaxCust.close();
						
						System.out.println("New Customer Added....Max Cust Id="+maxCustId);
					}
				}
				
			}
			else
			{
				PreparedStatement ps_chkCustomer = con
						.prepareStatement("select Cust_Id,Cust_Name from Customer_Tbl");
				ResultSet rs_chkCustomer = ps_chkCustomer.executeQuery();

				while (rs_chkCustomer.next()) {
					cust_name = rs_chkCustomer.getString("Cust_Name");

					if (cust_name.equalsIgnoreCase(bean.getCust_name())) {
						chkCustFlag = true;
						maxCustId = rs_chkCustomer.getInt("Cust_Id");

					}
				}
				rs_chkCustomer.close();
				ps_chkCustomer.close();

				if (chkCustFlag == false) {
					System.out.println("customer name not matched...");
					
					PreparedStatement ps_getCustId=con.prepareStatement("select Cust_id from dev_basicinfo_tbl where Basic_Id="+bean.getSheet_no());
					ResultSet rs_getCust_id=ps_getCustId.executeQuery();
					
					while(rs_getCust_id.next())
					{
						maxCustId=rs_getCust_id.getInt("Cust_Id");
					}
					rs_getCust_id.close();
					ps_getCustId.close();
					
					PreparedStatement ps_updateCust = con
							.prepareStatement("update Customer_Tbl set Cust_Name=?,Email=?,created_by=? where Cust_Id="+maxCustId);

					ps_updateCust.setString(1, bean.getCust_name());
					ps_updateCust.setString(2, "");
					ps_updateCust.setInt(3, uid);

					chkCust = ps_updateCust.executeUpdate();

					if (chkCust > 0) {
						System.out.println("customer Id when Cutomer name Updated ==="+ maxCustId);
					}
					
				}
				else 
				{
					System.out.println("customer name matched...");
					System.out.println("customer Id when name matched ==="
							+ maxCustId);
				}
			}
			
			//******************************************************************************************
			// Chk part  and add history... 
			//******************************************************************************************

			int chkPartName = 0;
			String part_name = null;
			int maxPartNameId = 0;
			boolean chkPartNameFlag = false;
			boolean chkNewPartNameFlag = false;
			Date orgDate_PartName=null;
		
			if(bean.getNew_part_name()!=null)
			{
				PreparedStatement ps_chkPartName = con
						.prepareStatement("select partName_id,Part_Name from cs_part_Name_tbl");
				ResultSet rs_chkPartName = ps_chkPartName.executeQuery();

				while (rs_chkPartName.next()) 
				{
					part_name = rs_chkPartName.getString("Part_Name");

					if (part_name.equalsIgnoreCase(bean.getNew_part_name())) 
					{
						chkNewPartNameFlag = true;
						maxPartNameId = rs_chkPartName.getInt("PartName_Id");
					}
				}
				if (chkNewPartNameFlag == true) 
				{
					System.out.println("part name matched...");
					System.out.println("part name id ... " + maxPartNameId);
				}
				else
				{
					PreparedStatement ps_addPartName = con
							.prepareStatement("insert into cs_part_name_tbl(Part_Name,Created_By,Created_Date,Enable_Id)values(?,?,?,?)");
					ps_addPartName.setString(1, bean.getNew_part_name());
					ps_addPartName.setInt(2, uid);
					ps_addPartName.setDate(3, curr_Date);
					ps_addPartName.setInt(4, 1);

					chkPartName = ps_addPartName.executeUpdate();

					if (chkPartName > 0) 
					{
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
						ps_addPartName_Hist.setString(2, bean.getNew_part_name());
						ps_addPartName_Hist.setInt(3, uid);
						ps_addPartName_Hist.setDate(4, curr_Date);
						ps_addPartName_Hist.setDate(5, curr_Date);
						ps_addPartName_Hist.setInt(6, 1);
						int i = 0;

						i = ps_addPartName_Hist.executeUpdate();

						if (i > 0) 
						{
								System.out.println("new part name added with history......part name id="+maxPartNameId);
							
						}
					}
				}

			}
			else
			{
				PreparedStatement ps_chkPartName = con
						.prepareStatement("select partName_id,Part_Name from cs_part_Name_tbl");
				ResultSet rs_chkPartName = ps_chkPartName.executeQuery();

				while (rs_chkPartName.next()) {
					part_name = rs_chkPartName.getString("Part_Name");

					if (part_name.equalsIgnoreCase(bean.getPart_name())) {
						chkPartNameFlag = true;
						maxPartNameId = rs_chkPartName.getInt("PartName_Id");
					}
				}
				if (chkPartNameFlag == true) 
				{
					System.out.println("part name matched...");
					System.out.println("part name id ... " + maxPartNameId);
				}
				else 
				{
					PreparedStatement ps_getPartNameId=con.prepareStatement("select PartName_Id from dev_basicinfo_tbl where Basic_Id="+bean.getSheet_no());
					ResultSet rs_getPartNameId=ps_getPartNameId.executeQuery();
					
					while(rs_getPartNameId.next())
					{
						maxPartNameId=rs_getPartNameId.getInt("PartName_Id");
					}
					rs_getPartNameId.close();
					ps_getPartNameId.close();
					
					PreparedStatement ps_getPartNameDate=con.prepareStatement("select created_date from cs_part_name_tbl where PartName_Id="+maxPartNameId);
					ResultSet rs_getPartNameDate=ps_getPartNameDate.executeQuery();
					
					while(rs_getPartNameDate.next())
					{
						orgDate_PartName=rs_getPartNameDate.getDate("created_date");
					}
					rs_getPartNameDate.close();
					ps_getPartNameDate.close();
					
					
					PreparedStatement ps_updatePartName = con
							.prepareStatement("update cs_part_name_tbl set Part_Name=?,Created_By=?,Created_Date=?,Enable_Id=? where PartName_Id="+maxPartNameId);
					ps_updatePartName.setString(1, bean.getPart_name());
					ps_updatePartName.setInt(2, uid);
					ps_updatePartName.setDate(3, curr_Date);
					ps_updatePartName.setInt(4, 1);

					chkPartName = ps_updatePartName.executeUpdate();

					if (chkPartName > 0) 
					{
						
							PreparedStatement ps_addPartName_Hist = con
								.prepareStatement("insert into cs_part_name_tbl_hist(PartName_Id,Part_Name,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?)");

						ps_addPartName_Hist.setInt(1, maxPartNameId);
						ps_addPartName_Hist.setString(2, bean.getPart_name());
						ps_addPartName_Hist.setInt(3, uid);
						ps_addPartName_Hist.setDate(4, curr_Date);
						ps_addPartName_Hist.setDate(5, orgDate_PartName);
						ps_addPartName_Hist.setInt(6, 1);
						int i = 0;

						i = ps_addPartName_Hist.executeUpdate();

						if (i > 0) {
							System.out.println("Part name not matched....its updated....");
							System.out.println("part name id...." + maxPartNameId);

						}
					}
				}

			}
			int CPRel_Count=0;
			
			PreparedStatement ps_chkCustPartRel=con.prepareStatement("select count(CP_Rel_Id) from cs_cust_partname_rel_tbl where Cust_ID="+maxCustId+" and PartName_Id="+maxPartNameId);
			ResultSet rs_chkCustPartRel=ps_chkCustPartRel.executeQuery();
			while(rs_chkCustPartRel.next())
			{
				CPRel_Count=rs_chkCustPartRel.getInt("count(CP_Rel_Id)");
			}
			
			if(CPRel_Count==0)
			{
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
			else
			{
				System.out.println("Customer-part name relation already available....");
			}
			
			//******************************************************************************************
			// Chk part No 
			//******************************************************************************************
			
			int chkPartNo = 0;
			int chkPartNo_Hist = 0;
			String part_no = null;
			int maxPartNoId = 0;
			boolean chkPartNoFlag = false;
			
			boolean chkNewPartNoFlag = false;
			Date orgDate_PartNo=null;
			
			int updatePartNo_var=0;
			int addHistPartNo_var=0;
			
			if(bean.getNew_part_no()!=null)
			{
				PreparedStatement ps_chkPartNo = con
						.prepareStatement("select PartNo_Id,Part_No from cs_part_no_tbl");
				ResultSet rs_chkPartNo = ps_chkPartNo.executeQuery();

				while (rs_chkPartNo.next()) 
				{
					part_no = rs_chkPartNo.getString("Part_no");

					if (part_no.equalsIgnoreCase(bean.getNew_part_no())) 
					{
						chkNewPartNoFlag = true;
						maxPartNoId = rs_chkPartNo.getInt("PartNo_Id");
					}
				}
				rs_chkPartNo.close();
				ps_chkPartNo.close();

				if (chkNewPartNoFlag == true) 
				{
					System.out.println("part no matched...");
					System.out.println("Max part no id.. :" + maxPartNoId);
				} else 
				{
					System.out.println("part no not matched...");
					
					PreparedStatement ps_addPartNo = con.prepareStatement("insert into cs_part_no_tbl(Part_No,PartName_Id,Created_By,Created_Date,Enable_Id)values(?,?,?,?,?)");

					ps_addPartNo.setString(1, bean.getNew_part_no());
					ps_addPartNo.setInt(2, maxPartNameId);
					ps_addPartNo.setInt(3, uid);
					ps_addPartNo.setDate(4, curr_Date);
					ps_addPartNo.setInt(5, 1);

					chkPartNo = ps_addPartNo.executeUpdate();

					if (chkPartNo > 0) 
					{
						PreparedStatement ps_getMaxPartNoId = con.prepareStatement("select max(PartNo_Id) from cs_part_no_tbl");
						ResultSet rs_getMaxPartNoId = ps_getMaxPartNoId.executeQuery();

						while (rs_getMaxPartNoId.next())
						{
							maxPartNoId = rs_getMaxPartNoId.getInt("max(PartNo_Id)");
						}

						System.out.println("Part no not matched ...");
						System.out.println("max part no id..." + maxPartNoId);

						PreparedStatement ps_addPartNo_Hist = con.prepareStatement("insert into cs_part_no_tbl_hist(PartNo_Id,Part_No,PartName_Id,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
						ps_addPartNo_Hist.setInt(1, maxPartNoId);
						ps_addPartNo_Hist.setString(2, bean.getNew_part_no());
						ps_addPartNo_Hist.setInt(3, maxPartNameId);
						ps_addPartNo_Hist.setInt(4, uid);
						ps_addPartNo_Hist.setDate(5, curr_Date);
						ps_addPartNo_Hist.setDate(6, curr_Date);
						ps_addPartNo_Hist.setInt(7, 1);

						chkPartNo_Hist = ps_addPartNo_Hist.executeUpdate();

						if (chkPartNo_Hist > 0) 
						{
							int regPartNo_Id=0;
							PreparedStatement ps_getPartNo_IdFromBasic=con.prepareStatement("select PartNo_Id from dev_basicinfo_tbl where Basic_Id="+bean.getSheet_no());
							ResultSet rs_getPartNo_IdFromBasic=ps_getPartNo_IdFromBasic.executeQuery();
							while(rs_getPartNo_IdFromBasic.next())
							{
								regPartNo_Id=rs_getPartNo_IdFromBasic.getInt("PartNo_Id");
							}
							System.out.println("already registered part no in activity sheet...."+regPartNo_Id);
							Date orgDate_PartPhoto=null;
							int orgId_partPhoto=0;
							InputStream orgAttach_PartPhoto=null;
							String orgFile_PartPhoto=null;
							
							
							PreparedStatement ps_getPartPhoto_Id=con.prepareStatement("select * from dev_partno_photo_tbl where PartNo_Id="+regPartNo_Id);
							ResultSet rs_getPartPhoto_Id=ps_getPartPhoto_Id.executeQuery();
							
							while(rs_getPartPhoto_Id.next())
							{
								orgId_partPhoto=rs_getPartPhoto_Id.getInt("part_photo_id");
								//orgDate_PartPhoto=rs_getPartPhoto_Id.getDate("created_date");
								//orgAttach_PartPhoto=(InputStream) rs_getPartPhoto_Id.getBlob("attachment");
								//orgFile_PartPhoto=rs_getPartPhoto_Id.getString("file_name");
							}
							System.out.println("part photo registered id===="+orgId_partPhoto);
								PreparedStatement ps_UpdatePartPhoto=con.prepareStatement("update dev_partno_photo_tbl set partno_id=?,created_by=?,created_date=?,Enable_id=? where part_photo_id="+orgId_partPhoto);
								ps_UpdatePartPhoto.setInt(1, maxPartNoId);
								ps_UpdatePartPhoto.setInt(2, uid);
								ps_UpdatePartPhoto.setDate(3, curr_Date);
								ps_UpdatePartPhoto.setInt(4, 1);
								
								int i=ps_UpdatePartPhoto.executeUpdate();
								
								if(i>0)
								{
//									PreparedStatement ps_addPartPhotoHist=con.prepareStatement("insert into dev_partno_photo_tbl_hist(part_photo_id,attachment,file_name,created_by,created_date,created_date_hist,partno_id,Enable_Id)values(?,?,?,?,?,?,?,?)");
//									
//									ps_addPartPhotoHist.setInt(1,orgId_partPhoto);
//									ps_addPartPhotoHist.setBlob(2, orgAttach_PartPhoto);
//									ps_addPartPhotoHist.setString(3, orgFile_PartPhoto);
//									ps_addPartPhotoHist.setInt(4, uid);
//									ps_addPartPhotoHist.setDate(5, curr_Date);
//									ps_addPartPhotoHist.setDate(6, orgDate_PartPhoto);
//									ps_addPartPhotoHist.setInt(7, maxPartNoId);
//									ps_addPartPhotoHist.setInt(8, 1);
//									
//									int j=ps_addPartPhotoHist.executeUpdate();
									
//									if(j>0)
//									{
//										System.out.println("Part no photo updated.....");
//									}
									
										System.out.println("Part no photo updated.....");
								}
							
							
							
							System.out.println("Part no history added....");
						}

					}

				}
			}
			else //bean.getNew_part_no()==null
			{
				PreparedStatement ps_chkPartNo = con
						.prepareStatement("select PartNo_Id,Part_No from cs_part_no_tbl");
				ResultSet rs_chkPartNo = ps_chkPartNo.executeQuery();

				while (rs_chkPartNo.next()) 
				{
					part_no = rs_chkPartNo.getString("Part_no");

					if (part_no.equalsIgnoreCase(bean.getPart_no())) 
					{
						chkPartNoFlag = true;
						maxPartNoId = rs_chkPartNo.getInt("PartNo_Id");
					}
				}
				rs_chkPartNo.close();
				ps_chkPartNo.close();
				
				if(chkPartNoFlag==true)
				{
					System.out.println("Part no matched....part no id="+maxPartNoId);
				}
				else
				{
					PreparedStatement ps_getPartNo_Id=con.prepareStatement("select PartNo_Id from dev_basicinfo_tbl where Basic_Id="+bean.getSheet_no());
					ResultSet rs_getPartNo_Id=ps_getPartNo_Id.executeQuery();
					
					while(rs_getPartNo_Id.next())
					{
						maxPartNoId=rs_getPartNo_Id.getInt("PartNo_Id");
					}
					rs_getPartNo_Id.close();
					ps_getPartNo_Id.close();
					
					PreparedStatement ps_getOrgDate_PartNo=con.prepareStatement("select created_date from cs_part_no_tbl where PartNo_Id="+maxPartNoId);
					ResultSet rs_getOrgDate_PartNo=ps_getOrgDate_PartNo.executeQuery();
					
					while(rs_getOrgDate_PartNo.next())
					{
						orgDate_PartNo=rs_getOrgDate_PartNo.getDate("created_date");
					}
					rs_getOrgDate_PartNo.close();
					ps_getOrgDate_PartNo.close();
						
					PreparedStatement ps_UpdatePartNo=con.prepareStatement("update cs_part_no_tbl set Part_No=?,PartName_Id=?,Created_By=?,Created_Date=?,Enable_Id=? where PartNo_Id="+maxPartNoId);
					
					ps_UpdatePartNo.setString(1, bean.getPart_no());
					ps_UpdatePartNo.setInt(2, maxPartNameId);
					ps_UpdatePartNo.setInt(3, uid);
					ps_UpdatePartNo.setDate(4, curr_Date);
					ps_UpdatePartNo.setInt(5, 1);
					
					updatePartNo_var=ps_UpdatePartNo.executeUpdate();
					
					if(updatePartNo_var>0)
					{
						PreparedStatement ps_addHistPartNo=con.prepareStatement("insert into cs_part_no_tbl_hist(PartNo_Id,Part_No,PartName_Id,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
								
						ps_addHistPartNo.setInt(1, maxPartNoId);
						ps_addHistPartNo.setString(2, bean.getPart_no());
						ps_addHistPartNo.setInt(3, maxPartNameId);
						ps_addHistPartNo.setInt(4, uid);
						ps_addHistPartNo.setDate(5, curr_Date);
						ps_addHistPartNo.setDate(6, orgDate_PartNo);
						ps_addHistPartNo.setInt(7, 1);
						
						addHistPartNo_var=ps_addHistPartNo.executeUpdate();
						
						if(addHistPartNo_var>0)
						{
							
							
							System.out.println("Part no updated and history added..... max part no id="+maxPartNoId);
						}
					}
				}

			}
			
			
			//******************************************************************************************
			// Chk grade and add history... 
			//******************************************************************************************


			
			int addGrade_var = 0;
			int addGradeHist_var = 0;
			//String grade = null;
			int maxGrade_Id = 0;
			
			boolean chkGradeFlag = false;
			boolean chkNewGradeFlag = false;
			
			Date orgDate_Grade=null;
			
			int updateGrade_var=0;
			int addUpdateGradeHist_var=0;
			
			if(bean.getNew_grade_type()!=null)
			{
				PreparedStatement ps_chkGrade=con.prepareStatement("select Grade_Id,Grade_Name from cs_grade_mst_tbl");
				ResultSet rs_ChkGrade=ps_chkGrade.executeQuery();
				
				while(rs_ChkGrade.next())
				{
					if(bean.getNew_grade_type().equals(rs_ChkGrade.getString("Grade_Name")))
					{
						maxGrade_Id=rs_ChkGrade.getInt("Grade_Id");
						chkNewGradeFlag=true;
					}
				}
				rs_ChkGrade.close();
				ps_chkGrade.close();
				
				if(chkNewGradeFlag==true)
				{
					System.out.println("Grade name matched....grade id="+maxGrade_Id);
				}
				else
				{
					PreparedStatement ps_addGrade=con.prepareStatement("insert into cs_grade_mst_tbl(Grade_Name,Created_By,Created_Date,Enable_id)values(?,?,?,?)");
					
					ps_addGrade.setString(1, bean.getNew_grade_type());
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
						ps_addGradeHist.setString(2, bean.getNew_grade_type());
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
				
			}
			else
			{
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

				rs_ChkGrade.close();
				ps_chkGrade.close();

				
				if(chkGradeFlag==true)
				{
					System.out.println("Grade Name Matched...Grade id is="+maxGrade_Id);
				}
				else
				{
					PreparedStatement ps_getGradeId=con.prepareStatement("select Grade_Id from dev_basicinfo_tbl where basic_id="+bean.getSheet_no());
					ResultSet rs_getGradeId=ps_getGradeId.executeQuery();
					
					while(rs_getGradeId.next())
					{
						maxGrade_Id=rs_getGradeId.getInt("Grade_Id");
					}
					rs_getGradeId.close();
					ps_getGradeId.close();
					
					PreparedStatement ps_getOrgDate_Grade=con.prepareStatement("select Created_Date from cs_grade_mst_tbl where Grade_id="+maxGrade_Id);
					ResultSet rs_getOrgDate_Grade=ps_getOrgDate_Grade.executeQuery();
					
					while(rs_getOrgDate_Grade.next())
					{
						orgDate_Grade=rs_getOrgDate_Grade.getDate("Created_Date");
					}
					rs_getOrgDate_Grade.close();
					ps_getOrgDate_Grade.close();
					
					PreparedStatement ps_UpdateGrade=con.prepareStatement("update cs_grade_mst_tbl set Grade_Name=?,Created_By=?,Created_Date=?,Enable_id=? where Grade_id="+maxGrade_Id);
					ps_UpdateGrade.setString(1, bean.getGrade_type());
					ps_UpdateGrade.setInt(2,uid);
					ps_UpdateGrade.setDate(3, curr_Date);
					ps_UpdateGrade.setInt(4,1);
					
					updateGrade_var=ps_UpdateGrade.executeUpdate();
					
					if(updateGrade_var>0)
					{
						PreparedStatement ps_addGradeHist=con.prepareStatement("insert into cs_grade_mst_tbl_hist(Grade_Id,Grade_Name,Created_By,Created_Date,Created_Date_Hist,Enable_id)values(?,?,?,?,?,?)");
						
						ps_addGradeHist.setInt(1, maxGrade_Id);
						ps_addGradeHist.setString(2, bean.getGrade_type());
						ps_addGradeHist.setInt(3, uid);
						ps_addGradeHist.setDate(4, curr_Date);
						ps_addGradeHist.setDate(5, orgDate_Grade);
						ps_addGradeHist.setInt(6, 1);
						
						addUpdateGradeHist_var=ps_addGradeHist.executeUpdate();
						
						if(addUpdateGradeHist_var>0)
						{
							System.out.println("Grade type is update and history added... max Grade id="+maxGrade_Id);
						}
					}
				}
		 }
			//*******************************************************************************
			//  update plant vendor
			//*******************************************************************************
			int addPV_var = 0;
			int addPVHist_var = 0;
			//String grade = null;
			int maxPV_Id = 0;
			
			boolean chkPVFlag = false;
			boolean chkNewPVFlag = false;
			
			Date orgDate_PV=null;
			
			int updatePV_var=0;
			int addUpdatePVHist_var=0;
			
			int PV_Basic_Rel_Counter=0;
			
			int PV_Basic_Rel_Id=0;
			Date OrgDate_PV_Basic_Rel=null;
			
			int PV_Basic_Rel_var=0;
			int PV_Basic_RelHist_var=0;
			
			if(bean.getNew_plant_vendor()!=null)
			{
				PreparedStatement ps_chkPV=con.prepareStatement("select plantvendor_id,plantvendor_name from dev_plantvendor_tbl");
				ResultSet rs_chkPV=ps_chkPV.executeQuery();
				
				while(rs_chkPV.next())
				{
					if(bean.getNew_plant_vendor().equalsIgnoreCase(rs_chkPV.getString("plantvendor_name")))
					{
						maxPV_Id=rs_chkPV.getInt("plantvendor_id");
						chkNewPVFlag=true;
					}
				}
				//rs_chkPV.close();
				//ps_chkPV.close();
			
			
				if(chkNewPVFlag==true)
				{
					System.out.println("plant vendor name matched... plant vendor id=="+maxPV_Id);
				}
				else
				{
					PreparedStatement ps_addNewPV=con.prepareStatement("insert into dev_plantvendor_tbl(plantvendor_name,created_by,Enable_Id,created_date)values(?,?,?,?)");
					
					ps_addNewPV.setString(1, bean.getNew_plant_vendor());
					ps_addNewPV.setInt(2, uid);
					ps_addNewPV.setInt(3, 1);
					ps_addNewPV.setDate(4, curr_Date);
					
					addPV_var=ps_addNewPV.executeUpdate();
					
					if(addPV_var>0)
					{
						PreparedStatement ps_getMaxPV_Id=con.prepareStatement("select max(plantvendor_id) from dev_plantvendor_tbl");
						ResultSet rs_getMaxPV_Id=ps_getMaxPV_Id.executeQuery();
						
						while(rs_getMaxPV_Id.next())
						{
							maxPV_Id=rs_getMaxPV_Id.getInt("max(plantvendor_id)");
						}
						//rs_getMaxPV_Id.close();
						//ps_getMaxPV_Id.close();
						
						PreparedStatement ps_addPV_Hist=con.prepareStatement("insert into dev_plantvendor_tbl_hist(plantvendor_id,created_by,Enable_Id,created_date,created_date_hist,plantvendor_name)values(?,?,?,?,?,?)");
						ps_addPV_Hist.setInt(1, maxPV_Id);
						ps_addPV_Hist.setInt(2, uid);
						ps_addPV_Hist.setInt(3, 1);
						ps_addPV_Hist.setDate(4,curr_Date);
						ps_addPV_Hist.setDate(5,curr_Date);
						ps_addPV_Hist.setString(6, bean.getNew_plant_vendor());
						
						addPVHist_var=ps_addPV_Hist.executeUpdate();
						
						if(addPVHist_var>0)
						{
							
							System.out.println("New Plant vendor is added with history....");
						}
					}
				
				}
			}
			else //if(bean.getNew_plant_vendor()==null)
			{
				/*PreparedStatement ps_chkPV=con.prepareStatement("select plantvendor_id,plantvendor_name from dev_plantvendor_tbl");
				ResultSet rs_chkPV=ps_chkPV.executeQuery();
				
				while(rs_chkPV.next())
				{
					if(bean.getPV_name().equalsIgnoreCase(rs_chkPV.getString("plantvendor_name")))
					{
						maxPV_Id=rs_chkPV.getInt("plantvendor_id");*/
						chkPVFlag=true;
				/*	}
				}*/
				//rs_chkPV.close();
				//ps_chkPV.close();
			}
			
				if(chkPVFlag==true)
				{
					System.out.println("plant vendor name matched or not available... plant vendor id=="+maxPV_Id);
				}
				else
				{
					System.out.println("in loop");
					PreparedStatement ps_getmaxPVID=con.prepareStatement("select PlantVendor_Id from dev_basic_plantvendor_rel_tbl where basic_id="+bean.getSheet_no());
					ResultSet rs_getmaxPVID=ps_getmaxPVID.executeQuery();
					
					while(rs_getmaxPVID.next())
					{
						maxPV_Id=rs_getmaxPVID.getInt("PlantVendor_Id");
					}
					
					
//					PreparedStatement ps_abc=con.prepareStatement("select * from dev_basic_plantvendor_rel_tbl where Basic_Id="+bean.getSheet_no());
//					ResultSet rs_abc=ps_abc.executeQuery();
//					while(rs_abc.next());
//					{
//						maxPV_Id=rs_abc.getInt("PlantVendor_Id");
//					}
//					System.out.println("Max COunt == " + maxPV_Id);
				//	rs_getMaxPVId1.close();
				//	ps_getMaxPVId.close();
					
					PreparedStatement ps_updatePV=con.prepareStatement("update dev_plantvendor_tbl set plantvendor_name=?,created_by=?,Enable_Id=?,created_date=? where PlantVendor_Id="+maxPV_Id);
					
					ps_updatePV.setString(1, bean.getPV_name());
					ps_updatePV.setInt(2, uid);
					ps_updatePV.setInt(3, 1);
					ps_updatePV.setDate(4, curr_Date);
					
					addPV_var=ps_updatePV.executeUpdate();
					
					if(addPV_var>0)
					{
						PreparedStatement ps_addPV_Hist=con.prepareStatement("insert into dev_plantvendor_tbl_hist(plantvendor_id,created_by,Enable_Id,created_date,created_date_hist,plantvendor_name)values(?,?,?,?,?,?)");
						ps_addPV_Hist.setInt(1, maxPV_Id);
						ps_addPV_Hist.setInt(2, uid);
						ps_addPV_Hist.setInt(3, 1);
						ps_addPV_Hist.setDate(4,curr_Date);
						ps_addPV_Hist.setDate(5,curr_Date);
						ps_addPV_Hist.setString(6, bean.getPV_name());
						
						addPVHist_var=ps_addPV_Hist.executeUpdate();
						
						if(addPVHist_var>0)
						{
								
							System.out.println("New Plant vendor is added with history....");
							
							PreparedStatement ps_getPV_Basic_Counter=con.prepareStatement("select count(BVP_Rel_Id) from dev_basic_plantvendor_rel_tbl where basic_id="+bean.getSheet_no());
							ResultSet rs_getPV_Basic_Counter=ps_getPV_Basic_Counter.executeQuery();
							
							while(rs_getPV_Basic_Counter.next())
							{
								PV_Basic_Rel_Counter=rs_getPV_Basic_Counter.getInt("count(BVP_Rel_Id)");
							}
							rs_getPV_Basic_Counter.close();
							ps_getPV_Basic_Counter.close();
							
							
							if(PV_Basic_Rel_Counter>0)
							{
								PreparedStatement ps_getPV_Basic_Details=con.prepareStatement("select BVP_Rel_Id,Created_Date from dev_basic_plantvendor_rel_tbl where basic_id="+bean.getSheet_no());
								ResultSet rs_getPV_Basic_Details=ps_getPV_Basic_Details.executeQuery();
								
								while(rs_getPV_Basic_Details.next())
								{
									PV_Basic_Rel_Id=rs_getPV_Basic_Details.getInt("BVP_Rel_Id");
									OrgDate_PV_Basic_Rel=rs_getPV_Basic_Details.getDate("Created_Date");
								}
								rs_getPV_Basic_Details.close();
								ps_getPV_Basic_Details.close();
								
								PreparedStatement ps_UpdatePV_Basic_Rel=con.prepareStatement("update dev_basic_plantvendor_rel_tbl set PlantVendor_Id=?,Created_By=?,Created_Date=?,enable_id=? where basic_id="+bean.getSheet_no()+" and BVP_Rel_Id="+PV_Basic_Rel_Id);
								
								ps_UpdatePV_Basic_Rel.setInt(1, maxPV_Id);
								ps_UpdatePV_Basic_Rel.setInt(2, uid);
								ps_UpdatePV_Basic_Rel.setDate(3, curr_Date);
								ps_UpdatePV_Basic_Rel.setInt(4, 1);
								
								PV_Basic_Rel_var=ps_UpdatePV_Basic_Rel.executeUpdate();
								
								if(PV_Basic_Rel_var>0)
								{
									PreparedStatement ps_addPVBasicRel_Hist=con.prepareStatement("insert into dev_basic_plantvendor_rel_tbl_hist(BVP_Rel_Id,PlantVendor_Id,Basic_Id,Created_by,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
									ps_addPVBasicRel_Hist.setInt(1, PV_Basic_Rel_Id);
									ps_addPVBasicRel_Hist.setInt(2, maxPV_Id);
									ps_addPVBasicRel_Hist.setInt(3, bean.getSheet_no());
									ps_addPVBasicRel_Hist.setInt(4, uid);
									ps_addPVBasicRel_Hist.setDate(5, curr_Date);
									ps_addPVBasicRel_Hist.setDate(6, OrgDate_PV_Basic_Rel);
									ps_addPVBasicRel_Hist.setInt(7, 1);
									
									PV_Basic_RelHist_var=ps_addPVBasicRel_Hist.executeUpdate();
									
									if(PV_Basic_RelHist_var>0)
									{
										System.out.println("PLant vendor relation is updated and history added.....");
									}
									
								}
							}
							else
							{
								PreparedStatement ps_addPVBasic_Rel=con.prepareStatement("insert into dev_basic_plantvendor_rel_tbl(PlantVendor_Id,Basic_Id,Created_By,Created_Date,Enable_Id)values(?,?,?,?,?)");
								
								ps_addPVBasic_Rel.setInt(1, maxPV_Id);
								ps_addPVBasic_Rel.setInt(2, bean.getSheet_no());
								ps_addPVBasic_Rel.setInt(3, uid);
								ps_addPVBasic_Rel.setDate(4, curr_Date);
								ps_addPVBasic_Rel.setInt(5, 1);
								
								PV_Basic_Rel_var=ps_addPVBasic_Rel.executeUpdate();
								
								if(PV_Basic_Rel_var>0)
								{
									PreparedStatement ps_getBasic_PVMaxRel_Id=con.prepareStatement("select max(BVP_Rel_Id) from dev_basic_plantvendor_rel_tbl");
									
									ResultSet rs_getBasic_PVMaxRel_Id=ps_getBasic_PVMaxRel_Id.executeQuery();
									while(rs_getBasic_PVMaxRel_Id.next())
									{
										PV_Basic_Rel_Id=rs_getBasic_PVMaxRel_Id.getInt("max(BVP_Rel_Id)");
									}
									rs_getBasic_PVMaxRel_Id.close();
									ps_getBasic_PVMaxRel_Id.close();
									
									PreparedStatement ps_addPVBasicRel_Hist=con.prepareStatement("insert into dev_basic_plantvendor_rel_tbl_hist(BVP_Rel_Id,PlantVendor_Id,Basic_Id,Created_by,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
									ps_addPVBasicRel_Hist.setInt(1, PV_Basic_Rel_Id);
									ps_addPVBasicRel_Hist.setInt(2, maxPV_Id);
									ps_addPVBasicRel_Hist.setInt(3, bean.getSheet_no());
									ps_addPVBasicRel_Hist.setInt(4, uid);
									ps_addPVBasicRel_Hist.setDate(5, curr_Date);
									ps_addPVBasicRel_Hist.setDate(6, curr_Date);
									ps_addPVBasicRel_Hist.setInt(7, 1);
									
									PV_Basic_RelHist_var=ps_addPVBasicRel_Hist.executeUpdate();
									
									if(PV_Basic_RelHist_var>0)
									{
										System.out.println("PLant vendor relation is updated and history added.....");
									}
								}
								
							}
							
						}
					}
				}
							//System.out.println("New Plant vendor is added with history....");
	
			
			
					
			
			
					//*******************************************************************************
					//  update casting vendor
					//*******************************************************************************
					int addCV_var = 0;
					int addCVHist_var = 0;
					//String grade = null;
					int maxCV_Id = 0;
					
					boolean chkCVFlag = false;
					boolean chkNewCVFlag = false;
					
					Date orgDate_CV=null;
					
					int updateCV_var=0;
					int addUpdateCVHist_var=0;
					
					int CV_Basic_Rel_Counter=0;
					
					int CV_Basic_Rel_Id=0;
					Date OrgDate_CV_Basic_Rel=null;
					
					int CV_Basic_Rel_var=0;
					int CV_Basic_RelHist_var=0;
					
					if(bean.getNew_casting_vendor()!=null)
					{
						PreparedStatement ps_chkCV=con.prepareStatement("select castingvendor_id,castingvendor_name from dev_castingvendor_tbl");
						ResultSet rs_chkCV=ps_chkCV.executeQuery();
						
						while(rs_chkCV.next())
						{
							if(bean.getNew_casting_vendor().equalsIgnoreCase(rs_chkCV.getString("castingvendor_name")))
							{
								maxCV_Id=rs_chkCV.getInt("castingvendor_id");
								chkNewCVFlag=true;
							}
						}
						rs_chkCV.close();
						ps_chkCV.close();
					
					
						if(chkNewCVFlag==true)
						{
							System.out.println("casting vendor name matched... Casting vendor id=="+maxCV_Id);
						}
						else
						{
							PreparedStatement ps_addNewCV=con.prepareStatement("insert into dev_castingvendor_tbl(castingvendor_name,created_by,Enable_Id,created_date)values(?,?,?,?)");
							
							ps_addNewCV.setString(1, bean.getNew_casting_vendor());
							ps_addNewCV.setInt(2, uid);
							ps_addNewCV.setInt(3, 1);
							ps_addNewCV.setDate(4, curr_Date);
							
							addCV_var=ps_addNewCV.executeUpdate();
							
							if(addCV_var>0)
							{
								PreparedStatement ps_getMaxCV_Id=con.prepareStatement("select max(castingvendor_id) from dev_castingvendor_tbl");
								ResultSet rs_getMaxCV_Id=ps_getMaxCV_Id.executeQuery();
								
								while(rs_getMaxCV_Id.next())
								{
									maxCV_Id=rs_getMaxCV_Id.getInt("max(castingvendor_id)");
								}
							//	rs_getMaxCV_Id.close();
							//	ps_getMaxCV_Id.close();
								
								PreparedStatement ps_addCV_Hist=con.prepareStatement("insert into dev_castingvendor_tbl_hist(castingvendor_id,created_by,Enable_Id,created_date,created_date_hist,castingvendor_name)values(?,?,?,?,?,?)");
								ps_addCV_Hist.setInt(1, maxCV_Id);
								ps_addCV_Hist.setInt(2, uid);
								ps_addCV_Hist.setInt(3, 1);
								ps_addCV_Hist.setDate(4,curr_Date);
								ps_addCV_Hist.setDate(5,curr_Date);
								ps_addCV_Hist.setString(6, bean.getNew_casting_vendor());
								
								addCVHist_var=ps_addCV_Hist.executeUpdate();
								
								if(addCVHist_var>0)
								{
										
									System.out.println("New Casting vendor is added with history....");
									
									
								}
							}
						
						}
					}
					else //if(bean.getNew_casting_vendor()==null)
					{
						/*PreparedStatement ps_chkCV=con.prepareStatement("select castingvendor_id,castingvendor_name from dev_castingvendor_tbl");
						ResultSet rs_chkCV=ps_chkCV.executeQuery();
						
						while(rs_chkCV.next())
						{
							if(bean.getCV_name().equalsIgnoreCase(rs_chkCV.getString("castingvendor_name")))
							{
								maxCV_Id=rs_chkCV.getInt("castingvendor_id");*/
								chkCVFlag=true;
						/*	}
						}
						rs_chkCV.close();
						ps_chkCV.close();*/
					}
					
						if(chkCVFlag==true)
						{
							System.out.println("casting vendor name matched or not available... casting vendor id=="+maxCV_Id);
						}
						else
						{
							
							PreparedStatement ps_getMaxCastVendor=con.prepareStatement("select * from dev_basic_castingvendor_rel_tbl where Basic_id="+bean.getSheet_no());
							ResultSet rs_getMaxCastVendor=ps_getMaxCastVendor.executeQuery();
							while(rs_getMaxCastVendor.next())
							{
								maxCV_Id=rs_getMaxCastVendor.getInt("CastingVendor_Id");
							}

						
							PreparedStatement ps_updateCV=con.prepareStatement("update dev_castingvendor_tbl set castingvendor_name=?,created_by=?,Enable_Id=?,created_date=? where castingvendor_id="+maxCV_Id);
							
							ps_updateCV.setString(1, bean.getCV_name());
							ps_updateCV.setInt(2, uid);
							ps_updateCV.setInt(3, 1);
							ps_updateCV.setDate(4, curr_Date);
							
							addCV_var=ps_updateCV.executeUpdate();
							
							if(addCV_var>0)
							{
								PreparedStatement ps_addCV_Hist=con.prepareStatement("insert into dev_castingvendor_tbl_hist(castingvendor_id,created_by,Enable_Id,created_date,created_date_hist,castingvendor_name)values(?,?,?,?,?,?)");
								ps_addCV_Hist.setInt(1, maxCV_Id);
								ps_addCV_Hist.setInt(2, uid);
								ps_addCV_Hist.setInt(3, 1);
								ps_addCV_Hist.setDate(4,curr_Date);
								ps_addCV_Hist.setDate(5,curr_Date);
								ps_addCV_Hist.setString(6, bean.getCV_name());
								
								addCVHist_var=ps_addCV_Hist.executeUpdate();
								
								if(addCVHist_var>0)
								{
										
									System.out.println("New casting vendor is added with history.... 1");
									
									PreparedStatement ps_getCV_Basic_Counter=con.prepareStatement("select count(BCV_Rel_Id) from dev_basic_castingvendor_rel_tbl where basic_id="+bean.getSheet_no());
									ResultSet rs_getCV_Basic_Counter=ps_getCV_Basic_Counter.executeQuery();
									
									while(rs_getCV_Basic_Counter.next())
									{
										CV_Basic_Rel_Counter=rs_getCV_Basic_Counter.getInt("count(BCV_Rel_Id)");
									}
									rs_getCV_Basic_Counter.close();
									ps_getCV_Basic_Counter.close();
									
									
									if(CV_Basic_Rel_Counter>0)
									{
										PreparedStatement ps_getCV_Basic_Details=con.prepareStatement("select BCV_Rel_Id,Created_Date from dev_basic_castingvendor_rel_tbl where basic_id="+bean.getSheet_no());
										ResultSet rs_getCV_Basic_Details=ps_getCV_Basic_Details.executeQuery();
										
										while(rs_getCV_Basic_Details.next())
										{
											CV_Basic_Rel_Id=rs_getCV_Basic_Details.getInt("BCV_Rel_Id");
											OrgDate_CV_Basic_Rel=rs_getCV_Basic_Details.getDate("Created_Date");
										}
										rs_getCV_Basic_Details.close();
										ps_getCV_Basic_Details.close();
										
										PreparedStatement ps_UpdateCV_Basic_Rel=con.prepareStatement("update dev_basic_castingvendor_rel_tbl set CastingVendor_Id=?,Created_By=?,Created_Date=?,enable_id=? where basic_id="+bean.getSheet_no());
										
										ps_UpdateCV_Basic_Rel.setInt(1, maxCV_Id);
										ps_UpdateCV_Basic_Rel.setInt(2, uid);
										ps_UpdateCV_Basic_Rel.setDate(3, curr_Date);
										ps_UpdateCV_Basic_Rel.setInt(4, 1);
										
										CV_Basic_Rel_var=ps_UpdateCV_Basic_Rel.executeUpdate();
										
										if(CV_Basic_Rel_var>0)
										{
											PreparedStatement ps_addCVBasicRel_Hist=con.prepareStatement("insert into dev_basic_castingvendor_rel_tbl_hist(BCV_Rel_Id,CastingVendor_Id,Basic_Id,Created_by,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
											ps_addCVBasicRel_Hist.setInt(1, CV_Basic_Rel_Id);
											ps_addCVBasicRel_Hist.setInt(2, maxCV_Id);
											ps_addCVBasicRel_Hist.setInt(3, bean.getSheet_no());
											ps_addCVBasicRel_Hist.setInt(4, uid);
											ps_addCVBasicRel_Hist.setDate(5, curr_Date);
											ps_addCVBasicRel_Hist.setDate(6, OrgDate_CV_Basic_Rel);
											ps_addCVBasicRel_Hist.setInt(7, 1);
											
											CV_Basic_RelHist_var=ps_addCVBasicRel_Hist.executeUpdate();
											
											if(CV_Basic_RelHist_var>0)
											{
												System.out.println("Casting vendor relation is updated and history added.....");
											}
											
										}
									}
									else
									{
										PreparedStatement ps_addCVBasic_Rel=con.prepareStatement("insert into dev_basic_castingvendor_rel_tbl(CastingVendor_Id,Basic_Id,Created_By,Created_Date,Enable_Id)values(?,?,?,?,?)");
										
										ps_addCVBasic_Rel.setInt(1, maxCV_Id);
										ps_addCVBasic_Rel.setInt(2, bean.getSheet_no());
										ps_addCVBasic_Rel.setInt(3, uid);
										ps_addCVBasic_Rel.setDate(4, curr_Date);
										ps_addCVBasic_Rel.setInt(5, 1);
										
										CV_Basic_Rel_var=ps_addCVBasic_Rel.executeUpdate();
										
										if(CV_Basic_Rel_var>0)
										{
											PreparedStatement ps_getBasic_CVMaxRel_Id=con.prepareStatement("select max(BCV_Rel_Id) from dev_basic_castingvendor_rel_tbl");
											
											ResultSet rs_getBasic_CVMaxRel_Id=ps_getBasic_CVMaxRel_Id.executeQuery();
											while(rs_getBasic_CVMaxRel_Id.next())
											{
												CV_Basic_Rel_Id=rs_getBasic_CVMaxRel_Id.getInt("max(BCV_Rel_Id)");
											}
											rs_getBasic_CVMaxRel_Id.close();
											ps_getBasic_CVMaxRel_Id.close();
											
											PreparedStatement ps_addCVBasicRel_Hist=con.prepareStatement("insert into dev_basic_castingvendor_rel_tbl_hist(BCV_Rel_Id,CastingVendor_Id,Basic_Id,Created_by,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
											ps_addCVBasicRel_Hist.setInt(1, CV_Basic_Rel_Id);
											ps_addCVBasicRel_Hist.setInt(2, maxCV_Id);
											ps_addCVBasicRel_Hist.setInt(3, bean.getSheet_no());
											ps_addCVBasicRel_Hist.setInt(4, uid);
											ps_addCVBasicRel_Hist.setDate(5, curr_Date);
											ps_addCVBasicRel_Hist.setDate(6, curr_Date);
											ps_addCVBasicRel_Hist.setInt(7, 1);
											
											CV_Basic_RelHist_var=ps_addCVBasicRel_Hist.executeUpdate();
											
											if(CV_Basic_RelHist_var>0)
											{
												System.out.println("cast vendor relation is updated and history added.....");
											}
										}
										
									}
								}
							}
						}
									//System.out.println("New casting vendor is added with history....");
					
					
					
							
					
							
							//**********************************************************************************
							// update basic-plant relation info 
							//**********************************************************************************
					
							int BP_Rel_Counter=0;
							int updateBP_var=0;
							int updateBPHist_var=0;
							
							
							int plant_id=0;
							int addBPRel_var=0;
							int addBPRelHist_var=0;
							
							int maxBPRel_Id=0;
							Date orgDate_BP_Rel=null;
							
							if(bean.getPlant_name()!=0)
							{
							
							PreparedStatement ps_chkBasic_Plant_Rel=con.prepareStatement("select count(BP_Rel_Id) from dev_basic_plant_rel_tbl where Basic_Id="+bean.getSheet_no());
							ResultSet rs_chkBasic_Plant_Rel=ps_chkBasic_Plant_Rel.executeQuery();
							
							while(rs_chkBasic_Plant_Rel.next())
							{
								BP_Rel_Counter=rs_chkBasic_Plant_Rel.getInt("count(BP_Rel_Id)");
							}
							rs_chkBasic_Plant_Rel.close();
							ps_chkBasic_Plant_Rel.close();
							
							
							
							if(BP_Rel_Counter>0)
							{
								PreparedStatement ps_getBPRelId=con.prepareStatement("select BP_Rel_Id,created_date from dev_basic_plant_rel_tbl where Basic_Id="+bean.getSheet_no());
								ResultSet rs_getBPRelId=ps_getBPRelId.executeQuery();
								
								while(rs_getBPRelId.next())
								{
									maxBPRel_Id=rs_getBPRelId.getInt("BP_Rel_Id");
									orgDate_BP_Rel=rs_getBPRelId.getDate("created_date");
								}
								rs_getBPRelId.close();
								ps_getBPRelId.close();
								
								PreparedStatement ps_UpdateBP_Rel=con.prepareStatement("update dev_basic_plant_rel_tbl set Plant_Id=?,Created_By=?,Created_Date=?,Enable_Id=? where Basic_Id="+bean.getSheet_no());
								
								ps_UpdateBP_Rel.setInt(1, bean.getPlant_name());
								ps_UpdateBP_Rel.setInt(2,uid);
								ps_UpdateBP_Rel.setDate(3,curr_Date);
								ps_UpdateBP_Rel.setInt(4, 1);
								
								updateBP_var=ps_UpdateBP_Rel.executeUpdate();
								
								if(updateBP_var>0)
								{
									
									PreparedStatement ps_addBPHist_Rel=con.prepareStatement("insert into dev_basic_plant_rel_tbl_hist(BP_Rel_Id,Plant_Id,Basic_Id,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
									
									ps_addBPHist_Rel.setInt(1, maxBPRel_Id);
									ps_addBPHist_Rel.setInt(2, bean.getPlant_name());
									ps_addBPHist_Rel.setInt(3, bean.getSheet_no());
									ps_addBPHist_Rel.setInt(4, uid);
									ps_addBPHist_Rel.setDate(5, curr_Date);
									ps_addBPHist_Rel.setDate(6, orgDate_BP_Rel);
									ps_addBPHist_Rel.setInt(7, 1);
									
									updateBPHist_var=ps_addBPHist_Rel.executeUpdate();
									if(updateBPHist_var>0)
									{
										System.out.println("plant basic relation is updated....");
									}
								}
								
							}
							else
							{
								PreparedStatement ps_addBPRel=con.prepareStatement("insert into dev_basic_plant_rel_tbl(Plant_Id,Basic_Id,Created_By,Created_Date,Enable_Id)values(?,?,?,?,?)");
								ps_addBPRel.setInt(1, bean.getPlant_name());
								ps_addBPRel.setInt(2, bean.getSheet_no());
								ps_addBPRel.setInt(3, uid);
								ps_addBPRel.setDate(4, curr_Date);
								ps_addBPRel.setInt(5, 1);
								
								addBPRel_var=ps_addBPRel.executeUpdate();
								
								if(addBPRel_var>0)
								{
									PreparedStatement ps_getMaxRelID=con.prepareStatement("select max(BP_Rel_Id) from dev_basic_plant_rel_tbl");
									ResultSet rs_getMaxRelID=ps_getMaxRelID.executeQuery();
									while(rs_getMaxRelID.next())
									{
										maxBPRel_Id=rs_getMaxRelID.getInt("max(BP_Rel_Id)");
									}
									rs_getMaxRelID.close();
									ps_getMaxRelID.close();
									
									PreparedStatement ps_addBPRel_Hist=con.prepareStatement("insert into dev_basic_plant_rel_tbl_hist(BP_Rel_Id,Plant_Id,Basic_Id,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
									
									ps_addBPRel_Hist.setInt(1, maxBPRel_Id);
									ps_addBPRel_Hist.setInt(2, bean.getPlant_name());
									ps_addBPRel_Hist.setInt(3, bean.getSheet_no());
									ps_addBPRel_Hist.setInt(4, uid);
									ps_addBPRel_Hist.setDate(5, curr_Date);
									ps_addBPRel_Hist.setDate(6, curr_Date);
									ps_addBPRel_Hist.setInt(7, 1);
									
									addBPRelHist_var=ps_addBPRel_Hist.executeUpdate();
	
									if(addBPRelHist_var>0)
									{
										System.out.println("new basic-plant relation created with history....");
									}
								}
							}
							
							}
							else
							{
								
								System.out.println("plant basic relation is updated when plant name is zero ....");
								
								PreparedStatement ps_getBPRelId=con.prepareStatement("select Plant_Id,BP_Rel_Id,created_date from dev_basic_plant_rel_tbl where Basic_Id="+bean.getSheet_no());
								ResultSet rs_getBPRelId=ps_getBPRelId.executeQuery();
								
								while(rs_getBPRelId.next())
								{
									plant_id=rs_getBPRelId.getInt("Plant_Id");
									maxBPRel_Id=rs_getBPRelId.getInt("BP_Rel_Id");
									orgDate_BP_Rel=rs_getBPRelId.getDate("created_date");
								}
								rs_getBPRelId.close();
								ps_getBPRelId.close();
								
								PreparedStatement ps_UpdateBP_Rel=con.prepareStatement("update dev_basic_plant_rel_tbl set Created_By=?,Created_Date=?,Enable_Id=? where Basic_Id="+bean.getSheet_no());
								
								//ps_UpdateBP_Rel.setInt(1, bean.getPlant_name());
								ps_UpdateBP_Rel.setInt(1,uid);
								ps_UpdateBP_Rel.setDate(2,curr_Date);
								ps_UpdateBP_Rel.setInt(3, 0);
								
								updateBP_var=ps_UpdateBP_Rel.executeUpdate();
								
								if(updateBP_var>0)
								{
									
									PreparedStatement ps_addBPHist_Rel=con.prepareStatement("insert into dev_basic_plant_rel_tbl_hist(BP_Rel_Id,Plant_Id,Basic_Id,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
									
									ps_addBPHist_Rel.setInt(1, maxBPRel_Id);
									ps_addBPHist_Rel.setInt(2, bean.getPlant_name());
									ps_addBPHist_Rel.setInt(3, bean.getSheet_no());
									ps_addBPHist_Rel.setInt(4, uid);
									ps_addBPHist_Rel.setDate(5, curr_Date);
									ps_addBPHist_Rel.setDate(6, orgDate_BP_Rel);
									ps_addBPHist_Rel.setInt(7, 0);
									
									updateBPHist_var=ps_addBPHist_Rel.executeUpdate();
									if(updateBPHist_var>0)
									{
										System.out.println("plant basic relation is updated when plant name is zero ....");
									}
								}
								
							}
							//**********************************************************************************
							// update basic-Casting from relation info 
							//**********************************************************************************
					
							int BC_Rel_Counter=0;
							int updateBC_var=0;
							int updateBCHist_var=0;
							
							int addBCRel_var=0;
							int addBCRelHist_var=0;
							
							int cast_from_id=0;
							int maxBCRel_Id=0;
							Date orgDate_BC_Rel=null;
							
							if(bean.getCasting_from()!=0)
							{
								
							PreparedStatement ps_chkBasic_Cast_Rel=con.prepareStatement("select count(BC_Rel_Id) from dev_basic_casting_rel_tbl where Basic_Id="+bean.getSheet_no());
							ResultSet rs_chkBasic_Cast_Rel=ps_chkBasic_Cast_Rel.executeQuery();
							
							while(rs_chkBasic_Cast_Rel.next())
							{
								BC_Rel_Counter=rs_chkBasic_Cast_Rel.getInt("count(BC_Rel_Id)");
							}
							rs_chkBasic_Cast_Rel.close();
							ps_chkBasic_Cast_Rel.close();
							
							
							
							if(BC_Rel_Counter>0)
							{
								PreparedStatement ps_getBCRelId=con.prepareStatement("select BC_Rel_Id,created_date from dev_basic_casting_rel_tbl where Basic_Id="+bean.getSheet_no());
								ResultSet rs_getBCRelId=ps_getBCRelId.executeQuery();
								
								while(rs_getBCRelId.next())
								{
									maxBCRel_Id=rs_getBCRelId.getInt("BC_Rel_Id");
									orgDate_BC_Rel=rs_getBCRelId.getDate("created_date");
								}
								rs_getBCRelId.close();
								ps_getBCRelId.close();
								
								PreparedStatement ps_UpdateBC_Rel=con.prepareStatement("update dev_basic_casting_rel_tbl set Casting_From_Id=?,Created_By=?,Created_Date=?,Enable_Id=? where Basic_Id="+bean.getSheet_no());
								
								ps_UpdateBC_Rel.setInt(1, bean.getCasting_from());
								ps_UpdateBC_Rel.setInt(2,uid);
								ps_UpdateBC_Rel.setDate(3,curr_Date);
								ps_UpdateBC_Rel.setInt(4, 1);
								
								updateBC_var=ps_UpdateBC_Rel.executeUpdate();
								
								if(updateBC_var>0)
								{
									
									PreparedStatement ps_addBCHist_Rel=con.prepareStatement("insert into dev_basic_casting_rel_tbl_hist(BC_Rel_Id,CastingFrom_Id,Basic_Id,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
									
									ps_addBCHist_Rel.setInt(1, maxBCRel_Id);
									ps_addBCHist_Rel.setInt(2, bean.getCasting_from());
									ps_addBCHist_Rel.setInt(3, bean.getSheet_no());
									ps_addBCHist_Rel.setInt(4, uid);
									ps_addBCHist_Rel.setDate(5, curr_Date);
									ps_addBCHist_Rel.setDate(6, orgDate_BC_Rel);
									ps_addBCHist_Rel.setInt(7, 1);
									
									updateBCHist_var=ps_addBCHist_Rel.executeUpdate();
									if(updateBCHist_var>0)
									{
										System.out.println("Casting from-basic relation is updated....");
									}
								}
								
							}
							else
							{
								PreparedStatement ps_addBCRel=con.prepareStatement("insert into dev_basic_casting_rel_tbl(Casting_From_Id,Basic_Id,Created_By,Created_Date,Enable_Id)values(?,?,?,?,?)");
								ps_addBCRel.setInt(1, bean.getCasting_from());
								ps_addBCRel.setInt(2, bean.getSheet_no());
								ps_addBCRel.setInt(3, uid);
								ps_addBCRel.setDate(4, curr_Date);
								ps_addBCRel.setInt(5, 1);
								
								addBCRel_var=ps_addBCRel.executeUpdate();
								
								if(addBCRel_var>0)
								{
									PreparedStatement ps_getMaxBCRelID=con.prepareStatement("select max(BC_Rel_Id) from dev_basic_casting_rel_tbl");
									ResultSet rs_getMaxBCRelID=ps_getMaxBCRelID.executeQuery();
									while(rs_getMaxBCRelID.next())
									{
										maxBCRel_Id=rs_getMaxBCRelID.getInt("max(BC_Rel_Id)");
									}
									rs_getMaxBCRelID.close();
									ps_getMaxBCRelID.close();
									
									PreparedStatement ps_addBCRel_Hist=con.prepareStatement("insert into dev_basic_casting_rel_tbl_hist(BC_Rel_Id,CastingFrom_Id,Basic_Id,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
									
									ps_addBCRel_Hist.setInt(1, maxBCRel_Id);
									ps_addBCRel_Hist.setInt(2, bean.getCasting_from());
									ps_addBCRel_Hist.setInt(3, bean.getSheet_no());
									ps_addBCRel_Hist.setInt(4, uid);
									ps_addBCRel_Hist.setDate(5, curr_Date);
									ps_addBCRel_Hist.setDate(6, curr_Date);
									ps_addBCRel_Hist.setInt(7, 1);
									
									addBCRelHist_var=ps_addBCRel_Hist.executeUpdate();
	
									if(addBCRelHist_var>0)
									{
										System.out.println("new basic-Casting from relation created with history....");
									}
								}
							}
							}
							else
							{
								System.out.println("when casting from is zero... ");
								
								PreparedStatement ps_getBCRelId=con.prepareStatement("select Casting_From_Id,BC_Rel_Id,created_date from dev_basic_casting_rel_tbl where Basic_Id="+bean.getSheet_no());
								ResultSet rs_getBCRelId=ps_getBCRelId.executeQuery();
								
								while(rs_getBCRelId.next())
								{
									cast_from_id=rs_getBCRelId.getInt("Casting_From_Id");
									maxBCRel_Id=rs_getBCRelId.getInt("BC_Rel_Id");
									orgDate_BC_Rel=rs_getBCRelId.getDate("created_date");
								}
								rs_getBCRelId.close();
								ps_getBCRelId.close();
								
								PreparedStatement ps_UpdateBC_Rel=con.prepareStatement("update dev_basic_casting_rel_tbl set Created_By=?,Created_Date=?,Enable_Id=? where Basic_Id="+bean.getSheet_no());
								
								
								ps_UpdateBC_Rel.setInt(1,uid);
								ps_UpdateBC_Rel.setDate(2,curr_Date);
								ps_UpdateBC_Rel.setInt(3, 0);
								
								updateBC_var=ps_UpdateBC_Rel.executeUpdate();
								
								if(updateBC_var>0)
								{
									
									PreparedStatement ps_addBCHist_Rel=con.prepareStatement("insert into dev_basic_casting_rel_tbl_hist(BC_Rel_Id,CastingFrom_Id,Basic_Id,Created_By,Created_Date,Created_Date_Hist,Enable_Id)values(?,?,?,?,?,?,?)");
									
									ps_addBCHist_Rel.setInt(1, maxBCRel_Id);
									ps_addBCHist_Rel.setInt(2, bean.getCasting_from());
									ps_addBCHist_Rel.setInt(3, bean.getSheet_no());
									ps_addBCHist_Rel.setInt(4, uid);
									ps_addBCHist_Rel.setDate(5, curr_Date);
									ps_addBCHist_Rel.setDate(6, orgDate_BC_Rel);
									ps_addBCHist_Rel.setInt(7, 0);
									
									updateBCHist_var=ps_addBCHist_Rel.executeUpdate();
									if(updateBCHist_var>0)
									{
										System.out.println("Casting from-basic  relation is updated when casting from value is zero .. ....");
									}
								}
							}
							//**********************************************************************************
							// update basic-Related person  from relation info 
							//**********************************************************************************	
				
							int BPR_Rel_counter=0;
							
							int updateBPR_Rel_var=0;
							int updateBPR_RelHist_var=0;
							
							int addBPR_Rel_var=0;
							int addBPR_RelHist_var=0;
							
							int maxBPR_Rel_Id=0;
							Date orgDate_BPR_Rel=null;
							
							
							PreparedStatement ps_chkBRP_Rel=con.prepareStatement("select count(BCF_Rel_Id) from dev_basic_relperson_rel_tbl where Basic_Id="+bean.getSheet_no());
							ResultSet rs_chkBPR_Rel=ps_chkBRP_Rel.executeQuery();
							
							while(rs_chkBPR_Rel.next())
							{
								BPR_Rel_counter=rs_chkBPR_Rel.getInt("count(BCF_Rel_Id)");
							}
							rs_chkBPR_Rel.close();
							ps_chkBRP_Rel.close();
							
							if(BPR_Rel_counter>0)
							{
								PreparedStatement ps_getBPR_Rel_Id=con.prepareStatement("select BCF_Rel_Id,created_date from dev_basic_relperson_rel_tbl where Basic_Id="+bean.getSheet_no());
								ResultSet rs_getBPR_Rel_Id=ps_getBPR_Rel_Id.executeQuery();
								
								while(rs_getBPR_Rel_Id.next())
								{
									maxBPR_Rel_Id=rs_getBPR_Rel_Id.getInt("BCF_Rel_Id");
									orgDate_BPR_Rel=rs_getBPR_Rel_Id.getDate("created_date");
								}
								rs_getBPR_Rel_Id.close();
								ps_getBPR_Rel_Id.close();
								
								
								PreparedStatement ps_updateBPR_Rel=con.prepareStatement("update dev_basic_relperson_rel_tbl set Related_Person=?,Created_By=?,Created_Date=? where Basic_Id="+bean.getSheet_no());
								
								ps_updateBPR_Rel.setInt(1, bean.getRelated_person());
								ps_updateBPR_Rel.setInt(2,uid);
								ps_updateBPR_Rel.setDate(3, curr_Date);
								
								updateBPR_Rel_var=ps_updateBPR_Rel.executeUpdate();
								
								if(updateBPR_Rel_var>0)
								{
									PreparedStatement ps_addBPRUpdate_hist=con.prepareStatement("insert into dev_basic_relperson_rel_tbl_hist(BCF_Rel_Id,Basic_Id,Releted_person,Created_by,Created_Date,Created_date_Hist)values(?,?,?,?,?,?)");
									ps_addBPRUpdate_hist.setInt(1, maxBPR_Rel_Id);
									ps_addBPRUpdate_hist.setInt(2, bean.getSheet_no());
									ps_addBPRUpdate_hist.setInt(3, bean.getRelated_person());
									ps_addBPRUpdate_hist.setInt(4, uid);
									ps_addBPRUpdate_hist.setDate(5, curr_Date);
									ps_addBPRUpdate_hist.setDate(6, orgDate_BPR_Rel);
									
									updateBPR_RelHist_var=ps_addBPRUpdate_hist.executeUpdate();
									
									if(updateBPR_RelHist_var>0)
									{
										System.out.println("basic related person relation is updated and history added ...");
									}
								}
								
							}
							//**********************************************************************************
							// update basic-Project Lead  from relation info 
							//**********************************************************************************	
				
							int BPL_Rel_counter=0;
							
							int updateBPL_Rel_var=0;
							int updateBPL_RelHist_var=0;
							
							int addBPL_Rel_var=0;
							int addBPL_RelHist_var=0;
							
							int maxBPL_Rel_Id=0;
							Date orgDate_BPL_Rel=null;
							
							
							PreparedStatement ps_chkBRL_Rel=con.prepareStatement("select count(BPL_Rel_Id) from dev_basic_projectlead_rel_tbl where Basic_Id="+bean.getSheet_no());
							ResultSet rs_chkBPL_Rel=ps_chkBRL_Rel.executeQuery();
							
							while(rs_chkBPL_Rel.next())
							{
								BPL_Rel_counter=rs_chkBPL_Rel.getInt("count(BPL_Rel_Id)");
							}
							rs_chkBPL_Rel.close();
							ps_chkBRL_Rel.close();
							
							if(BPL_Rel_counter>0)
							{
								PreparedStatement ps_getBPL_Rel_Id=con.prepareStatement("select BPL_Rel_Id,created_date from dev_basic_projectlead_rel_tbl where Basic_Id="+bean.getSheet_no());
								ResultSet rs_getBPL_Rel_Id=ps_getBPL_Rel_Id.executeQuery();
								
								while(rs_getBPL_Rel_Id.next())
								{
									maxBPL_Rel_Id=rs_getBPL_Rel_Id.getInt("BPL_Rel_Id");
									orgDate_BPL_Rel=rs_getBPL_Rel_Id.getDate("created_date");
								}
								rs_getBPL_Rel_Id.close();
								ps_getBPL_Rel_Id.close();
								
								
								PreparedStatement ps_updateBPL_Rel=con.prepareStatement("update dev_basic_projectlead_rel_tbl set Project_Lead=?,Created_By=?,Created_Date=? where Basic_Id="+bean.getSheet_no());
								
								ps_updateBPL_Rel.setInt(1, bean.getProject_leader());
								ps_updateBPL_Rel.setInt(2,uid);
								ps_updateBPL_Rel.setDate(3, curr_Date);
								
								updateBPL_Rel_var=ps_updateBPL_Rel.executeUpdate();
								
								if(updateBPL_Rel_var>0)
								{
									PreparedStatement ps_addBPLUpdate_hist=con.prepareStatement("insert into dev_basic_projectlead_rel_tbl_hist(BPL_Rel_Id,Basic_Id,Project_Lead,Created_by,Created_Date,Created_date_Hist)values(?,?,?,?,?,?)");
									ps_addBPLUpdate_hist.setInt(1, maxBPL_Rel_Id);
									ps_addBPLUpdate_hist.setInt(2, bean.getSheet_no());
									ps_addBPLUpdate_hist.setInt(3, bean.getProject_leader());
									ps_addBPLUpdate_hist.setInt(4, uid);
									ps_addBPLUpdate_hist.setDate(5, curr_Date);
									ps_addBPLUpdate_hist.setDate(6, orgDate_BPL_Rel);
									
									updateBPL_RelHist_var=ps_addBPLUpdate_hist.executeUpdate();
									
									if(updateBPL_RelHist_var>0)
									{
										System.out.println("basic Project lead relation is updated and history added ...");
									}
								}
								
							}
			
			
			
		//**********************************************************************************
		// update basic info 
		//**********************************************************************************
			
			int basicInfo_var = 0;
			int basicInfo_var_Hist = 0;
			Date orgDate_BasicInfo=null;
			
			
			PreparedStatement ps_getBasicDetails=con.prepareStatement("select created_date from dev_basicinfo_tbl where basic_id="+bean.getSheet_no());
			ResultSet rs_getBasicDetails=ps_getBasicDetails.executeQuery();
			
			while(rs_getBasicDetails.next())
			{
				orgDate_BasicInfo=rs_getBasicDetails.getDate("created_date");
			}
			rs_getBasicDetails.close();
			ps_getBasicDetails.close();

			PreparedStatement ps_addBasicInfo = con
					.prepareStatement("update dev_basicinfo_tbl set PartName_Id=?,Cust_Id=?,PartNo_Id=?,Revision_No=?,Revision_Date=?,Mkt_Approval=?,Schedule_Per_Month=?,PO_No_From_Cust=?,PO_Rcvd_At_Dev_Date=?,Grade_Id=?,Created_By=?,Created_Date=?,Enable_Id=?,PO_Date_From_Cust=?,Planned_Start_Date=?,Planned_End_Date=?,Actual_Start_Date=?,Actual_End_Date=? where basic_id="+bean.getSheet_no());

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

			if (basicInfo_var > 0) 
			{
				PreparedStatement ps_addBasicInfo_Hist = con.prepareStatement("insert into dev_basicinfo_tbl_hist(Created_Date_Hist,PartName_Id,Cust_Id,PartNo_Id,Revision_No,Revision_Date,Mkt_Approval,Schedule_Per_Month,PO_No_From_Cust,PO_Rcvd_At_Dev_Date,Grade_Id,Created_By,Created_Date,Enable_Id,PO_Date_From_Cust,Basic_Id,Planned_Start_Date,Planned_End_Date,Actual_Start_Date,Actual_End_Date)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

				ps_addBasicInfo_Hist.setDate(1, orgDate_BasicInfo);
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
				ps_addBasicInfo_Hist.setInt(16, bean.getSheet_no());
				ps_addBasicInfo_Hist.setDate(17, bean.getPlan_start_date());
				ps_addBasicInfo_Hist.setDate(18, bean.getPlan_end_date());
				ps_addBasicInfo_Hist.setDate(19, bean.getAct_start_date());
				ps_addBasicInfo_Hist.setDate(20, bean.getAct_end_date());

				basicInfo_var_Hist = ps_addBasicInfo_Hist.executeUpdate();
				
				if(basicInfo_var_Hist>0)
				{
					System.out.println("Basic info updated....and history added....");
				}
			}
			
			
			//**********************************************************************************
			// update part Image  if available 
			//**********************************************************************************
			
			if(bean.getPartImage_file_name()!="")
			{
				System.out.println("Part image upload loop......Part no id="+maxPartNoId);
				int PartImage_id=0;
				Date orgDate_PartImage=null;
				int updatePartImage_var=0;
				int updatePartImageHist_var=0;
				
				PreparedStatement ps_getPartImage_Id=con.prepareStatement("select part_photo_id,created_date from dev_partno_photo_tbl where partno_id="+maxPartNoId);
				ResultSet rs_getPartImage_Id=ps_getPartImage_Id.executeQuery();
				while(rs_getPartImage_Id.next())
				{
					PartImage_id=rs_getPartImage_Id.getInt("part_photo_id");
					orgDate_PartImage=rs_getPartImage_Id.getDate("created_date");
				}
				rs_getPartImage_Id.close();
				ps_getPartImage_Id.close();
				System.out.println("part image id==="+PartImage_id);
				
				if(PartImage_id>0)
				{
					PreparedStatement ps_UpdatePartImage=con.prepareStatement("update dev_partno_photo_tbl set attachment=?,file_name=?,created_by=?,created_date=?,Enable_id=? where partno_id="+maxPartNoId+" and part_photo_id="+PartImage_id);
					
					ps_UpdatePartImage.setBlob(1, bean.getPartImage_file_blob());
					ps_UpdatePartImage.setString(2, bean.getPartImage_file_name());
					ps_UpdatePartImage.setInt(3, uid);
					ps_UpdatePartImage.setDate(4, curr_Date);
					ps_UpdatePartImage.setInt(5, 1);
					
					updatePartImage_var=ps_UpdatePartImage.executeUpdate();
					
					if(updatePartImage_var>0)
					{
						System.out.println("part no photo updated.....");
						PreparedStatement ps_addPartImageHist=con.prepareStatement("insert into dev_partno_photo_tbl_hist(part_photo_id,attachment,file_name,created_by,created_date,created_date_hist,partno_id,Enable_Id)values(?,?,?,?,?,?,?,?)");
						ps_addPartImageHist.setInt(1, PartImage_id);
						ps_addPartImageHist.setBlob(2, bean.getPartImage_file_blob());
						ps_addPartImageHist.setString(3, bean.getPartImage_file_name());
						ps_addPartImageHist.setInt(4, uid);
						ps_addPartImageHist.setDate(5, curr_Date);
						ps_addPartImageHist.setDate(6, orgDate_PartImage);
						ps_addPartImageHist.setInt(7, maxPartNoId);
						ps_addPartImageHist.setInt(8, 1);
						
						updatePartImageHist_var=ps_addPartImageHist.executeUpdate();
						
						if(updatePartImageHist_var>0)
						{
							System.out.println("Part image updated......");
						}
						
					}
				}
				else
				{
					PreparedStatement ps_addPartImage=con.prepareStatement("insert into dev_partno_photo_tbl(partno_id,attachment,file_name,created_by,created_date,Enable_id)values(?,?,?,?,?,?)");
					
					ps_addPartImage.setInt(1, maxPartNoId);
					ps_addPartImage.setBlob(2, bean.getPartImage_file_blob());
					ps_addPartImage.setString(3, bean.getPartImage_file_name());
					ps_addPartImage.setInt(4, uid);
					ps_addPartImage.setDate(5, curr_Date);
					ps_addPartImage.setInt(6, 1);
					
					updatePartImage_var=ps_addPartImage.executeUpdate();
					
					if(updatePartImage_var>0)
					{
						PreparedStatement ps_getNewPartImage_Id=con.prepareStatement("select part_photo_id,created_date from dev_partno_photo_tbl where partno_id="+maxPartNoId);
						ResultSet rs_getNewPartImage_Id=ps_getPartImage_Id.executeQuery();
						while(rs_getNewPartImage_Id.next())
						{
							PartImage_id=rs_getNewPartImage_Id.getInt("part_photo_id");
							orgDate_PartImage=rs_getNewPartImage_Id.getDate("created_date");
						}
						rs_getNewPartImage_Id.close();
						ps_getNewPartImage_Id.close();
						System.out.println("part image id==="+PartImage_id);
						
						System.out.println("part no photo updated.....");
						PreparedStatement ps_addPartImageHist=con.prepareStatement("insert into dev_partno_photo_tbl_hist(part_photo_id,attachment,file_name,created_by,created_date,created_date_hist,partno_id,Enable_Id)values(?,?,?,?,?,?,?,?)");
						ps_addPartImageHist.setInt(1, PartImage_id);
						ps_addPartImageHist.setBlob(2, bean.getPartImage_file_blob());
						ps_addPartImageHist.setString(3, bean.getPartImage_file_name());
						ps_addPartImageHist.setInt(4, uid);
						ps_addPartImageHist.setDate(5, curr_Date);
						ps_addPartImageHist.setDate(6, orgDate_PartImage);
						ps_addPartImageHist.setInt(7, maxPartNoId);
						ps_addPartImageHist.setInt(8, 1);
						
						updatePartImageHist_var=ps_addPartImageHist.executeUpdate();
						
						if(updatePartImageHist_var>0)
						{
							System.out.println("Part image updated......");
						}
						
					}
				}
				
			}
			
			if(bean.getThreeD_drawing_file_name()!="")
			{
				int ThreeDrawing_id=0;
				Date orgDate_ThreeDrawing=null;
				int updateThreeDrawing_var=0;
				int updateThreeDrawingHist_var=0;
				
				int ThreeD_Counter=0;
				
				int addThreeD_var=0;
				int addThreeDHist_var=0;
				
				PreparedStatement ps_getThreeDFileCount=con.prepareStatement("select count(3D_drawing_attach_id) from dev_3d_drawing_attachment_tbl where Basic_Id="+bean.getSheet_no());
				ResultSet rs_getThreeDFileCount=ps_getThreeDFileCount.executeQuery();
				while(rs_getThreeDFileCount.next())
				{
					ThreeD_Counter=rs_getThreeDFileCount.getInt("count(3D_drawing_attach_id)");
				}
				rs_getThreeDFileCount.close();
				ps_getThreeDFileCount.close();
				
				if(ThreeD_Counter>0)
				{
				
					PreparedStatement ps_getThreeDrawing_Id=con.prepareStatement("select 3D_drawing_attach_id,Attached_Date from dev_3d_drawing_attachment_tbl where Basic_Id="+bean.getSheet_no());
					ResultSet rs_getThreeDrawing_Id=ps_getThreeDrawing_Id.executeQuery();
					while(rs_getThreeDrawing_Id.next())
					{
						ThreeDrawing_id=rs_getThreeDrawing_Id.getInt("3D_drawing_attach_id");
						orgDate_ThreeDrawing=rs_getThreeDrawing_Id.getDate("Attached_Date");
					}
					rs_getThreeDrawing_Id.close();
					ps_getThreeDrawing_Id.close();
				
				PreparedStatement ps_UpdateThreeDrawing=con.prepareStatement("update dev_3d_drawing_attachment_tbl set attachment=?,file_name=?,Attached_By=?,Attached_Date=?,Enable_id=? where Basic_Id="+bean.getSheet_no());
				
				ps_UpdateThreeDrawing.setBlob(1, bean.getThreeD_drawing());
				ps_UpdateThreeDrawing.setString(2, bean.getThreeD_drawing_file_name());
				ps_UpdateThreeDrawing.setInt(3, uid);
				ps_UpdateThreeDrawing.setDate(4, curr_Date);
				ps_UpdateThreeDrawing.setInt(5, 1);
				
				updateThreeDrawing_var=ps_UpdateThreeDrawing.executeUpdate();
				
				if(updateThreeDrawing_var>0)
				{
					PreparedStatement ps_addThreeDrawingHist=con.prepareStatement("insert into dev_3d_drawing_attachment_tbl_hist(Basic_Id,3D_drawing_attach_id,file_name,attachment,attached_by,attached_date,attached_date_hist,Enable_Id)values(?,?,?,?,?,?,?,?)");
					ps_addThreeDrawingHist.setInt(1, bean.getSheet_no());
					ps_addThreeDrawingHist.setInt(2, ThreeDrawing_id);
					ps_addThreeDrawingHist.setString(3, bean.getThreeD_drawing_file_name());
					ps_addThreeDrawingHist.setBlob(4, bean.getThreeD_drawing());
					ps_addThreeDrawingHist.setInt(5, uid);
					ps_addThreeDrawingHist.setDate(6, curr_Date);
					ps_addThreeDrawingHist.setDate(7, orgDate_ThreeDrawing);
					ps_addThreeDrawingHist.setInt(8, 1);
					
					updateThreeDrawingHist_var=ps_addThreeDrawingHist.executeUpdate();
					
					if(updateThreeDrawingHist_var>0)
					{
						System.out.println("3d File updated......");
					}
					
				}
				}
				else
				{
					PreparedStatement ps_add3DAttachment=con.prepareStatement("insert into dev_3d_drawing_attachment_tbl(Basic_Id,File_Name,Attachment,Attached_By,Attached_Date,Enable_id)values(?,?,?,?,?,?)");
					ps_add3DAttachment.setInt(1, bean.getSheet_no());
					ps_add3DAttachment.setString(2, bean.getThreeD_drawing_file_name());
					ps_add3DAttachment.setBlob(3, bean.getThreeD_drawing());
					ps_add3DAttachment.setInt(4, uid);
					ps_add3DAttachment.setDate(5,curr_Date);
					ps_add3DAttachment.setInt(6, 1);
					
					addThreeD_var=ps_add3DAttachment.executeUpdate();
					
					if(addThreeD_var>0)
					{
						PreparedStatement ps_getMaxTDId=con.prepareStatement("select max(3D_drawing_attach_id) from dev_3d_drawing_attachment_tbl");
						
						ResultSet rs_getMaxTDId=ps_getMaxTDId.executeQuery();
						while(rs_getMaxTDId.next())
						{
							ThreeDrawing_id=rs_getMaxTDId.getInt("max(3D_drawing_attach_id)");
						}
						rs_getMaxTDId.close();
						ps_getMaxTDId.close();
						
						PreparedStatement ps_addThreeDrawingHist=con.prepareStatement("insert into dev_3d_drawing_attachment_tbl_hist(Basic_Id,3D_drawing_attach_id,file_name,attachment,attached_by,attached_date,attached_date_hist,Enable_Id)values(?,?,?,?,?,?,?,?)");
						ps_addThreeDrawingHist.setInt(1, bean.getSheet_no());
						ps_addThreeDrawingHist.setInt(2, ThreeDrawing_id);
						ps_addThreeDrawingHist.setString(3, bean.getThreeD_drawing_file_name());
						ps_addThreeDrawingHist.setBlob(4, bean.getThreeD_drawing());
						ps_addThreeDrawingHist.setInt(5, uid);
						ps_addThreeDrawingHist.setDate(6, curr_Date);
						ps_addThreeDrawingHist.setDate(7, curr_Date);
						ps_addThreeDrawingHist.setInt(8, 1);
						
						addThreeDHist_var=ps_addThreeDrawingHist.executeUpdate();
						
						if(addThreeDHist_var>0)
						{
							System.out.println("3d File added with history ....");
						}
						
					}
				}
			}
			if(bean.getTwoD_drawing_file_name()!="")
			{
				int TwoD_id=0;
				Date orgDate_TwoD=null;
				int updateTwoD_var=0;
				int updateTwoDHist_var=0;
				
				PreparedStatement ps_getTwoD_Details=con.prepareStatement("select 2D_drawing_attach_id,Attached_Date from dev_2d_drawing_attachment where Basic_Id="+bean.getSheet_no());
				ResultSet rs_getTwoD_Details=ps_getTwoD_Details.executeQuery();
				
				while(rs_getTwoD_Details.next())
				{
					TwoD_id=rs_getTwoD_Details.getInt("2D_drawing_attach_id");
					orgDate_TwoD=rs_getTwoD_Details.getDate("Attached_Date");
				}
				rs_getTwoD_Details.close();
				ps_getTwoD_Details.close();
				
				
				PreparedStatement ps_updateTwoD=con.prepareStatement("update dev_2d_drawing_attachment set File_Name=?,Attachment=?,Attached_By=?,Attached_Date=?,Enable_Id=? where Basic_Id="+bean.getSheet_no());
				ps_updateTwoD.setString(1, bean.getTwoD_drawing_file_name());
				ps_updateTwoD.setBlob(2, bean.getTwoD_drawing());
				ps_updateTwoD.setInt(3, uid);
				ps_updateTwoD.setDate(4, curr_Date);
				ps_updateTwoD.setInt(5, 1);
				
				updateTwoD_var=ps_updateTwoD.executeUpdate();
				
				if(updateTwoD_var>0)
				{
					PreparedStatement ps_addTwoDHist=con.prepareStatement("insert into dev_2d_drawing_attachment_hist(Basic_Id,2d_drawing_attach_id,file_name,attachment,attached_by,attached_date,attached_date_hist,Enable_Id)values(?,?,?,?,?,?,?,?)");
					ps_addTwoDHist.setInt(1, bean.getSheet_no());
					ps_addTwoDHist.setInt(2, TwoD_id);
					ps_addTwoDHist.setString(3, bean.getTwoD_drawing_file_name());
					ps_addTwoDHist.setBlob(4, bean.getTwoD_drawing());
					ps_addTwoDHist.setInt(5, uid);
					ps_addTwoDHist.setDate(6, curr_Date);
					ps_addTwoDHist.setDate(7, orgDate_TwoD);
					ps_addTwoDHist.setInt(8, 1);
					
					updateTwoDHist_var=ps_addTwoDHist.executeUpdate();
					
					if(updateTwoDHist_var>0)
					{
						System.out.println("Two attachment is updated with history.....");
					}
				}
				
			}
			if(bean.getPo_file_name()!="")
			{
				int PO_id=0;
				Date orgDate_PO=null;
				int updatePO_var=0;
				int updatePOHist_var=0;
				
				PreparedStatement ps_getPO_Details=con.prepareStatement("select BI_PO_Attach_Id,Attached_Date from dev_basicinfo_po_attachment_tbl where Basic_Id="+bean.getSheet_no());
				ResultSet rs_getPO_Details=ps_getPO_Details.executeQuery();
				
				while(rs_getPO_Details.next())
				{
					PO_id=rs_getPO_Details.getInt("BI_PO_Attach_Id");
					orgDate_PO=rs_getPO_Details.getDate("Attached_Date");
				}
				rs_getPO_Details.close();
				ps_getPO_Details.close();
				
				
				PreparedStatement ps_updatePO=con.prepareStatement("update dev_basicinfo_po_attachment_tbl set File_Name=?,Attachment=?,Attached_By=?,Attached_Date=?,Enable_Id=? where Basic_Id="+bean.getSheet_no());
				ps_updatePO.setString(1, bean.getPo_file_name());
				ps_updatePO.setBlob(2, bean.getPo_file_blob());
				ps_updatePO.setInt(3, uid);
				ps_updatePO.setDate(4, curr_Date);
				ps_updatePO.setInt(5, 1);
				
				updatePO_var=ps_updatePO.executeUpdate();
				
				if(updatePO_var>0)
				{
					PreparedStatement ps_addPOHist=con.prepareStatement("insert into dev_basicinfo_po_attachment_tbl_hist(Basic_Id,bi_po_attach_id,file_name,attachment,attached_by,attached_date,attached_date_hist,Enable_Id)values(?,?,?,?,?,?,?,?)");
					ps_addPOHist.setInt(1, bean.getSheet_no());
					ps_addPOHist.setInt(2, PO_id);
					ps_addPOHist.setString(3, bean.getPo_file_name());
					ps_addPOHist.setBlob(4, bean.getPo_file_blob());
					ps_addPOHist.setInt(5, uid);
					ps_addPOHist.setDate(6, curr_Date);
					ps_addPOHist.setDate(7, orgDate_PO);
					ps_addPOHist.setInt(8, 1);
					
					updatePOHist_var=ps_addPOHist.executeUpdate();
					
					if(updatePOHist_var>0)
					{
						System.out.println("PO attachment is updated with history.....");
					}
				}
			}
			
	}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return basic_id;
	}

	public boolean updateAttach_File(Edit_NewSheet_vo bean,
			HttpSession session, int basic_id) 
	{
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
