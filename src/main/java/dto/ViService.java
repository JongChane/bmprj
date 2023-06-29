package dto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.VisitDao;

@Service
public class ViService {
	@Autowired
	private VisitDao viDao;

	public void insert(String vi_id, int vi_total, int vi_avg, int vi_game) {
		viDao.insert(vi_id, vi_total, vi_avg, vi_game);		
	}


}
