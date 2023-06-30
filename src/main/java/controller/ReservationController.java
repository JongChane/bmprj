package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.Reservation;
import dto.ReservationService;

@Controller
@RequestMapping("reservation")
public class ReservationController {
	@Autowired
	private ReservationService rvService;

	@GetMapping("*")
	public ModelAndView rv() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Reservation());
		return mav;
	}

}
