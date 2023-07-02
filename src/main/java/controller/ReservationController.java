package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public ModelAndView reservation(Reservation reservation) {
		ModelAndView mav = new ModelAndView();
		rvService.insert(reservation);

		return null;
	}

	@GetMapping("checkReservations")
	@ResponseBody
	public Map<String, List<String>> checkReservations(@RequestParam String date) {
		// service를 통해 해당 날짜에 이미 예약된 시간 목록을 찾습니다.
		System.out.println(date);
		List<String> reservedTimes = rvService.rvCheck(date);
		Map<String, List<String>> response = new HashMap<>();
		response.put("reservedTimes", reservedTimes);

		return response;
	}

}
