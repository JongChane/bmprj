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

import dto.BmService;
import dto.Reservation;
import dto.ReservationService;
import dto.ViService;
import exception.LoginException;

@Controller
@RequestMapping("reservation")
public class ReservationController {
	@Autowired
	private ReservationService rvService;
	@Autowired
	private BmService service;
	@Autowired
	private ViService vis;
	@GetMapping("*")
	public ModelAndView rv() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Reservation());
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
	@PostMapping("reservation")
	public ModelAndView reservation(@RequestParam("lane_num[]") String[] lane_nums, String[] vi_id,
			Reservation reservation, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		for(int i=0 ;i<lane_nums.length; i++) {
			reservation.setLane_num(lane_nums[i]);
			LocalTime rv_start = reservation.getRv_start();
			reservation.setRv_end(rv_start.plusMinutes(90));
			rvService.insert(reservation);
		}
		if(vi_id !=null) {
			for(int i = 0 ; i < vi_id.length ; i++) {
				vis.insert(vi_id[i], reservation.getRv_num(), reservation.getRv_game());
			}
		}
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
	/*
	 * @PostMapping("checkOut")
	 */
	
}
