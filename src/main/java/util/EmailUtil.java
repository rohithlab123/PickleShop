package util;

import java.util.Properties;

// RECHECK THESE: Make sure absolutely no 'jakarta' lines remain here
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class EmailUtil {
    // Keep your complete sendEmail methods and setup exactly the same below this!

    public static void sendOTP(String toEmail, String otp) {

        // 🔥 CHANGE THIS
        final String fromEmail = "rohithrohith61564@gmail.com";

        // 🔥 IMPORTANT: Gmail App Password (NOT normal password)
        final String password = "gfgq lgce akzq jbnq";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
            new jakarta.mail.Authenticator() {
                protected jakarta.mail.PasswordAuthentication getPasswordAuthentication() {
                    return new jakarta.mail.PasswordAuthentication(fromEmail, password);
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

            Transport.send(message);

            System.out.println("✅ OTP EMAIL SENT SUCCESSFULLY");

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ EMAIL SENDING FAILED: " + e.getMessage());
        }
    }
}
