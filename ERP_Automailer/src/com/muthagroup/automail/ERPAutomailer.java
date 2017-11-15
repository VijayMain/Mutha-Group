package com.muthagroup.automail;

import java.io.IOException;
import java.util.Timer; 
import java.util.TimerTask;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ERPAutomailer extends HttpServlet {
private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*______________________________________________________________________________________________________________________________*/
		/*______________________________________________________________________________________________________________________________*/
		try {
			Timer timer = new Timer();
			// ******************************************************************************************************************
			// Thread No 1
			// ******************************************************************************************************************
  
			// 09:40
			TimerTask  siscompSale =new SisterCompanySale_Report();
			timer.schedule(siscompSale, 1000, 60000);
			
			// 09:42
			TimerTask  wo_boring =new WO_Expected_Boring();
			timer.schedule(wo_boring, 1000, 60000);
			
			
			// 10:01  &  16:01
			TimerTask timerTask1 = new Purchase_Pending_ApprovalMEPLH21();
			timer.schedule(timerTask1, 1000, 60000);
			
			
			// 10:02  &  16:02
			TimerTask timerTask2 = new Purchase_Pending_ApprovalMEPLH25();
			timer.schedule(timerTask2, 1000, 60000);
			
			// 10:03  &  16:03
			TimerTask timerTask3 = new Purchase_Pending_ApprovalMFPL();
			timer.schedule(timerTask3, 1000, 60000);
			
			// 10:04  &  16:04
			TimerTask timerTask4 = new Purchase_Pending_ApprovalDI();
			timer.schedule(timerTask4, 1000, 60000);
			
			// 10:05  &  16:05
			TimerTask timerTask5 = new Purchase_Pending_ApprovalUnitIII();
			timer.schedule(timerTask5, 1000, 60000);
		  
		  	// 10:10
			TimerTask timerTask10 = new DailySale_MFPL();
			timer.schedule(timerTask10, 1000, 60000);
			
			// 10:11
			TimerTask timerTask7 = new DailySale_H21();
			timer.schedule(timerTask7, 1000, 60000);
			
			// 10:12
			TimerTask timerTask8 = new DailySale_H25();
			timer.schedule(timerTask8, 1000, 60000);
			
			// 10:13
			TimerTask timerTask6 = new DailySale_UnitIII();
			timer.schedule(timerTask6, 1000, 60000);
		 	 
		 	// 10:14
			TimerTask timerTask9 = new DailySale_DI();
			timer.schedule(timerTask9, 1000, 60000);
						
			// 10:15  &  16:10
			TimerTask  timerTask11 =new Purchase_Approved_statusH21();
			timer.schedule(timerTask11, 1000, 60000);
			
			// 10:16  &  16:11
		 	TimerTask  timerTask12 =new Purchase_Approved_statusH25();
			timer.schedule(timerTask12, 1000, 60000);
			
			// 10:17  &  16:12
			TimerTask  timerTask13 =new Purchase_Approved_statusmfpl();
			timer.schedule(timerTask13, 1000, 60000);
			
			// 10:18  &  16:13
			TimerTask  timerTask14 =new Purchase_Approved_statusdi();
			timer.schedule(timerTask14, 1000, 60000);
			
			// 10:19  &  16:14
			TimerTask  timerTask15 =new Purchase_Approved_statusk1();
			timer.schedule(timerTask15, 1000, 60000); 
					
			// 23:45
			TimerTask  timerTask21 =new TransporterWiseSale21();
			timer.schedule(timerTask21, 1000, 60000);
			
			// 23:46
			TimerTask  timerTask22 =new TransporterWiseSale25();
			timer.schedule(timerTask22, 1000, 60000);
			
			// 23:47
			TimerTask  timerTask23 =new TransporterWiseSaleMFPL();
			timer.schedule(timerTask23, 1000, 60000);
			
			// 23:48
			TimerTask  timerTask24 =new TransporterWiseSaleDI();
			timer.schedule(timerTask24, 1000, 60000);
			
			// 23:49
			TimerTask  timerTask25 =new TransporterWiseSaleK1();
			timer.schedule(timerTask25, 1000, 60000);
			
			// 15:30
			TimerTask  timerTask16 =new Purchase_PendDues_Stat21();
			timer.schedule(timerTask16, 1000, 60000);			
			
			// 15:36
			TimerTask  timerTask19 =new Purchase_PendDues_StatMFPL();
			timer.schedule(timerTask19, 1000, 60000);
						
			// 15:34
			TimerTask  timerTask18 =new Purchase_PendDues_StatDI();
			timer.schedule(timerTask18, 1000, 60000);
			
			// 15:39
			TimerTask  timerTask17 =new Purchase_PendDues_Stat25();
			timer.schedule(timerTask17, 1000, 60000);
			
			// 15:42
			TimerTask  timerTask20 =new Purchase_PendDues_StatK1();
			timer.schedule(timerTask20, 1000, 60000);
		
			
			
			// 11:01 | 14:30 | 16:30
			TimerTask  reqalert =new ERPReq_Alert();
			timer.schedule(reqalert, 1000, 60000);
			
			// 10:22
			TimerTask  poWithoutGRN =new POWithoutGRN();
			timer.schedule(poWithoutGRN, 1000, 60000);
			
			// 10:23
			TimerTask  issueWithoutWO = new IssueWithoutWO();
			timer.schedule(issueWithoutWO, 1000, 60000);
			
			// 10:29
			TimerTask  poWithoutGRN_1000 =new POWithoutGRN_1000();
			timer.schedule(poWithoutGRN_1000, 1000, 60000);
			
			// 10:30
			TimerTask  timerTaskSupplier =new Supplier_ReportFND();
			timer.schedule(timerTaskSupplier, 1000, 60000); 
			 
			// 10:35
			TimerTask  timerInOut =new InOut_Register();
			timer.schedule(timerInOut, 1000, 60000);  
			 
						// 13:57
						TimerTask  timerTaskMISF =new MIS_SummaryReportFND();
						timer.schedule(timerTaskMISF, 1000, 60000); 
			  			
			 			// 13:59
						TimerTask  timerTaskMISDI =new MIS_SummaryReportDI();
						timer.schedule(timerTaskMISDI, 1000, 60000);
						
						// 13:55
						TimerTask  timerTaskMISUIII=new MIS_SummaryReportK1();
						timer.schedule(timerTaskMISUIII, 1000, 60000);
						
						// 09:43
						TimerTask  valid_limitPOH21 = new Valid_limitPO();
						timer.schedule(valid_limitPOH21, 1000, 60000);
						
						// 09:45
						TimerTask  valid_limitPOH25 = new Valid_limitPOH25();
						timer.schedule(valid_limitPOH25, 1000, 60000);
						
						// 09:47
						TimerTask  valid_limitPOMFPL = new Valid_limitPOMFPL();
						timer.schedule(valid_limitPOMFPL, 1000, 60000);
						
						// 09:49
						TimerTask  valid_limitPODI = new Valid_limitPODI();
						timer.schedule(valid_limitPODI, 1000, 60000);
			
						// 09:51
						TimerTask  valid_limitPOK1 = new Valid_limitPOK1();
						timer.schedule(valid_limitPOK1, 1000, 60000); 
			 
						// 22:12
						TimerTask tvsMotors = new TvsMotors();
						timer.schedule(tvsMotors, 1000, 60000);
	  
						// 08:10
						TimerTask pending57f4 = new Pending_Challan57f4();
						timer.schedule(pending57f4, 1000, 60000);
						
						// 08:12
						TimerTask pending57f4_h25 = new Pending_Challan57f4_h25();
						timer.schedule(pending57f4_h25, 1000, 60000);
						
						// 08:14
						TimerTask pending57f4_di = new Pending_Challan57f4_di();
						timer.schedule(pending57f4_di, 1000, 60000);
						 
						// 08:16
						TimerTask pending57f4_UIII = new Pending_Challan57f4_UIII();
						timer.schedule(pending57f4_UIII, 1000, 60000);
						
						// 08:18
						TimerTask pending57f4_MFPL = new Pending_Challan57f4_MFPL();
						timer.schedule(pending57f4_MFPL, 1000, 60000);						
			
						// 15:07
						TimerTask closedIndent = new OpenIndent();
						timer.schedule(closedIndent, 1000, 60000);
												
						// 15:05
						TimerTask pendingPO = new ERP_PendingPO();
						timer.schedule(pendingPO, 1000, 60000);
		  
						// 23:30
						TimerTask  shedulexlsSummary =new SaleDispatchxls_Summary();
						timer.schedule(shedulexlsSummary, 1000, 60000); 
			
						// 08:10 | 16:16
						TimerTask  supplierAlert =new SupplierAlert();
						timer.schedule(supplierAlert, 1000, 60000);
			
									
					 
				
				 
				
				
				
				
				
				
			/*
			// 09:33
			TimerTask reqStatus = new ERP_RequisitionStatus();
			timer.schedule(reqStatus, 1000, 60000);
			
			// 09:33
			TimerTask reqStatus = new ERP_RequisitionStatus();
			timer.schedule(reqStatus, 1000, 60000);
			
			// 1:15
			TimerTask  shedulexls_h21 =new SheduleXLSReminder();
			timer.schedule(shedulexls_h21, 1000, 60000);
			*/
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
/*____________________________________________________ End of AutoMailer ___________________________________________________________*/
/*______________________________________________________________________________________________________________________________*/