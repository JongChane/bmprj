package controller;

import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import dto.Comment;
import dto.Reservation;
import dto.ReservationService;
import dto.User;
import dto.ViService;
import dto.Visit;
import exception.LoginException;

@Controller
@RequestMapping("admin")
public class AdminController {
	@Autowired
	ViService vis;
	@Autowired
	AdminService ads;
	@Autowired
	BmService service;
	@Autowired
	BoardService BoardService;
	@Autowired
	ReservationService rvs;

	@GetMapping("*")
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Admin());
		return mav;
	}

	@PostMapping("login")
	public ModelAndView login(@Valid Admin admin, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if (bresult.hasErrors()) {
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
		if (admin.getAdmin_pass().equals(dbAdmin.getAdmin_pass())) { // 정상 로그인
			session.setAttribute("admin", dbAdmin);
			session.setAttribute("adminId", dbAdmin.getAdmin_id());
			mav.setViewName("redirect:boardList");
		} else {
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
		mav.addObject("boardList", list);
		return mav;
	}
	
	@RequestMapping("boardLista")
	public ModelAndView adminboardLista(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<Board> list = BoardService.boardLista();
		mav.addObject("boardList", list);
		return mav;
	}
	
	@RequestMapping("boardListb")
	public ModelAndView adminboardListb(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<Board> list = BoardService.boardListb();
		mav.addObject("boardList", list);
		return mav;
	}
	
	
	@GetMapping("reply")
	public ModelAndView adminreplyGet(int board_num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println(board_num);
		Board board = BoardService.getBoard(board_num);
		mav.addObject("board", board);
		return mav;
	}

	@PostMapping("reply")
	public ModelAndView adminreplyPost(@Valid Board board, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println(board);
		if (bresult.hasErrors()) {
			Board dbboard = BoardService.getBoard(board.getBoard_num());
			Map<String, Object> map = bresult.getModel();
			Board b = (Board) map.get("board");
			b.setBoard_title(dbboard.getBoard_title());
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		try {
			BoardService.boardReply(board);
//			mav.setViewName("redirect:/boardList");
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("답변등록시 오류 발생", "reply?board_num=" + board.getBoard_num());
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

	@RequestMapping("visit")
	public ModelAndView adminvisit(Integer rv_num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<Visit> visitList = vis.visitList(rv_num);
		mav.addObject("visitList", visitList);
		return mav;

	}

	@PostMapping("visit")
	public ModelAndView adminscore(Integer rv_num, String[] vi_id, String[] vi_total, String[] vi_avg) {
		 System.out.println(rv_num+","+vi_id[0]+","+vi_total[0]+","+vi_avg[0]);
		 int[] total = new int[vi_total.length];
		 int[] avg = new int[vi_avg.length];
		 
		 for(int i = 0 ; i < vi_total.length ; i++) {
			 total[i] =Integer.parseInt(vi_total[i]); 
			}
		 for(int i = 0 ; i < vi_avg.length ; i++) {
			 avg[i] = Integer.parseInt(vi_avg[i]);
			} 
		 for(int i = 0 ; i < vi_id.length ; i++) {
			 vis.update(rv_num, vi_id[i], total[i], avg[i]);
			 service.avgUpdate(vi_id[i],avg[i]);
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

	@RequestMapping("reserveList")
	public ModelAndView adminReserveList(String sort, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<Reservation> reserveList = rvs.reserveList(); // 전체 회원목록
		if (sort != null) {
			Comparator<Reservation> comparator = null;

			switch (sort) {
			case "10":
				comparator = Comparator.comparingInt(Reservation::getRv_num);
				break;
			case "11":
				comparator = Comparator.comparingInt(Reservation::getRv_num).reversed();
				break;
			case "20":
				comparator = Comparator.comparing(Reservation::getUser_id);
				break;
			case "21":
				comparator = Comparator.comparing(Reservation::getUser_id).reversed();
				break;
			case "30":
				comparator = Comparator.comparing(Reservation::getRv_now);
				break;
			case "31":
				comparator = Comparator.comparing(Reservation::getRv_now).reversed();
				break;
			case "40":
				comparator = Comparator.comparing(Reservation::getRv_date);
				break;
			case "41":
				comparator = Comparator.comparing(Reservation::getRv_date).reversed();
				break;
			case "50":
				comparator = Comparator.comparing(Reservation::getRv_start);
				break;
			case "51":
				comparator = Comparator.comparing(Reservation::getRv_start).reversed();
				break;
			case "60":
				comparator = Comparator.comparing(Reservation::getRv_end);
				break;
			case "61":
				comparator = Comparator.comparing(Reservation::getRv_end).reversed();
				break;
			case "70":
				comparator = Comparator.comparing(Reservation::getLane_num);
				break;
			case "71":
				comparator = Comparator.comparing(Reservation::getLane_num).reversed();
				break;
			case "80":
				comparator = Comparator.comparing(Reservation::getRv_game);
				break;
			case "81":
				comparator = Comparator.comparing(Reservation::getRv_game).reversed();
				break;
			case "90":
				comparator = Comparator.comparing(Reservation::getRv_people);
				break;
			case "91":
				comparator = Comparator.comparing(Reservation::getRv_people).reversed();
				break;
			}

			if (comparator != null) {
				Collections.sort(reserveList, comparator);
			}
		}
		mav.addObject("reserveList", reserveList);
		return mav;
	}
	
	
	@RequestMapping("detail")
	public ModelAndView detailGet(Integer board_num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Board board = BoardService.getBoard(board_num);
		Comment comm = BoardService.getComment(board_num);
		BoardService.addReadcnt(board_num);
		if(board_num == null) {
			throw new LoginException("해당 게시글이 없습니다.", "/bmprj/board/list");
		}
		session.setAttribute("board_num", board_num);
		mav.addObject("comm",comm);
		mav.addObject("board",board);
		
		return mav;
	}
	
	@RequestMapping("comment")
	public ModelAndView comment(Comment comm, HttpServletRequest request) {
	ModelAndView mav = new ModelAndView();
	System.out.println(comm.getComm_content());
	int board_num = (int)request.getSession().getAttribute("board_num");
	String user = (String)request.getSession().getAttribute("adminId");
	comm.setBoard_num(board_num);
	comm.setAdmin_id(user);
	BoardService.commentinsert(comm);
	BoardService.boardUpdate(board_num);
	mav.setViewName("redirect:boardListb");
	return mav;
	}
}
