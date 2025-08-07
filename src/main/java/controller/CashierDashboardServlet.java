package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.CustomerDAO;
import dao.DatabaseConnection;
import model.Category;
import model.Product;
import model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Cashier/CashierDashboardServlet")
public class CashierDashboardServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Check if user is logged in and has cashier role
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            if (user == null || !"CASHIER".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/LoginServlet");
                return;
            }
            
            // Debug message
            System.out.println("Loading products and categories...");
            
            // Load products and categories for the modal
            ProductDAO productDAO = new ProductDAO();
            CategoryDAO categoryDAO = new CategoryDAO();
            
            List<Product> products = productDAO.getAllProducts();
            List<Category> categories = categoryDAO.getAllCategories();
            
            // Debug messages
            System.out.println("Number of products loaded: " + products.size());
            System.out.println("Number of categories loaded: " + categories.size());
            
            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            
            // Load dashboard statistics
            CustomerDAO customerDAO = new CustomerDAO(DatabaseConnection.getConnection());
            int totalCustomers = customerDAO.getAllCustomers().size();
            request.setAttribute("totalCustomers", totalCustomers);
            
            // Temporary values - replace with actual DAO calls
            request.setAttribute("activeLoans", 0);
            request.setAttribute("overdueItems", 0);
            request.setAttribute("dailySalesTotal", 0.0);
            request.setAttribute("dailySalesCount", 0);
            
            request.getRequestDispatcher("/Cashier/Cashierdashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}