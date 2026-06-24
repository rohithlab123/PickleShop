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

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("resetEmail");

        if (email == null) {
            response.sendRedirect("forgot-password.jsp");
            return;
        }

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {

            // 🔐 check passwords match
            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect("reset-password.jsp?error=match");
                return;
            }

            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql = "UPDATE users SET password=? WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, newPassword); // ⚠️ (you can hash later)
            ps.setString(2, email);

            int updated = ps.executeUpdate();

            if (updated > 0) {

                // 🧹 clear session (VERY IMPORTANT)
                session.removeAttribute("otp");
                session.removeAttribute("otpTime");
                session.removeAttribute("resetEmail");

                response.sendRedirect("login.jsp?reset=success");

            } else {
                response.sendRedirect("reset-password.jsp?error=true");
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("reset-password.jsp?error=true");
        }
    }
}