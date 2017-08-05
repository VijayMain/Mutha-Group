package com.muthagroup.controller;

import com.muthagroup.dao.MuthaGroupDAO;
import com.muthagroup.vo.MuthaGroupVO;
import java.util.ArrayList;

public class DailyReport {
    MuthaGroupDAO dao = new MuthaGroupDAO();
    MuthaGroupVO vo = new MuthaGroupVO();

 public ArrayList<ArrayList<String>> getList() {
        try {
            this.vo.setList(this.dao.getReport(this.vo));
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return this.vo.getList();
    }
 
 public ArrayList<ArrayList<String>> getTodayList() {
     try {
         this.vo.setList(this.dao.getTodayReport(this.vo));
     }
     catch (Exception e) {
         e.printStackTrace();
     }
     return this.vo.getList();
 }
}
