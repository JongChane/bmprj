package dao;

import java.util.HashMap;
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
}
