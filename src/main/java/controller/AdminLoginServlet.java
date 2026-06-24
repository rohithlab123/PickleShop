package controller;

import java.io.IOException;
import java.sql.*;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("EMAIL = " + email);

        try {

            Connection con = new DBConnection().getconnection();

            String sql = "SELECT * FROM admin WHERE email=? AND password=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                System.out.println("LOGIN SUCCESS");

                HttpSession session = request.getSession(true);

                session.setAttribute("isAdmin", true);
                session.setAttribute("adminEmail", email);
                System.out.println("IS ADMIN = " + session.getAttribute("isAdmin"));
                // ⏱ session timeout (30 min)
                session.setMaxInactiveInterval(30 * 60);

                response.sendRedirect("admin-dashboard.jsp");

            } else {

                System.out.println("LOGIN FAILED");

                response.sendRedirect("admin-login.jsp?error=1");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-login.jsp?error=true");
        }
    }
}