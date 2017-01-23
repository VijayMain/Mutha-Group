package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.connectionModel.Connection_Utility;
import com.muthagroup.vo.Edit_Operation_vo;


public class Edit_Operation_dao 
{
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	boolean flag=false;
	public boolean editOpration(Edit_Operation_vo vo, HttpServletRequest request) 
	{
		try
		{
			Connection con=Connection_Utility.getConnection();
			int uid=0;
			
			HttpSession session=request.getSession();
			
			uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			int maxOpn_id=0;
			
			int editOpn_var=0;
			int addOpn_var=0;
			int addNewOpn_var=0;
			int addNewOpnHist_var=0;
			
			java.sql.Date histDate=null;
			
			boolean sendOpn_flag=false;
			boolean chkOpn_flag1=false;
			boolean chkOpn_flag=false;
			
			if(vo.getNew_operation()!=null)
			{
				PreparedStatement ps_chkOpn=con.prepareStatement("select opn_id,operation from dev_operation_mst_tbl");
				ResultSet rs_chkOpn=ps_chkOpn.executeQuery();
				
				
				while(rs_chkOpn.next())
				{
					if(vo.getNew_operation().equalsIgnoreCase(rs_chkOpn.getString("operation")))
					{
						maxOpn_id=rs_chkOpn.getInt("opn_id");
						chkOpn_flag1=true;
					}
				}
				rs_chkOpn.close();
				ps_chkOpn.close();
				
				if(chkOpn_flag1==false)
				{
					PreparedStatement ps_addNewOpn=con.prepareStatement("insert into dev_operation_mst_tbl(operation,created_by,created_date)values(?,?,?)");
					ps_addNewOpn.setString(1, vo.getNew_operation());
					ps_addNewOpn.setInt(2, uid);
					ps_addNewOpn.setDate(3, Date);
					
					addNewOpn_var=ps_addNewOpn.executeUpdate();
					
					if(addNewOpn_var>0)
					{
						PreparedStatement ps_getMaxID=con.prepareStatement("select max(opn_id) from dev_operation_mst_tbl");
						ResultSet rs_getMaxID=ps_getMaxID.executeQuery();
						
						while(rs_getMaxID.next())
						{
							maxOpn_id=rs_getMaxID.getInt("max(opn_id)");
						}
						rs_getMaxID.close();
						ps_getMaxID.close();
						
						PreparedStatement ps_addNewOpn_Hist=con.prepareStatement("insert into dev_operation_mst_tbl_hist(opn_id,operation,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
						
						ps_addNewOpn_Hist.setInt(1, maxOpn_id);
						ps_addNewOpn_Hist.setString(2, vo.getNew_operation());
						ps_addNewOpn_Hist.setInt(3, uid);
						ps_addNewOpn_Hist.setDate(4, Date);
						ps_addNewOpn_Hist.setDate(5, Date);
						
						addNewOpnHist_var=ps_addNewOpn_Hist.executeUpdate();
						
						if(addNewOpnHist_var>0)
						{
							System.out.println("new opn added ..... opn id="+maxOpn_id);
							chkOpn_flag1=true;
						}
					}
					
				}
				sendOpn_flag=true;
			}
			else
			{
			PreparedStatement ps_chkOpn=con.prepareStatement("select opn_id,operation from dev_operation_mst_tbl");
			ResultSet rs_chkOpn=ps_chkOpn.executeQuery();
			
			
			while(rs_chkOpn.next())
			{
				if(vo.getOperation().equalsIgnoreCase(rs_chkOpn.getString("operation")))
				{
					maxOpn_id=rs_chkOpn.getInt("opn_id");
					chkOpn_flag=true;
				}
			}
			
			if(chkOpn_flag==true)
			{
				System.out.println("Operation matched... maxOpn id="+maxOpn_id);
				sendOpn_flag=true;
			}
			else
			{
				PreparedStatement ps_getDate=con.prepareStatement("select created_date from dev_operation_mst_tbl where opn_id="+vo.getAvail_opn_id());
				ResultSet rs_getDate=ps_getDate.executeQuery();
				
				while(rs_getDate.next())
				{
					histDate=rs_getDate.getDate("created_date");
				}
				
				PreparedStatement ps_editOperation=con.prepareStatement("update dev_operation_mst_tbl set operation=?,created_by=?,created_date=? where opn_id="+vo.getAvail_opn_id());
				
				ps_editOperation.setString(1, vo.getOperation());
				ps_editOperation.setInt(2, uid);
				ps_editOperation.setDate(3, Date);
				
				editOpn_var=ps_editOperation.executeUpdate();
				
				if(editOpn_var>0)
				{
					PreparedStatement ps_addOpnHist=con.prepareStatement("insert into dev_operation_mst_tbl_hist(opn_id,operation,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
					ps_addOpnHist.setInt(1, vo.getAvail_opn_id());
					ps_addOpnHist.setString(2, vo.getOperation());
					ps_addOpnHist.setInt(3, uid);
					ps_addOpnHist.setDate(4, Date);
					ps_addOpnHist.setDate(5, histDate);
					
					addOpn_var=ps_addOpnHist.executeUpdate();
					
					if(addOpn_var>0)
						
					{
						maxOpn_id=vo.getAvail_opn_id();
						sendOpn_flag=true;
					}
					
				}
				
			}
			}
			
			int maxOpnNo_id=0;
			
			boolean chkOpnNo_flag=false;
			boolean chkOpnNo_flag1=false;
			
			int editOpnNo_var=0;
			int addOpnNo_var=0;
			int addNewOpnNo_var=0;
			int addNewOpnNoHist_var=0;
			
			java.sql.Date histOpnNoDate=null;
			java.sql.Date histRelDate=null;
			
			
			boolean sendOPnNo_flag=false;
			
			
			if(vo.getNewOpn_no()!=0)
			{

				PreparedStatement ps_chkOpnNo=con.prepareStatement("select opnno_id,opn_no from dev_operation_no_mst_tbl");
				ResultSet rs_chkOpnNo=ps_chkOpnNo.executeQuery();
				
				
				while(rs_chkOpnNo.next())
				{
					if(vo.getNewOpn_no()==rs_chkOpnNo.getInt("opn_no"))
					{
						maxOpnNo_id=rs_chkOpnNo.getInt("opnno_id");
						chkOpnNo_flag1=true;
					}
				}
				rs_chkOpnNo.close();
				ps_chkOpnNo.close();
				
				
				if(chkOpnNo_flag1==false)
				{
					PreparedStatement ps_addNewOpnNo=con.prepareStatement("insert into dev_operation_no_mst_tbl(opn_no,created_by,created_date)values(?,?,?)");
					
					ps_addNewOpnNo.setInt(1, vo.getNewOpn_no());
					ps_addNewOpnNo.setInt(2, uid);
					ps_addNewOpnNo.setDate(3, Date);
					
					addNewOpnNo_var=ps_addNewOpnNo.executeUpdate();
					
					if(addNewOpnNo_var>0)
					{
						PreparedStatement ps_getMaxId=con.prepareStatement("select max(opnno_id) from dev_operation_no_mst_tbl");
						ResultSet rs_getMaxId=ps_getMaxId.executeQuery();
						
						while(rs_getMaxId.next())
						{
							maxOpnNo_id=rs_getMaxId.getInt("max(opnno_id)");
						}
						rs_getMaxId.close();
						ps_getMaxId.close();
						
						PreparedStatement ps_addNewOpnNo_hist=con.prepareStatement("insert into dev_operation_no_mst_tbl_hist(opnno_id,opn_no,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
						
						ps_addNewOpnNo_hist.setInt(1, maxOpnNo_id);
						ps_addNewOpnNo_hist.setInt(2, vo.getNewOpn_no());
						ps_addNewOpnNo_hist.setInt(3, uid);
						ps_addNewOpnNo_hist.setDate(4, Date);
						ps_addNewOpnNo_hist.setDate(5, Date);
						
						addNewOpnNoHist_var=ps_addNewOpnNo_hist.executeUpdate();
						
						if(addNewOpnNoHist_var>0)
						{
							System.out.println("new operation no added....max op no id="+maxOpnNo_id);
						}
						
					}
					
				}
				sendOPnNo_flag=true;
				
			}
			else
			{
		
			
			PreparedStatement ps_chkOpnNo=con.prepareStatement("select opnno_id,opn_no from dev_operation_no_mst_tbl");
			ResultSet rs_chkOpnNo=ps_chkOpnNo.executeQuery();
			
			
			while(rs_chkOpnNo.next())
			{
				if(vo.getOpno()==rs_chkOpnNo.getInt("opn_no"))
				{
					maxOpnNo_id=rs_chkOpnNo.getInt("opnno_id");
					chkOpnNo_flag=true;
				}
			}
			
			if(chkOpnNo_flag==true)
			{
				System.out.println("Operation No matched... maxOpn No id="+maxOpnNo_id);
				sendOPnNo_flag=true;
			}
			
			else
			{
				PreparedStatement ps_getDateNo=con.prepareStatement("select created_date from dev_operation_no_mst_tbl where opnno_id="+vo.getAvail_opn_no_id());
				ResultSet rs_getDateNo=ps_getDateNo.executeQuery();
				
				while(rs_getDateNo.next())
				{
					histOpnNoDate=rs_getDateNo.getDate("created_date");
				}
				
				PreparedStatement ps_editOperationNo=con.prepareStatement("update dev_operation_no_mst_tbl set opn_no=?,created_by=?,created_date=? where opnno_id="+vo.getAvail_opn_no_id());
				
				ps_editOperationNo.setInt(1, vo.getOpno());
				ps_editOperationNo.setInt(2, uid);
				ps_editOperationNo.setDate(3, Date);
				
				editOpnNo_var=ps_editOperationNo.executeUpdate();
				
				if(editOpnNo_var>0)
				{
					PreparedStatement ps_addOpnNoHist=con.prepareStatement("insert into dev_operation_no_mst_tbl_hist(opnno_id,opn_no,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
					ps_addOpnNoHist.setInt(1, vo.getAvail_opn_no_id());
					ps_addOpnNoHist.setInt(2, vo.getOpno());
					ps_addOpnNoHist.setInt(3, uid);
					ps_addOpnNoHist.setDate(4, Date);
					ps_addOpnNoHist.setDate(5, histOpnNoDate);
					
					addOpnNo_var=ps_addOpnNoHist.executeUpdate();
					
					if(addOpnNo_var>0)
						
					{
						maxOpnNo_id=vo.getAvail_opn_id();
						sendOPnNo_flag=true;
					}
					
				}
				
			}
			}
			if(sendOpn_flag==true && sendOPnNo_flag==true)
			{
				
			PreparedStatement ps_getRelDate=con.prepareStatement("select Created_Date from dev_opn_opnno_rel_tbl where opnno_opn_rel_id="+vo.getRel_id());
			ResultSet rs_getRelDate=ps_getRelDate.executeQuery();
			while(rs_getRelDate.next())
			{
				System.out.println("final...2");
				histRelDate=rs_getRelDate.getDate("Created_Date");
			}
			
			int rel_var=0;
			int relHist_var=0;
			
			PreparedStatement ps_updateRel=con.prepareStatement("update dev_opn_opnno_rel_tbl set opnno_id=?,opn_id=?,Created_Date=?,Created_By=? where opnno_opn_rel_id="+vo.getRel_id());
			
			ps_updateRel.setInt(1, maxOpnNo_id);
			ps_updateRel.setInt(2, maxOpn_id);
			ps_updateRel.setDate(3, histRelDate);
			ps_updateRel.setInt(4, uid);
			
			rel_var=ps_updateRel.executeUpdate();
			
			if(rel_var>0)
			{
				System.out.println("final...1");
				PreparedStatement ps_addRelHist=con.prepareStatement("insert into dev_opn_opnno_rel_tbl_hist(opnno_opn_rel_id,opnno_id,opn_id,Created_Date,Created_Date_Hist,Created_By)values(?,?,?,?,?,?)");
				
				ps_addRelHist.setInt(1, vo.getRel_id());
				ps_addRelHist.setInt(2, vo.getAvail_opn_no_id());
				ps_addRelHist.setInt(3, vo.getAvail_opn_id());
				ps_addRelHist.setDate(4, Date);
				ps_addRelHist.setDate(5, histRelDate);
				ps_addRelHist.setInt(6, uid);
				
				relHist_var=ps_addRelHist.executeUpdate();
				
				if(relHist_var>0)
				{
					System.out.println("final...");
					flag=true;
				}
			}
			

			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return flag;
	}
	public boolean InsertOpImage(int uid, Edit_Operation_vo vo) {
		try {
			int rem=0,att=0,att_hist=0, attach_Id=0, opn_basicId=0;;
			Connection con=Connection_Utility.getConnection();
			PreparedStatement ps_remove=con.prepareStatement("update dev_opopno_attachments_tbl set Enable_Id=0 where Enable_Id=1 and Opn_Basic_Id=(select Opn_Basic_Id from dev_opnandopnno_basic_rel_tbl where Basic_Id="+vo.getBasic_id()+" and OpnNo_Opn_Rel_Id="+vo.getRel_id()+")");
			rem = ps_remove.executeUpdate();
			ps_remove.close();
			
			PreparedStatement ps_selrel=con.prepareStatement("select Opn_Basic_Id from dev_opnandopnno_basic_rel_tbl where OpnNo_Opn_Rel_Id="+vo.getRel_id()+" and Basic_Id="+vo.getBasic_id());
			ResultSet rs_selrel=ps_selrel.executeQuery();
			while(rs_selrel.next()){
				opn_basicId = rs_selrel.getInt("Opn_Basic_Id");
			}
			ps_selrel.close();
			rs_selrel.close();
			
			PreparedStatement ps_op=con.prepareStatement("insert into dev_opopno_attachments_tbl" +
					"(Opn_Basic_Id,file_name,Attachment,Attached_By,Attached_date,Enable_Id)values(?,?,?,?,?,?)");
			ps_op.setInt(1, opn_basicId);
			ps_op.setString(2, vo.getOp_ImageName());
			ps_op.setBlob(3, vo.getOp_Image_blob());
			ps_op.setInt(4, uid);
			ps_op.setDate(5, Date);
			ps_op.setInt(6, 1);
			att = ps_op.executeUpdate();
			ps_op.close();
			
			if(att>0){
				
				PreparedStatement ps_selrel_hist=con.prepareStatement("select max(dev_opopno_attach_id) from dev_opopno_attachments_tbl");
				ResultSet rs_selrel_hist=ps_selrel_hist.executeQuery();
				while(rs_selrel_hist.next()){
					attach_Id = rs_selrel_hist.getInt("max(dev_opopno_attach_id)");
				}
				ps_selrel_hist.close();
				rs_selrel_hist.close();
				
				
				PreparedStatement ps_ophist=con.prepareStatement("insert into dev_opopno_attachments_tbl_hist" +
						"(Opn_Basic_Id,file_name,Attachment,Attached_By,Attached_date,Enable_Id,Attached_date_hist,dev_opopno_attach_id)values(?,?,?,?,?,?,?,?)");
				ps_ophist.setInt(1, opn_basicId);
				ps_ophist.setString(2, vo.getOp_ImageName());
				ps_ophist.setBlob(3, vo.getOp_Image_blob());
				ps_ophist.setInt(4, uid);
				ps_ophist.setDate(5, Date);
				ps_ophist.setInt(6, 1);
				ps_ophist.setDate(7, Date);
				ps_ophist.setInt(8,attach_Id);
				att_hist = ps_ophist.executeUpdate();
				ps_ophist.close();	
			}
			if(att>0 && att_hist>0){
				flag=true;
			}
			 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}

}
