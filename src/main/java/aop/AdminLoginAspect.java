package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.LoginException;
import dto.Admin;
import dto.User;

@Component
@Aspect
public class AdminLoginAspect {
	@Around("execution(* controller.AdminController.admin*(..)) && args(..,session)")
	public Object adminCheck(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable {
	    Admin admin = (Admin) session.getAttribute("admin");
		User loginUser = (User) session.getAttribute("loginUser");
	    if (admin == null) {
	        throw new LoginException("관리자로 로그인 하세요", "../admin/login");
	    } else if (!admin.getAdmin_id().equals("admin")) {
			throw new LoginException
			("관리자 페이지입니다.","../user/mypage?userid="+loginUser.getUser_id());
		}
	    return joinPoint.proceed();
	}
	
	
}
