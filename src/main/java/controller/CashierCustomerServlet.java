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
            throw new ServletException("Database error occurred", e);
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error occurred", e);
        }
    }
    
    private void listCustomers(HttpServletRequest request, HttpServletResponse response, CustomerDAO customerDAO) 
            throws ServletException, IOException, SQLException {
        List<Customer> customers = customerDAO.getAllCustomers();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/Cashier/customers.jsp").forward(request, response);
    }
    
    private void searchCustomers(HttpServletRequest request, HttpServletResponse response, CustomerDAO customerDAO) 
            throws ServletException, IOException, SQLException {
        String keyword = request.getParameter("keyword");
        List<Customer> customers = customerDAO.searchCustomers(keyword);
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/Cashier/customers.jsp").forward(request, response);
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Customer customer = new Customer();
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/Cashier/customer-form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response, CustomerDAO customerDAO) 
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Customer customer = customerDAO.getCustomerById(id);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/Cashier/customer-form.jsp").forward(request, response);
    }
    
    private void insertCustomer(HttpServletRequest request, HttpServletResponse response, CustomerDAO customerDAO) 
            throws ServletException, IOException, SQLException {
        Customer customer = new Customer();
        customer.setAccountNumber(request.getParameter("accountNumber"));
        customer.setName(request.getParameter("name"));
        customer.setAddress(request.getParameter("address"));
        customer.setTelephone(request.getParameter("telephone"));
        customer.setEmail(request.getParameter("email"));
        
        customerDAO.addCustomer(customer);
        response.sendRedirect(request.getContextPath() + "/Cashier/customers");
    }
    
    private void updateCustomer(HttpServletRequest request, HttpServletResponse response, CustomerDAO customerDAO) 
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Customer customer = new Customer();
        customer.setId(id);
        customer.setAccountNumber(request.getParameter("accountNumber"));
        customer.setName(request.getParameter("name"));
        customer.setAddress(request.getParameter("address"));
        customer.setTelephone(request.getParameter("telephone"));
        customer.setEmail(request.getParameter("email"));
        
        customerDAO.updateCustomer(customer);
        response.sendRedirect(request.getContextPath() + "/Cashier/customers");
    }
    
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response, CustomerDAO customerDAO) 
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        customerDAO.deleteCustomer(id);
        response.sendRedirect(request.getContextPath() + "/Cashier/customers");
    }
}