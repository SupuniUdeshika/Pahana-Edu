package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.UserDAO;
import model.User;
import dao.DatabaseConnection;
import util.EmailUtil;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Add a UserDAO field for testing injection
    private UserDAO userDAO;

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to the login page
        response.sendRedirect(request.getContextPath() + "/Auth/index.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        Connection connection = null;
        try {
            // Use injected DAO if available, otherwise create new
            UserDAO dao = (userDAO != null) ? userDAO : new UserDAO(DatabaseConnection.getConnection());
            User user = dao.getUserByEmail(email);

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

            new Thread(() -> sendLoginNotificationEmail(user)).start();

            response.setContentType("text/html");
            response.getWriter().write("<script>window.location.href='" +
                getDashboardPath(request, user) + "';</script>");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database connection error. Please try again later.");
            request.getRequestDispatcher("/Auth/index.jsp").forward(request, response);
        } finally {
            if (connection != null) {
                try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    private String getDashboardPath(HttpServletRequest request, User user) {
        String contextPath = request.getContextPath();
        if ("ADMIN".equals(user.getRole())) return contextPath + "/Admin/Admindashboard";
        if ("CASHIER".equals(user.getRole())) return contextPath + "/cashier/Cashierdashboard";
        return contextPath + "/Auth/index.jsp";
    }

    private void createRememberMeCookies(HttpServletResponse response, User user) {
        String token = java.util.UUID.randomUUID().toString();
        Cookie emailCookie = new Cookie("rememberMeEmail", user.getEmail());
        emailCookie.setMaxAge(30 * 24 * 60 * 60);
        emailCookie.setHttpOnly(true);
        emailCookie.setPath("/");
        emailCookie.setSecure(true);

        Cookie tokenCookie = new Cookie("rememberMeToken", token);
        tokenCookie.setMaxAge(30 * 24 * 60 * 60);
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
                + "Best regards,\nBook Management System Team";

        EmailUtil.sendEmail(user.getEmail(), subject, content);
    }
}
