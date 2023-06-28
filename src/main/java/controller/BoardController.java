package controller;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dto.Board;
import dto.BoardService;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired
	private BoardService service;
	
	@GetMapping("write")
	public ModelAndView writeget() {
		ModelAndView mav = new ModelAndView();
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
	
	
}
