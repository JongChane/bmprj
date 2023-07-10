package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ReservationMapper;
import dto.Reservation;


@Repository
public class ReservationDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private Class<ReservationMapper> cls = ReservationMapper.class;

	public void insert(Reservation reservation) {
		template.getMapper(cls).insert(reservation);

	}

	public List<Map<String, Object>> rvCheck(String date, List<String> laneNumbers) {
		return template.getMapper(cls).rvCheck(date,laneNumbers);
	}

	public List<Reservation> rvList() {
		return template.getMapper(cls).rvList();
	}
	public int maxRvnum() {
		return template.getMapper(cls).maxRvnum();
	}

	public int userReserveCount(String vi_id) {
		return template.getMapper(cls).UserReserveCount(vi_id);
	}

	public List<Reservation> getUserReserve(String userid, Integer pageNum, int limit) {
		param.clear();
		param.put("startrow", (pageNum - 1) * limit); // 1페이지 : 0 2페이지 :10
		param.put("limit", limit);
		param.put("vi_id", userid);
		return template.getMapper(cls).getUserReserve(param);
	}
}
