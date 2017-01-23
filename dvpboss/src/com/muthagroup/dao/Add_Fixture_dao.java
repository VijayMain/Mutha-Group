package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Add_Fixture_vo;

public class Add_Fixture_dao {

	boolean flag=false;
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	
	public boolean addFixture(Add_Fixture_vo vo, HttpServletRequest request) 
	{
		try
		{
			int uid=0;
			HttpSession session=request.getSession();
			uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			Connection con=Connection_Utility.getConnection();
			
			int maxFixture_Id=0;
			boolean chkfixtureFlag=false;
			boolean fixtureFlag=false;
			
			int addFixt_var=0;
			int addFixtHist_var=0;
					
			PreparedStatement ps_chkFixture=con.prepareStatement("select fixture_id,fixture_name from dev_fixture_mst_tbl");
			ResultSet rs_chkFixture=ps_chkFixture.executeQuery();
			
			while(rs_chkFixture.next())
			{
				if(vo.getFixture().equalsIgnoreCase(rs_chkFixture.getString("fixture_name")))
				{
					maxFixture_Id=rs_chkFixture.getInt("fixture_id");
					chkfixtureFlag=true;
				}
			}
			rs_chkFixture.close();
			ps_chkFixture.close();
			
			if(chkfixtureFlag==true)
			{
				System.out.println("fixture matched...."+maxFixture_Id);
				fixtureFlag=true;
			}
			else
			{
				PreparedStatement ps_addFixture=con.prepareStatement("insert into dev_fixture_mst_tbl(Fixture_Name,Created_by,Created_Date)values(?,?,?)");
				ps_addFixture.setString(1, vo.getFixture());
				ps_addFixture.setInt(2, uid);
				ps_addFixture.setDate(3, Date);
				
				addFixt_var=ps_addFixture.executeUpdate();
				
				if(addFixt_var>0)
				{
					PreparedStatement ps_getMaxFixtureId=con.prepareStatement("select max(FIxture_Id) from dev_fixture_mst_tbl");
					ResultSet rs_getMaxFixtureId=ps_getMaxFixtureId.executeQuery();
					while(rs_getMaxFixtureId.next())
					{
						maxFixture_Id=rs_getMaxFixtureId.getInt("max(Fixture_Id)");
					}
					
					PreparedStatement ps_addFixtureHist=con.prepareStatement("insert into dev_fixture_mst_tbl_hist(fixture_Id,fixture_Name,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
					ps_addFixtureHist.setInt(1, maxFixture_Id);
					ps_addFixtureHist.setString(2, vo.getFixture());
					ps_addFixtureHist.setInt(3, uid);
					ps_addFixtureHist.setDate(4, Date);
					ps_addFixtureHist.setDate(5, Date);
					
					addFixtHist_var=ps_addFixtureHist.executeUpdate();
					
					if(addFixtHist_var>0)
					{
						System.out.println("fixture not matched....history added ..."+maxFixture_Id);
						fixtureFlag=true;
					}
				
				}
			}
			
			boolean addFixtureNoFlag=false;
			boolean FixtureNoFlag=false;
			int maxFixtureNoId=0;
			
			int addFixtureNo_var=0;
			int addFixtureNoHist_var=0;
			
			
			PreparedStatement ps_chkFixtureNo=con.prepareStatement("select FixtureNo_Id,Fixture_No from dev_fixture_no_mst_tbl");
			ResultSet rs_chkFixtureNo=ps_chkFixtureNo.executeQuery();
			
			while(rs_chkFixtureNo.next())
			{
				if(rs_chkFixtureNo.getString("Fixture_No").equalsIgnoreCase(vo.getFixture_no()))
				{
					maxFixtureNoId=rs_chkFixtureNo.getInt("FixtureNo_Id");
					addFixtureNoFlag=true;
				}
			}
			
			if(addFixtureNoFlag==true)
			{
				System.out.println("fixture no matched..."+maxFixtureNoId);
				FixtureNoFlag=true;
			}
			else
			{
				PreparedStatement ps_addFixtureNo=con.prepareStatement("insert into dev_fixture_no_mst_tbl(Fixture_No,Created_By,Created_Date)values(?,?,?)");
				ps_addFixtureNo.setString(1, vo.getFixture_no());
				ps_addFixtureNo.setInt(2, uid);
				ps_addFixtureNo.setDate(3, Date);
				
				addFixtureNo_var=ps_addFixtureNo.executeUpdate();
				
				if(addFixtureNo_var>0)
				{
					PreparedStatement ps_getMaxFixtureNo_Id=con.prepareStatement("select max(FixtureNo_Id) from dev_fixture_no_mst_tbl");
					ResultSet rs_getMaxFixtureNo_Id=ps_getMaxFixtureNo_Id.executeQuery();
					
					while(rs_getMaxFixtureNo_Id.next())
					{
						maxFixtureNoId=rs_getMaxFixtureNo_Id.getInt("max(FixtureNo_Id)");
					}
					
					
					PreparedStatement ps_addFixtureNo_Hist=con.prepareStatement("insert into dev_fixture_no_mst_tbl_hist(FixtureNo_Id,Fixture_No,Created_By,Created_Date,Created_Date_Hist)values(?,?,?,?,?)");
					ps_addFixtureNo_Hist.setInt(1, maxFixtureNoId);
					ps_addFixtureNo_Hist.setString(2, vo.getFixture_no());
					ps_addFixtureNo_Hist.setInt(3, uid);
					ps_addFixtureNo_Hist.setDate(4, Date);
					ps_addFixtureNo_Hist.setDate(5, Date);
					
					addFixtureNoHist_var=ps_addFixtureNo_Hist.executeUpdate();
					
					if(addFixtureNoHist_var>0)
					{
						FixtureNoFlag=true;
						System.out.println("fixture no not matched ... max fixture no id..."+maxFixtureNoId);
					}
					
				}
			}
			
			int addRel_var=0;
			int addRelHist_var=0;
			int maxRelId=0;
			int addMCData_var=0;
			int addMCDataHist_var=0;
			
			int maxFDataId=0;
			
			if(fixtureFlag==true && FixtureNoFlag==true)
			{
				PreparedStatement ps_addFixtFixtNoRelNo=con.prepareStatement("insert into dev_fixture_fixtureno_rel_tbl(fixture_id,fixtureNo_id,Created_By,Created_Date)values(?,?,?,?)");
				
				ps_addFixtFixtNoRelNo.setInt(1, maxFixture_Id);
				ps_addFixtFixtNoRelNo.setInt(2, maxFixtureNoId);
				ps_addFixtFixtNoRelNo.setInt(3, uid);
				ps_addFixtFixtNoRelNo.setDate(4, Date);
				
				addRel_var=ps_addFixtFixtNoRelNo.executeUpdate();
				
				if(addRel_var>0)
				{
					PreparedStatement ps_getMaxRelId=con.prepareStatement("select max(fixt_fixtNo_rel_Id) from dev_fixture_fixtureno_rel_tbl");
					ResultSet rs_getMaxRelId=ps_getMaxRelId.executeQuery();
					
					while(rs_getMaxRelId.next())
					{
						maxRelId=rs_getMaxRelId.getInt("max(fixt_fixtNo_rel_Id)");
					}
					
					PreparedStatement ps_addFixtFixtNoRelNo_hist=con.prepareStatement("insert into dev_fixture_fixtureno_rel_tbl_hist(fixt_fixtNo_rel_Id,fixture_Id,fixtureNo_Id,Created_by,Created_date,Created_Date_Hist)values(?,?,?,?,?,?)");
					
					ps_addFixtFixtNoRelNo_hist.setInt(1, maxRelId);
					ps_addFixtFixtNoRelNo_hist.setInt(2, maxFixture_Id);
					ps_addFixtFixtNoRelNo_hist.setInt(3, maxFixtureNoId);
					ps_addFixtFixtNoRelNo_hist.setInt(4, uid);
					ps_addFixtFixtNoRelNo_hist.setDate(5, Date);
					ps_addFixtFixtNoRelNo_hist.setDate(6, Date);
					
					addRelHist_var=ps_addFixtFixtNoRelNo_hist.executeUpdate();
					
					if(addRelHist_var>0)
					{
						 
						PreparedStatement ps_addFData=con.prepareStatement("insert into dev_fixturedata_tbl(quotation_date,fixture_po_date,target_receipt_date,actual_receipt_date,created_by,created_date,mcdata_id,fixture_po_no,fixt_fixtNo_rel_Id,opnno_opn_rel_id,fixture_qty,avail_qty)values(?,?,?,?,?,?,?,?,?,?,?,?)");
						ps_addFData.setDate(1, vo.getQuotdate());
						ps_addFData.setDate(2, vo.getPodate());
						ps_addFData.setDate(3, vo.getTargetrecdate());
						ps_addFData.setDate(4, vo.getActrecdate());
						ps_addFData.setInt(5, uid);
						ps_addFData.setDate(6, Date);
						ps_addFData.setInt(7, vo.getMcdataid());
						ps_addFData.setString(8, vo.getFixtpono());
						ps_addFData.setInt(9, maxRelId);
						ps_addFData.setInt(10, vo.getRel_id());
						ps_addFData.setInt(11, vo.getFix_qty());
						ps_addFData.setInt(12, vo.getFixAvail());
						
						addMCData_var=ps_addFData.executeUpdate();
						
						if(addMCData_var>0)
						{
							PreparedStatement ps_getMaxFDataId=con.prepareStatement("select max(fd_id) from dev_fixturedata_tbl");
							ResultSet rs_getMaxFDataId=ps_getMaxFDataId.executeQuery();
							while(rs_getMaxFDataId.next())
							{
								maxFDataId=rs_getMaxFDataId.getInt("max(fd_id)");
							}
							
							PreparedStatement ps_addFData_Hist=con.prepareStatement("insert into dev_fixturedata_tbl_hist(fd_id,quotation_date,fixture_po_date,target_receipt_date,actual_receipt_date,created_by,created_date,mcdata_id,fixture_po_no,created_date_hist,fixt_fixtNo_rel_Id,opnno_opn_rel_id,fixture_qty,avail_qty)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
							
							ps_addFData_Hist.setInt(1, maxFDataId);
							ps_addFData_Hist.setDate(2, vo.getQuotdate());
							ps_addFData_Hist.setDate(3, vo.getPodate());
							ps_addFData_Hist.setDate(4, vo.getTargetrecdate());
							ps_addFData_Hist.setDate(5, vo.getActrecdate());
							ps_addFData_Hist.setInt(6, uid);
							ps_addFData_Hist.setDate(7, Date);
							ps_addFData_Hist.setInt(8, vo.getMcdataid());
							ps_addFData_Hist.setString(9, vo.getFixtpono());
							ps_addFData_Hist.setDate(10, Date);
							ps_addFData_Hist.setInt(11, maxRelId);
							ps_addFData_Hist.setInt(12, vo.getRel_id());
							ps_addFData_Hist.setInt(13, vo.getFix_qty());
							ps_addFData_Hist.setInt(14, vo.getFixAvail());
							
							addMCDataHist_var=ps_addFData_Hist.executeUpdate();
							
							if(addMCDataHist_var>0)
							{
								flag=true;
								System.out.println("Success.....");
							}
							
						}
					}
					
				}
			}
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}

}
