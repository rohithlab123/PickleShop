package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;

public class UserDAO {

    public boolean registerUser(User user) {

        boolean status = false;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getconnection();

            String sql = "INSERT INTO users(name,email,password,phone,address) VALUES(?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());

            int rows = ps.executeUpdate();

            if(rows > 0) {
                status = true;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }
        
        
        public User loginUser(String email, String password) {

            User user = null;

            try {

                DBConnection db = new DBConnection();
                Connection con = db.getconnection();

                String sql = "SELECT * FROM users WHERE email=? AND password=?";

                PreparedStatement ps = con.prepareStatement(sql);

                ps.setString(1, email);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if(rs.next()) {

                    user = new User();

                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                }

            } catch(Exception e) {
                e.printStackTrace();
            }

            return user;
        
    }
}