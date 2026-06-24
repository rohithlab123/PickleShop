package controller;

import java.io.IOException;
import dao.ReviewDAO;

// CHANGED FROM jakarta TO javax TO MATCH TOMCAT 9
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SubmitReviewServlet")
public class SubmitReviewServlet extends HttpServlet {
    // Leave all your review submission methods and logic untouched right below this!

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
