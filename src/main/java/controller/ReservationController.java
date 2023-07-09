package controller;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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
import dto.User;
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
	public ModelAndView reservation(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String[] lane_nums = (String[]) session.getAttribute("lane_nums");
		String[] vi_id = (String[]) session.getAttribute("vi_id");
		Reservation reservation = (Reservation) session.getAttribute("reservation");
		for(int i=0 ;i<lane_nums.length; i++) {
			reservation.setLane_num(lane_nums[i]);
			rvService.insert(reservation);
		}
		if(vi_id !=null) {
			for(int i = 0 ; i < vi_id.length ; i++) {
				vis.insert(vi_id[i], reservation.getRv_num(), reservation.getRv_game());
			}
		}
		String user_id = (String) session.getAttribute("login");
		session.removeAttribute("lane_nums");
		session.removeAttribute("vi_id");
		session.removeAttribute("reservation");
		mav.setViewName("redirect:../user/reserveList?user_id=" + user_id);
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

	@GetMapping("checkout")
	public ModelAndView reservCheckout(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Reservation reservation = (Reservation) session.getAttribute("reservation");
		if (reservation == null) {
			throw new LoginException("예약내역이 없습니다.", "reservation");
		}
		mav.addObject(new Reservation());
		return mav;
	}

	@PostMapping("checkout")
	public ModelAndView reservecheckout(@RequestParam("lane_num[]") String[] lane_nums, String[] vi_id,
			Reservation reservation, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		int game = reservation.getRv_game();
		int people = reservation.getRv_people();
		LocalTime rv_start = reservation.getRv_start();
		reservation.setRv_price((game * people) * 3000);
		reservation.setRv_end(rv_start.plusMinutes(90));
		List<Reservation> reservationList = new ArrayList<>();
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			throw new LoginException("로그인이 필요합니다.", "../user/login");
		}
		reservationList.add(reservation);
		mav.addObject("reserveList", reservationList);
		session.setAttribute("reservation", reservation);
		session.setAttribute("lane_nums", lane_nums);
		session.setAttribute("vi_id", vi_id);
		return mav;
	}

	@RequestMapping("kakao")
	@ResponseBody
	public Map<String, Object> kakao(HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		LocalTime now = LocalTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH-mm-ss");
		String formatedNow = now.format(formatter);
		Reservation reservation = (Reservation) session.getAttribute("reservation");
		map.put("merchant_uid", reservation.getUser_id() + "-" + formatedNow);
		map.put("name", reservation.getUser_id() + "-" + reservation.getRv_date());
		map.put("amount", reservation.getRv_price());
		map.put("buyer_name", reservation.getUser_id());
		return map; // 클라이언트는 json 객체로 전달
	}
}
