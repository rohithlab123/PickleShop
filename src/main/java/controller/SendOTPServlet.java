package controller;

import util.EmailUtil;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import dao.DBConnection;

// CHANGED FROM jakarta TO javax TO MATCH TOMCAT 9
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SendOTPServlet")
public class SendOTPServlet extends HttpServlet {
    // Keep the rest of your OTP generation and verification logic exactly as it is!

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        System.out.println("🔥 SEND OTP SERVLET HIT");  // 👈 ADD HERE
        
        String email = request.getParameter("email");
        System.out.println("EMAIL ENTERED: " + email);

        try {
            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql = "SELECT id FROM users WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                System.out.println("USER FOUND IN DATABASE");

                Random rand = new Random();
                int otp = 100000 + rand.nextInt(900000);

                long otpTime = System.currentTimeMillis();

                HttpSession session = request.getSession();

                session.setAttribute("otp", otp);
                session.setAttribute("otpTime", otpTime);
                session.setAttribute("resetEmail", email);

                System.out.println("ABOUT TO SEND OTP EMAIL");

                EmailUtil.sendOTP(email, String.valueOf(otp));

                response.sendRedirect("verify-otp.jsp");

            } else {

                System.out.println("USER NOT FOUND IN DATABASE");

                response.sendRedirect("forgot-password.jsp?error=invalid");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("forgot-password.jsp?error=true");
        }
    }
}
