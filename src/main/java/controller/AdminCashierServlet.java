package controller;

import dao.CategoryDAO;
import dao.CustomerDAO;
import dao.DatabaseConnection;
import dao.ProductDAO;
import dao.SaleDAO;
import model.Category;
import model.Customer;
import model.Product;
import model.Sale;
import model.SaleItem;
import util.EmailUtil;
import util.PDFGenerator;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

@WebServlet("/AdminCashier/*")
public class AdminCashierServlet extends HttpServlet {
    private ProductDAO productDAO;
    private CustomerDAO customerDAO;
    private SaleDAO saleDAO;
    private CategoryDAO categoryDAO;
    private static final Logger logger = Logger.getLogger(AdminCashierServlet.class.getName());

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            productDAO = new ProductDAO();
            customerDAO = new CustomerDAO(DatabaseConnection.getConnection());
            saleDAO = new SaleDAO();
            categoryDAO = new CategoryDAO(); // Add this line
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize DAOs", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        
        try {
            if (action == null) {
                action = "/pos";
            }
            
            switch (action) {
                case "/pos":
                    showPointOfSale(request, response);
                    break;
                case "/search-products":
                    searchProducts(request, response);
                    break;
                case "/search-customers":
                    searchCustomers(request, response);
                    break;
                case "/sales":
                    listSales(request, response);
                    break;
                case "/view-sale":
                    viewSale(request, response);
                    break;
                case "/export-sales":
                    exportSales(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        
        try {
            if (action == null) {
                action = "/process-sale";
            }
            
            switch (action) {
                case "/process-sale":
                    processSale(request, response);
                    break;
                case "/send-receipt":
                    sendReceipt(request, response);
                    break;
                case "/generate-pdf-receipt":
                    generatePdfReceipt(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }

    private void showPointOfSale(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<Product> products = productDAO.getAllProducts();
        List<Category> categories = categoryDAO.getAllCategories(); // Add this line
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories); // Add this line
        request.getRequestDispatcher("/Admin/pos.jsp").forward(request, response);
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String keyword = request.getParameter("keyword");
        String categoryId = request.getParameter("categoryId");
        
        List<Product> products;
        if (categoryId != null && !categoryId.isEmpty()) {
            products = productDAO.searchProductsByCategory(Integer.parseInt(categoryId));
        } else {
            products = productDAO.searchProducts(keyword);
        }
        
        request.setAttribute("products", products);
        request.getRequestDispatcher("/Admin/product-results.jsp").forward(request, response);
    }

    private void searchCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String keyword = request.getParameter("keyword");
        List<Customer> customers = customerDAO.searchCustomers(keyword);
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/Admin/customer-results.jsp").forward(request, response);
    }

    private void processSale(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        // Get form parameters
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        double amountPaid = Double.parseDouble(request.getParameter("amountPaid"));
        String paymentMethod = request.getParameter("paymentMethod");
        
        // Get cart items
        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");
        
        List<SaleItem> items = new ArrayList<>();
        double totalAmount = 0;
        
        for (int i = 0; i < productIds.length; i++) {
            int productId = Integer.parseInt(productIds[i]);
            int quantity = Integer.parseInt(quantities[i]);
            
            Product product = productDAO.getProductById(productId);
            
            SaleItem item = new SaleItem();
            item.setProductId(productId);
            item.setProductName(product.getName());
            item.setQuantity(quantity);
            item.setPrice(product.getPrice());
            item.setSubtotal(product.getPrice() * quantity);
            
            items.add(item);
            totalAmount += item.getSubtotal();
        }
        
        // Create sale
        Sale sale = new Sale();
        sale.setCustomerId(customerId);
        sale.setSaleDate(new Date());
        sale.setTotalAmount(totalAmount);
        sale.setAmountPaid(amountPaid);
        sale.setBalance(amountPaid - totalAmount);
        sale.setPaymentMethod(paymentMethod);
        
        // Save to database
        int saleId = saleDAO.createSale(sale);
        saleDAO.addSaleItems(saleId, items);
        
        // Get customer details for email
        Customer customer = customerDAO.getCustomerById(customerId);
        
        // Send email receipt if customer has email
        boolean emailSent = false;
        if (customer.getEmail() != null && !customer.getEmail().trim().isEmpty()) {
            try {
                emailSent = EmailUtil.sendReceiptEmail(
                    customer.getEmail(), 
                    customer.getName(), 
                    sale, 
                    items
                );
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Failed to send email receipt", e);
            }
        }
        
        // Set attributes for receipt
        request.setAttribute("sale", sale);
        request.setAttribute("items", items);
        request.setAttribute("customer", customer);
        request.setAttribute("emailSent", emailSent);
        
        // Add success parameter to the request
        request.setAttribute("success", true);
        
        // Forward to receipt page
        request.getRequestDispatcher("/Admin/receipt.jsp").forward(request, response);
    }

    private void listSales(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        // Default to last 7 days if no dates specified
        Date endDate = new Date();
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -7);
        Date startDate = cal.getTime();
        
        try {
            // Get date parameters from request
            String startDateParam = request.getParameter("startDate");
            String endDateParam = request.getParameter("endDate");
            
            if (startDateParam != null && !startDateParam.isEmpty()) {
                startDate = new java.util.Date(java.sql.Date.valueOf(startDateParam).getTime());
            }
            if (endDateParam != null && !endDateParam.isEmpty()) {
                endDate = new java.util.Date(java.sql.Date.valueOf(endDateParam).getTime());
            }
            
            // Get sales data
            List<Sale> sales = saleDAO.getSalesByDateRange(startDate, endDate);
            Map<String, Double> dailySales = saleDAO.getDailySalesSummary(startDate, endDate);
            
            // Set request attributes
            request.setAttribute("sales", sales);
            request.setAttribute("dailySales", dailySales);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            
            // Forward to JSP
            request.getRequestDispatcher("/Admin/sales.jsp").forward(request, response);
            
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date format. Please use yyyy-MM-dd format.");
            request.getRequestDispatcher("/Admin/sales.jsp").forward(request, response);
        }
    }

    private void viewSale(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int saleId = Integer.parseInt(request.getParameter("id"));
        Sale sale = saleDAO.getSaleById(saleId);
        
        if (sale != null) {
            sale.setItems(saleDAO.getSaleItems(saleId));
            // Get full customer details using the customerId from the sale
            Customer customer = customerDAO.getCustomerById(sale.getCustomerId());
            request.setAttribute("customer", customer);
        }
        
        request.setAttribute("sale", sale);
        request.getRequestDispatcher("/Admin/view-sale.jsp").forward(request, response);
    }
    
    private void sendReceipt(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            int saleId = Integer.parseInt(request.getParameter("saleId"));
            String customerEmail = request.getParameter("customerEmail");
            
            // Validate parameters
            if (customerEmail == null || customerEmail.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"status\":\"error\", \"message\":\"Customer email is not available\"}");
                return;
            }
            
            // Get sale details
            Sale sale = saleDAO.getSaleById(saleId);
            if (sale == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.write("{\"status\":\"error\", \"message\":\"Sale not found\"}");
                return;
            }
            
            List<SaleItem> items = saleDAO.getSaleItems(saleId);
            Customer customer = customerDAO.getCustomerById(sale.getCustomerId());
            
            // Send email
            boolean emailSent = EmailUtil.sendReceiptEmail(
                customerEmail, 
                customer.getName(), 
                sale, 
                items
            );
            
            if (emailSent) {
                out.write("{\"status\":\"success\", \"message\":\"Receipt sent successfully to " + customerEmail + "\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.write("{\"status\":\"error\", \"message\":\"Failed to send email to " + customerEmail + "\"}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.write("{\"status\":\"error\", \"message\":\"Invalid sale ID\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"status\":\"error\", \"message\":\"An error occurred: " + e.getMessage() + "\"}");
            logger.log(Level.SEVERE, "Error sending receipt", e);
        } finally {
            out.close();
        }
    }
    
    private void generatePdfReceipt(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        int saleId = Integer.parseInt(request.getParameter("saleId"));
        
        Sale sale = saleDAO.getSaleById(saleId);
        List<SaleItem> items = saleDAO.getSaleItems(saleId);
        Customer customer = customerDAO.getCustomerById(sale.getCustomerId());
        
        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "attachment; filename=receipt_" + saleId + ".pdf");
        
        // Create PDF using your preferred library
        PDFGenerator.generateReceipt(sale, items, customer, response.getOutputStream());
    }
    
    private void exportSales(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        try {
            // Get date parameters
            Date startDate = new java.util.Date(java.sql.Date.valueOf(request.getParameter("startDate")).getTime());
            Date endDate = new java.util.Date(java.sql.Date.valueOf(request.getParameter("endDate")).getTime());
            
            // Get sales data
            List<Sale> sales = saleDAO.getSalesByDateRange(startDate, endDate);
            
            // Set response headers for Excel download
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=sales_report_" + 
                    new SimpleDateFormat("yyyyMMdd").format(startDate) + "_to_" + 
                    new SimpleDateFormat("yyyyMMdd").format(endDate) + ".xls");
            
            // Create Excel content
            PrintWriter out = response.getWriter();
            out.write("Sale ID\tDate\tCustomer\tItems\tTotal Amount\tPayment Method\n");
            
            for (Sale sale : sales) {
                out.write(sale.getId() + "\t");
                out.write(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(sale.getSaleDate()) + "\t");
                out.write((sale.getCustomerName() != null ? sale.getCustomerName() : "Walk-in") + "\t");
                out.write(sale.getItems().size() + " items\t");
                out.write("Rs. " + String.format("%.2f", sale.getTotalAmount()) + "\t");
                out.write(sale.getPaymentMethod() + "\n");
            }
            
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating report");
        }
    }
    
}