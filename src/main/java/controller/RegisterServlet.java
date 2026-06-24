package controller;

import java.io.IOException;

// Changed from jakarta to javax to match your Tomcat 9 runtime environment
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        User user = new User();
        user.setName(request.getParameter("name"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));
        user.setPhone(request.getParameter("phone"));
        user.setAddress(request.getParameter("address"));

        UserDAO dao = new UserDAO();
        boolean status = dao.registerUser(user);

        if (status) {
            response.sendRedirect("login.jsp");
        } else {
            response.getWriter().println("❌ Registration Failed");
        }
    }
}
