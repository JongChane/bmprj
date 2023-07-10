package controller;

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
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dto.Admin;
import dto.AdminService;
import dto.BmService;
import dto.Board;
import dto.BoardService;
import dto.Comment;
import dto.Notice;
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
	public ModelAndView adminboardList(String type, Integer pageNum, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println(pageNum);
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		
		int limit = 10; //한페이지에 보여줄 게시물 건수
		int listCount = BoardService.boardCount();
		
		List<Board> list = BoardService.boardList(pageNum,limit);
		
		int maxpage = (int)((double)listCount/limit + 0.95);
		int startpage = (int)((pageNum/10.0 + 0.9) -1) * 10 + 1;
		int endpage = startpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int boardno = listCount - (pageNum - 1) * limit;
		
		mav.addObject("boardno",boardno);
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("listCount",listCount);
		mav.addObject("boardList", list);
		mav.addObject("type", type);
		
		return mav;
	}
	
	@RequestMapping("boardLista")
	public ModelAndView adminboardLista(String type, Integer pageNum, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		
		int limit = 10; //한페이지에 보여줄 게시물 건수
		int listCount = BoardService.boardCounta();
		
		List<Board> list = BoardService.boardLista(pageNum,limit);
		
		int maxpage = (int)((double)listCount/limit + 0.95);
		int startpage = (int)((pageNum/10.0 + 0.9) -1) * 10 + 1;
		int endpage = startpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int boardno = listCount - (pageNum - 1) * limit;
		
		mav.addObject("boardno",boardno);
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("listCount",listCount);
		mav.addObject("boardList", list);
		mav.addObject("type", type);
		
		return mav;
	}
	
	@RequestMapping("boardListb")
	public ModelAndView adminboardListb(String type , Integer pageNum,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		
		int limit = 10; //한페이지에 보여줄 게시물 건수
		int listCount = BoardService.boardCountb();
		
		List<Board> list = BoardService.boardListb(pageNum,limit);
		
		int maxpage = (int)((double)listCount/limit + 0.95);
		int startpage = (int)((pageNum/10.0 + 0.9) -1) * 10 + 1;
		int endpage = startpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int boardno = listCount - (pageNum - 1) * limit;
		
		mav.addObject("boardno",boardno);
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("listCount",listCount);
		mav.addObject("boardList", list);
		mav.addObject("type", type);
		
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
		ModelAndView mav = new ModelAndView();
		 int[] total = new int[vi_total.length];
		 int[] avg = new int[vi_avg.length];
		 
		 for(int i = 0 ; i < vi_total.length ; i++) {
			 total[i] =Integer.parseInt(vi_total[i]); 
			}
		 for(int i = 0 ; i < vi_avg.length ; i++) {
			 avg[i] = Integer.parseInt(vi_avg[i]);
			}

		 for(int i = 0 ; i < vi_id.length ; i++) {
				int dbAvg = vis.getAvg(rv_num, vi_id[i]);
				if (dbAvg != 0) {
					throw new LoginException("이미 점수등록을 완료한 게임입니다.", "reserveList");
				}
			 vis.update(rv_num, vi_id[i], total[i], avg[i]);
			 service.avgUpdate(vi_id[i],avg[i]);
			}
			mav.setViewName("redirect:reserveList");
			return mav;
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
	
	
	@GetMapping("write")
	public ModelAndView writeGet(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Notice());
		return mav;
	}
	
	@GetMapping("noticeUpdate")
	public ModelAndView noticeUpdate(Integer notice_num,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Notice notice = ads.getNotice(notice_num);
		
		if(notice == null) {
			throw new LoginException("해당 공지사항은 존재하지 않습니다.", "noticeList");
		}
		
		mav.addObject("notice", notice);
		return mav;
	}
	
	
	@PostMapping("noticeDelete")
	public ModelAndView noticeDelete(Integer notice_num,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(ads.deleteNotice(notice_num)) {
			mav.setViewName("redirect:noticeList");
			return mav;
		}else {
			throw new LoginException("공지사항 삭제 실패", "noticeList");
		}
	}
	
	@PostMapping("noticeUpdate")
	public ModelAndView noticeUpdate(@Valid Notice notice,BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String admin_id = (String)session.getAttribute("adminId");
		
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		
		notice.setAdmin_id(admin_id);
		ads.update(notice);
		mav.setViewName("redirect:noticeList");
		return mav;
	}
	
	@PostMapping("write")
	public ModelAndView write(@Valid Notice notice,BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String admin_id = (String)session.getAttribute("adminId");
		System.out.println(admin_id);
		
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		
		notice.setAdmin_id(admin_id);
		ads.insert(notice);
		mav.setViewName("redirect:noticeList");
		return mav;
	}
	
	@RequestMapping("imgupload")
	public String imgupload(MultipartFile upload, String CKEditorFuncNum, HttpServletRequest request, Model model) {
		//request.getServletContext().getRealPath("/") : 절대 경로 값
		String path = request.getServletContext().getRealPath("/") + "board/imgfile/";
		BoardService.uploadFileCreate(upload,path); //upload(파일의내용), path(업로드되는 폴더)
		String fileName = request.getContextPath() + "/board/imgfile/" + upload.getOriginalFilename();
		model.addAttribute("fileName",fileName);
		return "ckedit";//view 이름 /WEB-INF/view/ckedit.jsp
	}	
	
	@RequestMapping("noticeList")
	public ModelAndView noticeList(Integer pageNum,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		
		String admin_id = (String)session.getAttribute("adminId");
		if(admin_id == null) {
			throw new LoginException("로그인을 하셔야합니다.", "login");
		}
		
		int limit = 10;
		int listCount = ads.listCount();
		System.out.println("listCount :" + listCount);
		List<Notice> noticeList = ads.noticeList(admin_id,pageNum,limit);
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
		
		System.out.println(noticeList);
		
		mav.addObject("boardno",boardno);
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("listCount",listCount);
		mav.addObject("noticeList",noticeList);
		return mav;
	}
	
}
