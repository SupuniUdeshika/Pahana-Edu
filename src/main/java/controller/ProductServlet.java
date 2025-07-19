package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Product;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = {"/Admin/products"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action == null ? "list" : action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                case "lowstock":
                    listLowStockProducts(request, response);
                    break;
                case "search":
                    searchProducts(request, response);
                    break;
                default:
                    listProducts(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "insert":
                    insertProduct(request, response);
                    break;
                case "update":
                    updateProduct(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Admin/products.jsp");
        dispatcher.forward(request, response);
    }

    private void listLowStockProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productDAO.getLowStockProducts();
        request.setAttribute("products", products);
        request.setAttribute("lowStockFilter", true);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Admin/products.jsp");
        dispatcher.forward(request, response);
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Product> products = productDAO.searchProducts(keyword);
        request.setAttribute("products", products);
        request.setAttribute("keyword", keyword);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Admin/products.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("categories", categoryDAO.getAllCategories());
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Admin/product-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(id);
        request.setAttribute("product", product);
        request.setAttribute("categories", categoryDAO.getAllCategories());
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Admin/product-form.jsp");
        dispatcher.forward(request, response);
    }

    private void insertProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        Part filePart = request.getPart("image");
        byte[] imageBytes = filePart.getInputStream().readAllBytes();
        double price = Double.parseDouble(request.getParameter("price"));
        
        
        Product newProduct = new Product();
        newProduct.setName(name);
        newProduct.setDescription(description);
        newProduct.setQuantity(quantity);
        newProduct.setCategoryId(categoryId);
        newProduct.setImage(imageBytes);
        newProduct.setPrice(price);

        if (productDAO.addProduct(newProduct)) {
            response.sendRedirect("products?action=list");
        } else {
            request.setAttribute("error", "Failed to add product");
            request.getRequestDispatcher("/Admin/product-form.jsp").forward(request, response);
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        Part filePart = request.getPart("image");
        
        
        Product product = productDAO.getProductById(id);
        product.setName(name);
        product.setPrice(price);
        product.setDescription(description);
        product.setQuantity(quantity);
        product.setCategoryId(categoryId);
        

        // Only update image if a new one was uploaded
        if (filePart != null && filePart.getSize() > 0) {
            byte[] imageBytes = filePart.getInputStream().readAllBytes();
            product.setImage(imageBytes);
        }

        if (productDAO.updateProduct(product)) {
            response.sendRedirect("products?action=list");
        } else {
            request.setAttribute("error", "Failed to update product");
            request.getRequestDispatcher("/Admin/product-form.jsp").forward(request, response);
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.deleteProduct(id);
        response.sendRedirect("products?action=list");
    }
}