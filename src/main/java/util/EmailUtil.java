package util;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.*;
import javax.mail.internet.*;

import model.Sale;
import model.SaleItem;

public class EmailUtil {
    private static final Logger logger = Logger.getLogger(EmailUtil.class.getName());
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_USERNAME = "hmsupuniudeshika@gmail.com";
    private static final String EMAIL_PASSWORD = "sxsj lecr kfna uvqy";
    private static final String FROM_NAME = "Pahana Edu";

    public static boolean sendEmail(String toEmail, String subject, String content) {
        if (toEmail == null || toEmail.trim().isEmpty()) {
            logger.warning("No recipient email address provided");
            return false;
        }

        // Validate email format
        if (!toEmail.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            logger.warning("Invalid email address format: " + toEmail);
            return false;
        }

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", SMTP_HOST);
        props.put("mail.smtp.timeout", "10000"); // 10 seconds
        props.put("mail.smtp.connectiontimeout", "10000"); // 10 seconds
        props.put("mail.smtp.writetimeout", "10000"); // 10 seconds

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
            }
        });

        // Enable debugging to see SMTP communication
        session.setDebug(true);

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(content, "text/html; charset=utf-8");

            // Send the message
            Transport.send(message);
            logger.info("Email successfully sent to: " + toEmail);
            return true;
        } catch (AuthenticationFailedException e) {
            logger.log(Level.SEVERE, "Authentication failed. Check email credentials.", e);
        } catch (MessagingException e) {
            logger.log(Level.SEVERE, "Failed to send email to " + toEmail, e);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Unexpected error while sending email", e);
        }
        return false;
    }
    
    public static void sendCustomerWelcomeEmail(String customerEmail, String customerName) {
        String subject = "Welcome to Pahana Edu - Membership Confirmation";
        String content = "Dear " + customerName + ",\n\n"
                + "Thank you for registering with Pahana Edu! Your membership has been successfully created.\n\n"
                + "We're excited to have you as part of our community. You can now enjoy all the benefits of our services.\n\n"
                + "If you have any questions or need assistance, please don't hesitate to contact us.\n\n"
                + "Best regards,\n"
                + "Pahana Edu Team";
        
        boolean sent = sendEmail(customerEmail, subject, content);
        if (!sent) {
            logger.warning("Failed to send welcome email to: " + customerEmail);
        }
    }
    
    public static boolean sendReceiptEmail(String toEmail, String customerName, Sale sale, List<SaleItem> items) {
        if (toEmail == null || toEmail.trim().isEmpty()) {
            logger.warning("No email address provided for customer: " + customerName);
            return false;
        }

        String subject = "Your Purchase Receipt from Pahana Edu (Order #" + sale.getId() + ")";
        
        // Create HTML content for the email
        StringBuilder content = new StringBuilder();
        content.append("<html><body style='font-family: Arial, sans-serif; line-height: 1.6;'>");
        content.append("<div style='max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 5px;'>");
        
        // Header
        content.append("<div style='text-align: center; margin-bottom: 20px;'>");
        content.append("<h2 style='color: #2d3748; margin-bottom: 5px;'>Pahana Edu</h2>");
        content.append("<p style='color: #718096; margin-top: 0;'>123 Book Street, Colombo<br>Tel: 011-1234567</p>");
        content.append("</div>");
        
        // Receipt info
        content.append("<div style='background-color: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px;'>");
        content.append("<h3 style='color: #2d3748; margin-top: 0;'>Receipt #").append(sale.getId()).append("</h3>");
        content.append("<p style='margin-bottom: 5px;'><strong>Date:</strong> ")
              .append(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(sale.getSaleDate())).append("</p>");
        content.append("<p style='margin-top: 5px;'><strong>Customer:</strong> ").append(customerName).append("</p>");
        content.append("</div>");
        
        // Order items
        content.append("<table style='width: 100%; border-collapse: collapse; margin-bottom: 20px;'>");
        content.append("<thead><tr style='background-color: #2d3748; color: white;'>")
              .append("<th style='padding: 10px; text-align: left;'>Product</th>")
              .append("<th style='padding: 10px; text-align: right;'>Price</th>")
              .append("<th style='padding: 10px; text-align: center;'>Qty</th>")
              .append("<th style='padding: 10px; text-align: right;'>Subtotal</th>")
              .append("</tr></thead><tbody>");
        
        for (SaleItem item : items) {
            content.append("<tr style='border-bottom: 1px solid #e0e0e0;'>")
                  .append("<td style='padding: 10px;'>").append(item.getProductName()).append("</td>")
                  .append("<td style='padding: 10px; text-align: right;'>Rs. ")
                  .append(String.format("%,.2f", item.getPrice())).append("</td>")
                  .append("<td style='padding: 10px; text-align: center;'>").append(item.getQuantity()).append("</td>")
                  .append("<td style='padding: 10px; text-align: right;'>Rs. ")
                  .append(String.format("%,.2f", item.getSubtotal())).append("</td>")
                  .append("</tr>");
        }
        
        // Summary
        content.append("<tr><td colspan='4' style='padding-top: 15px;'></td></tr>");
        content.append("<tr><td colspan='3' style='text-align: right; padding: 5px 10px;'><strong>Subtotal:</strong></td>")
              .append("<td style='text-align: right; padding: 5px 10px;'>Rs. ")
              .append(String.format("%,.2f", sale.getTotalAmount())).append("</td></tr>");
        
        content.append("<tr><td colspan='3' style='text-align: right; padding: 5px 10px;'><strong>Payment Method:</strong></td>")
              .append("<td style='text-align: right; padding: 5px 10px;'>").append(sale.getPaymentMethod()).append("</td></tr>");
        
        content.append("<tr><td colspan='3' style='text-align: right; padding: 5px 10px;'><strong>Amount Paid:</strong></td>")
              .append("<td style='text-align: right; padding: 5px 10px;'>Rs. ")
              .append(String.format("%,.2f", sale.getAmountPaid())).append("</td></tr>");
        
        content.append("<tr style='background-color: #f8f9fa;'>")
              .append("<td colspan='3' style='text-align: right; padding: 10px;'><strong>Balance:</strong></td>")
              .append("<td style='text-align: right; padding: 10px;'><strong>Rs. ")
              .append(String.format("%,.2f", sale.getBalance())).append("</strong></td></tr>");
        
        content.append("</tbody></table>");
        
        // Footer
        content.append("<div style='text-align: center; margin-top: 20px; color: #718096; font-size: 0.9em;'>");
        content.append("<p>Thank you for your purchase!<br>Please come again</p>");
        content.append("<p>If you have any questions about your order, please contact us at support@pahanaedu.com</p>");
        content.append("</div>");
        
        content.append("</div></body></html>");

        return sendEmail(toEmail, subject, content.toString());
    }
}