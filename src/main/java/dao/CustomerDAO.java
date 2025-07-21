package dao;

import model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    private Connection connection;

    public CustomerDAO(Connection connection) {
        this.connection = connection;
    }

    // Add a new customer
    public boolean addCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO customers (account_number, name, address, telephone, email) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, customer.getAccountNumber());
            statement.setString(2, customer.getName());
            statement.setString(3, customer.getAddress());
            statement.setString(4, customer.getTelephone());
            statement.setString(5, customer.getEmail());

            int affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                return false;
            }

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    customer.setId(generatedKeys.getInt(1));
                    return true;
                }
            }
            return false;
        }
    }

    // Get all customers
    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers ORDER BY name";
        
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            
            while (resultSet.next()) {
                customers.add(extractCustomerFromResultSet(resultSet));
            }
        }
        return customers;
    }

    // Get customer by ID
    public Customer getCustomerById(int id) throws SQLException {
        String sql = "SELECT * FROM customers WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return extractCustomerFromResultSet(resultSet);
                }
            }
        }
        return null;
    }

    // Update customer
    public boolean updateCustomer(Customer customer) throws SQLException {
        String sql = "UPDATE customers SET account_number = ?, name = ?, address = ?, telephone = ?, email = ?, updated_at = ? WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, customer.getAccountNumber());
            statement.setString(2, customer.getName());
            statement.setString(3, customer.getAddress());
            statement.setString(4, customer.getTelephone());
            statement.setString(5, customer.getEmail());
            statement.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            statement.setInt(7, customer.getId());

            return statement.executeUpdate() > 0;
        }
    }

    // Delete customer
    public boolean deleteCustomer(int id) throws SQLException {
        String sql = "DELETE FROM customers WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        }
    }

    // Search customers
    public List<Customer> searchCustomers(String keyword) throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers WHERE name LIKE ? OR email LIKE ? OR account_number LIKE ? ORDER BY name";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            String searchTerm = "%" + keyword + "%";
            statement.setString(1, searchTerm);
            statement.setString(2, searchTerm);
            statement.setString(3, searchTerm);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    customers.add(extractCustomerFromResultSet(resultSet));
                }
            }
        }
        return customers;
    }

    // Helper method to extract customer from ResultSet
    private Customer extractCustomerFromResultSet(ResultSet resultSet) throws SQLException {
        Customer customer = new Customer();
        customer.setId(resultSet.getInt("id"));
        customer.setAccountNumber(resultSet.getString("account_number"));
        customer.setName(resultSet.getString("name"));
        customer.setAddress(resultSet.getString("address"));
        customer.setTelephone(resultSet.getString("telephone"));
        customer.setEmail(resultSet.getString("email"));
        customer.setCreatedAt(new Date(resultSet.getTimestamp("created_at").getTime()));
        customer.setUpdatedAt(new Date(resultSet.getTimestamp("updated_at").getTime()));
        
        return customer;
    }
}