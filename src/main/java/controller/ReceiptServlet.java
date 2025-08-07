// /Pahana Edu SU/src/main/java/controller/ReceiptServlet.java
package controller;

import dao.DatabaseConnection;
import dao.SaleDAO;
import model.Sale;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/Cashier/receipt")
public class ReceiptServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int saleId = Integer.parseInt(request.getParameter("id"));
        
        try (Connection connection = DatabaseConnection.getConnection()) {
            SaleDAO saleDAO = new SaleDAO();
            Sale sale = (Sale) saleDAO.getSaleItems(saleId);
            
            if (sale != null) {
                request.setAttribute("sale", sale);
                request.setAttribute("receiptDate", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                request.getRequestDispatcher("/Cashier/receipt.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sale not found");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error occurred", e);
        }
    }
}