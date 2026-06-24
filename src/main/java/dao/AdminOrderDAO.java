package dao;

import java.sql.*;
import java.util.*;

public class AdminOrderDAO {

    public Map<String, Object> getOrderWithUser(int orderId) {

        Map<String, Object> data = new HashMap<>();

        try {
            Connection con = new DBConnection().getconnection();

            String sql =
            "SELECT o.id, o.total_price, o.status, o.order_date, " +
            "u.name, u.email, u.phone, u.address " +
            "FROM orders o " +
            "JOIN users u ON o.user_id = u.id " +
            "WHERE o.id = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                data.put("orderId", rs.getInt("id"));
                data.put("total", rs.getDouble("total_price"));
                data.put("status", rs.getString("status"));
                data.put("date", rs.getString("order_date"));

                data.put("name", rs.getString("name"));
                data.put("email", rs.getString("email"));
                data.put("phone", rs.getString("phone"));
                data.put("address", rs.getString("address"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return data;
    }
}