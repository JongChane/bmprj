package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.BmService;
import dto.ViService;
import dto.Visit;


@Controller
@RequestMapping("visit")
public class VisitController {
	@Autowired
	private ViService vis;
	@Autowired
	private BmService service;
	@GetMapping("*")
	public ModelAndView visit() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Visit());
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
	public ModelAndView score(String[] vi_id, String[] vi_total, String[] vi_avg, String[] vi_game) {

		System.out.println("vi_id: " + vi_id[0]);
		System.out.println("vi_total: " + vi_total[0]);
		System.out.println("vi_avg: " + vi_avg[0]);
		System.out.println("vi_game: " + vi_game[0]);
		System.out.println("vi_id: " + vi_id[1]);
		System.out.println("vi_total: " + vi_total[1]);
		System.out.println("vi_avg: " + vi_avg[1]);
		System.out.println("vi_game: " + vi_game[1]);
			System.out.println("-----------------------------------");

		return null;
	}


}
