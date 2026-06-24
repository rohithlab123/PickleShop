package controller;

import java.io.IOException;
import dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminReviewServlet")
public class AdminReviewServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // 🔐 SAFE SESSION CHECK (ONLY ONE)
            HttpSession session = request.getSession(false);

            if(session == null || session.getAttribute("isAdmin") == null 
               || !(Boolean) session.getAttribute("isAdmin")) {

                response.sendRedirect("admin-login.jsp");
                return;
            }

            // 📌 parameters
            String reviewIdStr = request.getParameter("reviewId");
            String action = request.getParameter("action");

            if (reviewIdStr == null || action == null) {
                response.sendRedirect("admin-reviews.jsp");
                return;
            }

            int reviewId = Integer.parseInt(reviewIdStr);

            ReviewDAO dao = new ReviewDAO();

            if ("approve".equals(action)) {
                dao.approveReview(reviewId);
            } 
            else if ("delete".equals(action)) {
                dao.deleteReview(reviewId);
            }

            response.sendRedirect("admin-reviews.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-reviews.jsp?error=true");
        }
    }
}