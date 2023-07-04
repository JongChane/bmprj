package controller;

import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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

	@PostMapping("reservation")
	public ModelAndView reservation(@RequestParam("lane_num[]") String[] lane_nums, Reservation reservation, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println(lane_nums);
		reservation.setLane_num(lane_nums);
		LocalTime rv_start = reservation.getRv_start();
		reservation.setRv_end(rv_start.plusMinutes(90));
		rvService.insert(reservation);
		mav.setViewName("redirect:reserveList?user_id="+reservation.getUser_id());
		return mav;
	}

	@GetMapping("checkReservations")
	@ResponseBody
	public Map<String, List<Map<String, Object>>>
			checkReservations(@RequestParam String date, @RequestParam("laneNumbers") List<String> laneNumbers) {	
		List<Map<String, Object>> reservedTimes = rvService.rvCheck(date, laneNumbers);
		Map<String, List<Map<String, Object>>> response = new HashMap<>();
		response.put("reservations", reservedTimes);
		return response;
	}

}
