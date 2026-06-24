
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.CartItem;
import model.Order;

public class CartDAO {

    // ================= ADD TO CART =================

    public boolean addToCart(int userId, int productId) {

        boolean status = false;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String checkSql =
                "SELECT id, quantity FROM cart_items WHERE user_id=? AND product_id=?";

            PreparedStatement checkPs = con.prepareStatement(checkSql);

            checkPs.setInt(1, userId);
            checkPs.setInt(2, productId);

            ResultSet rs = checkPs.executeQuery();

            if(rs.next()) {

                int existingId = rs.getInt("id");
                int newQty = rs.getInt("quantity") + 1;

                String updateSql =
                    "UPDATE cart_items SET quantity=? WHERE id=?";

                PreparedStatement updatePs =
                    con.prepareStatement(updateSql);

                updatePs.setInt(1, newQty);
                updatePs.setInt(2, existingId);

                status = updatePs.executeUpdate() > 0;

            } else {

                String insertSql =
                    "INSERT INTO cart_items(user_id, product_id, quantity) VALUES(?,?,1)";

                PreparedStatement insertPs =
                    con.prepareStatement(insertSql);

                insertPs.setInt(1, userId);
                insertPs.setInt(2, productId);

                status = insertPs.executeUpdate() > 0;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // ================= GET CART ITEMS =================

    public List<CartItem> getCartItems(int userId) {

    	List<CartItem> items = new ArrayList<>();

    	try {

    	    DBConnection db = new DBConnection();
    	    Connection con = db.getconnection();

    	    String sql =
    	        "SELECT c.id, c.user_id, c.product_id, c.quantity, " +
    	        "p.name, p.price, p.image_url " +
    	        "FROM cart_items c " +
    	        "JOIN products p ON c.product_id = p.id " +
    	        "WHERE c.user_id=?";

    	    PreparedStatement ps = con.prepareStatement(sql);

    	    ps.setInt(1, userId);

    	    ResultSet rs = ps.executeQuery();

    	    while(rs.next()) {

    	        CartItem item = new CartItem();

    	        item.setId(rs.getInt("id"));
    	        item.setUserId(rs.getInt("user_id"));
    	        item.setProductId(rs.getInt("product_id"));
    	        item.setQuantity(rs.getInt("quantity"));

    	        item.setProductName(rs.getString("name"));
    	        item.setProductPrice(rs.getDouble("price"));

    	        item.setImageUrl(rs.getString("image_url"));

    	        item.setTotalPrice(
    	            item.getProductPrice() * item.getQuantity()
    	        );

    	        items.add(item);
    	    }

    	    con.close();

    	} catch(Exception e) {
    	    e.printStackTrace();
    	}

    	return items;
    	

    	}

    		

    // ================= TOTAL QUANTITY =================

    public int getTotalQuantity(int userId) {

        int total = 0;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql =
                "SELECT SUM(quantity) AS total FROM cart_items WHERE user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                total = rs.getInt("total");
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    // ================= INCREASE =================

    public boolean increaseQuantity(int cartItemId) {
        return changeQuantity(cartItemId, 1);
    }

    // ================= DECREASE =================

    public boolean decreaseQuantity(int cartItemId) {

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String checkSql =
                "SELECT quantity FROM cart_items WHERE id=?";

            PreparedStatement checkPs =
                con.prepareStatement(checkSql);

            checkPs.setInt(1, cartItemId);

            ResultSet rs = checkPs.executeQuery();

            if(rs.next() && rs.getInt("quantity") <= 1) {
                return removeItem(cartItemId);
            }

            return changeQuantity(cartItemId, -1);

        } catch(Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ================= CHANGE QUANTITY =================

    private boolean changeQuantity(int cartItemId, int change) {

        boolean status = false;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql =
                "UPDATE cart_items SET quantity = quantity + ? WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, change);
            ps.setInt(2, cartItemId);

            status = ps.executeUpdate() > 0;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // ================= REMOVE ITEM =================

    public boolean removeItem(int cartItemId) {

        boolean status = false;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql =
                "DELETE FROM cart_items WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, cartItemId);

            status = ps.executeUpdate() > 0;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // ================= USER ORDERS =================

    public List<Order> getUserOrders(int userId) {

        List<Order> orders = new ArrayList<>();

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql =
                "SELECT * FROM orders WHERE user_id=? ORDER BY id DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Order order = new Order();

                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getString("status"));
                order.setOrderDate(rs.getString("order_date"));

                orders.add(order);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
}

