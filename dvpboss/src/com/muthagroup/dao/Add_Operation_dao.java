package com.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.muthagroup.connectionModel.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.muthagroup.vo.Add_Operation_vo;

public class Add_Operation_dao {

	
	boolean flag=false;
	int oprel_id=0;
	int uid=0;
	private static final java.sql.Date Date =new java.sql.Date(System.currentTimeMillis());
	
	public int addOperation(HttpServletRequest request, Add_Operation_vo vo) 
	{
		try
		{
			
			HttpSession session=request.getSession();
			
			uid=Integer.parseInt(session.getAttribute("uid").toString());
			
			Connection con=Connection_Utility.getConnection();

			PreparedStatement ps_chkOpn=null;
			ResultSet rs_chkOpn=null;
			int maxOpnId=0;
			boolean opn_flag=false;
			boolean relflag=false;
			boolean relflag1=false;
			int addOpn=0;
			int addOpnId=0;
			
			
			ps_chkOpn=con.prepareStatement("select opn_id,operation from dev_operation_mst_tbl where operation='"+vo.getOperation()+"'");
			rs_chkOpn=ps_chkOpn.executeQuery();
			
			while(rs_chkOpn.next())
			{
				if(vo.getOperation().equalsIgnoreCase(rs_chkOpn.getString("operation")))
				{
					maxOpnId=rs_chkOpn.getInt("opn_id");
					opn_flag=true;
				}
				
			}
			rs_chkOpn.close();
			ps_chkOpn.close();
			
			if(opn_flag==true)
			{
				System.out.println("Operation matched .... opn_id="+maxOpnId);
				relflag1=true;
				//System.out.println("relflag becomes true....1 ...");
			}
			else
			{
				PreparedStatement ps_addOperation=con.prepareStatement("insert into dev_operation_mst_tbl(operation,created_by,created_date)values(?,?,?)");
				ps_addOperation.setString(1,vo.getOperation());
				ps_addOperation.setInt(2, uid);
				ps_addOperation.setDate(3,Date);
				
				addOpn=ps_addOperation.executeUpdate();
				
				if(addOpn>0)
				{
					PreparedStatement ps_getMaxOpn=con.prepareStatement("select max(Opn_Id) from dev_operation_mst_tbl");
					ResultSet rs_getMaxOpn=ps_getMaxOpn.executeQuery();
					
					while(rs_getMaxOpn.next())
					{
						maxOpnId=rs_getMaxOpn.getInt("max(Opn_Id)");
						
					}
					rs_getMaxOpn.close();
					ps_getMaxOpn.close();
					
					PreparedStatement ps_addOperationHist=con.prepareStatement("insert into dev_operation_mst_tbl_hist(opn_id,operation,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
					
					ps_addOperationHist.setInt(1,maxOpnId);
					ps_addOperationHist.setString(2, vo.getOperation());
					ps_addOperationHist.setInt(3, uid);
					ps_addOperationHist.setDate(4,Date);
					ps_addOperationHist.setDate(5, Date);
					
					addOpnId=ps_addOperationHist.executeUpdate();
					
					if(addOpnId>0)
					{
						System.out.println("operation not matched....History added..opn id="+maxOpnId);
						relflag1=true;
						
						//System.out.println("relflag becomes true....1 ... ");
					}
					
				}
			}
				
			PreparedStatement ps_chkOpnNo=null;
			ResultSet rs_chkOpnNo=null;
			int maxOpnNoId=0;
			boolean opnNo_flag=false;
			int addOpnNo=0;
			int addOpnNoHist=0;
		
			ps_chkOpnNo=con.prepareStatement("select opnno_id,opn_no from dev_operation_no_mst_tbl");
			
			rs_chkOpnNo=ps_chkOpnNo.executeQuery();
			
			while(rs_chkOpnNo.next())
			{
				if(rs_chkOpnNo.getInt("opn_no")==Integer.parseInt(vo.getOpnno()))
				{
					maxOpnNoId=rs_chkOpnNo.getInt("opnno_id");
					opnNo_flag=true;
				}
			}
			rs_chkOpnNo.close();
			ps_chkOpnNo.close();
			
			if(opnNo_flag==true)
			{
				System.out.println("operation no matched.... opn no id="+maxOpnNoId);
				relflag=true;
				//System.out.println("relflag becomes true....");
			}
			else
			{
				PreparedStatement ps_addOpnNo=con.prepareStatement("insert into dev_operation_no_mst_tbl(opn_no,created_by,created_date)values(?,?,?)");
				ps_addOpnNo.setInt(1, Integer.parseInt(vo.getOpnno()));
				ps_addOpnNo.setInt(2,uid);
				ps_addOpnNo.setDate(3,Date);
				
				addOpnNo=ps_addOpnNo.executeUpdate();
				
				if(addOpnNo>0)
				{
					PreparedStatement ps_getMaxOpnNo=con.prepareStatement("select max(opnno_id) from dev_operation_no_mst_tbl");
					ResultSet rs_getMaxOpnNo=ps_getMaxOpnNo.executeQuery();
					
					while(rs_getMaxOpnNo.next())
					{
						maxOpnNoId=rs_getMaxOpnNo.getInt("max(opnno_id)");
					}
					rs_getMaxOpnNo.close();
					ps_getMaxOpnNo.close();
					
					PreparedStatement ps_addOpnNoHist=con.prepareStatement("insert into dev_operation_no_mst_tbl_hist(opnno_id,opn_no,created_by,created_date,created_date_hist)values(?,?,?,?,?)");
					
					ps_addOpnNoHist.setInt(1, maxOpnNoId);
					ps_addOpnNoHist.setString(2, vo.getOpnno());
					ps_addOpnNoHist.setInt(3, uid);
					ps_addOpnNoHist.setDate(4, Date);
					ps_addOpnNoHist.setDate(5, Date);
					
					addOpnNoHist=ps_addOpnNoHist.executeUpdate();
					
					if(addOpnNoHist>0)
					{
						System.out.println("Operation no not matched.... history added... max opn no="+maxOpnNoId);
						relflag=true;
						
						//System.out.println("relflag becomes true....");
					}
				}
			}
					int rel_var=0,relHist_var=0;
					int getMaxRelId=0;
					
					
					if(relflag==true && relflag1==true)
					{
						//System.out.println("*************111111111111***************");
						PreparedStatement ps_addRel=con.prepareStatement("insert into dev_opn_opnno_rel_tbl(opnno_id,opn_id,Created_Date,Created_By)values(?,?,?,?)");
						ps_addRel.setInt(1, maxOpnNoId);
						ps_addRel.setInt(2, maxOpnId);
						ps_addRel.setDate(3, Date);
						ps_addRel.setInt(4, uid);
					
						rel_var=ps_addRel.executeUpdate();
						
						if(rel_var>0)
						{
							//System.out.println("*************2222222222222***************");
							PreparedStatement ps_getMaxRelId=con.prepareStatement("select max(opnno_opn_rel_id) from dev_opn_opnno_rel_tbl");
							ResultSet rs_getMaxRelId=ps_getMaxRelId.executeQuery();
							
							while(rs_getMaxRelId.next())
							{
								getMaxRelId=rs_getMaxRelId.getInt("max(opnno_opn_rel_id)");
								oprel_id = rs_getMaxRelId.getInt("max(opnno_opn_rel_id)");
							}
							
							rs_getMaxRelId.close();
							ps_getMaxRelId.close();
							
							PreparedStatement ps_addRelHist=con.prepareStatement("insert into dev_opn_opnno_rel_tbl_hist(opnno_opn_rel_id,opnno_id,opn_id,Created_Date,Created_Date_Hist,Created_By)values(?,?,?,?,?,?)");
							ps_addRelHist.setInt(1, getMaxRelId);
							ps_addRelHist.setInt(2, maxOpnNoId);
							ps_addRelHist.setInt(3, maxOpnId);
							ps_addRelHist.setDate(4, Date);
							ps_addRelHist.setDate(5, Date);
							ps_addRelHist.setInt(6, uid);
							
							relHist_var=ps_addRelHist.executeUpdate();
							
							if(relHist_var>0)
							{
								//System.out.println("*************3333333333333***************");
								
								int relWithBasic_var=0;
								PreparedStatement ps_relWithBasic=con.prepareStatement("insert into dev_opnandopnno_basic_rel_tbl(OpnNo_Opn_Rel_Id,Basic_Id,Created_Date,Created_By)values(?,?,?,?)");
								
								ps_relWithBasic.setInt(1, getMaxRelId);
								ps_relWithBasic.setInt(2, vo.getBasic_id());
								ps_relWithBasic.setDate(3, Date);
								ps_relWithBasic.setInt(4, uid);
								
								relWithBasic_var=ps_relWithBasic.executeUpdate();
								
								if(relWithBasic_var>0)
								{
									//System.out.println("*************4444444444444444***************");
									int var=0;
									int var1=0;
									PreparedStatement ps_getMaxBasicRel=con.prepareStatement("select max(Opn_Basic_Id) from dev_opnandopnno_basic_rel_tbl");
									ResultSet rs_getMaxBasicRel=ps_getMaxBasicRel.executeQuery();
									while(rs_getMaxBasicRel.next())
									{
										var=rs_getMaxBasicRel.getInt("max(Opn_Basic_Id)");
									}
									
									PreparedStatement ps_relWithBasic_Hist=con.prepareStatement("insert into dev_opnandopnno_basic_rel_tbl_hist(Opn_Basic_Id,OpnNo_Opn_Rel_Id,Basic_Id,Created_Date,Created_Date_Hist,Created_By)values(?,?,?,?,?,?)");
									
									ps_relWithBasic_Hist.setInt(1, var);
									ps_relWithBasic_Hist.setInt(2, getMaxRelId);
									ps_relWithBasic_Hist.setInt(3, vo.getBasic_id());
									ps_relWithBasic_Hist.setDate(4, Date);
									ps_relWithBasic_Hist.setDate(5, Date);
									ps_relWithBasic_Hist.setInt(6, uid);
									
									var1=ps_relWithBasic_Hist.executeUpdate();
									
									
									if(var1>0)
									{
										//System.out.println("*************555555555555***************");
										System.out.println("relation is added with history.... max relId="+getMaxRelId);
										flag=true;
									}	
								}
								
							}
						}
					}
				
		
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		if(flag==true){
		
		return oprel_id;
		}else {
			return 0;
		}
		
	}

	public boolean insert_image(int uid2, Add_Operation_vo vo, int op_rel_id) {
		int opn_basicId=0,att=0,att_hist=0,attach_Id=0;
		try {
			Connection con=Connection_Utility.getConnection();
			PreparedStatement ps_selrel=con.prepareStatement("select Opn_Basic_Id from dev_opnandopnno_basic_rel_tbl where OpnNo_Opn_Rel_Id="+op_rel_id+" and Basic_Id="+vo.getBasic_id());
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
			ps_op.setInt(4, uid2);
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
				ps_ophist.setInt(4, uid2);
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

