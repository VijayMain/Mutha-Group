package com.muthagroup.controller;

import com.muthagroup.dao.MuthaGroupDAO;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(value={"/Event"})
public class Event
extends HttpServlet {
    ArrayList<ArrayList<String>> list = new ArrayList<ArrayList<String>>();
    HttpSession session;
    MuthaGroupDAO dao = new MuthaGroupDAO();
    private static final long serialVersionUID = 1;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<String> list = new ArrayList<String>();
        try {
        	session = request.getSession(); 
        	list.add(request.getParameter("date"));//0
            list.add(request.getParameter("text"));//1
            list.add(request.getParameter("start"));//2
            list.add(request.getParameter("end"));//3
            list.add(request.getParameter("venue"));//4
            list.add(request.getParameter("desc"));//5
            list.add(request.getParameter("users"));//6
            list.add(request.getParameter("user"));//7
            
            System.out.println("This is the update = " + list);
            int uid = Integer.parseInt(session.getAttribute("u_id").toString());
            this.dao.saveEvent(list,uid);
            response.sendRedirect("mainpage.jsp");
            /*RequestDispatcher view = this.getServletContext().getRequestDispatcher("/mainpage.jsp");
            view.forward((ServletRequest)request, (ServletResponse)response);
*/        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
