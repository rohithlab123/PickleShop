package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import dao.CartDAO;
import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CartItem;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = (Integer) request.getSession().getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {

            CartDAO cartDAO = new CartDAO();
            List<CartItem> cartItems = cartDAO.getCartItems(userId);

            if (cartItems.isEmpty()) {
                response.sendRedirect("cart.jsp");
                return;
            }

            double totalPrice = 0;

            for (CartItem item : cartItems) {
                totalPrice += item.getTotalPrice();
            }

            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

         // INSERT ORDER
            String orderSql = "INSERT INTO orders(user_id, total_price, status, order_date) VALUES(?, ?, ?, NOW())";

            PreparedStatement orderPs =
                    con.prepareStatement(orderSql, PreparedStatement.RETURN_GENERATED_KEYS);

            orderPs.setInt(1, userId);
            orderPs.setDouble(2, totalPrice);
            orderPs.setString(3, "PLACED");

            orderPs.executeUpdate();

            // GET ORDER ID
            ResultSet rs = orderPs.getGeneratedKeys();

            int orderId = 0;

            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // INSERT ORDER ITEMS
            String itemSql =
                    "INSERT INTO order_items(order_id, product_id, quantity, price_at_order) VALUES(?, ?, ?, ?)";

            PreparedStatement itemPs = con.prepareStatement(itemSql);

            for (CartItem item : cartItems) {

                itemPs.setInt(1, orderId);
                itemPs.setInt(2, item.getProductId());
                itemPs.setInt(3, item.getQuantity());
                itemPs.setDouble(4, item.getProductPrice());

                itemPs.executeUpdate();
            }

            // CLEAR CART
            String clearSql = "DELETE FROM cart_items WHERE user_id = ?";

            PreparedStatement clearPs = con.prepareStatement(clearSql);

            clearPs.setInt(1, userId);

            clearPs.executeUpdate();

            response.sendRedirect("order-success.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}