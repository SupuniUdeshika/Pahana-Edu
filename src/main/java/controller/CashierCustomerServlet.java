package controller;

import dao.CustomerDAO;
import model.Customer;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.DatabaseConnection;
import util.EmailUtil;

@WebServlet("/Cashier/customers")
public class CashierCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try (Connection connection = DatabaseConnection.getConnection()) {
            CustomerDAO customerDAO = new CustomerDAO(connection);
            
            if (action == null) {
                action = "list";
            }
            
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response, customerDAO);
                    break;
                case "delete":
                    deleteCustomer(request, response, customerDAO);
                    break;
                case "search":
                    searchCustomers(request, response, customerDAO);
                    break;
                default:
                    listCustomers(request, response, customerDAO);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Database error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Cashier/customers");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try (Connection connection = DatabaseConnection.getConnection()) {
            CustomerDAO customerDAO = new CustomerDAO(connection);
            
            if ("insert".equals(action)) {
                insertCustomer(request, response, customerDAO);
            } else if ("update".equals(action)) {
                updateCustomer(request, response, customerDAO);
            } else if ("delete".equals(action)) {
                deleteCustomer(request, response, customerDAO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Database error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Cashier/customers");
        }
    }
    
    private void listCustomers(HttpServletRequest request, HttpServletResponse response, CustomerDAO customerDAO) 
            throws ServletException, IOException, SQLException {
        List<Customer> customers = customerDAO.getAllCustomers();
        request.setAttribute("customers", customers);
        
        // Check for success message from session
        String successMessage = (String) request.getSession().getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            request.getSession().removeAttribute("successMessage");
        }
        
        // Check for error message from session
        String errorMessage = (String) request.getSession().getAttribute("errorMessage");
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getSession().removeAttribute("errorMessage");
        }
        
        request.getRequestDispatcher("/cashier/customers.jsp").forward(request, response);
    }
    
    private void searchCustomers(HttpServletRequest request, HttpServletResponse response, CustomerDAO customerDAO) 
            throws ServletException, IOException, SQLException {
        String keyword = request.getParameter("keyword");
        List<Customer> customers = customerDAO.searchCustomers(keyword);
        request.setAttribute("customers", customers);
        
        // Check for success message from session
        String successMessage = (String) request.getSession().getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            request.getSession().removeAttribute("successMessage");
        }
        
        // Check for error message from session
        String errorMessage = (String) request.getSession().getAttribute("errorMessage");
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getSession().removeAttribute("errorMessage");
        }
        
        request.getRequestDispatcher("/cashier/customers.jsp").forward(request, response);
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/cashier/customer-form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response, CustomerDAO customerDAO) 
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Customer customer = customerDAO.getCustomerById(id);
        
        if (customer != null) {
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/cashier/customer-form.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("errorMessage", "Customer not found with ID: " + id);
            response.sendRedirect(request.getContextPath() + "/Cashier/customers");
        }
    }
    
    private void insertCustomer(HttpServletRequest request, HttpServletResponse response, CustomerDAO customerDAO) 
            throws ServletException, IOException, SQLException {
        try {
            Customer customer = new Customer();
            customer.setAccountNumber(request.getParameter("accountNumber"));
            customer.setName(request.getParameter("name"));
            customer.setAddress(request.getParameter("address"));
            customer.setTelephone(request.getParameter("telephone"));
            customer.setEmail(request.getParameter("email"));
            
            // Validate required fields
            if (customer.getName() == null || customer.getName().trim().isEmpty() ||
                customer.getEmail() == null || customer.getEmail().trim().isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Name and Email are required fields.");
                response.sendRedirect(request.getContextPath() + "/Cashier/customers?action=new");
                return;
            }
            
            // Customer එක add කරන්න
            boolean success = customerDAO.addCustomer(customer);
            
            if (success) {
                // Email එක යවන්න
                String customerEmail = customer.getEmail();
                String customerName = customer.getName();
                
                // Background thread එකකින් email යවන්න (performance සඳහා)
                new Thread(() -> {
                    EmailUtil.sendCustomerWelcomeEmail(customerEmail, customerName);
                }).start();
                
                request.getSession().setAttribute("successMessage", "Customer added successfully! Welcome email sent.");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to add customer. Account number or email might already exist.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error adding customer: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/Cashier/customers");
    }
    
    private void updateCustomer(HttpServletRequest request, HttpServletResponse response, CustomerDAO customerDAO) 
            throws ServletException, IOException, SQLException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Customer customer = new Customer();
            customer.setId(id);
            customer.setAccountNumber(request.getParameter("accountNumber"));
            customer.setName(request.getParameter("name"));
            customer.setAddress(request.getParameter("address"));
            customer.setTelephone(request.getParameter("telephone"));
            customer.setEmail(request.getParameter("email"));
            
            // Validate required fields
            if (customer.getName() == null || customer.getName().trim().isEmpty() ||
                customer.getEmail() == null || customer.getEmail().trim().isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Name and Email are required fields.");
                response.sendRedirect(request.getContextPath() + "/Cashier/customers?action=edit&id=" + id);
                return;
            }
            
            boolean success = customerDAO.updateCustomer(customer);
            
            if (success) {
                request.getSession().setAttribute("successMessage", "Customer updated successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to update customer. Account number or email might already exist.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error updating customer: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/Cashier/customers");
    }
    
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response, CustomerDAO customerDAO) 
            throws ServletException, IOException, SQLException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = customerDAO.deleteCustomer(id);
            
            if (success) {
                request.getSession().setAttribute("successMessage", "Customer deleted successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to delete customer. The customer might have associated orders.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error deleting customer: " + e.getMessage());
        }
        
        // For AJAX requests, we don't redirect but let the client handle the response
        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true}");
        } else {
            response.sendRedirect(request.getContextPath() + "/Cashier/customers");
        }
    }
}