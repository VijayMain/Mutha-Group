package com.muthagroup.controller;

import java.io.IOException; 
import java.util.Timer;
import java.util.TimerTask;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Automailer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			// ******************************************************************************************************************
			Timer timer = new Timer();
  
			TimerTask complaintZilla_alert = new ComplaintZilla_alert();
			timer.schedule(complaintZilla_alert, 1000, 55000);
			
			TimerTask complaintZilla_PlantHalert = new ComplaintZilla_PlantHalert();
			timer.schedule(complaintZilla_PlantHalert, 1000, 55000);
			
			
			/*
			
			TimerTask timerTask3 = new Repetative_Task_24Hours_Remainder();
			timer.schedule(timerTask3, 10000, 60000);
			
			TimerTask timerTask1 = new Repetative_Task_Regular();
			timer.schedule(timerTask1, 1000, 20000);
			 
			TimerTask timeECN = new ECN_Automailer();
			timer.schedule(timeECN, 1000, 55000);
			
			TimerTask ECN_cust = new ECN_Customer_mailer();
			timer.schedule(ECN_cust, 1000, 55000);
			
			// No Action ===>
			TimerTask ECN_NoAction = new ECN_NoAction_mailer();
			timer.schedule(ECN_NoAction, 1000, 55000);
			
			TimerTask ECN_NoActionCust = new ECN_NoAction_Custmailer();
			timer.schedule(ECN_NoActionCust, 1000, 55000);
			
			// Check Action ===>
			TimerTask ECN_CheckAction = new ECN_CheckAction_mailer();
			timer.schedule(ECN_CheckAction, 1000, 55000);			
			
			TimerTask ECN_CustActionCheck = new ECN_ActionCustCheck_mailer();
			timer.schedule(ECN_CustActionCheck, 1000, 55000);
			
			TimerTask ECNCounts = new ECN_Counts();
			timer.schedule(ECNCounts, 1000, 55000); 
			
			TimerTask complaintZilla_alert = new ComplaintZilla_alert();
			timer.schedule(complaintZilla_alert, 1000, 55000);
			
			TimerTask complaintZilla_PlantHalert = new ComplaintZilla_PlantHalert();
			timer.schedule(complaintZilla_PlantHalert, 1000, 55000);
			
			
			*/
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		// ******************************************************************************************************************
		
		
		
		// ******************************************************************************************************************
		// Thread No 2
		// ******************************************************************************************************************

		// TimerTask timerTask2 = new Repetative_Task_Remainder();
		// timer.schedule(timerTask2, 1000, 60000);

		// ******************************************************************************************************************
					// Thread No 4
					// ******************************************************************************************************************
				//	Unassigned Automailer Block This	
				//	TimerTask timerTask4 = new Repetative_Task_Automail();
				//	timer.schedule(timerTask4, 10000, 60000);

					// ******************************************************************************************************************
					// ******************************************************************************************************************
	}
}