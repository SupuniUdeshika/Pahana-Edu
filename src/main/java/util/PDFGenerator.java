package util;

import model.Customer;
import model.Sale;
import model.SaleItem;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.List;

public class PDFGenerator {
    private static final Font TITLE_FONT = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
    private static final Font HEADER_FONT = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
    private static final Font NORMAL_FONT = new Font(Font.FontFamily.HELVETICA, 10);

    public static void generateReceipt(Sale sale, List<SaleItem> items, Customer customer, OutputStream outputStream) {
        Document document = new Document();
        try {
            PdfWriter.getInstance(document, outputStream);
            document.open();

            // Add title
            Paragraph title = new Paragraph("PAHANA EDU - SALES RECEIPT", TITLE_FONT);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(20f);
            document.add(title);

            // Add receipt info
            PdfPTable infoTable = new PdfPTable(2);
            infoTable.setWidthPercentage(100);
            infoTable.setSpacingAfter(20f);

            addInfoCell(infoTable, "Receipt #:", String.valueOf(sale.getId()));
            addInfoCell(infoTable, "Date:", new SimpleDateFormat("yyyy-MM-dd HH:mm").format(sale.getSaleDate()));
            addInfoCell(infoTable, "Customer:", customer.getName());
            addInfoCell(infoTable, "Payment Method:", sale.getPaymentMethod());

            document.add(infoTable);

            // Add customer info
            Paragraph customerInfo = new Paragraph("Customer Details:", HEADER_FONT);
            customerInfo.setSpacingAfter(5f);
            document.add(customerInfo);

            PdfPTable customerTable = new PdfPTable(2);
            customerTable.setWidthPercentage(100);
            customerTable.setSpacingAfter(20f);

            addInfoCell(customerTable, "Name:", customer.getName());
            if (customer.getEmail() != null && !customer.getEmail().isEmpty()) {
                addInfoCell(customerTable, "Email:", customer.getEmail());
            }
            if (customer.getTelephone() != null && !customer.getTelephone().isEmpty()) {
                addInfoCell(customerTable, "Phone:", customer.getTelephone());
            }

            document.add(customerTable);

            // Add items table
            Paragraph itemsHeader = new Paragraph("Items Purchased:", HEADER_FONT);
            itemsHeader.setSpacingAfter(5f);
            document.add(itemsHeader);

            PdfPTable itemsTable = new PdfPTable(4);
            itemsTable.setWidthPercentage(100);
            itemsTable.setSpacingAfter(20f);

            // Table headers
            addTableHeader(itemsTable, "Product");
            addTableHeader(itemsTable, "Price");
            addTableHeader(itemsTable, "Qty");
            addTableHeader(itemsTable, "Subtotal");

            // Add items
            for (SaleItem item : items) {
                addTableCell(itemsTable, item.getProductName());
                addTableCell(itemsTable, String.format("Rs. %.2f", item.getPrice()));
                addTableCell(itemsTable, String.valueOf(item.getQuantity()));
                addTableCell(itemsTable, String.format("Rs. %.2f", item.getSubtotal()));
            }

            document.add(itemsTable);

            // Add totals
            PdfPTable totalsTable = new PdfPTable(2);
            totalsTable.setWidthPercentage(50);
            totalsTable.setHorizontalAlignment(Element.ALIGN_RIGHT);
            totalsTable.setSpacingAfter(20f);

            addTotalCell(totalsTable, "Subtotal:", String.format("Rs. %.2f", sale.getTotalAmount()));
            addTotalCell(totalsTable, "Amount Paid:", String.format("Rs. %.2f", sale.getAmountPaid()));
            addTotalCell(totalsTable, "Balance:", String.format("Rs. %.2f", sale.getBalance()));

            document.add(totalsTable);

            // Add footer
            Paragraph footer = new Paragraph("Thank you for your purchase!\nPlease come again", NORMAL_FONT);
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

        } catch (DocumentException e) {
            e.printStackTrace();
        } finally {
            document.close();
        }
    }

    private static void addInfoCell(PdfPTable table, String label, String value) {
        table.addCell(createCell(label, true));
        table.addCell(createCell(value, false));
    }

    private static void addTableHeader(PdfPTable table, String text) {
        PdfPCell cell = new PdfPCell(new Phrase(text, HEADER_FONT));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
        table.addCell(cell);
    }

    private static void addTableCell(PdfPTable table, String text) {
        PdfPCell cell = new PdfPCell(new Phrase(text, NORMAL_FONT));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setPadding(5);
        table.addCell(cell);
    }

    private static void addTotalCell(PdfPTable table, String label, String value) {
        table.addCell(createCell(label, true));
        table.addCell(createCell(value, false));
    }

    private static PdfPCell createCell(String text, boolean isBold) {
        PdfPCell cell = new PdfPCell(new Phrase(text, isBold ? HEADER_FONT : NORMAL_FONT));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setPadding(5);
        return cell;
    }
}