package controller;

import java.io.IOException;

// CHANGED FROM jakarta TO javax TO MATCH TOMCAT 9
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {
    // Keep your complete verification logic and method blocks exactly as they are below this!

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String userOtp = request.getParameter("otp");

        Integer sessionOtp = (Integer) session.getAttribute("otp");
        Long otpTime = (Long) session.getAttribute("otpTime");

        // 🔥 safety check
        if (sessionOtp == null || otpTime == null) {
            response.sendRedirect("verify-otp.jsp?error=true");
            return;
        }

        // ⏰ check expiry (5 minutes = 300000 ms)
        long currentTime = System.currentTimeMillis();

        if ((currentTime - otpTime) > 300000) {

            // clear session
            session.removeAttribute("otp");
            session.removeAttribute("otpTime");

            response.sendRedirect("verify-otp.jsp?error=expired");
            return;
        }

        // 🔐 check OTP match
        if (userOtp.equals(String.valueOf(sessionOtp))) {

            // OTP correct → go to reset page
            response.sendRedirect("reset-password.jsp");

        } else {

            // wrong OTP
            response.sendRedirect("verify-otp.jsp?error=true");
        }
    }
}
