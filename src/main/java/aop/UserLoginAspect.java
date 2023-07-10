package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import dto.Admin;
import dto.User;
import exception.LoginException;

@Component
@Aspect
public class UserLoginAspect {
@Around
("execution(* controller.User*.idCheck*(..)) && args(..,userid,session)")
	public Object userIdCheck(ProceedingJoinPoint joinPoint,String userid,
			HttpSession session) throws Throwable {
		User loginUser = (User) session.getAttribute("loginUser");
		Admin admin = (Admin) session.getAttribute("admin");
		if (loginUser == null && admin == null) {
			throw new LoginException("로그인이 필요합니다.", "login");
		}
		if (admin != null) { // 관리자(admin)인 경우
			return joinPoint.proceed(); // 모든 정보를 확인할 수 있도록 진행
		}
		if (!loginUser.getUser_id().equals(userid)) {
			throw new LoginException("본인의 정보만 확인할 수 있습니다.", "../user/mypage?user_id=" + loginUser.getUser_id());
		}
		return joinPoint.proceed();
	}

	//UserController.loginCheck*(..,HttpSession) => pointcut
	@Around
("execution(* controller.User*.loginCheck*(..)) && args(..,session)")
	public Object loginCheck(ProceedingJoinPoint joinPoint,
			HttpSession session) throws Throwable {
	   User loginUser = (User)session.getAttribute("loginUser");	
			Admin admin = (Admin) session.getAttribute("admin");
			if (loginUser == null && admin == null) {
		   throw new LoginException("[loginCheck]로그인이 필요합니다.","login");
			}
			if (admin != null) { // 관리자(admin)인 경우
				return joinPoint.proceed(); // 모든 정보를 확인할 수 있도록 진행
			}
	   return joinPoint.proceed();	
	}

}
