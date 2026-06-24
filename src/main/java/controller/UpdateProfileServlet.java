package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name    = request.getParameter("name");
        String phone   = request.getParameter("phone");
        String address = request.getParameter("address");

        try {
            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql = "UPDATE users SET name=?, phone=?, address=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setInt(4, userId);
            ps.executeUpdate();

            // Update session so header name updates immediately
            session.setAttribute("userName", name);
            session.setAttribute("userPhone", phone);
            session.setAttribute("userAddress", address);

            response.sendRedirect("profile.jsp?updated=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=true");
        }
    }
}