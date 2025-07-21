package controller;

import dao.UserDAO;
import model.User;
import util.EmailUtil;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.DatabaseConnection;

@WebServlet("/Admin/users")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try (Connection connection = DatabaseConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(connection);
            
            if (action == null) {
                action = "list";
            }
            
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response, userDAO);
                    break;
                case "delete":
                    deleteUser(request, response, userDAO);
                    break;
                case "search":
                    searchUsers(request, response, userDAO);
                    break;
                default:
                    listUsers(request, response, userDAO);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error occurred", e);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try (Connection connection = DatabaseConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(connection);
            
            if ("insert".equals(action)) {
                insertUser(request, response, userDAO);
            } else if ("update".equals(action)) {
                updateUser(request, response, userDAO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error occurred", e);
        }
    }
    
    private void listUsers(HttpServletRequest request, HttpServletResponse response, UserDAO userDAO) 
            throws ServletException, IOException, SQLException {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/Admin/users.jsp").forward(request, response);
    }
    
    private void searchUsers(HttpServletRequest request, HttpServletResponse response, UserDAO userDAO) 
            throws ServletException, IOException, SQLException {
        String keyword = request.getParameter("keyword");
        List<User> users = userDAO.searchUsers(keyword);
        request.setAttribute("users", users);
        request.getRequestDispatcher("/Admin/users.jsp").forward(request, response);
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User user = new User();
        // Make sure ID is not set for new users
        request.setAttribute("user", user);
        request.setAttribute("isNewUser", true);
        request.getRequestDispatcher("/Admin/user-form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response, UserDAO userDAO) 
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.getUserById(id);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/Admin/user-form.jsp").forward(request, response);
    }
    
    private void insertUser(HttpServletRequest request, HttpServletResponse response, UserDAO userDAO) 
            throws ServletException, IOException, SQLException {
        User user = new User();
        user.setName(request.getParameter("name"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));
        user.setRole(request.getParameter("role"));
        
        // Generate verification token and set expiry date (24 hours from now)
        user.setVerificationToken(UUID.randomUUID().toString());
        user.setVerificationTokenExpiry(new Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000));
        
        if (userDAO.addUser(user)) {
            // Send password setup email in a separate thread
            new Thread(() -> {
                sendVerificationEmail(user, request);
            }).start();
            
            response.sendRedirect(request.getContextPath() + "/Admin/users");
        } else {
            request.setAttribute("error", "Failed to add user");
            request.setAttribute("isNewUser", true);
            request.getRequestDispatcher("/Admin/user-form.jsp").forward(request, response);
        }
    }
    
    private void updateUser(HttpServletRequest request, HttpServletResponse response, UserDAO userDAO) 
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = new User();
        user.setId(id);
        user.setName(request.getParameter("name"));
        user.setEmail(request.getParameter("email"));
        user.setRole(request.getParameter("role"));
        
        // Only update password if it's provided
        String password = request.getParameter("password");
        if (password != null && !password.isEmpty()) {
            user.setPassword(password);
        }
        
        userDAO.updateUser(user);
        response.sendRedirect(request.getContextPath() + "/Admin/users");
    }
    
    private void deleteUser(HttpServletRequest request, HttpServletResponse response, UserDAO userDAO) 
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(id);
        response.sendRedirect(request.getContextPath() + "/Admin/users");
    }
    
    private void sendVerificationEmail(User user, HttpServletRequest request) {
        try {
            String subject = "Your Account Has Been Created - Pahana Edu";
            
            String verificationToken = user.getVerificationToken();
            Date expiryDate = user.getVerificationTokenExpiry();
            
            String verificationLink = request.getScheme() + "://" + request.getServerName() + ":" + 
                              request.getServerPort() + request.getContextPath() + 
                              "/VerifyAccountServlet?token=" + verificationToken;
            
            String content = "Dear " + user.getName() + ",\n\n"
                    + "Your account has been successfully created by the administrator.\n"
                    + "You can now login to the system using the following credentials:\n\n"
                    + "Email: " + user.getEmail() + "\n"
                    + "Password: " + user.getPassword() + "\n\n"
                    + "Please verify your account by clicking the following link:\n"
                    + verificationLink + "\n\n"
                    + "This link will expire on " + expiryDate + ".\n\n"
                    + "Best regards,\n"
                    + "Pahana Edu Management Team";
            
            System.out.println("Attempting to send email to: " + user.getEmail()); // Logging
            System.out.println("Email content: " + content); // Logging
            
            EmailUtil.sendEmail(user.getEmail(), subject, content);
            System.out.println("Email sent successfully to: " + user.getEmail()); // Logging
        } catch (Exception e) {
            System.err.println("Failed to send verification email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}