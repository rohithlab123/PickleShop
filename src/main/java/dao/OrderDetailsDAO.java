package dao;

import java.sql.*;
import java.util.*;
import model.CartItem;

public class OrderDetailsDAO {

	public List<CartItem> getOrderItems(int orderId) {

	    List<CartItem> list = new ArrayList<>();

	    try {
	        Connection con = new DBConnection().getconnection();

	        String sql =
	        "SELECT oi.product_id, oi.quantity, oi.price_at_order, p.name, p.image_url " +
	        "FROM order_items oi " +
	        "JOIN products p ON oi.product_id = p.id " +
	        "WHERE oi.order_id = ?";

	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, orderId);

	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {

	            CartItem item = new CartItem();

	            item.setProductId(rs.getInt("product_id"));
	            item.setProductName(rs.getString("name"));
	            item.setProductPrice(rs.getDouble("price_at_order"));
	            item.setQuantity(rs.getInt("quantity"));
	            item.setImageUrl(rs.getString("image_url")); // ✅ NEW

	            list.add(item);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}
    
    public boolean cancelOrder(int orderId, int userId) {

        boolean status = false;

        try {
            Connection con = new DBConnection().getconnection();

            String sql = "UPDATE orders SET status='CANCELLED' WHERE id=? AND user_id=? AND status IN ('PLACED','CONFIRMED')";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setInt(2, userId);

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}