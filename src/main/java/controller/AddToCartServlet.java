package controller;

import java.io.IOException;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

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