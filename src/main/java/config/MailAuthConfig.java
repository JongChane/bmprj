package config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailAuthConfig {
	@Bean(name = "mailSender")
	public JavaMailSender getJavaMailSender() {
		Properties properties = new Properties();
		properties.setProperty("mail.transport.protocol", "smtp"); // 프로토콜 설정
		properties.setProperty("mail.smtp.auth", "true"); // smtp 인증
		properties.setProperty("mail.smtp.starttls.enable", "true"); // smtp strattles 사용
		properties.setProperty("mail.debug", "true"); // 디버그 사용
		properties.setProperty("mail.smtp.ssl.trust", "smtp.naver.com"); // ssl 인증 서버 (smtp 서버명)
		properties.setProperty("mail.smtp.ssl.enable", "true"); // ssl 사용
		properties.put("mail.smtp.ssl.protocols", "TLSv1.2");

		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost("smtp.naver.com");
		mailSender.setPort(465);
		mailSender.setUsername("mik3533@naver.com");
		mailSender.setPassword("qhfaovm1234!");
		mailSender.setDefaultEncoding("utf-8");
		mailSender.setJavaMailProperties(properties);

		return mailSender;

	}

	@Bean
	public JavaMailSenderImpl javaMailSender() {
		return (JavaMailSenderImpl) getJavaMailSender();
	}
}
