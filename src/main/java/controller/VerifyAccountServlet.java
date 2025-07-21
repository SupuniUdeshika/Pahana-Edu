package controller;

import dao.UserDAO;
import dao.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/VerifyAccountServlet")
public class VerifyAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String token = request.getParameter("token");
        
        if (token == null || token.isEmpty()) {
            response.sendRedirect("Auth/index.jsp?error=Invalid verification token");
            return;
        }

        try (Connection connection = DatabaseConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(connection);
            
            // Verify the token
            if (userDAO.verifyUser(token)) {
                response.sendRedirect("Auth/index.jsp?success=Account verified successfully");
            } else {
                response.sendRedirect("Auth/index.jsp?error=Invalid or expired verification token");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("Auth/index.jsp?error=Database error during verification");
        }
    }
}