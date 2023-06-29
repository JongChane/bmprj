package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.Game;
import dto.GameService;

@Controller
@RequestMapping("game")
public class GameController {
    @Autowired
	private GameService service;

	@GetMapping("*")
	public ModelAndView write() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Game());
		return mav;
	}
	
	
	@PostMapping("write") 
	public ModelAndView writePost(@Valid Game game, BindingResult bresult, HttpServletRequest request) {
		  ModelAndView mav = new ModelAndView();
		  if(bresult.hasErrors()) {
			  System.out.println("inputcheck:"+ bresult.getModel());
			  mav.getModel().putAll(bresult.getModel());
			  return mav; 
		}
		  System.out.println(game);
		  service.gameInsert(game);
		  mav.setViewName("redirect:gamelist");
	  return mav; 
	}
	
	@GetMapping("write")
	public ModelAndView writeGet(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String user_id = (String)session.getAttribute("login");
		System.out.println(user_id);
		Game g = new Game();
		g.setUser_id(user_id);
		mav.addObject("game",g);
		return mav;
	}
	
	@RequestMapping("gamelist")
	public ModelAndView gamelist() {
		ModelAndView mav = new ModelAndView();
		List<Game> gamelist = service.gameList();
		mav.addObject("gamelist",gamelist);
		return mav;
	}
	 
}
