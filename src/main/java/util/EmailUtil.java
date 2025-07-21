package util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_USERNAME = "hmsupuniudeshika@gmail.com";
    private static final String EMAIL_PASSWORD = "sxsj lecr kfna uvqy";

    public static void sendEmail(String toEmail, String subject, String content) {
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
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(content);

            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send email", e);
        }
    }
    
    public static void sendCustomerWelcomeEmail(String customerEmail, String customerName) {
        String subject = "Welcome to Pahana Edu - Membership Confirmation";
        String content = "Dear " + customerName + ",\n\n"
                + "Thank you for registering with Pahana Edu! Your membership has been successfully created.\n\n"
                + "We're excited to have you as part of our community. You can now enjoy all the benefits of our services.\n\n"
                + "If you have any questions or need assistance, please don't hesitate to contact us.\n\n"
                + "Best regards,\n"
                + "Pahana Edu Team";
        
        sendEmail(customerEmail, subject, content);
    }
}