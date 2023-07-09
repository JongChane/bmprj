package controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dto.AdminService;
import dto.Board;
import dto.BoardService;
import dto.Comment;
import dto.Notice;
import exception.LoginException;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired
	private BoardService service;
	@Autowired
	private AdminService ads;
	@GetMapping("write")
	public ModelAndView writeget(HttpServletRequest request) {
	    ModelAndView mav = new ModelAndView();
	    String login = (String) request.getSession().getAttribute("login");
	    if (login == null) {
	    	throw new LoginException("로그인을 하셔야합니다","/bmprj/user/login");
	    }
	    mav.addObject(new Board());
	    return mav;
	}

	@PostMapping("write")
	public ModelAndView wrtiePost(@Valid Board board, BindingResult bresult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		
		String user_id = (String)request.getSession().getAttribute("login");
		String board_id = (String)request.getSession().getAttribute("boardid");
		
		if(board_id == null) board_id = "1";
		request.getSession().setAttribute("board_id", board_id);
		board.setBoard_id(board_id);
		board.setUser_id(user_id);
		service.write(board);
		mav.setViewName("redirect:list?board_id="+board_id);
		return mav;
	}
	
	@RequestMapping("imgupload")
	public String imgupload(MultipartFile upload, String CKEditorFuncNum, HttpServletRequest request, Model model) {
		//request.getServletContext().getRealPath("/") : 절대 경로 값
		String path = request.getServletContext().getRealPath("/") + "board/imgfile/";
		service.uploadFileCreate(upload,path); //upload(파일의내용), path(업로드되는 폴더)
		String fileName = request.getContextPath() + "/board/imgfile/" + upload.getOriginalFilename();
		model.addAttribute("fileName",fileName);
		return "ckedit";//view 이름 /WEB-INF/view/ckedit.jsp
	}
	
	@RequestMapping("list")
	public ModelAndView list(@RequestParam Map<String,String> param, HttpSession session) {
		Integer pageNum = null;
		if(param.get("pageNum") != null) pageNum = Integer.parseInt(param.get("pageNum"));
		String board_id = param.get("board_id");
		String searchtype = param.get("searchtype");
		String searchcontent = param.get("searchcontent");
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(board_id == null || board_id.equals("")) {
			board_id = "1";
		}
		session.setAttribute("board_id", board_id);
		if(searchtype==null || searchcontent == null || searchtype.trim().equals("") || searchcontent.trim().equals("")) {
			searchtype=null;
			searchcontent=null;
		}
		int limit = 10; //한페이지에 보여줄 게시물 건수
		int listCount = service.boardCount(board_id,searchtype,searchcontent);
		List<Board> boardlist = service.boardList(pageNum,limit,board_id,searchtype,searchcontent);
		int maxpage = (int)((double)listCount/limit + 0.95);
		int startpage = (int)((pageNum/10.0 + 0.9) -1) * 10 + 1;
		int endpage = startpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int boardno = listCount - (pageNum - 1) * limit;
		String today = new SimpleDateFormat("yyyyMMdd").format(new Date()); //오늘 날짜를 문자열로 저장
		mav.addObject("board_id",board_id);
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("listCount",listCount);
		mav.addObject("boardlist",boardlist);
		mav.addObject("boardno",boardno);
		mav.addObject("today",today);
		return mav;
	}
	
	@RequestMapping("detail")
	public ModelAndView detailGet(Integer board_num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Board board = service.getBoard(board_num);
		Comment comm = service.getComment(board_num);
		service.addReadcnt(board_num);
		if(board_num == null) {
			throw new LoginException("해당 게시글이 없습니다.", "/bmprj/board/list");
		}
		session.setAttribute("board_num", board_num);
		mav.addObject("comm",comm);
		mav.addObject("board",board);
		
		return mav;
	}
	
	
	@GetMapping("detailJson")
	@ResponseBody
	public Board detailJson(Integer board_num) {
		Board board = service.getBoard(board_num);
		service.addReadcnt(board_num);
		if(board_num == null) {
			throw new LoginException("해당 게시글이 없습니다.", "/bmprj/board/list");
		}
		return board;
	}
	
	
	
	@PostMapping("/delete")
	@ResponseBody
	public Map<String, Object> deleteBoard(@RequestParam("board_num") int board_num) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        // 게시글 삭제 로직 수행
	    	service.deleteComment(board_num);
	        service.deleteBoard(board_num);
	        response.put("success", true);
	    } catch (Exception e) {
	        response.put("success", false);
	    }
	    return response;
	}
	
	@GetMapping("update")
	public ModelAndView getBoard(Integer board_num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String login = (String)session.getAttribute("login");
		Board dbBoard = service.getBoard(board_num);
		if(login == null) {
			throw new LoginException("로그인을 하셔야합니다.","/bmprj/user/login");
		}
		if(board_num == null || dbBoard == null) {
			throw new LoginException("해당 게시글이 없습니다.", "/bmprj/board/list");
		}
		if(!dbBoard.getUser_id().equals(login)) {
			throw new LoginException("해당 작성자만 가능합니다.","/bmprj/board/list");
		}
		
		Board board = service.getBoard(board_num);
		mav.addObject(board);
		return mav;
	}
	
	@PostMapping("update")
	public ModelAndView updatePost(@Valid Board board, BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		Board dbBoard = service.getBoard(board.getBoard_num());
			if(service.update(board)) {
				throw new LoginException("게시글 수정 완료되었습니다.", "/bmprj/board/list");
			}	
			else {
				throw new LoginException("게시글 수정에 실패 했습니다.", "update?board_num="+board.getBoard_num());
			}
	}
	
	
	@RequestMapping("comment")
	public ModelAndView comment(Comment comm, HttpServletRequest request) {
	ModelAndView mav = new ModelAndView();
	System.out.println(comm.getComm_content());
	int board_num = (int)request.getSession().getAttribute("board_num");
	String user = (String)request.getSession().getAttribute("adminId");
	comm.setBoard_num(board_num);
	comm.setAdmin_id(user);
	service.commentinsert(comm);
	mav.setViewName("redirect:detail?board_num="+comm.getBoard_num());
	return mav;
	}
	
	@RequestMapping("noticeList")
	public ModelAndView noticeList(Integer pageNum,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		String admin_id = (String)session.getAttribute("adminId");
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
