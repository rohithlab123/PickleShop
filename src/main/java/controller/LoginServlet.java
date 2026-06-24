package controller;

import java.io.IOException;
import dao.UserDAO;
import model.User;

// CHANGED FROM jakarta TO javax TO MATCH TOMCAT 9
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// Double check that this annotation matches your form action attribute exactly!
@WebServlet("/LoginServlet") 
public class LoginServlet extends HttpServlet {
    // Keep the rest of your doPost/doGet logic exactly the same!

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();

        User user = dao.loginUser(email, password);

        if(user != null) {

            HttpSession session = request.getSession();

            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());

            response.sendRedirect("index.jsp");

        } else {

            // FIX: Set the error text and forward back to login.jsp without breaking the UI
            request.setAttribute("error", "Invalid Email or Password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
