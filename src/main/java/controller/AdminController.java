package controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.Admin;
import dto.AdminService;
import dto.BmService;
import dto.Board;
import dto.BoardService;
import dto.User;
import dto.ViService;
import exception.LoginException;
@Controller
@RequestMapping("admin")
public class AdminController {
	@Autowired
	private ViService vis;
	@Autowired
	private AdminService ads;
	@Autowired
	private BmService service;
	@Autowired
	BoardService BoardService;
	
	@GetMapping("*")
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Admin());
		return mav;
	}
	
	@PostMapping("login")
	public ModelAndView login
	(@Valid Admin admin, BindingResult bresult,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.login.input");
			return mav;
		}
		Admin dbAdmin;
		try {
		    dbAdmin = ads.selectAdmin(admin.getAdmin_id());
		    if (dbAdmin == null) {
		        bresult.reject("error.admin.id");
		        mav.getModel().putAll(bresult.getModel());
		        return mav;
		    }
		} catch (EmptyResultDataAccessException e) {
		    e.printStackTrace();
		    mav.getModel().putAll(bresult.getModel());
		    return mav;
		}
		if(admin.getAdmin_pass().equals(dbAdmin.getAdmin_pass())) { //정상 로그인
		 	 session.setAttribute("admin", dbAdmin);
		 	 session.setAttribute("adminId", dbAdmin.getAdmin_id());
			 mav.setViewName("redirect:boardList");
		}else {  
			bresult.reject("error.login.password");
			mav.getModel().putAll(bresult.getModel());
		}		
		return mav;
	}
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:login";
	}
	@RequestMapping("boardList")
	public ModelAndView adminboardList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<Board> list = BoardService.boardList();
		mav.addObject("boardList",list);
		return mav;
	}
	
	@GetMapping("reply")
	public ModelAndView adminreplyGet(int board_num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println(board_num);
		Board board = BoardService.getBoard(board_num);
		mav.addObject("board",board);
		return mav;
	}
	
	@PostMapping("reply")
	public ModelAndView adminreplyPost(@Valid Board board, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println(board);
		if(bresult.hasErrors()) {
			Board dbboard = BoardService.getBoard(board.getBoard_num());
			Map<String,Object> map = bresult.getModel();
			Board b = (Board)map.get("board");
			b.setBoard_title(dbboard.getBoard_title());
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		try {
			BoardService.boardReply(board);
//			mav.setViewName("redirect:/boardList");
		} catch(Exception e) {
			e.printStackTrace();
			throw new LoginException("답변등록시 오류 발생","reply?board_num="+board.getBoard_num());
		}
		return mav;
	}

	@PostMapping("checkUser")
	@ResponseBody
	public String checkUser(String user_id) {
		System.out.println(user_id);
		boolean checkId = service.checkId(user_id);
		if (checkId) {
			return "true";
		} else {
			return "false";
		}
	}

	@PostMapping("visit")
	public ModelAndView adminscore(String[] vi_id, String[] vi_total, String[] vi_avg, String[] vi_game, HttpSession session) {
		int[] total = new int[vi_total.length];
		int[] avg = new int[vi_avg.length];
		int[] game = new int[vi_game.length];
		
		for(int i = 0 ; i < vi_total.length ; i++) {
			total[i] = Integer.parseInt(vi_total[i]);
		}
		for(int i = 0 ; i < vi_avg.length ; i++) {
			avg[i] = Integer.parseInt(vi_avg[i]);
		}
		for(int i = 0 ; i < vi_game.length ; i++) {
			game[i] = Integer.parseInt(vi_game[i]);
		}
		
		for(int i = 0 ; i < vi_id.length ; i++) {
			vis.insert(vi_id[i], total[i], avg[i], game[i]);
		}
		

		return null;
	}

	@RequestMapping("list")
	public ModelAndView adminlist(String sort, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		// list : db에 등록된 모든 회원정보 저장 목록
		List<User> list = service.userlist(); // 전체 회원목록
		if (sort != null) {
			switch (sort) {
			case "10":
				Collections.sort(list, new Comparator<User>() {
					@Override
					public int compare(User u1, User u2) {
						return u1.getUser_id().compareTo(u2.getUser_id());
					}
				});
				break;
			case "11":
				Collections.sort(list, (u1, u2) -> u2.getUser_id().compareTo(u1.getUser_id()));
				break;
			case "20":
				Collections.sort(list, (u1, u2) -> u1.getUser_name().compareTo(u2.getUser_name()));
				break;
			case "21":
				Collections.sort(list, (u1, u2) -> u2.getUser_name().compareTo(u1.getUser_name()));
				break;
			case "30":
				Collections.sort(list, (u1, u2) -> u2.getUser_tel().compareTo(u1.getUser_tel()));
				break;
			case "31":
				Collections.sort(list, (u1, u2) -> u1.getUser_tel().compareTo(u2.getUser_tel()));
				break;
			case "40":
				Collections.sort(list, (u1, u2) -> Integer.compare(u2.getUser_age(), u1.getUser_age()));
				break;
			case "41":
				Collections.sort(list, (u1, u2) -> Integer.compare(u1.getUser_age(), u2.getUser_age()));
				break;
			case "50":
				Collections.sort(list, (u1, u2) -> u1.getUser_email().compareTo(u2.getUser_email()));
				break;
			case "51":
				Collections.sort(list, (u1, u2) -> u2.getUser_email().compareTo(u1.getUser_email()));
				break;
			}
		}
		mav.addObject("list", list);
		return mav;
	}
}
