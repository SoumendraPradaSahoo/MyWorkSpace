package com;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class SampleMail {

	public static void main(String[] args) {

		final String username = "XXXXX@gmail.com";
		final String password = "XXXXXX";
		final String to = "XXXXXXX.co.in";
		final String smtpServer = "smtp.gmail.com";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", smtpServer);
		props.put("mail.smtp.ssl.trust", smtpServer);
//		props.put("mail.smtp.host", "smtp.mail.yahoo.com");
//		props.put("mail.smtp.ssl.trust", "smtp.mail.yahoo.com");
		props.put("mail.smtp.port", "587");
//		props.put("mail.smtp.port", "465");
//		props.put("mail.smtp.socketFactory.fallback", "false");
//		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

		Session session = Session.getInstance(props,
				new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {
			Message message = new MimeMessage(session);
			System.out.println("Session Created");
			message.setFrom(new InternetAddress(username));
//			message.setRecipients(Message.RecipientType.TO,
//					InternetAddress.parse("email@mail.com"));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setSubject("Testing Subject");
//			message.setText("Dear Mr XXX," + "\n\n This is a test e-mail, please ignore!");
//			message.setFileName("\\Desktop\\sample.pdf");
			
			BodyPart messageBodyPart = new MimeBodyPart();
			messageBodyPart.setText("Dear Mr XXXX," + "\n\n This is a test e-mail, please ignore!");
			
			Multipart multiPartMesssage = new MimeMultipart();
			multiPartMesssage.addBodyPart(messageBodyPart);
			
			messageBodyPart = new MimeBodyPart();
			DataSource source = new FileDataSource("\\Desktop\\sample.pdf");	
			messageBodyPart.setDataHandler(new DataHandler(source));
			messageBodyPart.setFileName("sample File.PDF");
			multiPartMesssage.addBodyPart(messageBodyPart);
			
			message.setContent(multiPartMesssage);
			
			
			System.out.println("Message composed");
			//Transport transport = session.getTransport("smtp");
			Transport.send(message);
			//EmailUtil.sendEmail(session, "email@mail.com","TLSEmail Testing Subject", "TLSEmail Testing Body");

			System.out.println("Message sent");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
}
