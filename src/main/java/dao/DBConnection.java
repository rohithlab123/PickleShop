package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    // 🔴 FIXED: Global "Connection con = null;" removed from here to stop the massive website lag.

    public Connection getconnection() {
        Connection con = null; // 🟢 FIXED: The connection object is now local to this method call.

        try {
            // Load the MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to Aiven Cloud MySQL
            con = DriverManager.getConnection(
                "jdbc:mysql://pickelsshop-pickels.h.aivencloud.com:23064/defaultdb?useSSL=true&trustServerCertificate=true",
                "avnadmin",
                "AVNS_VrQ-6vvFsu5_OommVEd"
            );

        } catch (Exception e) {
            System.out.println("❌ Cloud Connection Failed!");
            e.printStackTrace();
        }

        return con;
    }
}
