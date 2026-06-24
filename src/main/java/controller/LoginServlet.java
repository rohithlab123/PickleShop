package controller;

import java.io.IOException;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

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

            response.getWriter().println("Invalid Email or Password");
        }
    }
}