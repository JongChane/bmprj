package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.VisitMapper;
import dto.Visit;

@Repository
public class VisitDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private Class<VisitMapper> cls = VisitMapper.class;
	
	public void insert(String vi_id, int rv_num, int rv_game) {
		param.clear();
		param.put("vi_id", vi_id);
		param.put("rv_num", rv_num);
		param.put("vi_game", rv_game);
		template.getMapper(cls).insert(param);
		
	}

	public List<Visit> visitList(Integer rv_num) {
		param.clear();
		param.put("rv_num", rv_num);
		return template.getMapper(cls).visitList(param);
	}

	public void update(Integer rv_num, String vi_id, int vi_total, int vi_avg) {
		param.clear();
		param.put("rv_num", rv_num);
		param.put("vi_id", vi_id);
		param.put("vi_total", vi_total);
	    param.put("vi_avg", vi_avg);
	    template.getMapper(cls).update(param);
	}

	public List<Visit> viList() {
		return template.getMapper(cls).viList();
	}

	public int getAvg(Integer rv_num, String vi_id) {
		param.clear();
		param.put("rv_num", rv_num);
		param.put("vi_id", vi_id);
		return template.getMapper(cls).getAvg(param);
	}

}
