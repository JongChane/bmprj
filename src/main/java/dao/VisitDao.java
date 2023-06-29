package dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.VisitMapper;

@Repository
public class VisitDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private Class<VisitMapper> cls = VisitMapper.class;
	
	public void insert(String vi_id, int vi_total, int vi_avg, int vi_game) {
		param.clear();
		param.put("vi_id", vi_id);
		param.put("vi_total", vi_total);
		param.put("vi_avg", vi_avg);
		param.put("vi_game", vi_game);
		template.getMapper(cls).insert(param);
		
	}

}
