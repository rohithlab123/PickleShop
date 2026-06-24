package controller;

import java.io.IOException;
import dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SubmitReviewServlet")
public class SubmitReviewServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Must be logged in to review
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment").trim();

        // Basic validation
        if (comment.isEmpty() || rating < 1 || rating > 5) {
            response.sendRedirect("index.jsp#reviews");
            return;
        }

        ReviewDAO dao = new ReviewDAO();
        dao.addReview(userId, rating, comment);

        // Redirect back to reviews section with a thank-you flag
        response.sendRedirect("index.jsp?reviewSubmitted=true#reviews");
    }
}