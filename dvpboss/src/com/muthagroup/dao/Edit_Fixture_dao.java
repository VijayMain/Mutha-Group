package com.muthagroup.dao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.sql.*;
import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Edit_Fixture_vo;

public class Edit_Fixture_dao 
{
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	boolean flag=false;
	public boolean editFixture(Edit_Fixture_vo vo, HttpServletRequest request) 
	{
		HttpSession session=request.getSession();
		
		int uid=0;
		
		int getFName_Id=0;
		int getFNo_Id=0;
		
		Date histDate_FName=null;
		Date histDate_FNo=null;
		
		int chkFName_var=0;
		int chkFNameHist_var=0;
		
		int chkFNo_var=0;
		int chkFNoHist_var=0;
		
		boolean chkFName_Flag=false;
		boolean chkFNo_Flag=false;
		
		boolean chkFName_Flag1=false;
		boolean chkFNo_Flag1=false;
		
		int addNewFixture_var=0;
		int addNewFixtureHist_var=0;
		
		
		
		uid=Integer.parseInt(session.getAttribute("uid").toString());
		
		
		try
		{
		
			Connection con=Connection_Utility.getConnection();
			
			int rel_id=0;
			
			
			PreparedStatement ps_getFRel_Id=con.prepareStatement("select fixt_fixtNo_rel_Id from dev_fixturedata_tbl where mcdata_id="+vo.getMcdataid()+" and opnno_opn_rel_id="+vo.getRel_id());
			ResultSet rs_getFRel_Id=ps_getFRel_Id.executeQuery();
			
			while(rs_getFRel_Id.next())
			{
				rel_id=rs_getFRel_Id.getInt("fixt_fixtNo_rel_Id");
			}
			
			
			
			if(vo.getNew_fixture()!=null)
			{
				System.out.println("new fixture is available....");
					
				PreparedStatement ps_chkFName=con.prepareStatement("select Fixture_Id,Fixture_Name from dev_fixture_mst_tbl");
				
				ResultSet rs_chkFName=ps_chkFName.executeQuery();
				
				while(rs_chkFName.next())
				{
					
					if(vo.getNew_fixture().equalsIgnoreCase(rs_chkFName.getString("Fixture_Name")))
					{
						getFName_Id=rs_chkFName.getInt("Fixture_Id");
						chkFName_Flag1=true;
					}
				}
				
				if(chkFName_Flag1==false)
				{
					
					
					PreparedStatement ps_addNewFName=con.prepareStatement("insert into dev_fixture_mst_tbl(Fixture_Name,Created_by,Created_Date)values(?,?,?)");
					
					ps_addNewFName.setString(1, vo.getNew_fixture());
					ps_addNewFName.setInt(2, uid);
					ps_addNewFName.setDate(3, Date);
					
					addNewFixture_var=ps_addNewFName.executeUpdate();
					
					if(addNewFixture_var>0)
					{
						PreparedStatement ps_getId=con.prepareStatement("select max(Fixture_Id) from dev_fixture_mst_tbl");
						ResultSet rs_getId=ps_getId.executeQuery();
						
						while(rs_getId.next())
						{
							getFName_Id=rs_getId.getInt("max(Fixture_Id)");
						}
						rs_getId.close();
						ps_getId.close();
						
						PreparedStatement ps_addNewFName_Hist=con.prepareStatement("insert into dev_fixture_mst_tbl_hist(fixture_Id,fixture_Name,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
						
						ps_addNewFName_Hist.setInt(1, getFName_Id);
						ps_addNewFName_Hist.setString(2, vo.getNew_fixture());
						ps_addNewFName_Hist.setInt(3, uid);
						ps_addNewFName_Hist.setDate(4, Date);
						ps_addNewFName_Hist.setDate(5, Date);
						
						addNewFixtureHist_var=ps_addNewFName_Hist.executeUpdate();
						
						if(addNewFixtureHist_var>0)
						{
							System.out.println("new fixture added with history.... fixture id="+getFName_Id);
						}
					}
					
				}
				
			}
			else
			{
				
			
			PreparedStatement ps_chkFName=con.prepareStatement("select Fixture_Id,Fixture_Name from dev_fixture_mst_tbl");
			
			ResultSet rs_chkFName=ps_chkFName.executeQuery();
			
			while(rs_chkFName.next())
			{
				
				if(vo.getFixture().equalsIgnoreCase(rs_chkFName.getString("Fixture_Name")))
				{
					getFName_Id=rs_chkFName.getInt("Fixture_Id");
					chkFName_Flag=true;
				}
			}
			
			if(chkFName_Flag==true)
			{
				System.out.println("Fixture name matched.... id="+getFName_Id);
			}
			else
			{
							
				PreparedStatement ps_getFName_Id=con.prepareStatement("select Fixture_Id from dev_fixture_fixtureno_rel_tbl where fixt_fixtNo_rel_Id="+rel_id);
				ResultSet rs_getFName_Id=ps_getFName_Id.executeQuery();
				
				while(rs_getFName_Id.next())
				{
					getFName_Id=rs_getFName_Id.getInt("Fixture_Id");
				}
				
				PreparedStatement ps_getFNameDate=con.prepareStatement("select Created_Date from dev_fixture_mst_tbl where Fixture_Id="+getFName_Id);
				ResultSet rs_getFNameDate=ps_getFNameDate.executeQuery();
				
				while(rs_getFNameDate.next())
				{
					histDate_FName=rs_getFNameDate.getDate("Created_Date");
				}
				
				PreparedStatement ps_updateFName=con.prepareStatement("update dev_fixture_mst_tbl set Fixture_Name=?,Created_by=?,Created_Date=? where Fixture_Id="+getFName_Id);
				
				ps_updateFName.setString(1, vo.getFixture());
				ps_updateFName.setInt(2, uid);
				ps_updateFName.setDate(3, Date);
				
				chkFName_var=ps_updateFName.executeUpdate();
				
				if(chkFName_var>0)
				{
					PreparedStatement ps_addFName_Hist=con.prepareStatement("insert into dev_fixture_mst_tbl_hist(fixture_Id,fixture_Name,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
					ps_addFName_Hist.setInt(1, getFName_Id);
					ps_addFName_Hist.setString(2, vo.getFixture());
					ps_addFName_Hist.setInt(3, uid);
					ps_addFName_Hist.setDate(4, Date);
					ps_addFName_Hist.setDate(5, histDate_FName);
					
					chkFNameHist_var=ps_addFName_Hist.executeUpdate();
					
					if(chkFNameHist_var>0)
					{
						System.out.println("Fname History added....fName id="+getFName_Id);
					}
					
				}
				
			}

			}
			
			int newAddFNo_var=0;
			int newAddFNoHist_var=0;
			
			if(vo.getNew_fixture_no()!=null)
			{
				System.out.println("New fixt. no available....");
				
				PreparedStatement ps_chkFNo=con.prepareStatement("select FixtureNo_Id,Fixture_No from dev_fixture_no_mst_tbl");
				
				ResultSet rs_chkFNo=ps_chkFNo.executeQuery();
				
				while(rs_chkFNo.next())
				{
					
					if(vo.getNew_fixture_no().equalsIgnoreCase(rs_chkFNo.getString("Fixture_No")))
					{
						getFNo_Id=rs_chkFNo.getInt("FixtureNo_Id");
						chkFNo_Flag1=true;
					}
				}
				rs_chkFNo.close();
				ps_chkFNo.close();
				
				if(chkFNo_Flag1==false)
				{
					PreparedStatement ps_addNewFNo=con.prepareStatement("insert into dev_fixture_no_mst_tbl(Fixture_No,Created_By,Created_Date)values(?,?,?)");
					
					ps_addNewFNo.setString(1,vo.getNew_fixture_no());
					ps_addNewFNo.setInt(2, uid);
					ps_addNewFNo.setDate(3, Date);
					
					newAddFNo_var=ps_addNewFNo.executeUpdate();
					
					if(newAddFNo_var>0)
					{
						PreparedStatement ps_getMaxId=con.prepareStatement("select max(FixtureNo_Id) from dev_fixture_no_mst_tbl");
						ResultSet rs_getMaxId=ps_getMaxId.executeQuery();
						
						while(rs_getMaxId.next())
						{
							getFNo_Id=rs_getMaxId.getInt("max(FixtureNo_Id)");
						}
						rs_getMaxId.close();
						ps_getMaxId.close();
						
						PreparedStatement ps_addNewFNo_Hist=con.prepareStatement("insert into dev_fixture_no_mst_tbl_hist(FixtureNo_Id,Fixture_No,Created_By,Created_Date,Created_Date_Hist)values(?,?,?,?,?)");
						
						ps_addNewFNo_Hist.setInt(1,getFNo_Id);
						ps_addNewFNo_Hist.setString(2,vo.getNew_fixture_no());
						ps_addNewFNo_Hist.setInt(3, uid);
						ps_addNewFNo_Hist.setDate(4, Date);
						ps_addNewFNo_Hist.setDate(5, Date);
						
						
						newAddFNoHist_var=ps_addNewFNo_Hist.executeUpdate();
						
						if(newAddFNoHist_var>0)
						{
							System.out.println("new fixture no is added with hist .... fixt. no id="+getFNo_Id);
						}
						
					}
					
				}
				
			}
			else
			{
			
			PreparedStatement ps_chkFNo=con.prepareStatement("select FixtureNo_Id,Fixture_No from dev_fixture_no_mst_tbl");
			
			ResultSet rs_chkFNo=ps_chkFNo.executeQuery();
			
			while(rs_chkFNo.next())
			{
				
				if(vo.getFixture_no().equalsIgnoreCase(rs_chkFNo.getString("Fixture_No")))
				{
					getFNo_Id=rs_chkFNo.getInt("FixtureNo_Id");
					chkFNo_Flag=true;
				}
			}
			
			if(chkFNo_Flag==true)
			{
				System.out.println("Fixture name matched.... id="+getFNo_Id);
			}
			else
			{
				
				PreparedStatement ps_getFName_Id=con.prepareStatement("select fixtureNo_id from dev_fixture_fixtureno_rel_tbl where fixt_fixtNo_rel_Id="+rel_id);
				ResultSet rs_getFName_Id=ps_getFName_Id.executeQuery();
				
				while(rs_getFName_Id.next())
				{
					getFNo_Id=rs_getFName_Id.getInt("fixtureNo_id");
				}
				
				PreparedStatement ps_getFNoDate=con.prepareStatement("select Created_Date from dev_fixture_no_mst_tbl where fixtureNo_id="+getFNo_Id);
				ResultSet rs_getFNoDate=ps_getFNoDate.executeQuery();
				
				while(rs_getFNoDate.next())
				{
					histDate_FNo=rs_getFNoDate.getDate("Created_Date");
				}
				
				PreparedStatement ps_updateFNo=con.prepareStatement("update dev_fixture_no_mst_tbl set Fixture_No=?,Created_by=?,Created_Date=? where FixtureNo_Id="+getFNo_Id);
				
				ps_updateFNo.setString(1, vo.getFixture_no());
				ps_updateFNo.setInt(2, uid);
				ps_updateFNo.setDate(3, Date);
				
				chkFNo_var=ps_updateFNo.executeUpdate();
				
				if(chkFNo_var>0)
				{
					PreparedStatement ps_addFNo_Hist=con.prepareStatement("insert into dev_fixture_no_mst_tbl_hist(FixtureNo_Id,Fixture_No,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
					ps_addFNo_Hist.setInt(1, getFNo_Id);
					ps_addFNo_Hist.setString(2, vo.getFixture_no());
					ps_addFNo_Hist.setInt(3, uid);
					ps_addFNo_Hist.setDate(4, Date);
					ps_addFNo_Hist.setDate(5, histDate_FNo);
					
					chkFNoHist_var=ps_addFNo_Hist.executeUpdate();
					
					if(chkFNoHist_var>0)
					{
						System.out.println("Fno History added....fNo id="+getFNo_Id);
					}
					
				}
				
			}
			
			}
			
			
			int rel_var=0;
			int relHist_var=0;
			Date relOrgDate=null;
			
			PreparedStatement ps_getRelDate=con.prepareStatement("select Created_Date from dev_fixture_fixtureno_rel_tbl where fixt_fixtNo_rel_Id="+rel_id);
			ResultSet rs_getFRelDate=ps_getRelDate.executeQuery();
			
			while(rs_getFRelDate.next())
			{
				relOrgDate=rs_getFRelDate.getDate("Created_Date");
			}
			
			PreparedStatement ps_updateRel=con.prepareStatement("update dev_fixture_fixtureno_rel_tbl set fixture_id=?,fixtureNo_id=?,Created_By=?,Created_Date=? where fixt_fixtNo_rel_Id="+rel_id);
			ps_updateRel.setInt(1, getFName_Id);
			ps_updateRel.setInt(2, getFNo_Id);
			ps_updateRel.setInt(3, uid);
			ps_updateRel.setDate(4, Date);
			
			rel_var=ps_updateRel.executeUpdate();
			
			if(rel_var>0)
			{
				PreparedStatement ps_updateRelHist=con.prepareStatement("insert into dev_fixture_fixtureno_rel_tbl_hist(fixt_fixtNo_rel_Id,fixture_Id,fixtureNo_Id,Created_by,Created_date,Created_Date_Hist)values(?,?,?,?,?,?)");
				
				ps_updateRelHist.setInt(1, rel_id);
				ps_updateRelHist.setInt(2, getFName_Id);
				ps_updateRelHist.setInt(3, getFNo_Id);
				ps_updateRelHist.setInt(4, uid);
				ps_updateRelHist.setDate(5, Date);
				ps_updateRelHist.setDate(6, relOrgDate);
				
				relHist_var=ps_updateRelHist.executeUpdate();
				
				if(relHist_var>0)
				{
					System.out.println("rel updated.... id="+rel_id);
				}
			}
			
			
			int FData_var=0;
			int FDataHist_var=0;
			int FD_Id=0;
			Date FData_HistDate=null;
			
			PreparedStatement ps_getFData_Date=con.prepareStatement("select created_date,fd_id from dev_fixturedata_tbl where opnno_opn_rel_id="+vo.getRel_id()+" and mcdata_id="+vo.getMcdataid());
			ResultSet rs_getFData_Date=ps_getFData_Date.executeQuery();
			
			while(rs_getFData_Date.next())
			{
				FData_HistDate=rs_getFData_Date.getDate("created_date");
				FD_Id=rs_getFData_Date.getInt("fd_id");
			}
			rs_getFData_Date.close();
			ps_getFData_Date.close();
			
			PreparedStatement ps_updateFData=con.prepareStatement("update dev_fixturedata_tbl set quotation_date=?,fixture_po_date=?,target_receipt_date=?,actual_receipt_date=?,created_by=?,created_date=?,fixture_po_no=?,fixt_fixtNo_rel_Id=?,fixture_qty=?,avail_qty=? where opnno_opn_rel_id="+vo.getRel_id()+" and mcdata_id="+vo.getMcdataid());
			
			ps_updateFData.setDate(1, vo.getQuotdate());
			ps_updateFData.setDate(2, vo.getPodate());
			ps_updateFData.setDate(3, vo.getTargetrecdate());
			ps_updateFData.setDate(4, vo.getActrecdate());
			ps_updateFData.setInt(5, uid);
			ps_updateFData.setDate(6,Date);
			ps_updateFData.setString(7, vo.getFixtpono());
			ps_updateFData.setInt(8, rel_id);
			ps_updateFData.setInt(9,vo.getFixtqty());
			ps_updateFData.setInt(10, vo.getFixAvail());
			
			FData_var=ps_updateFData.executeUpdate();
			
			if(FData_var>0)
			{
				PreparedStatement ps_addFD_Hist=con.prepareStatement("insert into dev_fixturedata_tbl_hist(fd_id,quotation_date,fixture_po_date,target_receipt_date,actual_receipt_date,created_by,created_date,mcdata_id,fixture_po_no,created_date_hist,fixt_fixtNo_rel_Id,opnno_opn_rel_id,fixture_qty,avail_qty)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				
				ps_addFD_Hist.setInt(1, FD_Id);
				ps_addFD_Hist.setDate(2, vo.getQuotdate());
				ps_addFD_Hist.setDate(3, vo.getPodate());
				ps_addFD_Hist.setDate(4, vo.getTargetrecdate());
				ps_addFD_Hist.setDate(5, vo.getActrecdate());
				ps_addFD_Hist.setInt(6, uid);
				ps_addFD_Hist.setDate(7,Date);
				ps_addFD_Hist.setInt(8,vo.getMcdataid());
				ps_addFD_Hist.setString(9, vo.getFixtpono());
				ps_addFD_Hist.setDate(10,FData_HistDate);
				ps_addFD_Hist.setInt(11, rel_id);
				ps_addFD_Hist.setInt(12,vo.getRel_id());
				ps_addFD_Hist.setInt(13,vo.getFixtqty());
				ps_addFD_Hist.setInt(14, vo.getFixAvail());
				
				FDataHist_var=ps_addFD_Hist.executeUpdate();
				
				if(FDataHist_var>0)
				{
					System.out.println("Fixture data update ... hist added.... ");
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
