package drivetecTestCases;

import jakarta.activation.DataHandler;

// import javax.mail.*;
// import javax.mail.internet.*;
// import java.util.Properties;
// import java.io.File;
// import javax.activation.DataHandler;
// import javax.activation.DataSource;
// import javax.activation.FileDataSource;

// public class EmailSender {

//     public static void sendEmailWithReport(String reportPath) {
//         // Set up the SMTP server properties
//         Properties properties = new Properties();
//         properties.put("mail.smtp.auth", "true");
//         properties.put("mail.smtp.starttls.enable", "true");
//         properties.put("mail.smtp.host", "smtp.gmail.com"); // Example for Gmail
//         properties.put("mail.smtp.port", "587");

//         // Authenticate using your email credentials
//         final String username = "malagamjagdesh@gmail.com";
//         final String password = "iups vrge jwpx qbfq";

//         Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
//             protected PasswordAuthentication getPasswordAuthentication() {
//                 return new PasswordAuthentication(username, password);
//             }
//         });

//         try {
//             // Create a new email message
//             Message message = new MimeMessage(session);
//             message.setFrom(new InternetAddress("malagamjagdesh@gmail.com"));
//             message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("jaganprabha1991@gmail.com"));
//             message.setSubject("Karate Test Report");

//             // Create the message body
//             MimeBodyPart messageBodyPart = new MimeBodyPart();
//             messageBodyPart.setText("Please find the attached Cucumber report for the recent Karate test execution.");

//             // Attach the report file
//             MimeBodyPart attachmentPart = new MimeBodyPart();
//             DataSource source = new FileDataSource(new File(reportPath));
//             attachmentPart.setDataHandler(new DataHandler(source));
//             attachmentPart.setFileName("KarateReport.html"); // Name of the attached file

//             // Combine message body and attachment
//             Multipart multipart = new MimeMultipart();
//             multipart.addBodyPart(messageBodyPart);
//             multipart.addBodyPart(attachmentPart);

//             // Set the complete message parts
//             message.setContent(multipart);

//             // Send the email
//             Transport.send(message);

//             System.out.println("Email sent successfully with the report.");

//         } catch (MessagingException e) {
//             e.printStackTrace();
//         }
//     }
// }

import jakarta.activation.DataSource;
import jakarta.activation.FileDataSource;
import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.util.Properties;

public class EmailSender {
    public static void sendEmailWithAttachment(String to) {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.example.com"); // Replace with your SMTP host
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("malagamjagdesh@fmail.com", "iups vrge jwpx qbfq"); // Use your credentials
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("malagamjagdesh@fmail.com"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);

            // Create the message body part
            MimeBodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setText(body);

            // Create a multipart message
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messageBodyPart);

            // Add the attachment
            MimeBodyPart attachmentBodyPart = new MimeBodyPart();
            DataSource source = new FileDataSource(filePath);
            attachmentBodyPart.setDataHandler(new DataHandler(source));
            attachmentBodyPart.setFileName("Report.pdf"); // Specify the filename
            multipart.addBodyPart(attachmentBodyPart);

            // Set the complete message parts
            message.setContent(multipart);

            // Send the message
            Transport.send(message);
            System.out.println("Email sent successfully with attachment!");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}


