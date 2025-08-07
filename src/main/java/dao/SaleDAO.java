package dao;

import model.Sale;
import model.SaleItem;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Date;

public class SaleDAO {
    private Connection connection;

    public SaleDAO() throws SQLException {
        this.connection = DatabaseConnection.getConnection();
    }


    // Create a new sale
    public int createSale(Sale sale) throws SQLException {
        String sql = "INSERT INTO sales (customer_id, sale_date, total_amount, amount_paid, balance, payment_method) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, sale.getCustomerId());
            statement.setTimestamp(2, new Timestamp(sale.getSaleDate().getTime()));
            statement.setDouble(3, sale.getTotalAmount());
            statement.setDouble(4, sale.getAmountPaid());
            statement.setDouble(5, sale.getBalance());
            statement.setString(6, sale.getPaymentMethod());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating sale failed, no rows affected.");
            }
            
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating sale failed, no ID obtained.");
                }
            }
        }
    }

    // Add sale items
    public void addSaleItems(int saleId, List<SaleItem> items) throws SQLException {
        String sql = "INSERT INTO sale_items (sale_id, product_id, product_name, quantity, price, subtotal) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            for (SaleItem item : items) {
                statement.setInt(1, saleId);
                statement.setInt(2, item.getProductId());
                statement.setString(3, item.getProductName());
                statement.setInt(4, item.getQuantity());
                statement.setDouble(5, item.getPrice());
                statement.setDouble(6, item.getSubtotal());
                statement.addBatch();
                
                // Update product quantity
                updateProductQuantity(item.getProductId(), item.getQuantity());
            }
            statement.executeBatch();
        }
    }

    // Update product quantity after sale
    private void updateProductQuantity(int productId, int quantitySold) throws SQLException {
        String sql = "UPDATE products SET quantity = quantity - ? WHERE id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, quantitySold);
            statement.setInt(2, productId);
            statement.executeUpdate();
        }
    }

    // Get sales by date
    public List<Sale> getSalesByDate(java.util.Date date) throws SQLException {
        List<Sale> sales = new ArrayList<>();
        String sql = "SELECT s.*, c.name as customer_name FROM sales s LEFT JOIN customers c ON s.customer_id = c.id WHERE DATE(s.sale_date) = ? ORDER BY s.sale_date DESC";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setDate(1, new java.sql.Date(date.getTime()));
            
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Sale sale = extractSaleFromResultSet(resultSet);
                    sale.setItems(getSaleItems(sale.getId()));
                    sales.add(sale);
                }
            }
        }
        return sales;
    }

    // Get sale by ID
    public Sale getSaleById(int saleId) throws SQLException {
        String sql = "SELECT s.*, c.name as customer_name FROM sales s LEFT JOIN customers c ON s.customer_id = c.id WHERE s.id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, saleId);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Sale sale = extractSaleFromResultSet(resultSet);
                    sale.setItems(getSaleItems(saleId));
                    return sale;
                }
            }
        }
        return null;
    }

    // Get sale items for a sale
    public List<SaleItem> getSaleItems(int saleId) throws SQLException {
        List<SaleItem> items = new ArrayList<>();
        String sql = "SELECT * FROM sale_items WHERE sale_id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, saleId);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    SaleItem item = new SaleItem();
                    item.setId(resultSet.getInt("id"));
                    item.setSaleId(resultSet.getInt("sale_id"));
                    item.setProductId(resultSet.getInt("product_id"));
                    item.setProductName(resultSet.getString("product_name"));
                    item.setQuantity(resultSet.getInt("quantity"));
                    item.setPrice(resultSet.getDouble("price"));
                    item.setSubtotal(resultSet.getDouble("subtotal"));
                    
                    items.add(item);
                }
            }
        }
        return items;
    }

    // Helper method to extract sale from ResultSet
    private Sale extractSaleFromResultSet(ResultSet resultSet) throws SQLException {
        Sale sale = new Sale();
        sale.setId(resultSet.getInt("id"));
        sale.setCustomerId(resultSet.getInt("customer_id"));
        sale.setCustomerName(resultSet.getString("customer_name"));
        sale.setSaleDate(new Date(resultSet.getTimestamp("sale_date").getTime()));
        sale.setTotalAmount(resultSet.getDouble("total_amount"));
        sale.setAmountPaid(resultSet.getDouble("amount_paid"));
        sale.setBalance(resultSet.getDouble("balance"));
        sale.setPaymentMethod(resultSet.getString("payment_method"));
        return sale;
    }
    
    public List<Sale> getSalesByDateRange(Date startDate, Date endDate) throws SQLException {
        List<Sale> sales = new ArrayList<>();
        String sql = "SELECT s.*, c.name as customer_name FROM sales s " +
                     "LEFT JOIN customers c ON s.customer_id = c.id " +
                     "WHERE s.sale_date BETWEEN ? AND ? " +
                     "ORDER BY s.sale_date DESC";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setTimestamp(1, new Timestamp(startDate.getTime()));
            statement.setTimestamp(2, new Timestamp(endDate.getTime()));
            
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Sale sale = extractSaleFromResultSet(resultSet);
                    sale.setItems(getSaleItems(sale.getId()));
                    sales.add(sale);
                }
            }
        }
        return sales;
    }

    public Map<String, Double> getDailySalesSummary(Date startDate, Date endDate) throws SQLException {
        Map<String, Double> dailySales = new LinkedHashMap<>();
        
        // First initialize all dates in range with 0.0
        Calendar cal = Calendar.getInstance();
        cal.setTime(startDate);
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        while (!cal.getTime().after(endDate)) {
            dailySales.put(dateFormat.format(cal.getTime()), 0.0);
            cal.add(Calendar.DATE, 1);
        }
        
        // Then get actual sales data
        String sql = "SELECT DATE(sale_date) as sale_date, SUM(total_amount) as daily_total " +
                     "FROM sales " +
                     "WHERE sale_date BETWEEN ? AND ? " +
                     "GROUP BY DATE(sale_date) " +
                     "ORDER BY DATE(sale_date)";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setTimestamp(1, new Timestamp(startDate.getTime()));
            statement.setTimestamp(2, new Timestamp(endDate.getTime()));
            
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    String dateStr = resultSet.getString("sale_date");
                    double total = resultSet.getDouble("daily_total");
                    dailySales.put(dateStr, total);
                }
            }
        }
        
        return dailySales;
    }
    

}