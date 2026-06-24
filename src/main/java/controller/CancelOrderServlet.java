package controller;

import java.io.IOException;
import dao.OrderDetailsDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {

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