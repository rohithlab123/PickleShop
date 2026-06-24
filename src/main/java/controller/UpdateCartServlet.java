
package controller;

import java.io.IOException;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

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
