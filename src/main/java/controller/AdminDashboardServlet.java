package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.SaleDAO;
import model.Sale;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Admin/Admindashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Initialize DAOs
            CategoryDAO categoryDAO = new CategoryDAO();
            ProductDAO productDAO = new ProductDAO();
            SaleDAO saleDAO = new SaleDAO();
            
            // Get current date and calculate date range for this month
            Date now = new Date();
            Date startOfMonth = getStartOfMonth(now);
            
            // Fetch data
            int totalCategories = categoryDAO.getAllCategories().size();
            int totalProducts = productDAO.getTotalProducts();
            int lowStockProducts = productDAO.getLowStockProductsCount();
            double totalSales = getTotalSalesThisMonth(saleDAO, startOfMonth, now);
            Map<String, Double> dailySales = saleDAO.getDailySalesSummary(startOfMonth, now);
            
            // Set attributes for JSP
            request.setAttribute("totalCategories", totalCategories);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("lowStockProducts", lowStockProducts);
            request.setAttribute("totalSales", totalSales);
            request.setAttribute("dailySales", dailySales);
            
            // Forward to JSP
            request.getRequestDispatcher("/Admin/Admindashboard.jsp").forward(request, response);
            
        } catch (SQLException ex) {
            throw new ServletException("Database error occurred", ex);
        }
    }
    
    private double getTotalSalesThisMonth(SaleDAO saleDAO, Date startDate, Date endDate) throws SQLException {
        List<Sale> sales = saleDAO.getSalesByDateRange(startDate, endDate);
        return sales.stream().mapToDouble(Sale::getTotalAmount).sum();
    }
    
    private Date getStartOfMonth(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return calendar.getTime();
    }
}