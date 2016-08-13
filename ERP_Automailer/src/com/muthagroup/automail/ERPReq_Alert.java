package com.muthagroup.automail;

import java.util.Date;
import java.util.TimerTask;

public class ERPReq_Alert extends TimerTask {
	@Override
	public void run() {
		try {
			Date d = new Date();
			String weekday[] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
			/*if ((!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 11 && d.getMinutes() == 01) ||
				(!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 14 && d.getMinutes() == 30) ||
				(!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 16 && d.getMinutes() == 30)
			){*/
			if ((!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 11 && d.getMinutes() == 01) ||
				(!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 14 && d.getMinutes() == 30) ||
				(!weekday[d.getDay()].equals("Tuesday") && d.getHours() == 16 && d.getMinutes() == 30)){
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
