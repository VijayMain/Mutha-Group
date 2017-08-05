package com.muthagroup.controller;

import com.muthagroup.connection.ConnectionModel;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(value={"/FirstServlet"})
public class FirstServlet
extends HttpServlet {
    private static final long serialVersionUID = 1;
    Connection con = ConnectionModel.getConnection();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String user = request.getParameter("user");
            String pass = request.getParameter("pass");
            String sql = "select * from user_tbl where Login_Name='" + user + "' and Login_Password='" + pass + "' and Enable_id=1";
            PreparedStatement ps = this.con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("user", rs.getString("U_Name"));
                session.setAttribute("u_id", rs.getInt("U_Id"));
                response.sendRedirect("mainpage.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
