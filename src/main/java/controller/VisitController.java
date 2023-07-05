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

	@RequestMapping("visit")
	public ModelAndView score(Integer rv_num,String[] vi_total, String[] vi_avg) {
		System.out.println(rv_num);
		/*
		 * int[] total = new int[vi_total.length]; int[] avg = new int[vi_avg.length];
		 * int[] game = new int[vi_game.length];
		 * 
		 * for(int i = 0 ; i < vi_total.length ; i++) { total[i] =
		 * Integer.parseInt(vi_total[i]); } for(int i = 0 ; i < vi_avg.length ; i++) {
		 * avg[i] = Integer.parseInt(vi_avg[i]); } for(int i = 0 ; i < vi_game.length ;
		 * i++) { game[i] = Integer.parseInt(vi_game[i]); }
		 */
		
		/*
		 * for(int i = 0 ; i < vi_id.length ; i++) { vis.update(vi_id[i], total[i],
		 * avg[i], game[i]); }
		 */

		return null;
	}


}
