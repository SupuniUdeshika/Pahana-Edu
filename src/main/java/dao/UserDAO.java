package dao;

import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

public class UserDAO {
    private Connection connection;

    public UserDAO(Connection connection) {
        this.connection = connection;
    }

    // Add a new user
    public boolean addUser(User user) throws SQLException {
        String sql = "INSERT INTO users (name, email, password, role, verification_token, verification_token_expiry, created_at, updated_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            ps.setString(5, user.getVerificationToken());
            
            // Handle null expiry date
            if (user.getVerificationTokenExpiry() != null) {
                ps.setTimestamp(6, new Timestamp(user.getVerificationTokenExpiry().getTime()));
            } else {
                ps.setNull(6, Types.TIMESTAMP);
            }
            
            ps.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
            ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                return false;
            }
            
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    user.setId(generatedKeys.getInt(1));
                    return true;
                }
            }
            return false;
        }
    }

    // Get all users
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY name";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        }
        return users;
    }

    // Get user by ID
    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return extractUserFromResultSet(resultSet);
                }
            }
        }
        return null;
    }

    // Get user by email
    public User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return extractUserFromResultSet(resultSet);
                }
            }
        }
        return null;
    }

    // Update user
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET name = ?, email = ?, role = ?, updated_at = ? " +
                     (user.getPassword() != null && !user.getPassword().isEmpty() ? ", password = ? " : "") + 
                     "WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            ps.setString(paramIndex++, user.getName());
            ps.setString(paramIndex++, user.getEmail());
            ps.setString(paramIndex++, user.getRole());
            ps.setTimestamp(paramIndex++, new Timestamp(System.currentTimeMillis()));
            
            if (user.getPassword() != null && !user.getPassword().isEmpty()) {
                ps.setString(paramIndex++, user.getPassword());
            }
            
            ps.setInt(paramIndex, user.getId());
            
            return ps.executeUpdate() > 0;
        }
    }

    // Delete user
    public boolean deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // Search users
    public List<User> searchUsers(String keyword) throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE name LIKE ? OR email LIKE ? ORDER BY name";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String searchTerm = "%" + keyword + "%";
            ps.setString(1, searchTerm);
            ps.setString(2, searchTerm);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(extractUserFromResultSet(rs));
                }
            }
        }
        return users;
    }

    // Get user by verification token
    public User getUserByVerificationToken(String token) throws SQLException {
        String sql = "SELECT * FROM users WHERE verification_token = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, token);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return extractUserFromResultSet(resultSet);
                }
            }
        }
        return null;
    }

    // Get user by reset token
    public User getUserByResetToken(String token) throws SQLException {
        String sql = "SELECT * FROM users WHERE reset_token = ? AND reset_token_expiry > NOW()";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, token);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return extractUserFromResultSet(resultSet);
                }
            }
        }
        return null;
    }

    // Verify user
    public boolean verifyUser(String token) throws SQLException {
        String sql = "UPDATE users SET verified = true, verification_token = NULL, " +
                     "verification_token_expiry = NULL, updated_at = NOW() " +
                     "WHERE verification_token = ? AND verification_token_expiry > NOW()";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, token);
            return statement.executeUpdate() > 0;
        }
    }

    // Update password
    public boolean updatePassword(int userId, String newPassword) throws SQLException {
        String sql = "UPDATE users SET password = ?, reset_token = NULL, reset_token_expiry = NULL, updated_at = ? WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, newPassword);
            statement.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            statement.setInt(3, userId);
            return statement.executeUpdate() > 0;
        }
    }

    // Create password reset token
    public boolean createPasswordResetToken(String email, String token, Date expiryDate) throws SQLException {
        String sql = "UPDATE users SET reset_token = ?, reset_token_expiry = ?, updated_at = ? WHERE email = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, token);
            statement.setTimestamp(2, new Timestamp(expiryDate.getTime()));
            statement.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            statement.setString(4, email);
            return statement.executeUpdate() > 0;
        }
    }

    // Helper method to extract user from ResultSet
    private User extractUserFromResultSet(ResultSet resultSet) throws SQLException {
        User user = new User();
        user.setId(resultSet.getInt("id"));
        user.setName(resultSet.getString("name"));
        user.setEmail(resultSet.getString("email"));
        user.setPassword(resultSet.getString("password"));
        user.setRole(resultSet.getString("role"));
        user.setVerified(resultSet.getBoolean("verified"));
        user.setVerificationToken(resultSet.getString("verification_token"));
        
        Timestamp verificationTokenExpiry = resultSet.getTimestamp("verification_token_expiry");
        if (verificationTokenExpiry != null) {
            user.setVerificationTokenExpiry(new Date(verificationTokenExpiry.getTime()));
        }
        
        user.setResetToken(resultSet.getString("reset_token"));
        
        Timestamp resetTokenExpiry = resultSet.getTimestamp("reset_token_expiry");
        if (resetTokenExpiry != null) {
            user.setResetTokenExpiry(new Date(resetTokenExpiry.getTime()));
        }
        
        user.setCreatedAt(new Date(resultSet.getTimestamp("created_at").getTime()));
        user.setUpdatedAt(new Date(resultSet.getTimestamp("updated_at").getTime()));
        
        return user;
    }
}