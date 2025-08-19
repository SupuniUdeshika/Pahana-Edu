package dao;

import model.Product;
import org.junit.*;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

import java.sql.*;
import java.util.List;

import static org.junit.Assert.*;

public class ProductDAOTest {

    private static Connection h2Conn;
    private static MockedStatic<DatabaseConnection> mockedStatic; // mock static call
    private ProductDAO productDAO;

    @BeforeClass
    public static void beforeClass() throws Exception {
        // Start H2 in-memory database
        Class.forName("org.h2.Driver");
        h2Conn = DriverManager.getConnection("jdbc:h2:mem:testdb;MODE=MySQL;DB_CLOSE_DELAY=-1", "sa", "");

        // Mock DatabaseConnection.getConnection() to return our H2 connection
        mockedStatic = Mockito.mockStatic(DatabaseConnection.class);
        mockedStatic.when(DatabaseConnection::getConnection).thenReturn(h2Conn);

        // Create minimal schema used by ProductDAO
        try (Statement st = h2Conn.createStatement()) {
            st.execute("CREATE TABLE categories (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "name VARCHAR(255) NOT NULL" +
                    ")");

            st.execute("CREATE TABLE products (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "name VARCHAR(255) NOT NULL," +
                    "description TEXT," +
                    "quantity INT NOT NULL," +
                    "category_id INT," +
                    "image BLOB," +
                    "price DOUBLE," +
                    "FOREIGN KEY (category_id) REFERENCES categories(id)" +
                    ")");

            st.execute("CREATE TABLE customers (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "name VARCHAR(255))");

            st.execute("CREATE TABLE sales (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "customer_id INT," +
                    "sale_date TIMESTAMP," +
                    "total_amount DOUBLE," +
                    "amount_paid DOUBLE," +
                    "balance DOUBLE," +
                    "payment_method VARCHAR(50))");

            st.execute("CREATE TABLE sale_items (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "sale_id INT," +
                    "product_id INT," +
                    "product_name VARCHAR(255)," +
                    "quantity INT," +
                    "price DOUBLE," +
                    "subtotal DOUBLE)");
        }

        // Seed one category
        try (PreparedStatement ps = h2Conn.prepareStatement("INSERT INTO categories(name) VALUES (?)")) {
            ps.setString(1, "Laptops");
            ps.executeUpdate();
        }
    }

    @AfterClass
    public static void afterClass() throws Exception {
        if (mockedStatic != null) mockedStatic.close();
        if (h2Conn != null && !h2Conn.isClosed()) h2Conn.close();
    }

    @Before
    public void setUp() {
        productDAO = new ProductDAO();
        try (Statement st = h2Conn.createStatement()) {
            st.execute("DELETE FROM products");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Test
    public void testAddProductAndGetAllProducts() {
        Product p = new Product();
        p.setName("Dell XPS 13");
        p.setDescription("13-inch ultrabook");
        p.setQuantity(10);
        p.setCategoryId(1);
        p.setImage(new byte[]{1, 2, 3});
        p.setPrice(1999.99);

        assertTrue(productDAO.addProduct(p));

        List<Product> all = productDAO.getAllProducts();
        assertEquals(1, all.size());
        Product got = all.get(0);
        assertEquals("Dell XPS 13", got.getName());
        assertEquals("13-inch ultrabook", got.getDescription());
        assertEquals(10, got.getQuantity());
        assertEquals(1, got.getCategoryId());
        assertNotNull(got.getImage());
        assertEquals(1999.99, got.getPrice(), 0.0001);
        assertNotNull(got.getImageBase64());
        assertEquals("Laptops", got.getCategoryName());
    }

    @Test
    public void testUpdateProduct() throws Exception {
        try (PreparedStatement ps = h2Conn.prepareStatement(
                "INSERT INTO products(name, description, quantity, category_id, image, price) VALUES(?,?,?,?,?,?)",
                Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, "HP 250");
            ps.setString(2, "Entry laptop");
            ps.setInt(3, 5);
            ps.setInt(4, 1);
            ps.setBytes(5, new byte[]{9});
            ps.setDouble(6, 750.0);
            ps.executeUpdate();
        }

        int id = getOnlyId();

        Product toUpdate = productDAO.getProductById(id);
        assertNotNull(toUpdate);

        toUpdate.setName("HP 255 G9");
        toUpdate.setDescription("Refreshed model");
        toUpdate.setQuantity(7);
        toUpdate.setCategoryId(1);
        toUpdate.setImage(new byte[]{7, 7, 7});
        toUpdate.setPrice(825.50);

        assertTrue(productDAO.updateProduct(toUpdate));

        Product after = productDAO.getProductById(id);
        assertEquals("HP 255 G9", after.getName());
        assertEquals("Refreshed model", after.getDescription());
        assertEquals(7, after.getQuantity());
        assertEquals(825.50, after.getPrice(), 0.0001);
        assertNotNull(after.getImageBase64());
    }

    @Test
    public void testDeleteProduct() throws Exception {
        try (PreparedStatement ps = h2Conn.prepareStatement(
                "INSERT INTO products(name, description, quantity, category_id, image, price) VALUES(?,?,?,?,?,?)")) {
            ps.setString(1, "Lenovo ThinkPad");
            ps.setString(2, "Business laptop");
            ps.setInt(3, 3);
            ps.setInt(4, 1);
            ps.setBytes(5, null);
            ps.setDouble(6, 1200.0);
            ps.executeUpdate();
        }
        int id = getOnlyId();
        assertTrue(productDAO.deleteProduct(id));
        assertNull(productDAO.getProductById(id));
        assertEquals(0, productDAO.getAllProducts().size());
    }

    @Test
    public void testSearchProducts() throws Exception {
        seedProductsForSearch();
        List<Product> byName = productDAO.searchProducts("MacBook");
        assertEquals(1, byName.size());
        assertEquals("MacBook Air", byName.get(0).getName());

        List<Product> byDesc = productDAO.searchProducts("gaming");
        assertEquals(1, byDesc.size());
        assertEquals("Acer Nitro", byDesc.get(0).getName());

        List<Product> byCategory = productDAO.searchProducts("Laptops");
        assertEquals(2, byCategory.size());
    }

    @Test
    public void testLowStockProducts() throws Exception {
        try (PreparedStatement ps = h2Conn.prepareStatement(
                "INSERT INTO products(name, description, quantity, category_id, image, price) VALUES(?,?,?,?,?,?)")) {
            insert(ps, "Mini PC", "Small form factor", 2, 1, null, 350.0);
            insert(ps, "Router", "WiFi 6", 5, 1, null, 120.0);
            insert(ps, "Monitor", "27 inch", 8, 1, null, 250.0);
        }

        List<Product> low = productDAO.getLowStockProducts();
        assertEquals(2, low.size());
        assertTrue(low.get(0).getQuantity() <= low.get(1).getQuantity());
    }

    @Test
    public void testGetTotals() throws Exception {
        assertEquals(0, productDAO.getTotalProducts());
        try (PreparedStatement ps = h2Conn.prepareStatement(
                "INSERT INTO products(name, description, quantity, category_id, image, price) VALUES(?,?,?,?,?,?)")) {
            insert(ps, "ItemA", "", 1, 1, null, 10.0);
            insert(ps, "ItemB", "", 2, 1, null, 20.0);
            insert(ps, "ItemC", "", 6, 1, null, 30.0);
        }
        assertEquals(3, productDAO.getTotalProducts());
        assertEquals(2, productDAO.getLowStockProductsCount());
    }

    // ---------- helpers ----------

    private static void insert(PreparedStatement ps, String name, String desc, int qty, int catId, byte[] img, double price) throws SQLException {
        ps.setString(1, name);
        ps.setString(2, desc);
        ps.setInt(3, qty);
        ps.setInt(4, catId);
        ps.setBytes(5, img);
        ps.setDouble(6, price);
        ps.executeUpdate();
    }

    private static int getOnlyId() throws SQLException {
        try (Statement st = h2Conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT id FROM products")) {
            if (rs.next()) return rs.getInt(1);
        }
        throw new IllegalStateException("No rows to fetch id from");
    }

    private void seedProductsForSearch() throws SQLException {
        try (PreparedStatement ps = h2Conn.prepareStatement(
                "INSERT INTO products(name, description, quantity, category_id, image, price) VALUES(?,?,?,?,?,?)")) {
            insert(ps, "MacBook Air", "Lightweight ultrabook", 15, 1, null, 2400.0);
            insert(ps, "Acer Nitro", "gaming laptop", 4, 1, null, 1500.0);
        }
    }
}
