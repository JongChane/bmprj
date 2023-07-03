package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import dto.User;
import exception.LoginException;
@Component
@Aspect
public class GameLoginAspect {
	@Around
	("execution(* controller.Game*.write*(..)) && args(..,session)")
		public Object userIdCheck(ProceedingJoinPoint joinPoint,
				HttpSession session) throws Throwable {
		   User loginUser = (User)session.getAttribute("loginUser");	
		   if(loginUser == null) {
			   throw new LoginException("로그인이 필요합니다.","../user/login");
		   }
		   return joinPoint.proceed();	
		}
	}
