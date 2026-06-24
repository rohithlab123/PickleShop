package controller;

package controller;

import java.io.IOException;
import dao.CartDAO;

// CHANGED FROM jakarta TO javax TO MATCH TOMCAT 9
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    // Keep the rest of your doPost or doGet method code exactly as it is!

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.getWriter().write("LOGIN_REQUIRED");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));

        CartDAO dao = new CartDAO();

        dao.addToCart(userId, productId);

        int totalQty = dao.getTotalQuantity(userId);

        response.getWriter().write(String.valueOf(totalQty));
    }
}
