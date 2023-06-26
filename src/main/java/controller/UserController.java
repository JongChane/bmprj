package controller;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.BmService;
import dto.MailSendService;
import dto.User;
import exception.LoginException;
import util.CipherUtil;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired
	private BmService service;
	@Autowired
	private MailSendService mss;
	@Autowired
	private CipherUtil util;
	@Autowired
	private JavaMailSenderImpl mailSender;

	// ===================== 비밀번호 암호화 메서드 시작
	private String passHash(String pass) {
		try {
			return util.makehash(pass, "SHA-512");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}

	// ===================== 비밀번호 암호화 메서드 끝
	@GetMapping("*")
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}

	@PostMapping("join")
	public ModelAndView userAdd(@Valid User user, BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		if (bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.user");
			bresult.reject("error.input.check");
			return mav;
		}
		try {
			user.setUser_pass(passHash(user.getUser_pass()));
			service.userInsert(user);
			mav.addObject("user", user);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			bresult.reject("error.duplicate.user"); // 중복된 아이디 오류
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		mav.setViewName("redirect:login");
		return mav;
	}

	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) throws UnsupportedEncodingException, MessagingException {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		return mss.joinEmail(email);
	}
	@PostMapping("login")
	public ModelAndView login
	(@Valid User user, BindingResult bresult,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.login.input");
			return mav;
		}
		User dbUser;
		try {
			dbUser = service.selectUser(user.getUser_id());
		} catch(EmptyResultDataAccessException e) {//조회된 데이터가 없는 경우 발생 예외
			e.printStackTrace();
			bresult.reject("error.login.id"); //아이디를 확인하세요 
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		user.setUser_pass(passHash(user.getUser_pass()));
		if(user.getUser_pass().equals(dbUser.getUser_pass())) { //정상 로그인
		 	 session.setAttribute("loginUser", dbUser);
			 mav.setViewName("redirect:mypage?user_id="+user.getUser_id());
		}else {  
			bresult.reject("error.login.password");
			mav.getModel().putAll(bresult.getModel());
		}		
		return mav;
	}
	@RequestMapping("mypage")
	public ModelAndView idCheckMypage(String user_id,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.selectUser(user_id);
		mav.addObject("user", user);
		return mav;
	}

	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:login";
	}
	@GetMapping({"update","delete"})
	public ModelAndView idCheckUser(String user_id,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.selectUser(user_id);
		mav.addObject("user",user);
		return mav;
	}
	@PostMapping("update")
	public ModelAndView idCheckUpdate(@Valid User user,BindingResult bresult,
			String user_id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.update.user");
			return mav;
		}
		User loginUser = (User)session.getAttribute("loginUser");
		if(!loginUser.getUser_pass().equals(this.passHash(user.getUser_pass()))) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.login.password");
			return mav;
		}
		try {
			user.setUser_pass(passHash(user.getUser_pass()));
			service.userUpdate(user);
			if(loginUser.getUser_id().equals(user.getUser_id())) 			   
			   session.setAttribute("loginUser", user);
			mav.setViewName("redirect:mypage?user_id="+user.getUser_id());
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException
			("회원정보 수정 실패","update?user_id="+user.getUser_id());
		}
		return mav;
	}
}
