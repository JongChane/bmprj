package dto;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ReservationDao;

@Service
public class ReservationService {
	@Autowired
	private ReservationDao rvDao;

	public void insert(Reservation reservation) {
		int maxRvnum = rvDao.maxRvnum();
		reservation.setRv_num(++maxRvnum);
		rvDao.insert(reservation);

	}

	public List<Map<String, Object>> rvCheck(String date, List<String> laneNumbers) {
		List<Map<String, Object>> times = rvDao.rvCheck(date, laneNumbers);
    return times.stream()
				.map(time -> {
					java.sql.Time rv_start_time = (java.sql.Time) time.get("rv_start");
					java.sql.Time rv_end_time = (java.sql.Time) time.get("rv_end");

					LocalTime rv_start_local_time = rv_start_time.toLocalTime();
					LocalTime rv_end_local_time = rv_end_time.toLocalTime();

					time.put("rv_start", rv_start_local_time.format(DateTimeFormatter.ofPattern("HH:mm")));
					time.put("rv_end", rv_end_local_time.format(DateTimeFormatter.ofPattern("HH:mm")));
					return time;
				}) // 시간과 분만 추출
				.collect(Collectors.toList());
	}

	public List<Reservation> reserveList() {
		return rvDao.rvList();
	}

	public int UserReserveCount(String user_id) {
		return rvDao.userReserveCount(user_id);

	}

	public List<Reservation> getUserReserve(String user_id, Integer pageNum, int limit) {
		return rvDao.getUserReserve(user_id, pageNum, limit);
	}
}
