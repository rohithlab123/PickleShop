package dao;
import java.sql.Connection;
import java.sql.DriverManager;
public class DBConnection {
     Connection con = null;

     public Connection getconnection() {

         try {
             Class.forName("com.mysql.cj.jdbc.Driver");
             con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pickle_shop", "root", "root");

             System.out.println("Database Connected");
         }

         catch(Exception e) {
                System.out.println(e);
                System.out.println("connection fail");
            }

         return con;
     }

    }