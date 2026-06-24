package util;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class EmailUtil {

    public static void sendOTP(String toEmail, String otp) {

        final String fromEmail = "rohithrohith61564@gmail.com";
        final String password = "gfgq lgce akzq jbnq";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // FIXED: Switched from inline jakarta references to standard javax Authenticator
        Session session = Session.getInstance(props,
            new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            }
        );

        try {
            MimeMessage message = new MimeMessage(session);

            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));

            message.setSubject("Ammamma's Kitchen - OTP Verification");

            message.setText(
                "Your OTP is: " + otp + "\n\n" +
                "This OTP is valid for 5 minutes.\n\n" +
                "Do not share it with anyone."
            );

         // 👇 ADD THESE TWO LINES RIGHT HERE TO FIX THE CLASSCAST ERROR 👇
            ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
            Thread.currentThread().setContextClassLoader(javax.mail.Message.class.getClassLoader());

            Transport.send(message);

            // 👇 ADD THIS LINE RIGHT AFTER TO RESTORE THE ENVIRONMENT 👇
            Thread.currentThread().setContextClassLoader(classLoader);

            System.out.println("✅ OTP EMAIL SENT SUCCESSFULLY");

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ EMAIL SENDING FAILED: " + e.getMessage());
        }
    }
}
