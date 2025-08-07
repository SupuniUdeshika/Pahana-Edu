// /Pahana Edu SU/src/main/java/util/ReceiptEmailService.java
package util;

import model.Sale;
import model.SaleItem;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class ReceiptEmailService {
	 private static final String SMTP_HOST = "smtp.gmail.com";
	 private static final String SMTP_PORT = "587";
	 private static final String EMAIL_USERNAME = "hmsupuniudeshika@gmail.com";
	 private static final String EMAIL_PASSWORD = "sxsj lecr kfna uvqy";

    public static void sendReceipt(Sale sale, String customerEmail) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(customerEmail));
            message.setSubject("Pahana Edu - Purchase Receipt #" + sale.getId());

            String content = buildEmailContent(sale);
            message.setContent(content, "text/html");

            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send receipt email", e);
        }
    }

    private static String buildEmailContent(Sale sale) {
        StringBuilder sb = new StringBuilder();
        sb.append("<html><body>");
        sb.append("<h2>Pahana Edu - Purchase Receipt</h2>");
        sb.append("<p>Thank you for your purchase! Below are the details of your transaction:</p>");
        
        sb.append("<h3>Receipt #").append(sale.getId()).append("</h3>");
        sb.append("<p><strong>Date:</strong> ").append(sale.getSaleDate()).append("</p>");
        sb.append("<p><strong>Customer:</strong> ").append(sale.getCustomerName()).append("</p>");
        
        sb.append("<h4>Items Purchased:</h4>");
        sb.append("<table border='1' cellpadding='5' cellspacing='0'>");
        sb.append("<tr><th>Item</th><th>Price</th><th>Qty</th><th>Subtotal</th></tr>");
        
        for (SaleItem item : sale.getItems()) {
            sb.append("<tr>");
            sb.append("<td>").append(item.getProductName()).append("</td>");
            sb.append("<td>Rs. ").append(String.format("%.2f", item.getPrice())).append("</td>");
            sb.append("<td>").append(item.getQuantity()).append("</td>");
            sb.append("<td>Rs. ").append(String.format("%.2f", item.getSubtotal())).append("</td>");
            sb.append("</tr>");
        }
        
        sb.append("<tr><td colspan='3'><strong>Total:</strong></td><td>Rs. ")
          .append(String.format("%.2f", sale.getTotalAmount())).append("</td></tr>");
        sb.append("<tr><td colspan='3'><strong>Amount Paid:</strong></td><td>Rs. ")
          .append(String.format("%.2f", sale.getAmountPaid())).append("</td></tr>");
        sb.append("<tr><td colspan='3'><strong>Balance:</strong></td><td>Rs. ")
          .append(String.format("%.2f", sale.getBalance())).append("</td></tr>");
        
        sb.append("</table>");
        sb.append("<p><strong>Payment Method:</strong> ").append(sale.getPaymentMethod()).append("</p>");
        
        sb.append("<p>Thank you for shopping with Pahana Edu. We appreciate your business!</p>");
        sb.append("<p>For any inquiries, please contact us at info@pahana.edu or call +94 112 345 678</p>");
        sb.append("</body></html>");
        
        return sb.toString();
    }
}