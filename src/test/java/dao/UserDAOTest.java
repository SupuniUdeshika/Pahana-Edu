package dao;

import model.User;
import org.junit.*;
import java.sql.*;
import java.util.*;

import static org.junit.Assert.*;

public class UserDAOTest {
    private static Connection connection;
    private UserDAO userDAO;

    @BeforeClass
    public static void setupDatabase() throws Exception {
        // H2 in-memory database
        connection = DriverManager.getConnection("jdbc:h2:mem:test;DB_CLOSE_DELAY=-1");
        Statement stmt = connection.createStatement();
        stmt.execute("CREATE TABLE users (" +
                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                "name VARCHAR(255), " +
                "email VARCHAR(255), " +
                "password VARCHAR(255), " +
                "role VARCHAR(50), " +
                "verified BOOLEAN DEFAULT FALSE, " +
                "verification_token VARCHAR(255), " +
                "verification_token_expiry TIMESTAMP, " +
                "reset_token VARCHAR(255), " +
                "reset_token_expiry TIMESTAMP, " +
                "created_at TIMESTAMP, " +
                "updated_at TIMESTAMP)");
    }

    @Before
    public void setUp() {
        userDAO = new UserDAO(connection);
    }

    @After
    public void cleanUp() throws Exception {
        Statement stmt = connection.createStatement();
        stmt.execute("DELETE FROM users");
    }

    @AfterClass
    public static void closeDatabase() throws Exception {
        connection.close();
    }

    @Test
    public void testAddUserAndGetByEmail() throws Exception {
        User user = new User("John Doe", "john@example.com", "1234", "ADMIN");
        user.setVerificationToken("token123");
        userDAO.addUser(user);

        User fetched = userDAO.getUserByEmail("john@example.com");
        assertNotNull(fetched);
        assertEquals("John Doe", fetched.getName());
        assertEquals("1234", fetched.getPassword());
        assertEquals("ADMIN", fetched.getRole());
    }

    @Test
    public void testUpdateUser() throws Exception {
        User user = new User("Jane Doe", "jane@example.com", "abcd", "CASHIER");
        user.setVerificationToken("tok456");
        userDAO.addUser(user);

        user.setName("Jane Updated");
        user.setPassword("newpass");
        boolean updated = userDAO.updateUser(user);

        assertTrue(updated);
        User fetched = userDAO.getUserByEmail("jane@example.com");
        assertEquals("Jane Updated", fetched.getName());
        assertEquals("newpass", fetched.getPassword());
    }

    @Test
    public void testDeleteUser() throws Exception {
        User user = new User("Delete Me", "del@example.com", "delpass", "ADMIN");
        userDAO.addUser(user);

        boolean deleted = userDAO.deleteUser(user.getId());
        assertTrue(deleted);
        assertNull(userDAO.getUserByEmail("del@example.com"));
    }
}
