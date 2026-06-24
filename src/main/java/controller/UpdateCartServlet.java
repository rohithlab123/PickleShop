
package controller;

import java.io.IOException;
import dao.CartDAO;

// CHANGED FROM jakarta TO javax TO MATCH TOMCAT 9
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    // Keep your complete quantity adjustment and cart calculation logic right below this!

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));

        String action = request.getParameter("action");

        CartDAO dao = new CartDAO();

        if ("increase".equals(action)) {

            dao.increaseQuantity(cartItemId);

        } else if ("decrease".equals(action)) {

            dao.decreaseQuantity(cartItemId);

        } else if ("remove".equals(action)) {

            dao.removeItem(cartItemId);
        }

        response.sendRedirect("cart.jsp");
    }
}
