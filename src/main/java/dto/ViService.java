package dto;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.VisitDao;

@Service
public class ViService {
	@Autowired
	private VisitDao viDao;

	public void insert(String vi_id, int rv_num, int rv_game) {
		viDao.insert(vi_id, rv_num, rv_game);		
	}

	public List<Visit> visitList(Integer rv_num) {
		return viDao.visitList(rv_num);
	}

	public void update(Integer rv_num, String vi_id, int vi_total, int vi_avg) {
		viDao.update(rv_num, vi_id, vi_total, vi_avg);
		
	}

	public List<Visit> viList() {
		return viDao.viList();
	}


	/*
	 * public void update(String vi_id, int vi_total, int vi_avg, int vi_game) {
	 * viDao.update(vi_id, vi_total, vi_avg, vi_game);
	 * 
	 * }
	 */



}
