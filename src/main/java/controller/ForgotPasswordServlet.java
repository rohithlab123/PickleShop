package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String input = request.getParameter("identifier");

        try {
            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql = "SELECT * FROM users WHERE email=? OR phone=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, input);
            ps.setString(2, input);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                int userId = rs.getInt("id");

                HttpSession session = request.getSession();
                session.setAttribute("resetUserId", userId);

                response.sendRedirect("reset-password.jsp");

            } else {
                response.sendRedirect("forgot-password.jsp?error=true");
            }

        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("forgot-password.jsp?error=true");
        }
    }
}