package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.Board;
import dto.BoardService;
import exception.LoginException;
@Controller
@RequestMapping("admin")
public class AdminController {
	@Autowired
	BoardService BoardService;
	@RequestMapping("boardList")
	public ModelAndView boardList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<Board> list = BoardService.boardList();
		mav.addObject("boardList",list);
		return mav;
	}
	
	@GetMapping("reply")
	public ModelAndView replyGet(int board_num) {
		ModelAndView mav = new ModelAndView();
		System.out.println(board_num);
		Board board = BoardService.getBoard(board_num);
		mav.addObject("board",board);
		return mav;
	}
	
	@PostMapping("reply")
	public ModelAndView replyPost(@Valid Board board, BindingResult bresult) {
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
}
