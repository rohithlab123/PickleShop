package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    Connection con = null;

    public Connection getconnection() {

        try {
            // Load the MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Updated URL with SSL trust flags and your real password string
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
