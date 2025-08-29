package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.CustomerDAO;
import dao.ProductDAO;

@WebServlet("/cashier/Cashierdashboard")
public class CashierDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;
    private ProductDAO productDAO;

    public void init() {
        customerDAO = new CustomerDAO();
        productDAO = new ProductDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get counts for dashboard
            int totalCustomers = customerDAO.getTotalCustomers();
            int totalProducts = productDAO.getTotalProducts();
            int lowStockProducts = productDAO.getLowStockProductsCount();
            
            // Set attributes for JSP
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("lowStockProducts", lowStockProducts);
            
            // Forward to dashboard JSP
            request.getRequestDispatcher("/cashier/Cashierdashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading dashboard data", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}