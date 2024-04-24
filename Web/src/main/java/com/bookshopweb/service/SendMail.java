package com.bookshopweb.service;


<<<<<<< HEAD
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

=======
>>>>>>> 434da7c2c2a2d07a69e97966e0b6f3d8f933c26d
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {
    static final String from = "fitstore567@gmail.com";
    static final String password = "cgkf kchb iaxe egwh";
//	static final String from = "timkodctk4@gmail.com";
//	static final String password = "lbsn hmhr eixz rdmi";
<<<<<<< HEAD
    static Session session;
private JavaMailSender mailSender;
=======
>>>>>>> 434da7c2c2a2d07a69e97966e0b6f3d8f933c26d

    public static boolean sendEmail(String to, String verification, String userName) {
        String title = "Xác nhận tài khoản bookstore";
        String content = "Mã xác nhận của tài khoản " + userName + " là: <strong>" + verification +
            "</strong> mã có hiệu lực trong 5 phút, hết hạn lúc: " + new Timestamp(Calendar.getInstance().getTimeInMillis() + 300000).toString();
        // Properties : khai báo các thuộc tính
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
        props.put("mail.smtp.port", "587"); // TLS 587 SSL 465
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // create Authenticator
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                // TODO Auto-generated method stub
                return new PasswordAuthentication(from, password);
            }
        };

        // Phiên làm việc
<<<<<<< HEAD
        if(session == null){
            session = Session.getInstance(props, auth);
        }
=======
        Session session = Session.getInstance(props, auth);
>>>>>>> 434da7c2c2a2d07a69e97966e0b6f3d8f933c26d

        // Tạo một tin nhắn
        MimeMessage msg = new MimeMessage(session);

        try {
            // Kiểu nội dung
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");

            // Người gửi
            msg.setFrom(from);

            // Người nhận
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));

            // Tiêu đề email
            msg.setSubject(title);

            // Quy đinh ngày gửi
            msg.setSentDate(new Date(Calendar.getInstance().getTimeInMillis()));

            // Quy định email nhận phản hồi
            // msg.setReplyTo(InternetAddress.parse(from, false))

            // Nội dung
            msg.setContent(content, "text/HTML; charset=UTF-8");

            // Gửi email
            Transport.send(msg);
            System.out.println("Gửi email thành công");
            return true;
        } catch (Exception e) {
            System.out.println("Gặp lỗi trong quá trình gửi email");
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        System.out.println(sendEmail("21130356@st.hcmuaf.edu.vn", "210903","HiuNe"));
//        System.out.println(new Timestamp(Calendar.getInstance().getTimeInMillis() + 300000).toString());
    }
}
