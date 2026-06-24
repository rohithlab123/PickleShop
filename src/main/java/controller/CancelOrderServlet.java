package controller;

package controller;

import java.io.IOException;
import dao.OrderDetailsDAO;

// CHANGED FROM jakarta TO javax TO MATCH TOMCAT 9
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {
    // Keep the rest of your internal code exactly the same!

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(req.getParameter("orderId"));

        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        OrderDetailsDAO dao = new OrderDetailsDAO();
        dao.cancelOrder(orderId, userId);

        resp.sendRedirect(req.getContextPath() + "/my-orders.jsp");
    }
}
