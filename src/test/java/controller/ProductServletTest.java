package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Product;
import org.junit.Before;
import org.junit.Test;
import org.mockito.ArgumentCaptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.*;
import javax.servlet.http.Part;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.*;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

public class ProductServletTest {

    private ProductServlet servlet;
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher dispatcher;

    @Before
    public void setUp() throws Exception {
        servlet = new ProductServlet();

        // mock DAOs
        productDAO = mock(ProductDAO.class);
        categoryDAO = mock(CategoryDAO.class);

        // inject mocks into servlet private fields
        setPrivate(servlet, "productDAO", productDAO);
        setPrivate(servlet, "categoryDAO", categoryDAO);

        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        dispatcher = mock(RequestDispatcher.class);

        // common forwards
        when(request.getRequestDispatcher("/Admin/products.jsp")).thenReturn(dispatcher);
        when(request.getRequestDispatcher("/Admin/product-form.jsp")).thenReturn(dispatcher);

        // Avoid NPE with getServletContext in some containers
        ServletConfig config = mock(ServletConfig.class);
        ServletContext ctx = mock(ServletContext.class);
        when(config.getServletContext()).thenReturn(ctx);
        // We won’t call init() since it would overwrite our injected DAOs.
    }

    @Test
    public void testListProducts() throws Exception {
        when(request.getParameter("action")).thenReturn(null); // defaults to "list"
        List<Product> list = Arrays.asList(dummy(1, "A"), dummy(2, "B"));
        when(productDAO.getAllProducts()).thenReturn(list);

        servlet.doGet(request, response);

        verify(productDAO).getAllProducts();
        verify(request).setAttribute(eq("products"), eq(list));
        verify(dispatcher).forward(request, response);
    }

    @Test
    public void testShowNewForm() throws Exception {
        when(request.getParameter("action")).thenReturn("new");
        when(categoryDAO.getAllCategories()).thenReturn(Collections.emptyList());

        servlet.doGet(request, response);

        verify(categoryDAO).getAllCategories();
        verify(request).setAttribute(eq("categories"), any());
        verify(dispatcher).forward(request, response);
    }

    @Test
    public void testShowEditForm() throws Exception {
        when(request.getParameter("action")).thenReturn("edit");
        when(request.getParameter("id")).thenReturn("5");

        Product p = dummy(5, "EditMe");
        when(productDAO.getProductById(5)).thenReturn(p);
        when(categoryDAO.getAllCategories()).thenReturn(Collections.emptyList());

        servlet.doGet(request, response);

        verify(productDAO).getProductById(5);
        verify(request).setAttribute("product", p);
        verify(request).setAttribute(eq("categories"), any());
        verify(dispatcher).forward(request, response);
    }

    @Test
    public void testDeleteProduct() throws Exception {
        when(request.getParameter("action")).thenReturn("delete");
        when(request.getParameter("id")).thenReturn("7");

        when(productDAO.deleteProduct(7)).thenReturn(true);

        servlet.doGet(request, response);

        verify(productDAO).deleteProduct(7);
        verify(response).sendRedirect("products?action=list");
    }

    @Test
    public void testSearchProducts() throws Exception {
        when(request.getParameter("action")).thenReturn("search");
        when(request.getParameter("keyword")).thenReturn("lap");
        List<Product> results = Collections.singletonList(dummy(9, "Laptop Z"));
        when(productDAO.searchProducts("lap")).thenReturn(results);

        servlet.doGet(request, response);

        verify(productDAO).searchProducts("lap");
        verify(request).setAttribute("products", results);
        verify(request).setAttribute("keyword", "lap");
        verify(dispatcher).forward(request, response);
    }

    @Test
    public void testListLowStock() throws Exception {
        when(request.getParameter("action")).thenReturn("lowstock");
        List<Product> low = Collections.singletonList(dummy(2, "Low One"));
        when(productDAO.getLowStockProducts()).thenReturn(low);

        servlet.doGet(request, response);

        verify(productDAO).getLowStockProducts();
        verify(request).setAttribute("products", low);
        verify(request).setAttribute(eq("lowStockFilter"), eq(true));
        verify(dispatcher).forward(request, response);
    }

    @Test
    public void testInsertProduct_Success() throws Exception {
        when(request.getParameter("action")).thenReturn("insert");
        when(request.getParameter("name")).thenReturn("New Gadget");
        when(request.getParameter("description")).thenReturn("Shiny");
        when(request.getParameter("quantity")).thenReturn("3");
        when(request.getParameter("categoryId")).thenReturn("1");
        when(request.getParameter("price")).thenReturn("999.50");

        Part imagePart = mock(Part.class);
        when(imagePart.getInputStream()).thenReturn(new ByteArrayInputStream(new byte[]{1, 2, 3}));
        when(imagePart.getSize()).thenReturn(3L);
        when(request.getPart("image")).thenReturn(imagePart);

        when(productDAO.addProduct(any(Product.class))).thenReturn(true);

        servlet.doPost(request, response);

        // capture the product passed to DAO
        ArgumentCaptor<Product> cap = ArgumentCaptor.forClass(Product.class);
        verify(productDAO).addProduct(cap.capture());
        Product sent = cap.getValue();
        assertEquals("New Gadget", sent.getName());
        assertEquals("Shiny", sent.getDescription());
        assertEquals(3, sent.getQuantity());
        assertEquals(1, sent.getCategoryId());
        assertEquals(999.50, sent.getPrice(), 0.0001);
        assertNotNull(sent.getImage());
        verify(response).sendRedirect("products?action=list");
    }

    @Test
    public void testUpdateProduct_WithNewImage() throws Exception {
        when(request.getParameter("action")).thenReturn("update");
        when(request.getParameter("id")).thenReturn("11");
        when(request.getParameter("name")).thenReturn("Updated Name");
        when(request.getParameter("price")).thenReturn("1500");
        when(request.getParameter("description")).thenReturn("Updated Desc");
        when(request.getParameter("quantity")).thenReturn("6");
        when(request.getParameter("categoryId")).thenReturn("1");

        Product existing = dummy(11, "Old Name");
        existing.setImage(new byte[]{9});
        when(productDAO.getProductById(11)).thenReturn(existing);

        Part imagePart = mock(Part.class);
        when(imagePart.getSize()).thenReturn(5L); // triggers image replacement
        when(imagePart.getInputStream()).thenReturn(new ByteArrayInputStream(new byte[]{7, 7, 7, 7, 7}));
        when(request.getPart("image")).thenReturn(imagePart);

        when(productDAO.updateProduct(any(Product.class))).thenReturn(true);

        servlet.doPost(request, response);

        ArgumentCaptor<Product> cap = ArgumentCaptor.forClass(Product.class);
        verify(productDAO).updateProduct(cap.capture());
        Product updated = cap.getValue();
        assertEquals(11, updated.getId());
        assertEquals("Updated Name", updated.getName());
        assertEquals(1500.0, updated.getPrice(), 0.0001);
        assertEquals("Updated Desc", updated.getDescription());
        assertEquals(6, updated.getQuantity());
        assertEquals(1, updated.getCategoryId());
        assertArrayEquals(new byte[]{7, 7, 7, 7, 7}, updated.getImage());
        verify(response).sendRedirect("products?action=list");
    }

    @Test
    public void testUpdateProduct_WithoutNewImage() throws Exception {
        when(request.getParameter("action")).thenReturn("update");
        when(request.getParameter("id")).thenReturn("12");
        when(request.getParameter("name")).thenReturn("NoImageChange");
        when(request.getParameter("price")).thenReturn("555");
        when(request.getParameter("description")).thenReturn("Same image");
        when(request.getParameter("quantity")).thenReturn("2");
        when(request.getParameter("categoryId")).thenReturn("1");

        Product existing = dummy(12, "Old");
        byte[] oldImg = new byte[]{4, 4};
        existing.setImage(oldImg);
        when(productDAO.getProductById(12)).thenReturn(existing);

        Part imagePart = mock(Part.class);
        when(imagePart.getSize()).thenReturn(0L); // no new image uploaded
        when(request.getPart("image")).thenReturn(imagePart);

        when(productDAO.updateProduct(any(Product.class))).thenReturn(true);

        servlet.doPost(request, response);

        ArgumentCaptor<Product> cap = ArgumentCaptor.forClass(Product.class);
        verify(productDAO).updateProduct(cap.capture());
        Product updated = cap.getValue();
        assertArrayEquals(oldImg, updated.getImage()); // unchanged
        verify(response).sendRedirect("products?action=list");
    }

    // ---------- helpers ----------

    private static void setPrivate(Object target, String fieldName, Object value) throws Exception {
        Field f = target.getClass().getDeclaredField(fieldName);
        f.setAccessible(true);
        f.set(target, value);
    }

    private static Product dummy(int id, String name) {
        Product p = new Product();
        p.setId(id);
        p.setName(name);
        p.setDescription("");
        p.setPrice(0);
        p.setQuantity(0);
        p.setCategoryId(1);
        return p;
    }
}
