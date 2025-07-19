package dao;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class ProductDAO {
    private Connection connection;

    public ProductDAO() {
        try {
            this.connection = DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize database connection", e);
        }
    }

    // Add a new product
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (name, description, quantity, category_id, image, price) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, product.getName());
            statement.setString(2, product.getDescription());
            statement.setInt(3, product.getQuantity());
            statement.setInt(4, product.getCategoryId());
            statement.setBytes(5, product.getImage());
            statement.setDouble(6, product.getPrice());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all products
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            while (resultSet.next()) {
                Product product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setDescription(resultSet.getString("description"));
                product.setPrice(resultSet.getDouble("price"));
                product.setQuantity(resultSet.getInt("quantity"));
                product.setCategoryId(resultSet.getInt("category_id"));
                product.setCategoryName(resultSet.getString("category_name"));
                
                // Handle image data
                byte[] imageBytes = resultSet.getBytes("image");
                product.setImage(imageBytes); // Set the byte array
                
                // Convert to Base64 for display if image exists
                if (imageBytes != null && imageBytes.length > 0) {
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    product.setImageBase64(base64Image);
                }
                
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Get product by ID
    public Product getProductById(int id) {
        String sql = "SELECT p.*, c.name as category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id WHERE p.id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                Product product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setDescription(resultSet.getString("description"));
                product.setPrice(resultSet.getDouble("price"));
                product.setQuantity(resultSet.getInt("quantity"));
                product.setCategoryId(resultSet.getInt("category_id"));
                product.setCategoryName(resultSet.getString("category_name"));
                
                // Handle image data
                byte[] imageBytes = resultSet.getBytes("image");
                product.setImage(imageBytes);
                
                // Convert to Base64 for display if image exists
                if (imageBytes != null && imageBytes.length > 0) {
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    product.setImageBase64(base64Image);
                }
                
                return product;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update product
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET name = ?, description = ?, quantity = ?, category_id = ?, image = ?, price = ? WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, product.getName());
            statement.setString(2, product.getDescription());
            statement.setInt(3, product.getQuantity());
            statement.setInt(4, product.getCategoryId());
            statement.setBytes(5, product.getImage());
            statement.setDouble(6, product.getPrice());
            statement.setInt(7, product.getId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete product
    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Search products
    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.name LIKE ? OR p.description LIKE ? OR c.name LIKE ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            String searchKeyword = "%" + keyword + "%";
            statement.setString(1, searchKeyword);
            statement.setString(2, searchKeyword);
            statement.setString(3, searchKeyword);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setDescription(resultSet.getString("description"));
                product.setPrice(resultSet.getDouble("price"));
                product.setQuantity(resultSet.getInt("quantity"));
                product.setCategoryId(resultSet.getInt("category_id"));
                product.setCategoryName(resultSet.getString("category_name"));
                
                // Handle image data
                byte[] imageBytes = resultSet.getBytes("image");
                product.setImage(imageBytes);
                
                // Convert to Base64 for display if image exists
                if (imageBytes != null && imageBytes.length > 0) {
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    product.setImageBase64(base64Image); // Now this will work
                }
                
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Get low stock products (quantity <= 5)
    public List<Product> getLowStockProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.quantity <= 5 ORDER BY p.quantity ASC";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            while (resultSet.next()) {
                Product product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setDescription(resultSet.getString("description"));
                product.setPrice(resultSet.getDouble("price"));
                product.setQuantity(resultSet.getInt("quantity"));
                product.setCategoryId(resultSet.getInt("category_id"));
                product.setCategoryName(resultSet.getString("category_name"));
                
                // Handle image data
                byte[] imageBytes = resultSet.getBytes("image");
                product.setImage(imageBytes);
                
                // Convert to Base64 for display if image exists
                if (imageBytes != null && imageBytes.length > 0) {
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    product.setImageBase64(base64Image);
                }
                
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}