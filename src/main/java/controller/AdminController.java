package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.Board;
import dto.BoardService;
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
	
}
