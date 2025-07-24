package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;
import dao.DatabaseConnection;
import util.EmailUtil;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            redirectBasedOnRole(request, response, user);
            return;
        }
        response.sendRedirect(request.getContextPath() + "/Auth/index.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            UserDAO userDAO = new UserDAO(connection);
            User user = userDAO.getUserByEmail(email);
            
            if (user == null || !user.getPassword().equals(password)) {
                request.setAttribute("errorMessage", "Invalid email or password");
                request.getRequestDispatcher("/Auth/index.jsp").forward(request, response);
                return;
            }
            
            if (!user.isVerified()) {
                request.setAttribute("errorMessage", "Account not verified. Please check your email for verification link.");
                request.getRequestDispatcher("/Auth/index.jsp").forward(request, response);
                return;
            }
            
            // Create new session and invalidate old one if exists
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("user", user);
            newSession.setMaxInactiveInterval(30*60); // 30 minutes
            
            if ("on".equals(rememberMe)) {
                createRememberMeCookies(response, user);
            }
            
            // Send email in a separate thread to avoid delay
            new Thread(() -> {
                sendLoginNotificationEmail(user);
            }).start();
            
            // Immediate response to avoid waiting
            response.setContentType("text/html");
            response.getWriter().write("<script>window.location.href='" + 
                getDashboardPath(request, user) + "';</script>");
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database connection error. Please try again later.");
            request.getRequestDispatcher("/Auth/index.jsp").forward(request, response);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    private String getDashboardPath(HttpServletRequest request, User user) {
        String contextPath = request.getContextPath();
        if ("ADMIN".equals(user.getRole())) {
            return contextPath + "/Admin/Admindashboard.jsp";
        } else if ("CASHIER".equals(user.getRole())) {
            return contextPath + "/Cashier/Cashierdashboard.jsp";
        }
        return contextPath + "/Auth/index.jsp"; // Default fallback
    }
    
    private void redirectBasedOnRole(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        response.sendRedirect(getDashboardPath(request, user));
    }
    
    private void createRememberMeCookies(HttpServletResponse response, User user) {
        String token = java.util.UUID.randomUUID().toString();
        
        Cookie emailCookie = new Cookie("rememberMeEmail", user.getEmail());
        emailCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
        emailCookie.setHttpOnly(true);
        emailCookie.setPath("/");
        emailCookie.setSecure(true);
        
        Cookie tokenCookie = new Cookie("rememberMeToken", token);
        tokenCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
        tokenCookie.setHttpOnly(true);
        tokenCookie.setPath("/");
        tokenCookie.setSecure(true);
        
        response.addCookie(emailCookie);
        response.addCookie(tokenCookie);
    }
    
    private void sendLoginNotificationEmail(User user) {
        String subject = "Login Notification - Book Management System";
        String content = "Dear " + user.getName() + ",\n\n"
                + "You have successfully logged into the Book Management System at " + new Date() + ".\n\n"
                + "If this was not you, please contact the system administrator immediately.\n\n"
                + "Best regards,\n"
                + "Book Management System Team";
        
        EmailUtil.sendEmail(user.getEmail(), subject, content);
    }
}