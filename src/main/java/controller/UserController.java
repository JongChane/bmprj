package controller;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

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

import dto.Admin;
import dto.BmService;
import dto.BoardService;
import dto.Game;
import dto.Gamer;
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
	@Autowired
	private BoardService boardService;
	
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
		boolean emailDuplicated = service.emailDuplicated(email);
		if(emailDuplicated) {
			return "duplicated";
		} else {
			return mss.joinEmail(email);
		}
	}
	@GetMapping("/idMailCheck")
	@ResponseBody
	public String idMailCheck(String email) throws UnsupportedEncodingException, MessagingException {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		return mss.idSearchEmail(email);
	}

	@GetMapping("/pwMailCheck")
	@ResponseBody
	public String pwMailCheck(String email, String user_id) throws UnsupportedEncodingException, MessagingException {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		boolean idEmailIsEmpty = service.idEmailIsEmpty(email, user_id);
		if(idEmailIsEmpty) {
			return mss.pwSearchEmail(email);
		} else {
			return "idEmailIsEmpty";
		}
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
		 	 System.out.println(dbUser);
		 	 session.setAttribute("login", dbUser.getUser_id());
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
	@PostMapping("delete")
	public String idCheckdelete(String user_pass, String user_id, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		Admin admin = (Admin) session.getAttribute("admin");

		if (admin != null) {
			try {
				service.userDelete(user_id);
			} catch (Exception e) {
				e.printStackTrace();
				throw new LoginException("탈퇴시 오류발생.", "delete?user_id=" + user_id);
			}
		} else {
			// 관리자가 아닌 경우에는 본인 확인 후 탈퇴 가능
			if (!passHash(user_pass).equals(loginUser.getUser_pass())) {
				throw new LoginException("비밀번호를 확인하세요.", "delete?user_id=" + user_id);
			}

			try {
				service.userDelete(user_id);
			} catch (Exception e) {
				e.printStackTrace();
				throw new LoginException("탈퇴시 오류발생.", "delete?user_id=" + user_id);
			}
			session.removeAttribute("loginUser");
		}
		return "redirect:login";
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
	@PostMapping("password") 
	public String loginCheckPasswordRtn
	     (String user_pass,String chgpass,HttpSession session) {
		User loginUser = (User)session.getAttribute("loginUser");
		if(!passHash(user_pass).equals(loginUser.getUser_pass())) {
		  throw new LoginException("비밀번호 오류 입니다.","password");
		}
		try {
			service.userChgpass(loginUser.getUser_id(),passHash(chgpass));
			loginUser.setUser_pass(chgpass); //로그인 정보에 비밀번호 수정
		} catch(Exception e) {
			  throw new LoginException
			  ("비밀번호 수정시 db 오류 입니다.","password");
		}
		return "redirect:mypage?user_id="+loginUser.getUser_id();
	}
	@PostMapping("idsearch")
	public ModelAndView idsearch(User user) {
		ModelAndView mav = new ModelAndView();
		User dbUser = service.idSearch(user.getUser_email());
		String result = null;
		String title = "아이디";
		result = dbUser.getUser_id();
		mav.addObject("result", result);
		mav.addObject("title", title);
		mav.setViewName("search");
		return mav;
	}

	@PostMapping("pwsearch")
	public ModelAndView pwsearch(User user) {
		ModelAndView mav = new ModelAndView();
		User dbUser = service.idSearch(user.getUser_email());
		String pass = null;
		String result = null;
		String title = "비밀번호";
		try {
			pass = util.makehash(dbUser.getUser_id(), "SHA-512");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		int index = (int)(Math.random()*(pass.length()-10));
		result = pass.substring(index, index + 6);
		service.userChgpass(dbUser.getUser_id(), passHash(result));
		mav.addObject("result",result);
		mav.addObject("title",title);
		mav.setViewName("search");
		return mav;
	}
	@RequestMapping("mpgameList")
	public ModelAndView gamelist(String user_id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		List<Game> glist = service.gList(user.getUser_id());
		
		List<Gamer> gmlist = service.gmList();
		List<User> gmuser = service.gmUser();
		
		mav.addObject("gmuser",gmuser);
		mav.addObject("glist",glist);
		mav.addObject("gmlist",gmlist);
		return mav;
	}
}
