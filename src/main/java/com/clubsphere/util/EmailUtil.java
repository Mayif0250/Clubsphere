package com.clubsphere.util;

import java.util.*;
import java.io.*;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {

    // Use Properties to load configuration
    private static final Properties config = new Properties();

    static {
        try (InputStream input = EmailUtil.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (input == null) {
                System.out.println("Sorry, unable to find config.properties");
            } else {
                config.load(input);
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    private static final String FROM = config.getProperty("email.from");
    private static final String PASSWORD = config.getProperty("email.password");

    /**
     * Sends an email (plain text or HTML based on isHtml flag)
     */
    public static void sendEmail(String to, String subject, String messageBody, boolean isHtml)
            throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM, "ClubSphere"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);

            // 📨 Handle both HTML and plain text
            if (isHtml) {
                message.setContent(messageBody, "text/html; charset=UTF-8");
            } else {
                message.setText(messageBody);
            }

            Transport.send(message);
            System.out.println("✅ Email sent successfully to: " + to);

        } catch (MessagingException e) {
            System.err.println("❌ Email send failed to: " + to + " — " + e.getMessage());
            throw e;
        } catch (Exception e) {
            System.err.println("⚠️ Unexpected error sending email to: " + to + " — " + e.getMessage());
        }
    }

    /**
     * Backward compatible version (plain text only)
     */
    public static void sendEmail(String to, String subject, String messageBody) throws MessagingException {
        sendEmail(to, subject, messageBody, false);
    }
}
