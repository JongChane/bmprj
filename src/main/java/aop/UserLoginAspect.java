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
public class UserLoginAspect {
@Around
("execution(* controller.User*.idCheck*(..)) && args(..,userid,session)")
	public Object userIdCheck(ProceedingJoinPoint joinPoint,String userid,
			HttpSession session) throws Throwable {
	   User loginUser = (User)session.getAttribute("loginUser");	
	   if(loginUser == null) {
		   throw new LoginException("[idCheck]로그인이 필요합니다.","login");
	   }
	   return joinPoint.proceed();	
	}
	//UserController.loginCheck*(..,HttpSession) => pointcut
	@Around
("execution(* controller.User*.loginCheck*(..)) && args(..,session)")
	public Object loginCheck(ProceedingJoinPoint joinPoint,
			HttpSession session) throws Throwable {
	   User loginUser = (User)session.getAttribute("loginUser");	
	   if(loginUser == null) {
		   throw new LoginException("[loginCheck]로그인이 필요합니다.","login");
	   }
	   return joinPoint.proceed();	
	}
	
	@Around
	("execution(* controller.Reservation*.reservation*(..)) && args(..,session)")
	public Object rvloginCheck(ProceedingJoinPoint joinPoint,
			HttpSession session) throws Throwable {
	   User loginUser = (User)session.getAttribute("loginUser");	
	   if(loginUser == null) {
		   throw new LoginException("[loginCheck]로그인이 필요합니다.","login");
	   }
	   return joinPoint.proceed();	
	}
}
