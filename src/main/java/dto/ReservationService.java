package dto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ReservationDao;

@Service
public class ReservationService {
	@Autowired
	private ReservationDao rvDao;
}
