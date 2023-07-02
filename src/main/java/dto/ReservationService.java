package dto;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ReservationDao;

@Service
public class ReservationService {
	@Autowired
	private ReservationDao rvDao;

	public void insert(Reservation reservation) {
		rvDao.insert(reservation);

	}

	public List<String> rvCheck(String date) {
    List<String> times = rvDao.rvCheck(date);
    return times.stream()
            .map(time -> time.substring(0, 5)) // 시간과 분만 추출
            .collect(Collectors.toList());
	}
}
