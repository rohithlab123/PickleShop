package dao;

import java.sql.*;
import java.util.*;
import model.Order;

public class OrderDAO {

    // 🔵 GET ALL ORDERS (WITH USER NAME)
    public List<Order> getAllOrders() {

        List<Order> list = new ArrayList<>();

        try {
            Connection con = new DBConnection().getconnection();

            String sql =
            "SELECT o.id, o.user_id, u.name, o.total_price, o.status, o.order_date " +
            "FROM orders o " +
            "JOIN users u ON o.user_id = u.id " +
            "ORDER BY o.id DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Order o = new Order();

                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));

                // 👇 customer name from JOIN
                o.setUserName(rs.getString("name"));

                o.setTotalPrice(rs.getDouble("total_price"));
                o.setStatus(rs.getString("status"));
                o.setOrderDate(rs.getString("order_date"));

                list.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 📊 TOTAL ORDERS
    public int getTotalOrders() {

        int count = 0;

        try {
            Connection con = new DBConnection().getconnection();

            String sql = "SELECT COUNT(*) FROM orders";
            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    // 💰 TOTAL REVENUE
    public double getTotalRevenue() {

        double total = 0;

        try {
            Connection con = new DBConnection().getconnection();

            String sql = "SELECT SUM(total_price) FROM orders WHERE status != 'CANCELLED'";
            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }
}