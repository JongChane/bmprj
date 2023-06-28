package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.User;
import dto.ViService;
import dto.Visit;

@Controller
@RequestMapping("visit")
public class VisitController {
	@Autowired
	private ViService vis;
	
	@GetMapping("*")
	public ModelAndView visit() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Visit());
		return mav;
	}
	@PostMapping("visit")
	public ModelAndView score(List<Visit> visitList) {
	  
	      
	        System.out.println("1: " + visitList.get(0));
	        System.out.println("2: " + visitList.get(1));
	        
	        ModelAndView mav = new ModelAndView();
	        mav.setViewName("score_result"); // 결과를 보여줄 뷰 이름 설정
	        
	        return mav;
	}
}
