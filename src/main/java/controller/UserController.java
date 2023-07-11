
package controller;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
import dto.Board;
import dto.BoardService;
import dto.Game;
import dto.Gamer;
import dto.MailSendService;
import dto.Reservation;
import dto.ReservationService;
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
	@Autowired
	private ReservationService rvs;
	
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
	public ModelAndView idCheckPasswordRtn
	(String user_pass, String chgpass, String user_id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
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
		mav.setViewName("mypage?user_id="+loginUser.getUser_id());
		return mav;
	}
	@PostMapping("idsearch")
	public ModelAndView idsearch(User user) {
		ModelAndView mav = new ModelAndView();
		User dbUser = service.idSearch(user.getUser_email());
		String result = null;
		String title = "아이디";
		try {
		result = dbUser.getUser_id();
		} catch(Exception e) {
			  throw new LoginException
			  ("회원 정보가 존재하지 않습니다.","idsearch");
		}
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
	public ModelAndView loginCheckgamelist(String user_id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<Game> glist = service.gList(user_id);
		Map<Game, List<User>> map = new LinkedHashMap<>();
		for(Game g : glist) {
			List<Gamer> gamerList = service.getGmList(g.getGame_num());
			List<User> userList = new ArrayList<>();
			for(Gamer gm : gamerList) {
				User user = service.getUser(gm.getUser_id());
				userList.add(user);
			}
			map.put(g, userList);
		}
		
		
		mav.addObject("glist",glist);
		mav.addObject("gmuser",map);
		return mav;
	}
	@RequestMapping("mpdelete")
	public ModelAndView loginCheckmpdelete(Integer gmnum,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");
		Game game = service.getGame(gmnum);
		if(game == null) {
			throw new LoginException("없는 게임 번호입니다.","mpgameList?user_id="+loginUser.getUser_id());
		}
		if(!loginUser.getUser_id().equals(game.getUser_id())) {
			throw new LoginException("본인만 삭제 가능합니다.","mpgameList?user_id="+loginUser.getUser_id());
		}
		service.gamedelete(gmnum);
		service.gamerdelete(gmnum);
		mav.addObject("gmnum",gmnum);
		throw new LoginException("내 게시글이 삭제되었습니다","mpgameList?user_id="+loginUser.getUser_id());
	}
	@RequestMapping("mpudelete") 
	public ModelAndView idCheckmpudelete(Integer gmnum, String user_id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Game game = service.getGame(gmnum);
		if(game == null) {
			throw new LoginException("없는 게임 번호입니다.","mpgameList?user_id="+user_id);
		}
		if(service.mygamedelete(gmnum,user_id)) {
			//gamelist에서 game_people 수 하나 빼기 -1
			if(service.gamepeople(gmnum))
			throw new LoginException("매치 나가기에 성공했습니다.","mpgameList?user_id="+user_id);
		} 
		else throw new LoginException("매치 나가기에 실패했습니다.","mpgameList?user_id="+user_id);		
		return mav;
	}
	@RequestMapping("boardList")
	public ModelAndView idCheckboardList(Integer pageNum, Integer board_anser, String user_id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		
		String user = (String)session.getAttribute("login");
		int limit = 10; //한페이지에 보여줄 게시물 건수
		int listCount = boardService.UserboardCount(user,board_anser);
		
		// listCount 출력
		System.out.println("listCount : " + listCount);
		
		List<Board> board = boardService.getUserBoard(user,pageNum,limit,board_anser);
		int maxpage = (int)((double)listCount/limit + 0.95);
		// 맥스 출력
		System.out.println("maxpage : " + maxpage);
		int startpage = (int)((pageNum/10.0 + 0.9) -1) * 10 + 1;
		// 스타트 
		System.out.println("startpage : " + startpage);
		int endpage = startpage + 9;
		System.out.println("endpage : " + endpage);
		// 둥앤드
		if(endpage > maxpage) endpage = maxpage;
		int boardno = listCount - (pageNum - 1) * limit;
		
		
		
		mav.addObject("boardno",boardno);
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("listCount",listCount);
		mav.addObject("board",board);
		mav.addObject("user_id", user);
		mav.addObject("board_anser",board_anser);
		return mav;
	}
	
	@RequestMapping("reserveList")
	public ModelAndView idCheckreserveList(Integer pageNum, String user_id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}

		String userid = (String) session.getAttribute("login");
		int limit = 10; // 한페이지에 보여줄 게시물 건수
		int reserveCount = rvs.UserReserveCount(userid);
		List<Reservation> reserve = rvs.getUserReserve(userid, pageNum, limit);
		System.out.println("예약내역 : " + reserve);
		int maxpage = (int) ((double) reserveCount / limit + 0.95);
		int startpage = (int) ((pageNum / 10.0 + 0.9) - 1) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage)
			endpage = maxpage;
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listCount", reserveCount);
		mav.addObject("reserve", reserve);
		return mav;

	}
	
}
