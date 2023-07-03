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
import dto.User;
import exception.LoginException;

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
		  //작성할 때 로그인이 되어있는지 확인합니다.
		  if(bresult.hasErrors()) {
			  System.out.println("inputcheck:"+ bresult.getModel());
			  mav.getModel().putAll(bresult.getModel());
			  return mav; 
		}
		  //확인이 되었으면 db에 저장 후 게임 리스트로 이동합니다
		  System.out.println(game);
		  service.gameInsert(game);
		  mav.setViewName("redirect:gamelist");
	  return mav; 
	}
	
	@GetMapping("write")
	public ModelAndView writeGet(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		//로그인 정보를 가져오기위해 session 정보를 가져와서 user_id로 저장합니다.
		String user_id = (String)session.getAttribute("login");
		System.out.println(user_id);
		Game g = new Game();
		//dto에 있는 게임클래스를 가져와서 
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
	@RequestMapping("gameinfo")
	public ModelAndView getgameinfo(Integer game_num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Game game = service.getGame(game_num);
		String user_id = (String)session.getAttribute("login");		
		mav.addObject("game",game);
		return mav;
	}
	@RequestMapping("apply")
	public ModelAndView apply(Integer game_num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Game game = service.getGame(game_num);
		User user = (User)session.getAttribute("loginUser");
		if(game.getGame_people() >= game.getGame_max()) {
			throw new LoginException("마감되었습니다.","gameinfo?game_num="+game_num);
		}
		if(Integer.parseInt(user.getUser_age()) > game.getGame_age()) {
			throw new LoginException("나이 맞지않습니다.","gameinfo?game_num="+game_num);
		}
		

		service.gameupdate(user.getUser_id(),game_num);
		mav.addObject("game",game);
		mav.setViewName("redirect:gameinfo?game_num="+game_num);
		return mav;
	}
	
	
	/*
	 * @PostMapping("gameinfo") public ModelAndView postgameinfo(HttpSession
	 * session) { ModelAndView mav = new ModelAndView(); String user_id =
	 * (String)session.getAttribute("login"); service.gameupdate(user_id); return
	 * mav; }
	 */
	 
}
