package dao;

import java.sql.*;
import dao.DBConnection;

public class AdminDAO {

    public boolean validateAdmin(String username, String password) {

        boolean status = false;

        try {
            Connection con = new DBConnection().getconnection();

            String sql = "SELECT * FROM admin WHERE username=? AND password=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                status = true;
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }
}