package controller;

import dao.CategoryDAO;
import model.Category;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CashierCategoryServlet", value = "/Cashier/categories")
public class CashierCategoryServlet extends HttpServlet {
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteCategory(request, response);
                    break;
                case "search":
                    searchCategories(request, response);
                    break;
                default:
                    listCategories(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "insert":
                    insertCategory(request, response);
                    break;
                case "update":
                    updateCategory(request, response);
                    break;
                default:
                    listCategories(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        
        // Check for success message from session
        String successMessage = (String) request.getSession().getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            request.getSession().removeAttribute("successMessage");
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/cashier/categories.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/cashier/category-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Category existingCategory = categoryDAO.getCategoryById(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/cashier/category-form.jsp");
        request.setAttribute("category", existingCategory);
        dispatcher.forward(request, response);
    }

    private void insertCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        Category newCategory = new Category();
        newCategory.setName(name);
        newCategory.setDescription(description);
        
        categoryDAO.addCategory(newCategory);
        
        // Set success message in session
        request.getSession().setAttribute("successMessage", "Category added successfully!");
        response.sendRedirect(request.getContextPath() + "/Cashier/categories");
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        Category category = new Category(id, name, description);
        categoryDAO.updateCategory(category);
        
        // Set success message in session
        request.getSession().setAttribute("successMessage", "Category updated successfully!");
        response.sendRedirect(request.getContextPath() + "/Cashier/categories");
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        categoryDAO.deleteCategory(id);
        
        // Set success message in session
        request.getSession().setAttribute("successMessage", "Category deleted successfully!");
        response.sendRedirect(request.getContextPath() + "/Cashier/categories");
    }

    private void searchCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Category> categories = categoryDAO.searchCategories(keyword);
        request.setAttribute("categories", categories);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/cashier/categories.jsp");
        dispatcher.forward(request, response);
    }
}